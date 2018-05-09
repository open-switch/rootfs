# rootfs ![badge](https://concourse.openswitch.net/api/v1/teams/main/pipelines/rootfs/jobs/release-jessie/badge)

*OpenSwitch Debian root filesystem*

To build the root filesystem, run `build.sh`. This script must run as root.

```bash
./build.sh jessie amd64
```

If `debootstrap` is not available, you can use a container.

```bash
docker-compose run jessie
```

A docker image can be created from this root filesystem.

```bash
docker import opx-rootfs_$(cat VERSION)-jessie_amd64.tar.gz opxhub/rootfs:jessie
docker run opxhub/rootfs:jessie cat /etc/os-release
```

© 2018 Dell Inc. or its subsidiaries. All Rights Reserved.
