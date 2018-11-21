# rootfs [![Build status](https://badge.buildkite.com/8e5efe5aceb8cce2c1a6493884c4e717f816b89be91132d47d.svg)](https://buildkite.com/opx/rootfs)

*OpenSwitch Debian root filesystem*

To build the root filesystem, run `build.sh`. This script must run as root.

```bash
./build.sh stretch amd64
```

If `debootstrap` is not available, you can use a container.

> *Warning*: root must be able to write to your current directory (I'm looking at you, NFS)

```bash
DIST=stretch docker-compose run --rm rootfs
```

A docker image can be created from this root filesystem.

```bash
docker import opx-rootfs_$(cat VERSION)-stretch.tar.gz opxhub/rootfs:stretch
docker run opxhub/rootfs:stretch cat /etc/os-release
```

© 2018 Dell Inc. or its subsidiaries. All Rights Reserved.
