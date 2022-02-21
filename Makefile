.PHONY: all
all: build

.PHONY: theseus
theseus:
	ln -sf $(realpath hosts/$@/configuration.nix) /etc/nixos

.PHONY: nas
nas:
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

.PHONY: install-uefi 
install-uefi:
	$(call check_defined, DEVICE, ex. /dev/sda)
	wipefs -a $(DEVICE)
	parted --script -a optimal -- $(DEVICE) \
		mklabel gpt	\
		mkpart primary 512Mib 100% \
		mkpart ESP fat32 1M 512M \
		set 3 esp on 
	mkdir -p /mnt/boot
	mkfs.ext4 "$(DEVICE)1"
	mkfs.vfat "$(DEVICE)2"
	mount "$(DEVICE)1" /mnt
	mount "$(DEVICE)2" /mnt/boot
	nixos-generate-config --root /mnt

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
