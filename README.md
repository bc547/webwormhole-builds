# Unofficial WebWormhole builds

This repository automatically builds the `ww` command-line application
from the upstream WebWormhole repository:

https://github.com/saljam/webwormhole

The upstream repository is checked once per day. When a new upstream
commit is found, GitHub Actions builds and publishes a new release.

## Provided executables

- `ww-windows-amd64.exe`: Windows x86-64
- `ww-linux-amd64`: Linux x86-64
- `ww-linux-arm64-rpi`: Linux ARM64 for Raspberry Pi 3, 4, and 5
- `ww-linux-riscv64`: Linux RISC-V 64-bit

The Raspberry Pi executable requires a 64-bit operating system.

## Latest downloads

### Windows x86-64

https://github.com/bc547/webwormhole-builds/releases/latest/download/ww-windows-amd64.exe

### Linux x86-64

https://github.com/bc547/webwormhole-builds/releases/latest/download/ww-linux-amd64

### Linux ARM64 for Raspberry Pi

https://github.com/bc547/webwormhole-builds/releases/latest/download/ww-linux-arm64-rpi

### Linux RISC-V 64-bit

https://github.com/bc547/webwormhole-builds/releases/latest/download/ww-linux-riscv64

### Checksums

https://github.com/bc547/webwormhole-builds/releases/latest/download/SHA256SUMS

## Verify a Linux download

Download the executable and checksums:

```sh
curl -fLO \
  https://github.com/bc547/webwormhole-builds/releases/latest/download/ww-linux-amd64

curl -fLO \
  https://github.com/YOUR-USERNAME/webwormhole-builds/releases/latest/download/SHA256SUMS
