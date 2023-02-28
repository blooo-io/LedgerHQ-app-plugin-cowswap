#include "cowswap_plugin.h"

void handle_query_contract_id(void *parameters) {
    ethQueryContractID_t *msg = (ethQueryContractID_t *) parameters;
    cowswap_parameters_t *context = (cowswap_parameters_t *) msg->pluginContext;

    strlcpy(msg->name, PLUGIN_NAME, msg->nameLength);

    switch (context->selectorIndex) {
        case DEPOSIT:
            strlcpy(msg->version, "Deposit", msg->versionLength);
            break;
        case WITHDRAW:
            strlcpy(msg->version, "Withdraw", msg->versionLength);
            break;
        case INVALIDATE_ORDER:
        case INVALIDATE_ORDER_ETH_FLOW:
            strlcpy(msg->version, "Invalidate Order", msg->versionLength);
            break;
        case SET_PRE_SIGNATURE:
            strlcpy(msg->version, "Set Pre Signature", msg->versionLength);
            break;
        case CREATE_ORDER:
            strlcpy(msg->version, "Create Order", msg->versionLength);
            break;
        default:
            PRINTF("Selector Index :%d not supported\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
}