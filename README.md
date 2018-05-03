# OpenSwitch Root Filesystem

[![Build status](https://badge.buildkite.com/bb0768e5e6e177eb85a2e9f3f967d07fba1238bb0118c8f253.svg)](https://buildkite.com/opx/rootfs)

To build the root filesystem, run `build_opx_rootfs.sh`. This script must run
as root.

```bash
./build.sh stretch amd64
```

If `debootstrap` is not available, you can use a container.

```bash
docker-compose run stretch
```

A docker image can be created from this root filesystem.

```bash
docker import opx-rootfs_$(cat VERSION)-stretch_amd64.tar.gz opxhub/rootfs:stretch
docker run opxhub/rootfs:stretch cat /etc/os-release
```

© 2018 Dell Inc. or its subsidiaries. All Rights Reserved.
