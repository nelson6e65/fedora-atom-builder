# Fedora: Atom Builder
[![License](https://img.shields.io/github/license/nelson6e65/fedora-atom-builder.svg)](LICENSE)
[![Latest Tag](https://img.shields.io/github/tag/nelson6e65/fedora-atom-builder.svg)](https://github.com/nelson6e65/fedora-atom-builder/tags)
[![Latest Release](https://img.shields.io/github/release/nelson6e65/fedora-atom-builder.svg)](https://github.com/nelson6e65/fedora-atom-builder/release)


[![Atom](https://img.shields.io/github/release/atom/atom.svg?label=atom)](https://github.com/nelson6e65/fedora-atom-builder/release)
[![npm](https://img.shields.io/npm/v/npm.svg)](https://github.com/npm/npm)
[![node](https://img.shields.io/node/v/gh-badges.svg)](https://github.com/npm/node)


A bash helper to build Atom Editor in Fedora.

This is a unattended script to install dependencies, get latest Atom release sources and generate an `*.rpm` installer for your distro (Fedora).

Is intended for Fedora 32 bits arch. Should work for 64 bits, but there is an `*.rpm` installer in official [Atom releases](https://github.com/atom/atom/releases) already.

## Dependencies
As [Atom build requirement](https://github.com/atom/atom/blob/master/docs/build-instructions/linux.md#requirements), you will need **Node.js** and **npm** installed:
- Node.js (0.10.x or above)
- npm v1.4.x or above (automatically bundled with Node.js)
    - `npm -v` to check the version.
    - `npm config set python /usr/bin/python2 -g` to ensure that `gyp` uses `python2`.
        - You might need to run this command as sudo, depending on how you have set up npm.

If you have not installed yet, you can check the [node installation instructions for Fedora](https://github.com/nodesource/distributions#installation-instructions-1).

>**Note**: Other dependencies will be installed automatically via `run.sh` (or `script/install-dependencies` task).

## Installing
After install [Node.js](https://github.com/nodesource/distributions#installation-instructions-1) in your system, you can download Fedora Atom Builder using one of this options:

### Option 1: Manual
You can manually download [latest release](https://github.com/nelson6e65/fedora-atom-builder/releases) and unzip it in any folder.

Then, go to resultant folder, where `run.sh` bash script is.

```sh
cd /path/to/fedora-atom-builder
./run.sh
```

### Option 2: Using Bower
If you already have [**Bower**](http://bower.io/docs/api/#install) installed in your system, you can use it to download Fedora Atom Builder and execute `run.sh` bash script:



```sh
# Get the latest release (use 'master' to get the development version):
bower install nelson6e65/fedora-atom-builder#latest

# Go to the download directory
cd bower_components/fedora-atom-builder
```

>Note: Bower requires `node`, `npm` and `git` installed.


## Usage
It's simple: Just go to `fedora-atom-builder` directory where you downloaded and execute `run.sh`:

```sh
cd /path/to/fedora-atom-builder
./run.sh
```
>You can also execute this command instead: `sh run.sh`.

You only will be asked for sudo privilegies when installing dependecies.

After success, you can use the `*.rpm` file to install Atom via `yum`.

For example:

```sh
cd dist/
sudo yum localinstall atom-1.3.2-0.1.fc21.i686.rpm
```

### Advanced usage
You can, instead, run task by task (useful to skip installation/update of dependencies when you are sure you already have installed):

#### Install all dependencies
Download and install all dependencies.
You can skip this if you already installed recently or you did it manually.
`yum` will ask you for sudo password.

```sh
script/install-dependencies
```

#### Get sources of Atom Editor
This will download Atom sources.

```sh
script/get-sources
```

It will be used `bower` to get the latest stable Atom version. So, if you want to skip validations, you can run instead:

```sh
bower install
```

#### Build atom sources and RPM installer:
This is mandatory, obviously. After get atom sources and install dependencies, you ned to build installer:

```sh
script/build-sources
script/build-rpm
```

After this, you can install the `*.rpm` file in `dist` directory:

```sh
cd dist/
sudo yum localinstall atom-*.rpm
```

>Note: You may need to make ejecutable the files inside `script` directory to be able to run it directly.

**Done! You have the latest Atom Editor updated in your Fedora! Easy :cake:.**

> This instructions was tested in **`Fedora 21 TwentyOne`**, kernel `i686 Linux 4.0.8-200.fc21.i686`
