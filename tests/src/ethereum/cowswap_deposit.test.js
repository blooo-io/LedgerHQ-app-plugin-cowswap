import { processTest, populateTransaction } from "../test.fixture";

const contractName = "WETH9"; // <= Name of the smart contract

const testLabel = "ethereum_deposit_method"; // <= Name of the test
const testDirSuffix = "deposit_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0x81e1284b2f4ff02a3646f22f669da05b3030eca8ac8069a155368e151dbe9196
const inputData = "0xd0e30db0";
const value = "0.12310242223428492";

// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID, value);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 6, // <= Define the number of steps for this test case and this device
  },
  // {
  //   name: "nanox",
  //   label: "Nano X",
  //   steps: 5, // <= Define the number of steps for this test case and this device
  // },
  // {
  //   name: "nanosp",
  //   label: "Nano S+",
  //   steps: 5, // <= Define the number of steps for this test case and this device
  // },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
