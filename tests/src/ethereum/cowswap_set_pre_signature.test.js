// import { processTest, populateTransaction } from "../test.fixture";

// const contractName = "GPv2Settlement"; // <= Name of the smart contract

// const testLabel = "ethereum_set_pre_signature_method"; // <= Name of the test
// const testDirSuffix = "set_pre_signature_method"; // <= directory to compare device snapshots to
// const testNetwork = "ethereum";
// const signedPlugin = false;

// const contractAddr = "0x9008d19f58aabd9ed0d60971565aa8510560ab41"; // <= Address of the smart contract
// const chainID = 1;

// // From : https://etherscan.io/tx/0xed83432f33605888e1ecec5f156a38957acec7517ba82e9a570200902462070e
// const inputData = "0xec6cb13f000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000038cf8bc6a887b31e205d5f98cc1fb780ca4da94d0039bd8d8811a1a3acff0c05401a1e852f970a231d32271c88162e222a09c1650a63ee344e0000000000000000";

// // Create serializedTx and remove the "0x" prefix
// const serializedTx = populateTransaction(contractAddr, inputData, chainID);
// const devices = [
//   {
//     name: "nanos",
//     label: "Nano S",
//     steps: 11, // <= Define the number of steps for this test case and this device
//   },
//   {
//     name: "nanox",
//     label: "Nano X",
//     steps: 7, // <= Define the number of steps for this test case and this device
//   },
//   {
//     name: "nanosp",
//     label: "Nano S+",
//     steps: 7, // <= Define the number of steps for this test case and this device
//   },
// ];

// devices.forEach((device) =>
//   processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
// );
