#include "cowswap_plugin.h"

// Need more information about the interface for plugins? Please read the README.md!

// You can check CoW Swap methods here :
// https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#writeContract
//

static const uint8_t COWSWAP_<Plugin Function Name>_SELECTOR[SELECTOR_SIZE] = {0x00,
                                                                               0x00,
                                                                               0x00,
                                                                               0x00};

// Array of all the different LI.FI selectors.
const uint8_t *const COWSWAP_SELECTORS[NUM_COWSWAP_SELECTORS] = {
   COWSWAP_<Plugin Function Name>_SELECTOR,
};

// Ask dummy address ETH
// Remove if not used
const uint8_t PLUGIN_ETH_ADDRESS[ADDRESS_LENGTH] = {0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee,
                                                    0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee,
                                                    0xee, 0xee, 0xee, 0xee, 0xee, 0xee};

// Remove if not used
const uint8_t NULL_ETH_ADDRESS[ADDRESS_LENGTH] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
