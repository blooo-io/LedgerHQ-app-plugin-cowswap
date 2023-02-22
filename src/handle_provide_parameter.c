#include "cowswap_plugin.h"

// Store the amount sent in the form of a string, without any ticker or decimals. These will be
// added when displaying.

static void handle_amount_sent(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    memcpy(context->amount_sent, msg->parameter, INT256_LENGTH);
}

static void handle_amount_received(ethPluginProvideParameter_t *msg,
                                   cowswap_parameters_t *context) {
    memcpy(context->amount_received, msg->parameter, INT256_LENGTH);
}

static void handle_order_uid_two(ethPluginProvideParameter_t *msg,
                                 cowswap_parameters_t *context) {
    memcpy(context->amount_received, msg->parameter, ORDER_UID_TWO_LENGTH);
}

static void handle_withdraw(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    switch (context->next_param) {
        case AMOUNT_SENT :
            handle_amount_sent(msg, context);
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

static void handle_invalidated_order(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    switch (context->next_param) {
        case ORDER_UID_ONE :
            handle_amount_sent(msg, context);
            context->next_param = ORDER_UID_TWO;
            break;
        case ORDER_UID_TWO:
            handle_order_uid_two(msg, context);
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
    printf_hex_array("Plugin provide parameter: ", PARAMETER_LENGTH, msg->parameter);

    msg->result = ETH_PLUGIN_RESULT_OK;

    // If not used remove from here
    if (context->skip) {
        // Skip this step, and don't forget to decrease skipping counter.
        context->skip--;
    } else {
        if ((context->offset) && msg->parameterOffset != context->checkpoint + context->offset) {
            PRINTF("offset: %d, checkpoint: %d, parameterOffset: %d\n",
                   context->offset,
                   context->checkpoint,
                   msg->parameterOffset);
            return;
        }
        context->offset = 0;
        // To here
        switch (context->selectorIndex) {
            case WITHDRAW:
                handle_withdraw(msg, context);
                break;
            case INVALIDATE_ORDER:
                handle_invalidated_order(msg, context);
                break;
            default:
                PRINTF("Selector Index %d not supported\n", context->selectorIndex);
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
        }
    }
}