import { processTest, populateTransaction } from "../test.fixture";

const contractName = "CoWSwapEthFlow"; // <= Name of the smart contract

const testLabel = "ethereum_create_order_c_one_method"; // <= Name of the test
const testDirSuffix = "create_order_c_one_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x40a50cf069e992aa4536211b23f286ef88752187"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0xe2de726e956a62510a9bcb46e53a694f1cdcd99355849ab85bedf980e4eb9ec8
const inputData = "0x322bba21000000000000000000000000dd69db25f6d620a7bad3023c5d32761d353d3de9000000000000000000000000546b4a7a30b3193badf70e1d43d8142928f3db0b00000000000000000000000000000000000000000000000006e116ac9e0cf41b00000000000000000000000000000000000000000000009dd73f88039155c9203f1aabaf92e2f1cdd097c8712ef50a412c7e37e28ac7d08c63b9eba3d64f2b8d000000000000000000000000000000000000000000000000000f44ad35a50be50000000000000000000000000000000000000000000000000000000063fcb6f5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055f093c";

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
  {
    name: "nanosp",
    label: "Nano S+",
    steps: 6, // <= Define the number of steps for this test case and this device
  },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
