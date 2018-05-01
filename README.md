# OpenSwitch Root Filesystem

[![Build status](https://badge.buildkite.com/a7841f889246f2e58f49aba7c30c11a707b28b39f88de9921a.svg)](https://buildkite.com/opx/rootfs)

To build the root filesystem, run `build_opx_rootfs.sh`.

```bash
./build.sh stretch amd64
```

If `debootstrap` is not available, you can use a container.

```bash
DIST=stretch
docker run --rm -it --privileged -v $(pwd):/mnt \
  -e LOCAL_UID=$(id -u) -e LOCAL_GID=$(id -g) \
  --entrypoint /mnt/build.sh \
  opxhub/build:$DIST $DIST amd64
```

A docker image can be created from this root filesystem.

```bash
cat <<EOF | docker build -t opxhub/rootfs:$DIST -f- .
FROM scratch
ADD opx-rootfs_*-${DIST}_*.tar.gz /
CMD ["bash"]
EOF
docker run opxhub/rootfs:$DIST cat /etc/os-release
```

© 2018 Dell Inc. or its subsidiaries. All Rights Reserved.

