import { processTest, populateTransaction } from "../test.fixture";

const contractName = "CoWSwapEthFlow"; // <= Name of the smart contract

const testLabel = "ethereum_create_order_c_one_method"; // <= Name of the test
const testDirSuffix = "create_order_c_one_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x40a50cf069e992aa4536211b23f286ef88752187"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0xd6535b4cce2222501a4f82bae58a8e56aed58caf33342132992627262727035e
const inputData = "0x322bba21000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec7000000000000000000000000177360cdff76f87a646029c30d22bc69e15b26090000000000000000000000000000000000000000000000000c2a7662936438080000000000000000000000000000000000000000000000000000000052f76adb3f1aabaf92e2f1cdd097c8712ef50a412c7e37e28ac7d08c63b9eba3d64f2b8d000000000000000000000000000000000000000000000000000becf3d6f3c7f80000000000000000000000000000000000000000000000000000000063fdd85a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000565320e";
const value = "0.88"
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID, value);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 9, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanox",
    label: "Nano X",
    steps: 7, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanosp",
    label: "Nano S+",
    steps: 7, // <= Define the number of steps for this test case and this device
  },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
