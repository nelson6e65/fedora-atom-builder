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

## Instructions
- Download the [latest release](https://github.com/nelson6e65/fedora-atom-builder/releases).
- Unzip that download.
- Run the `run.sh` bash script.
- If not errors, go to `dist` directory and install Atom with the `*.rpm` file generated.

```sh
$ cd to/root/dir
$ ./run.sh
```

You only will be asked for sudo privilegies when installing dependecies.

You can, instead, run task by task (useful to skip installation/update of dependencies when you are sure you already have installed):

```sh
# Download and install all dependencies. You can skip this if you already installed
# recently or you did it manually. You will be asked for sudo password. The first time
# you should run this and the skip when you are updating:
script/install-dependencies


# Get sources of atom to build. The first time will take some minutes, depending of
# your Internet download. After first clone, the download time will be shorter. You
# should run this always to get the latest stable Atom version:
script/get-sources

# This will build atom sources and prepare the build of RPM installer.
# Is mandatory run this:
script/build-sources

# Now, you can build RPM installer:
script/build-rpm

```

>Note: You may need to make ejecutable the files inside `script` directory to be able to run it directly.

After success, you can use the `*.rpm` file to install Atom via `yum`.

For example:

```sh
cd dist/
sudo yum localinstall atom-1.3.2-0.1.fc21.i686.rpm
```

**Done! You have the latest Atom Editor updated in your Fedora! Easy :cake:.**

> This instructions was tested in **`Fedora 21 TwentyOne`**, kernel `i686 Linux 4.0.8-200.fc21.i686`
