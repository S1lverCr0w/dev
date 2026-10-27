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

### step 3 - install and configure the vm
```bash
doas pacman -S --needed qemu-desktop libvirt virt-manager edk2-ovmf dnsmasq swtpm dmidecode
doas systemctl enable --now libvirtd.service
doas usermod -aG libvirt "$USER"        # log out and back in afterwards
doas virsh net-autostart default
doas virsh net-start default
```
log out and back in then check if everything wen well
```bash
virsh -c qemu:///system list --all
ls -l /dev/kvm
lsmod | grep kvm_amd
```
if there's an existing vm remove it if not needed
```bash
virsh -c qemu:///system undefine win10bmtl --nvram
virsh -c qemu:///system list --all    # should now be empty
```
mkinicpio check
```bash
grep -E '^(MODULES|HOOKS)' /etc/mkinitcpio.conf
ls /etc/modprobe.d/
```

### step 4 - bind the rx6600xt to vfio-pci (static)
```bash
# 6.1 Tell vfio-pci to claim the 6600 XT and its audio
doas tee /etc/modprobe.d/vfio.conf >/dev/null <<'EOF'
options vfio-pci ids=1002:73ff,1002:ab28
softdep drm pre: vfio-pci
EOF
cat /etc/modprobe.d/vfio.conf

# 6.2 Load VFIO in the initramfs, before amdgpu (backup first)
doas cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak-pre-vfio
doas sed -i 's/^MODULES=()$/MODULES=(vfio_pci vfio vfio_iommu_type1)/' /etc/mkinitcpio.conf
grep '^MODULES' /etc/mkinitcpio.conf
doas mkinitcpio -P
lsinitcpio /boot/initramfs-linux-lts.img | grep -E 'vfio|modprobe.d'
```

before the reboot: check the image contains three vfio modules and the config
```bash
doas mkinitcpio -P
lsinitcpio /boot/initramfs-linux-lts.img | grep -E 'vfio|modprobe.d'
```

reboot and then run:
```bash
lspci -nnk -d 1002:73ff
lspci -nnk -d 1002:ab28
lspci -nnk -d 1002:7590
```

before building the vm: 
\[ wip\]

make ufw allow virbr0 to connect to the internet
```bash
doas ufw allow in on virbr0          # VM -> Arch: getting an IP address and DNS (and file sharing later)
doas ufw route allow in on virbr0    # VM -> internet
doas ufw route allow out on virbr0
doas ufw status verbose
```



