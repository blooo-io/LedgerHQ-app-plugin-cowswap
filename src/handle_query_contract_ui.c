#include "cowswap_plugin.h"

// Set UI for the "Send" screen. Usually used for common amount value
static void set_send_ui(ethQueryContractUI_t *msg, cowswap_parameters_t *context) {
    switch (context->selectorIndex) {
        case DEPOSIT:
            strlcpy(msg->title, "Send", msg->titleLength);
            break;
        case WITHDRAW:
            strlcpy(msg->title, "Receive", msg->titleLength);
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    // set network ticker (ETH, BNB, etc) if needed
    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
        strlcpy(context->ticker_sent, msg->network_ticker, sizeof(context->ticker_sent));
    }

    // handle which data to return
    switch (context->selectorIndex) {
        case DEPOSIT:
            amountToString(msg->pluginSharedRO->txContent->value.value,
                           msg->pluginSharedRO->txContent->value.length,
                           WEI_TO_ETHER,
                           context->ticker_sent,
                           msg->msg,
                           msg->msgLength);
            break;
        default:
            amountToString(context->amount_sent,
                           INT256_LENGTH,
                           context->decimals_sent,
                           context->ticker_sent,
                           msg->msg,
                           msg->msgLength);
            return;
    }
    PRINTF("AMOUNT SENT: %s\n", msg->msg);
}

// Set UI for "Receive" screen.
static void set_receive_ui(ethQueryContractUI_t *msg, cowswap_parameters_t *context) {
    switch (context->selectorIndex) {
        case INVALIDATE_ORDER:
            strlcpy(msg->title, "Order uid 2/2", msg->titleLength);
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    // set network ticker (ETH, BNB, etc) if needed
    if (ADDRESS_IS_NETWORK_TOKEN(context->contract_address_received)) {
        strlcpy(context->ticker_received, msg->network_ticker, sizeof(context->ticker_received));
    }

    // Convert to string.
    amountToString(context->amount_received,
                   INT256_LENGTH,
                   context->decimals_received,
                   context->ticker_received,
                   msg->msg,
                   msg->msgLength);
    PRINTF("AMOUNT RECEIVED: %s\n", msg->msg);
}

// Set UI for "Warning" screen.
static void set_warning_ui(ethQueryContractUI_t *msg,
                           const cowswap_parameters_t *context __attribute__((unused))) {
    strlcpy(msg->title, "WARNING", msg->titleLength);
    strlcpy(msg->msg, "Unknown token", msg->msgLength);
}

// Set UI for Order Uid first part
static void set_order_uid_ui(ethQueryContractUI_t *msg, cowswap_parameters_t *context) {
    switch (context->selectorIndex) {
        case INVALIDATE_ORDER:
            strlcpy(msg->title, "Order UID 1", msg->titleLength);
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->msg[0] = '0';
    msg->msg[1] = 'x';
    getOrderUid(context->amount_sent, msg->msg + 2, INT256_LENGTH);
}

// Set UI for Order Uid second part
static void set_order_uid_two_ui(ethQueryContractUI_t *msg, cowswap_parameters_t *context) {
    switch (context->selectorIndex) {
        case INVALIDATE_ORDER:
            strlcpy(msg->title, "Order UID 2", msg->titleLength);
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    getOrderUid(context->amount_received, msg->msg, ORDER_UID_TWO_LENGTH);
}

// Helper function that returns the enum corresponding to the screen that should be displayed.
static screens_t get_screen(ethQueryContractUI_t *msg,
                            cowswap_parameters_t *context __attribute__((unused))) {
    uint8_t index = msg->screenIndex;

    // Remove if not used from here
    bool token_sent_found = context->tokens_found & TOKEN_SENT_FOUND;
    bool token_received_found = context->tokens_found & TOKEN_RECEIVED_FOUND;

    bool both_tokens_found = token_received_found && token_sent_found;
    bool both_tokens_not_found = !token_received_found && !token_sent_found;
    // To here
    switch (context->selectorIndex) {
        case DEPOSIT:
            switch (index) {
                case 0:
                    return SEND_SCREEN;
                default:
                    return ERROR;
            }
        case WITHDRAW:
            switch (index) {
                case 0:
                    return SEND_SCREEN;
                default:
                    return ERROR;
            }
        case INVALIDATE_ORDER:
            switch (index) {
                case 0:
                    return ORDER_UID_SCREEN;
                case 1 : 
                    return ORDER_UID_SCREEN_TWO;
                default:
                    return ERROR;
            }
        default:
            return ERROR;
    }
    return ERROR;
}

void handle_query_contract_ui(void *parameters) {
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;
    memset(msg->title, 0, msg->titleLength);
    memset(msg->msg, 0, msg->msgLength);
    msg->result = ETH_PLUGIN_RESULT_OK;

    screens_t screen = get_screen(msg, context);
    switch (screen) {
        case SEND_SCREEN:
            set_send_ui(msg, context);
            break;
        case RECEIVE_SCREEN:
            set_receive_ui(msg, context);
            break;
        case WARN_SCREEN:
            set_warning_ui(msg, context);
            break;
        case ORDER_UID_SCREEN:
            set_order_uid_ui(msg, context);
            break;
        case ORDER_UID_SCREEN_TWO:
            set_order_uid_two_ui(msg, context);
        break;
        default:
            PRINTF("Received an invalid screenIndex %d\n", screen);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }
}
