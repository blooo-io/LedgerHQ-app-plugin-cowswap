#pragma once

#include <string.h>
#include "eth_internals.h"
#include "eth_plugin_interface.h"

#define PARAMETER_LENGTH 32

#define RUN_APPLICATION 1

#define NUM_COWSWAP_SELECTORS 6
#define SELECTOR_SIZE         4

#define PLUGIN_NAME "CoW Swap"

#define TOKEN_SENT_FOUND     1       // REMOVE IF NOT USED
#define TOKEN_RECEIVED_FOUND 1 << 1  // REMOVE IF NOT USED

extern const uint8_t PLUGIN_ETH_ADDRESS[ADDRESS_LENGTH];  // REMOVE IF NOT USED
extern const uint8_t NULL_ETH_ADDRESS[ADDRESS_LENGTH];    // REMOVE IF NOT USED

// Returns 1 if corresponding address is the address for the chain token (ETH, BNB, MATIC,
#define ADDRESS_IS_NETWORK_TOKEN(_addr)                    \
    (!memcmp(_addr, PLUGIN_ETH_ADDRESS, ADDRESS_LENGTH) || \
     !memcmp(_addr, NULL_ETH_ADDRESS, ADDRESS_LENGTH))

typedef enum {
    DEPOSIT,
    WITHDRAW,
    INVALIDATE_ORDER,
    SET_PRE_SIGNATURE,
    CREATE_ORDER,
    INVALIDATE_ORDER_ETH_FLOW
} pluginSelector_t;

extern const uint8_t *const COWSWAP_SELECTORS[NUM_COWSWAP_SELECTORS];

typedef enum {
    SEND_SCREEN,
    RECEIVE_SCREEN,
    WARN_SCREEN,
    ERROR,
    ORDER_UID_SCREEN,
    ORDER_UID_SCREEN_TWO,
    SIGNED_SCREEN,
    RECEIVER_SCREEN,
    PARTIAL_FILL_SCREEN,
} screens_t;

#define AMOUNT_SENT     0  // Amount sent by the user to the contract.
#define AMOUNT_RECEIVED 1  // Amount sent by the contract to the user.
#define NONE            2  // Placeholder variant to be set when parsing is done.
#define ORDER_UID_ONE   3  // Used for order UID first part
#define ORDER_UID_TWO   4  // Used for order UID second part
#define SIGNED          5  // Order UID OFFSET
#define TOKEN           6  // TOKEN
#define RECIPIENT       7  // Recipient
#define PARTIAL_FILL    8  // Partial fill

#define ORDER_UID_TWO_LENGTH 24
#define ORDER_UID_LENGTH     56

// Number of decimals used when the token wasn't found in the CAL.
#define DEFAULT_DECIMAL WEI_TO_ETHER

// Ticker used when the token wasn't found in the CAL.
#define DEFAULT_TICKER ""

// Shared global memory with Ethereum app. Must be at most 5 * 32 bytes.
typedef struct cowswap_parameters_t {
    uint8_t amount_sent[INT256_LENGTH];
    uint8_t amount_received[INT256_LENGTH];

    uint8_t contract_address_sent[ADDRESS_LENGTH];
    uint8_t contract_address_received[ADDRESS_LENGTH];
    uint8_t receiver_address[ADDRESS_LENGTH];

    char ticker_sent[MAX_TICKER_LEN];
    char ticker_received[MAX_TICKER_LEN];

    uint16_t offset;
    uint16_t checkpoint;
    uint16_t is_true;

    uint8_t next_param;
    uint8_t tokens_found;
    uint8_t valid;
    uint8_t decimals_sent;
    uint8_t decimals_received;
    uint8_t selectorIndex;
    uint8_t flags;
    uint8_t skip;
} cowswap_parameters_t;  // Remove any variable not used
// 32*2 + 3*20 + 11*2 = 146
// 2*3 + 1*8 = 14
// 14+126 = 160

// Piece of code that will check that the above structure is not bigger than 5 * 32.
// Do not remove this check.
_Static_assert(sizeof(cowswap_parameters_t) <= 5 * 32, "Structure of parameters too big.");

void handle_provide_parameter(void *parameters);
void handle_query_contract_ui(void *parameters);
void handle_finalize(void *parameters);
void handle_init_contract(void *parameters);
void handle_provide_token(void *parameters);
void handle_query_contract_id(void *parameters);

static inline void printf_hex_array(const char *title __attribute__((unused)),
                                    size_t len __attribute__((unused)),
                                    const uint8_t *data __attribute__((unused))) {
    PRINTF(title);
    for (size_t i = 0; i < len; ++i) {
        PRINTF("%02x", data[i]);
    };
    PRINTF("\n");
}

static inline void getOrderUid(uint8_t *address, char *out, size_t len) {
    // save some precious stack space
    union locals_union {
        uint8_t hashChecksum[INT256_LENGTH];
        uint8_t tmp[51];
    } locals_union;
    uint8_t i;
    uint32_t offset = 0;

    for (i = 0; i < len; i++) {
        uint8_t digit = address[i];
        locals_union.tmp[offset + 2 * i] = HEXDIGITS[(digit >> 4) & 0x0f];
        locals_union.tmp[offset + 2 * i + 1] = HEXDIGITS[digit & 0x0f];
    }

    for (i = 0; i < len * 2; i++) {
        uint8_t digit = address[i / 2];
        if ((i % 2) == 0) {
            digit = (digit >> 4) & 0x0f;
        } else {
            digit = digit & 0x0f;
        }
        out[i] = HEXDIGITS[digit];
    }
    out[len * 2] = '\0';
}
