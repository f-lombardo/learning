# Virtual Machines under Linux

Here are some notes on virtual machines under Linux, mainly from this [blog post](https://ubuntuhandbook.org/index.php/2024/12/kvm-qemu-virtual-machines-ubuntu/).

### Check the KVM module

Check if your CPU supports virtualization
```shell
LC_ALL=C.UTF-8 lscpu | grep Virtualization
```

If it outputs nothing, then make sure you have enabled the virtualization support in your BIOS.

Then check if the module is loaded:
```shell
lsmod | grep kvm
```
If this is not the case, try to load it wit

```shell
sudo modprobe -a kvm kvm_intel #Intel CPU
```
or
```shell
sudo modprobe -a kvm kvm_amd #AMD CPU
```
Then install QEMU:
```shell
sudo apt install qemu-system
```

## Create a VM using command line
Create a virtual disk

```shell
qemu-img create -f raw /path/to/disk_name.raw 30G
```
You can have two kind of virtual disks: 
```
-f raw
 ```
this disk type will allocate all the space at once;
```
-f qcow2
```
this disk type will allocate space as needed, having slower performances.

## Run the VM
```shell
#!/bin/bash

qemu-system-x86_64 -cdrom /path/to/iso_image.iso \
 -usbdevice tablet -boot menu=on -drive file=/path/to/disk_name.raw,format=raw \
 -m 8G -cpu host -smp sockets=1,cores=2,threads=2 --enable-kvm \
 -virtfs local,path=/path/to/shared_dir,mount_tag=hostshare,security_model=none,id=hostshare
```

The `-usbdevice table` is important for having a correct mouse position in the VM.

The `-virtfs local,path=/path/to/shared_dir,mount_tag=hostshare,security_model=none,id=hostshare` is used for sharing files between the host and the VM.

For automounting the shared folder in a Linux guest VM, you have to:
1. Load the `9p` kernel module, if not already done (check with `lsmod | grep 9p`)
2. Create the `/mnt/hostshare` directory.
3. Edit the `/etc/fstab` file adding this line:
```
hostshare   /mnt/hostshare   9p   trans=virtio,version=9p2000.L,rw,_netdev   0  0
```

## Run a Windows VM

```shell
#!/bin/bash

qemu-system-x86_64 \
    -enable-kvm \
    -machine q35 \
    -cpu host \
    -smp 4 \
    -m 8192 \
    -drive file=/path/to/disk_name.qcow2,format=qcow2,if=ide \
    -netdev user,id=net0 \
    -device e1000,netdev=net0 \
    -device ich9-usb-ehci1,id=usb1 \
    -device ich9-usb-uhci1,masterbus=usb1.0,firstport=0,multifunction=on \
    -device ich9-usb-uhci2,masterbus=usb1.0,firstport=2 \
    -device ich9-usb-uhci3,masterbus=usb1.0,firstport=4 \
    -device usb-kbd \
    -device usb-tablet \
    -vga std -monitor stdio
```
