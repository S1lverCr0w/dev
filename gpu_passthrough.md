# gpu passthrough attempt to document from the start
#### pc specs
```
amd ryzen r5950x
gigabyte x570s aorus master
sapphire nitro+ rx9060xt 16gb
gigabyte oc pro rx6600xt 8gb
crosair 4x16gb ram
os arch linux
```

### step 1 - bios settings
- svm mode: enabled
- iommu: enabled
- above 4g decoding: enabled
- csm: disabled
- resizable bar: auto (no enabled option)

### step 2 - iommu group check
[arch wiki: ensuring that iommu groups are valid](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Ensuring_that_the_groups_are_valid)
```bash
#!/bin/bash
shopt -s nullglob
for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;
```
