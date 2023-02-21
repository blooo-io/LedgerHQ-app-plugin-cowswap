import { processTest, populateTransaction } from "../test.fixture";

const contractName = "WETH9"; // <= Name of the smart contract

const testLabel = "ethereum_withdraw_method"; // <= Name of the test
const testDirSuffix = "withdraw_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0x22db7ee64b4ad0a4ee3e136469a3739b39ebf3c90d25326533b41a4f9daa52cd
const inputData = "0x2e1a7d4d00000000000000000000000000000000000000000000000012dfb0cb5e880000";

// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 4, // <= Define the number of steps for this test case and this device
  },
  // {
  //   name: "nanox",
  //   label: "Nano X",
  //   steps: 4, // <= Define the number of steps for this test case and this device
  // },
  // {
  //   name: "nanosp",
  //   label: "Nano S+",
  //   steps: 4, // <= Define the number of steps for this test case and this device
  // },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
