# Fedora: Atom builder
A bash helper to build Atom Editor in Fedora.

This is a unattended script to install dependencies, get the sources and generate installer for 32 bits arch. Should work for 64 bits arch, but there is an `*.rpm` installer in official [Atom releases](https://github.com/atom/atom/releases) already.

## Instructions
- Download the [latest release](https://github.com/nelson6e65/fedora-atom-builder/releases).
- Unzip that download.
- Open your console and enter in directory where you unzipped.
- Run `run.sh`
- If not errors, go to `dist` directory and install Atom with the `*.rpm` file generated.

> This instructions was tested in **`Fedora 21 TwentyOne`**, kernel `i686 Linux 4.0.8-200.fc21.i686`
