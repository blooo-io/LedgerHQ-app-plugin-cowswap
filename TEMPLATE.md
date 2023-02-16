# Plugin Template

## Steps

### - Disable auto-format before replacing
Not doing so will introduce unwanted spacings when replacing the variables. You can turn it back on after applying the changes.

### - Replace the following tags through the code:

|       Tag       | Description |
|      -----      |    -----    |
|`<Plugin Name>`                | Name of the plugin, in lowercase |
|`<Plugin Uppercase Name>`      | Name of the plugin, in uppercase |
|`<Plugin Displayed Name>`      | Name to be displayed on the screens |
|`<Plugin Repo Name>`           | Ex: LedgerHQ-app-plugin-xxx |
|`<Plugin Function Name>`       | Name of the first method to integrate, in uppercase |
|`<Plugin Contract Name>`       | Name of the smart contract |
|`<Plugin Contract Link>`       | Etherscan link to the smart contract |
|`<Plugin Github Action Badger>`| Github actions badges, to paste at the end |

### - Replace the <`Plugin Name`> tag in the file in <Plugin Repo Name>/src/