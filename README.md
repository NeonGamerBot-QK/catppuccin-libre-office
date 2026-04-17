<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://libreoffice.org">LibreOffice</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
	<a href="https://github.com/catppuccin/libreoffice/stargazers"><img src="https://img.shields.io/github/stars/catppuccin/libreoffice?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
	<a href="https://github.com/catppuccin/libreoffice/issues"><img src="https://img.shields.io/github/issues/catppuccin/libreoffice?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
	<a href="https://github.com/catppuccin/libreoffice/contributors"><img src="https://img.shields.io/github/contributors/catppuccin/libreoffice?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<p align="center">
	<img src="./assets/preview.webp"/>
</p>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="./assets/latte.webp"/>
</details>
<details>
<summary>🪴 Frappé</summary>
<img src="./assets/frappe.webp"/>
</details>
<details>
<summary>🌺 Macchiato</summary>
<img src="./assets/macchiato.webp"/>
</details>
<details>
<summary>🌿 Mocha</summary>
<img src="./assets/mocha.webp"/>
</details>

## Usage

### Color Palette

Replace the variables `<flavor>` and `<accent>` with the values that you want to use from the [themes](./themes) folder. E.g. (flavor as `mocha` and accent as `mauve`)

Copy the `.soc` file (`themes/<flavor>/<accent>/catppuccin-<flavor>-<accent>.soc`) to the correct path for your operating system:

- **Linux**: `${XDG_CONFIG_HOME:-$HOME/.config}"/libreoffice/*/user/config/`
- **macOS**: `$HOME/Library/Application Support/LibreOffice"/*/user/config/`
- **Windows**: `$HOME/AppData/Roaming/LibreOffice"/*/user/config/`

> [!IMPORTANT]
> After copying the chosen `.soc` file, open LibreOffice and go to Tools → Options → LibreOffice → Appearance. Toggle the "Enable application theming" setting to ensure the theming settings file is generated. Then fully close all LibreOffice windows (save your work) before running the install script.

### Application Colors

> [!IMPORTANT]  
> Application Colors can only be modified on macOS and Linux.

> [!WARNING]  
> This will backup and overwrite the `registrymodifications.xcu` configuration file.

Run the [scripts/install_theme.sh](./scripts/install_theme.sh) script.

E.g. `./scripts/install_theme.sh mocha mauve`

<!-- The FAQ section is optional. Remove if needed.-->
<!--
## 🙋 FAQ

- Q: **_"How can I do X?"_**\
  A: ... -->

## 💝 Thanks to

- [NeonGamerBot](https://github.com/NeonGamerBot-QK)
- [dracula/libreoffice](https://github.com/dracula/libreoffice)

&nbsp;

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
	Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
	<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
