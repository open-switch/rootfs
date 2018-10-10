# rootfs [![Build status](https://badge.buildkite.com/8e5efe5aceb8cce2c1a6493884c4e717f816b89be91132d47d.svg)](https://buildkite.com/opx/rootfs)

*OpenSwitch Debian root filesystem*

To build the root filesystem, run `build.sh`. This script must run as root.

```bash
./build.sh jessie amd64
```

If `debootstrap` is not available, you can use a container.

> *Warning*: root must be able to write to your current directory (I'm looking at you, NFS)

```bash
docker-compose run --rm jessie
```

A docker image can be created from this root filesystem.

```bash
docker import opx-rootfs_$(cat VERSION)-jessie_amd64.tar.gz opxhub/rootfs:jessie
docker run opxhub/rootfs:jessie cat /etc/os-release
```

© 2018 Dell Inc. or its subsidiaries. All Rights Reserved.
