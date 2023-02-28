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

static void handle_order_uid_two(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    memcpy(context->amount_received, msg->parameter, ORDER_UID_TWO_LENGTH);
}

static void handle_bool(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    if (!U2BE_from_parameter(msg->parameter, &context->is_true)) {
        msg->result = ETH_PLUGIN_RESULT_ERROR;
    }
}

static void handle_address(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    copy_address(context->receiver_address, msg->parameter, sizeof(context->receiver_address));
    printf_hex_array("ADDRESS RECEIVED: ", ADDRESS_LENGTH, context->receiver_address);
}

static void handle_token_address(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    copy_address(context->contract_address_received,
                 msg->parameter,
                 sizeof(context->contract_address_received));
    printf_hex_array("TOKEN RECEIVED: ", ADDRESS_LENGTH, context->contract_address_received);
}

static void handle_withdraw(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    switch (context->next_param) {
        case AMOUNT_SENT:
            handle_amount_sent(msg, context);
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

static void handle_invalidated_order(ethPluginProvideParameter_t *msg,
                                     cowswap_parameters_t *context) {
    switch (context->next_param) {
        case ORDER_UID_ONE:
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

static void handle_set_pre_signature(ethPluginProvideParameter_t *msg,
                                     cowswap_parameters_t *context) {
    switch (context->next_param) {
        case SIGNED:
            handle_bool(msg, context);
            context->skip++;
            context->next_param = ORDER_UID_ONE;
            break;
        case ORDER_UID_ONE:
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

static void handle_create_order(ethPluginProvideParameter_t *msg, cowswap_parameters_t *context) {
    switch (context->next_param) {
        case TOKEN:
            handle_token_address(msg, context);
            context->next_param = RECIPIENT;
            break;
        case RECIPIENT:
            handle_address(msg, context);
            context->skip++;
            context->next_param = AMOUNT_RECEIVED;
            break;
        case AMOUNT_RECEIVED:
            handle_amount_received(msg, context);
            context->skip = 3;
            context->next_param = PARTIAL_FILL;
            break;
        case PARTIAL_FILL:
            handle_bool(msg, context);
            context->skip++;
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
            case SET_PRE_SIGNATURE:
                handle_set_pre_signature(msg, context);
                break;
            case INVALIDATE_ORDER_ETH_FLOW:
            case CREATE_ORDER:
                handle_create_order(msg, context);
                break;
            default:
                PRINTF("Selector Index %d not supported\n", context->selectorIndex);
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
        }
        // set valid to true after parsing all parameters
        context->valid = 1;
    }
}