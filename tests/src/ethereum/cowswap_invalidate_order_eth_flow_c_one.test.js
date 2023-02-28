import { processTest, populateTransaction } from "../test.fixture";

const contractName = "CoWSwapEthFlow"; // <= Name of the smart contract

const testLabel = "ethereum_invalidate_order_eth_flow_c_one_method"; // <= Name of the test
const testDirSuffix = "invalidate_order_eth_flow_c_one_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x40a50cf069e992aa4536211b23f286ef88752187"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0xdde05b31205f2612368611dee9586a93eb115fb095c29d11e3b08560ed464981
const inputData = "0x7bc41b9600000000000000000000000072e9d9038ce484ee986fea183f8d8df93f9ada13000000000000000000000000c5076c26965302964e6c9525eae24d49f47ba96e0000000000000000000000000000000000000000000000001bb6cc153b1768cb0000000000000000000000000000000000000000000000f40c0846a674bba51b3f1aabaf92e2f1cdd097c8712ef50a412c7e37e28ac7d08c63b9eba3d64f2b8d000000000000000000000000000000000000000000000000000aa15213b097350000000000000000000000000000000000000000000000000000000063fd489900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
const value = "0"
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID, value);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 11, // <= Define the number of steps for this test case and this device
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
