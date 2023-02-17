#include "cowswap_plugin.h"

// Store the amount sent in the form of a string, without any ticker or decimals. These will be
// added when displaying.
static void handle_amount_sent(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    memcpy(context->amount_sent, msg->parameter, INT256_LENGTH);
}

static void handle_value_sent(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    memcpy(context->amount_sent, msg->pluginSharedRO->txContent->value.value , msg->pluginSharedRO->txContent->value.length);
}

static void handle_deposit(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    switch (context->next_param) {
        case NONE:
            handle_value_sent(msg, context);
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    cowswap_parameters_t *context = (cowswap>_parameters_t *) msg->pluginContext;
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
            case DEPOSIT:
                handle_deposit(msg, context);
                break;
            default:
                PRINTF("Selector Index %d not supported\n", context->selectorIndex);
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
        }
    }
}