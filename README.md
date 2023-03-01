# Badges

[![Code style check](https://github.com/blooo-io/LedgerHQ-app-plugin-cowswap/actions/workflows/lint-workflow.yml/badge.svg?branch=main)](https://github.com/blooo-io/LedgerHQ-app-plugin-cowswap/actions/workflows/lint-workflow.yml)
[![Compilation & tests](https://github.com/blooo-io/LedgerHQ-app-plugin-cowswap/actions/workflows/ci-workflow.yml/badge.svg?branch=main)](https://github.com/blooo-io/LedgerHQ-app-plugin-cowswap/actions/workflows/ci-workflow.yml)

# Ledger CoW Swap Plugin

This is a plugin for the Ethereum application which helps parsing and displaying relevant information when signing a CoW Swap transaction.

## Prerequisite

Clone the plugin to a new folder.

```shell
git clone https://github.com/blooo-io/LedgerHQ-app-plugin-cowswap.git
```

Then in the same folder clone two more repositories, which is the plugin-tools and app-ethereum.

```shell
git clone https://github.com/LedgerHQ/plugin-tools.git                          #plugin-tools
git clone --recurse-submodules https://github.com/LedgerHQ/app-ethereum.git     #app-ethereum
```

## Documentation

Need more information about the interface, the architecture, or general stuff about ethereum plugins? You can find more about them in the [ethereum-app documentation](https://github.com/LedgerHQ/app-ethereum/blob/master/doc/ethapp_plugins.asc).

## Smart Contracts

Smart contracts covered by this plugin are:

| Network  | Version | Smart Contract                               |
| -------- | ------- | -------------------------------------------- |
| Ethereum | V4      | `0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2` |
| Ethereum | V7      | `0x9008D19f58AAbD9eD0D60971565AA8510560ab41` |
| Ethereum | V8      | `0x40A50cf069e992AA4536211B23F286eF88752187` |
| Ethereum | V8      | `0xD02De8Da0B71E1B59489794F423FaBBa2AdC4d93` |


On these smart contracts, the functions covered by this plugin are:

|    Function   | Selector  | Displayed Parameters |
| ---           | ---       | --- |
| Deposit | 0xd0e30db0| <code>no parameters</code> |
| Withdraw     | 0x3c659741| <code>uint256 wad</code>|
| Invalidate Order     | 0xf35af1f8| <code>bytes orderUid</code> |
| Set Pre Signature     | 0xec6cb13f| <table>  <tbody>  <tr><td><code>bytes orderUid</code></td></tr> <tr><td><code>bool signed</code></td></tr> </tbody> </table> |
| Create Order | 0x322bba21 | <table>  <tbody> <tr><td><code>uint256 value</code></td></tr>  <tr><td><code>address order.buyToken</code></td></tr> <tr><td><code>address order.receiver</code></td></tr> <tr><td><code>uint256 order.buyAmount</code></td></tr> <tr><td><code>bool partiallyFillable</code></td></tr> </tbody> </table>
| Invalidate Order Eth Flow | 0x7bc41b96 | <table>  <tbody> <tr><td><code>uint256 value</code></td></tr>  <tr><td><code>address order.buyToken</code></td></tr> <tr><td><code>address order.receiver</code></td></tr> <tr><td><code>uint256 order.buyAmount</code></td></tr> <tr><td><code>bool partiallyFillable</code></td></tr> </tbody> </table>
## Build

Go to the plugin-tools folder and run the "./start" script.

```shell
cd plugin-tools  # go to plugin folder
./start.sh       # run the script start.sh
```

The script will build a docker image and attach a console.
When the docker image is running go to the "LedgerHQ-app-plugin-cowswap" folder and build the ".elf" files.

```shell
cd LedgerHQ-app-plugin-cowswap/tests       # go to the tests folder in LedgerHQ-app-plugin-cowswap
./build_local_test_elfs.sh              # run the script build_local_test_elfs.sh
```

## Tests

To test the plugin go to the tests folder from the "LedgerHQ-app-plugin-cowswap" and run the script "test"

```shell
cd LedgerHQ-app-plugin-cowswap/tests       # go to the tests folder in LedgerHQ-app-plugin-cowswap
yarn test                       # run the script test
```

## Continuous Integration

The flow processed in [GitHub Actions](https://github.com/features/actions) is the following:

- Code formatting with [clang-format](http://clang.llvm.org/docs/ClangFormat.html)
- Compilation of the application for Ledger Nano S in [ledger-app-builder](https://github.com/LedgerHQ/ledger-app-builder)
