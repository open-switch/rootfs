#!/usr/bin/env bash
set -e

[[ $# -ne 2 ]] && echo "Usage: $0 <dist> <arch>" && exit 1

VERSION="$(cat VERSION)"
DIST="$1"
ARCH="$2"

tmpdir=$(mktemp -d)

debootstrap \
  --arch="$ARCH" \
  --include=dirmngr,sudo \
  "$DIST" \
  "$tmpdir" \
  http://deb.debian.org/debian/

# Fetch OPX apt key
chroot "$tmpdir" apt-key adv --fetch-keys http://deb.openswitch.net/opx.asc

# Add the admin user
chroot "$tmpdir" adduser --quiet \
  --gecos 'OPX Administrator,,,,' \
  --disabled-password \
  admin
# Set the default password
echo 'admin:admin' | chroot "$tmpdir" chpasswd

# Set the default hostname into /etc/hostname and /etc/hosts
default_hostname=OPX
echo $default_hostname >"$tmpdir/etc/hostname"
echo "127.0.1.1	$default_hostname" >>"$tmpdir/etc/hosts"

# Copy the contents of the rootconf folder to the rootfs
apt-get install -y --no-install-recommends rsync
rsync -avz --chown root:root rootconf/* "$tmpdir"

# Update package cache
chroot "$tmpdir" apt-get update

# Add the admin user to the sudo group
chroot "$tmpdir" usermod -a -G sudo admin

rm "$tmpdir/usr/sbin/policy-rc.d"

# Add pip and pysnmp
# TODO: Install using Debian package
chroot "$tmpdir" apt-get install -y python-pip
chroot "$tmpdir" pip install pysnmp

# Reduce file size
chroot "$tmpdir" apt-get clean
rm -rf "$tmpdir/tmp"/*
rm -rf "$tmpdir/var/lib/apt/lists"/*

# Create the rootfs tarball
tarfile="opx-rootfs_${VERSION}-${DIST}_${ARCH}.tar.gz"
tar czf "$tarfile" -C "$tmpdir" .

# Reset the ownership
if [[ -n $LOCAL_UID ]]; then
  chown "$LOCAL_UID:$LOCAL_GID" "$tarfile"
fi

# Clean up
rm -fr "$tmpdir"

