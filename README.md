# Setup #

## requirements: ##

qemu-system-x86_64 installed.

This will not run inside another virtual host (virtualbox, vmware, etc).

## clone buildroot to any directory outside of this one: ##

```sh
	$ git clone git://git.buildroot.net/buildroot ../buildroot
```

## export variables: ##

Use absolute paths:

```sh
	$ export GBDIR=/path/to/greybus
	$ export GBSIMDIR=/path/to/gbsim

	$ export BR2_EXTERNAL=/path/to/ara_buildroot_x86_64
```


# Build #

go to buildroot cloned directory and run:

```sh
	$ make ara_qemu_x86_64_defconfig
	$ make
```

grab a cup of coffee!!!

# Run #

- in the top directory of buildroot where you have run make:

```sh
$ qemu-system-x86_64  -M pc -kernel output/images/bzImage \
-drive file=output/images/rootfs.ext2,if=ide \
-append "root=/dev/sda console=ttys0,115200" -net nic,model=rtl8139 -net user \
-nographic -s
```

- when prompt appear, login as root, no password need and you can run:
```sh
	$ gbsim -h /tmp/gbsim -v
```
- Then in the /etc are some manifest files to copy to /tmp/gbsim/hotplug-module/

There already an alias for the above command:

g&

Example output:
```sh
Welcome to Buildroot
buildroot login: root
$ g&

hotplug_basedir /tmp/gbsim
verbose 1
file system registered
[I] GBSIM: USB gadget created
read descriptors
read strings
[D] GBSIM: USB BIND
usb 1-1: new high-speed USB device number 2 using dummy_hcd
configfs-gadget gadget: high-speed config #1: config
[D] GBSIM: USB ENABLE
[D] GBSIM: Start SVC/CPort endpoints
[D] GBSIM: SVC->AP handshake sent
[D] GBSIM: USB SETUP
[D] GBSIM: AP->AP Bridge setup message:
[D] GBSIM:   bRequestType = 41
[D] GBSIM:   bRequest     = 01
[D] GBSIM:   wValue       = 0000
[D] GBSIM:   wIndex       = 0000
[D] GBSIM:   wLength      = 000b
[D] GBSIM: AP->SVC message:
  00 00 03 00 00 01 01 00 00 00 00
  [I] GBSIM: AP handshake complete
  [D] GBSIM: SVC -> AP ID (IID:0 DID:1) message sent
```

- To stop qemu do:

	Ctrl-a-x

# Modifying #

* in BR2_EXTERNAL/board/ara/overlay/etc is the etc directory with the init
  script to load modules and manifestos.

* rebuild individual components (all in buildroot directory):

	- greybus:
	```sh
		$ make greybus-dirclean; make greybus; make
	```

	- gbsim:
	```sh
		$ make gbsim-dirclean; make gbsim; make
	```

go to step Run.

# Debuging #

To attach a gdb you can use a gdbinit file already in the overlay:
```sh
	$ cd /path/to/buildroot/output/build/linux-4.1.5
	$ gdb -x $BR2_EXTERNAL/board/ara/qemu_x86_64/gdbinit
```

or if you prefer:
```sh
	$ cgdb -- -x $BR2_EXTERNAL/board/ara/qemu_x86_64/gdbinit
```

at the last stage of boot it is printout the file and address of the greybus
modules, you can add them to the gdbinit as they should not change that much or
copy/paste to the gdb prompt every time you run it, ex:

```sh
add-symbol-file /path/to/buildroot/output/build/greybus-master/greybus.o 0xffffffffa001e000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-es1.o 0xffffffffa002c000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-phy.o 0xffffffffa0035000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-loopback.o 0xffffffffa0041000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-raw.o 0xffffffffa0047000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-battery.o 0xffffffffa004b000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-vibrator.o 0xffffffffa004f000
add-symbol-file /path/to/buildroot/output/build/greybus-master/gb-light.o 0xffffffffa0053000
```
