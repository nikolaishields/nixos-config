.PHONY: all
all: build

.PHONY: theseus
theseus:
	ln -sf $(realpath hosts/$@/configuration.nix) /etc/nixos

.PHONY: switch
switch: 
	nixos-rebuild $@

.PHONY: build
build:
	nixos-rebuild $@

.PHONY: test
test:
	nixos-rebuild $@

.PHONY: install-uefi check_user_confirmation
install-uefi:
	$(call check_defined, DEVICE, ex. /dev/sda)
	$(call check_defined, HOST, target host config (see hosts/))
	parted --script $(DEVICE) \
		mklabel gpt	\
		mkpart primary 512MiB -8GiB	\
		mkpart primary linux-swap -8GiB 100% \
		mkpart ESP fat32 1MiB 512MiB \
		set 3 esp on \
	mkfs.ext4 -L nixos "$(DEVICE)1"
	mkswap -L swap "$(DEVICE)2"
	mkfs.fat -F 32 -n boot "$(DEVICE)3"
	mount /dev/disk/by-label/nixos /mnt
	mkdir -p /mnt/boot
	mount /dev/disk/by-label/boot /mnt/boot
	swapon "$(DEVICE)2"
	nixos-generate-config --root /mnt
	make $(HOST)
	nixos-install

.PHONY: usb
usb:
	$(call check_defined, DEVICE, ex. /dev/sda)
	curl 'https://channels.nixos.org/nixos-21.11/latest-nixos-gnome-x86_64-linux.iso' | dd conv=noerror,sync bs=4M of=$(DEVICE) status=progress


clean:
	rm -rf result
	unlink /etc/nixos/configuration.nix

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))

__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))
