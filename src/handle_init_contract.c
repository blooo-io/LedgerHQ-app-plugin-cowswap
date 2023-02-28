#include "cowswap_plugin.h"

// Called once to init.
void handle_init_contract(void *parameters) {
    ethPluginInitContract_t *msg = (ethPluginInitContract_t *) parameters;
    if (msg->interfaceVersion != ETH_PLUGIN_INTERFACE_VERSION_LATEST) {
        msg->result = ETH_PLUGIN_RESULT_UNAVAILABLE;
        return;
    }
    if (msg->pluginContextLength < sizeof(cowswap_parameters_t)) {
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
    memset(context, 0, sizeof(*context));
    context->valid = 0;

    // Determine a function to call
    size_t i;
    for (i = 0; i < NUM_COWSWAP_SELECTORS; i++) {
        if (memcmp((uint8_t *) PIC(COWSWAP_SELECTORS[i]), msg->selector, SELECTOR_SIZE) == 0) {
            context->selectorIndex = i;
            break;
        }
    }

    if (i == NUM_COWSWAP_SELECTORS) {
        // Selector was not found
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    // Set `next_param` to be the first field we expect to parse.
    switch (context->selectorIndex) {
        case DEPOSIT:
            context->valid = 1;  // need to be valid now because it will skip provide params
            break;
        case WITHDRAW:
            context->next_param = AMOUNT_SENT;
            break;
        case INVALIDATE_ORDER:
            context->skip = 2;
            context->next_param = ORDER_UID_ONE;
            break;
        case SET_PRE_SIGNATURE:
            context->skip++;
            context->next_param = SIGNED;
            break;
        case INVALIDATE_ORDER_ETH_FLOW:
        case CREATE_ORDER:
            context->next_param = TOKEN;
            break;
        default:
            PRINTF("Missing selectorIndex\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }
    msg->result = ETH_PLUGIN_RESULT_OK;
}