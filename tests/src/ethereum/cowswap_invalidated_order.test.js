import { processTest, populateTransaction } from "../test.fixture";

const contractName = "GPv2Settlement"; // <= Name of the smart contract

const testLabel = "ethereum_invalidated_order_method"; // <= Name of the test
const testDirSuffix = "invalidated_order_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x9008d19f58aabd9ed0d60971565aa8510560ab41"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0x0117e56ee6c11618efc02f9f36fce14ca89cbbd773f0782cbce1548f30daee52
const inputData = "0x15337bc000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000038a4ed812705bc7211495de9895c9d05cc7ce136308e76f4a59ed0e7ea1f1ad25aa510d3d64e7b0c09704b458ded31c76a8d4333a063dbeef00000000000000000";

// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 10, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanox",
    label: "Nano X",
    steps: 6, // <= Define the number of steps for this test case and this device
  },
  // {
  //   name: "nanosp",
  //   label: "Nano S+",
  //   steps: 4, // <= Define the number of steps for this test case and this device
  // },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
