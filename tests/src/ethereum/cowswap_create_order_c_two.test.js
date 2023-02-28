import { processTest, populateTransaction } from "../test.fixture";

const contractName = "CoWSwapEthFlow"; // <= Name of the smart contract

const testLabel = "ethereum_create_order_c_two_method"; // <= Name of the test
const testDirSuffix = "create_order_c_two_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xd02de8da0b71e1b59489794f423fabba2adc4d93"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0xb721375b681bd644c6661b3ca38849c8d47f4e6fc1c2d4174ef571185d775190
const inputData = "0x322bba21000000000000000000000000a0b86991c6218b36c1d19d4a2e9eb0ce3606eb480000000000000000000000005df5435c14f8401058610051134fa226e374182e0000000000000000000000000000000000000000000000001a722435a119083500000000000000000000000000000000000000000000000000000000b75eba518526fa54b4906757741e17fef499747c637e4b0f86c0a4fe92b7cbd6d5105a64000000000000000000000000000000000000000000000000000f8aabbfe5f7cb0000000000000000000000000000000000000000000000000000000063f8ad06000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001de955";
const value = "1.91"
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
