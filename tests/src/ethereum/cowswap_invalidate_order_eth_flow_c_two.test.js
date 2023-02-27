import { processTest, populateTransaction } from "../test.fixture";

const contractName = "CoWSwapEthFlow"; // <= Name of the smart contract

const testLabel = "ethereum_invalidate_order_eth_flow_two_method"; // <= Name of the test
const testDirSuffix = "invalidate_order_eth_flow_two_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xd02de8da0b71e1b59489794f423fabba2adc4d93"; // <= Address of the smart contract
const chainID = 1;

// From :https://etherscan.io/tx/0x91138b9777e9fd7ba949533b87a12e573cceb7fad7587b370dd02a4596bc947a
const inputData = "0x7bc41b960000000000000000000000006f80310ca7f2c654691d1383149fa1a57d8ab1f80000000000000000000000004a0904e50d759a9d70db078a2249ce638caeaa2e00000000000000000000000000000000000000000000000019ba30e00a04ecaa0000000000000000000000000000000000000000000011a95451d080e2d5e4a93f1aabaf92e2f1cdd097c8712ef50a412c7e37e28ac7d08c63b9eba3d64f2b8d0000000000000000000000000000000000000000000000000021ef8d587193560000000000000000000000000000000000000000000000000000000063fca79c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 12, // <= Define the number of steps for this test case and this device
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
