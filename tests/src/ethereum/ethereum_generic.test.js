import { processTest, populateTransaction } from "../test.fixture";

const contractName = "<Plugin Contract Name>";  // <= Name of the smart contract

const testLabel = "ethereum_first_method"; // <= Name of the test
const testDirSuffix = "first_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x000";   // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0xba5c36b3f94cc5c36177f402d91042336bbb02a47637b8135643a97451ca36bb
const inputData = "0x00";

// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);

const devices = [
    {
        name: "nanos",
        label: "Nano S",
        steps: 7, // <= Define the number of steps for this test case and this device
    },
    {
        name: "nanox",
        label: "Nano X",
        steps: 5, // <= Define the number of steps for this test case and this device
    },
    {
        name: "nanosp",
        label: "Nano S+",
        steps: 5, // <= Define the number of steps for this test case and this device
    }
];

devices.forEach((device) =>
    processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
