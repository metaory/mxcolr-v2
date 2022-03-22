# mxcolr-v2 ▲

<p align="center">
  <img src="./assets/2022-01-29-163127_318x127_scrot.png">
</p>
<p align="center">
  <img src="./assets/2022-01-29-190221_2560x1080_scrot.png">
</p>

Usage
=====
    chmod +x mxcolr
    mxcolr [-s <vivid|lch>] [-i]

    -s  | (Pastel randomization strategy) default is vivid
    -i  | interactive mode

### every file in `./templates/{tpl}` will be parsed;
### scheme variables replaced; and placed in `./out/{tpl}`

![generate](https://github.com/metaory/mxcolr-v2/wiki/assets/gifcast_220322103028.gif)


`SBG`, `WBG`, `EBG` are trio of randomely generated colors, they are the core of the palette
> Given the same `seed`, its guaranteed the same `scheme file` be produced.

Possible variables available in all templates or plugins are:
```bash
C00 C01 C02 C03 C04 C05 C06 C07 C08 C09 C10 C11 C12 C13 C14 C15
    CX1 CX2 CX3 CX4 CX5 CX6 # extra saturated
    CY1 CY2 CY3 CY4 CY5 CY6 # extra desaturated
    CF1 CF2 CF3 CF4 CF5 CF6 # fg color on CX bg

SBG WBG EBG # seed bg colors
SFG WFG EFG # seed fg colors

SK0 SK1 SK2 SK3 SK4 SK5 SK6 SK7 SK8 SK9 # S shades
WK0 WK1 WK2 WK3 WK4 WK5 WK6 WK7 WK8 WK9 # W shades
EK0 EK1 EK2 EK3 EK4 EK5 EK6 EK7 EK8 EK9 # E shades

XBG # main bg colors
XFG # main fg colors
```
Advance Usage
=============
if further steps required to patch an app a plugin `sh` file can be added to plugins folder to make the additinal steps

each `sh` file presents in `./plugins` folder is treated as a plugin and is sourced

its expected to follow these patterns:
* filename: `[0-9]-[a-z_].sh` _eg `1-vim.sh`_
  * prefix number is the `order` its loaded, 0 means disabled
  * suffix the `plugin_name`
* plugin file is expected to have a function named `apply`
  this function will be called with confirmation prompt

> current active loaded theme variables are available to plugin

> all templates if any are parsed before calling apply_ function

> plugins outputs will first be drafted in `/tmp/mxc` and later upon confirmation prompt moved to `~/.config/mxc-v2/{plugin_name}`
unless different destination is set


Motivations
===========
While tools like Oomox and Spicetify are great in reallity you probably got more than GTK theme and Icons you'd want to patch

Terminal colors, terminal prompt, window manager / status bar theme / icons, Vim/Atom/SourceCode editor and more

Some apps might require to compile and build, all of these are just too repetitive and anoying to do for every change, then there is the never ending search for the right color scheme

What about
----------
- [Pywal](https://github.com/dylanaraps/pywal): all about Wallpaper,, great documentation and support though.
> almost all [pywal-customization](https://github.com/dylanaraps/pywal/wiki/customization) can be easilly added
- [Oomox](https://github.com/themix-project/oomox) plugins: possible,, to mxcolr, oomox is just another plugin for gtk theme and icon

#### This repo goal is to be a tool for generating and previewing palettes and serve as a framework for patching any application with few keystrokes.


Requirements
------------
- [pastel](https://github.com/sharkdp/pastel)
- [GNU bc](https://www.gnu.org/software/bc)

## this project is the version 2 of [mxcolr](https://github.com/metaory/mxcolr)

## V2 Roadmap
- [X] plugin mechanics
- [X] live preview* alacritty only
- [X] interactive mode
- [ ] snapshots
- [ ] demos

## Similar projects
- [xi/xiwal](https://github.com/xi/xiwal) _python_
- [piutranq/cologen](https://github.com/piutranq/cologen) _rust_
- [kumux/kumux-colorscheme-engine](https://github.com/kumux/kumux-colorscheme-engine) _javascript_
- [dylanaraps/pywal](https://github.com/dylanaraps/pywal) _python_
- [themix-project/oomox](https://github.com/themix-project/oomox) _python_
- [spicetify/spicetify-cli](https://github.com/spicetify/spicetify-cli) _javascript_
