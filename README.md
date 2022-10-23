# systems

This repository stores the nix configurations for various machines.

## System overview

| name | description |
| ---- | ----------- |
| chirm | Dell XPS 13 7390 |
| morpork | AMD Ryzen 5 3600, etc. |
| tsort | OCI Ampere |

## Handy reminders

ZFS

```
zpool create -O mountpoint=none -O atime=off -O compression=lz4 -O xattr=sa -O acltype=posixacl rpool /dev/mapper/zfsPool
zfs create -o mountpoint=legacy rpool/root
zfs create -o mountpoint=legacy rpool/home
zfs create -o sync=disabled -o setuid=off -o devices=off -o mountpoint=legacy rpool/tmp
```
