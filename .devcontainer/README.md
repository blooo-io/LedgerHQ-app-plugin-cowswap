# nano-plugin-codespace-template

## Current steps

- Creates a container with the following softwares installed:
	- docker
	- node
	- python
</br>
</br>

- Installs the following extensions to the codespace's vscode:
	- `ms-vscode.cpptools`,
	- `maziac.hex-hover-converter`,
	- `atlassian.atlascode`,
	- `eamodio.gitlens`,
	- `GitHub.codespaces`,
	- `GitHub.vscode-pull-request-github`,
	- `dsznajder.es7-react-js-snippets`,
	- `artdiniz.quitcontrol-vscode`
</br>
</br>

- Run a bash script that will:
	- Clone `app-ethereum` in /workspace
	- Clone `plugin-tools` in /workspace
	- Pull the ledger-app-builder image in plugin-tools