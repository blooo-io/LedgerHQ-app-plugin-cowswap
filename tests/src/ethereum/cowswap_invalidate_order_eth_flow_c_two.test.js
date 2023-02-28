import { processTest, populateTransaction } from "../test.fixture";

const contractName = "CoWSwapEthFlow"; // <= Name of the smart contract

const testLabel = "ethereum_invalidate_order_eth_flow_two_method"; // <= Name of the test
const testDirSuffix = "invalidate_order_eth_flow_two_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xd02de8da0b71e1b59489794f423fabba2adc4d93"; // <= Address of the smart contract
const chainID = 1;

// From :https://etherscan.io/tx/0x867a0f4fcc4d43fee32a352d71a4af6e3f24aa7893bffc3e23316fb564d5cd14
const inputData = "0x7bc41b96000000000000000000000000a0b86991c6218b36c1d19d4a2e9eb0ce3606eb480000000000000000000000009fa3c00a92ec5f96b1ad2527ab41b3932efeda5800000000000000000000000000000000000000000000000000207d543c788ffd0000000000000000000000000000000000000000000000000000000000a59893723d4a83ea08bc929d1c866ab6c61923bae9604f7a870f8b2889d88a7f2408df0000000000000000000000000000000000000000000000000003099e334870030000000000000000000000000000000000000000000000000000000063a2ec8100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
const value = "0"
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID, value);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 9, // <= Define the number of steps for this test case and this device
  },
//   {
//     name: "nanox",
//     label: "Nano X",
//     steps: 6, // <= Define the number of steps for this test case and this device
//   },
//   {
//     name: "nanosp",
//     label: "Nano S+",
//     steps: 6, // <= Define the number of steps for this test case and this device
//   },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
