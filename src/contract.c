#include "cowswap_plugin.h"

// Need more information about the interface for plugins? Please read the README.md!

// You can check CoW Swap methods here :
// https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#writeContract
//

// deposit : 0xd0e30db0
static const uint8_t COWSWAP_DEPOSIT_SELECTOR[SELECTOR_SIZE] = {0xd0, 0xe3, 0x0d, 0xb0};

// withdraw : 0x2e1a7d4d
static const uint8_t COWSWAP_WITHDRAW_SELECTOR[SELECTOR_SIZE] = {0x2e, 0x1a, 0x7d, 0x4d};

// invalidated order : 0x15337bc0
static const uint8_t COWSWAP_INVALIDATE_ORDER_SELECTOR[SELECTOR_SIZE] = {0x15, 0x33, 0x7b, 0xc0};

// Array of all the different CoW Swap selectors.
const uint8_t *const COWSWAP_SELECTORS[NUM_COWSWAP_SELECTORS] = {COWSWAP_DEPOSIT_SELECTOR,
                                                                 COWSWAP_WITHDRAW_SELECTOR,
                                                                 COWSWAP_INVALIDATE_ORDER_SELECTOR};

// Ask dummy address ETH
// Remove if not used
const uint8_t PLUGIN_ETH_ADDRESS[ADDRESS_LENGTH] = {0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee,
                                                    0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee,
                                                    0xee, 0xee, 0xee, 0xee, 0xee, 0xee};

// Remove if not used
const uint8_t NULL_ETH_ADDRESS[ADDRESS_LENGTH] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                                  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                                  0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
