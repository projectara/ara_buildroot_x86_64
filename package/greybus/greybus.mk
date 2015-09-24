################################################################################
#
# greybus
#
################################################################################

GREYBUS_VERSION = master
GREYBUS_SITE = $(GBDIR)
GREYBUS_SITE_METHOD = local

GREYBUS_DEPENDENCIES = linux

define GREYBUS_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef

define GREYBUS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) INSTALL_MOD_PATH=$(TARGET_DIR) KERNELVER=$(LINUX_VERSION) KERNELDIR=$(LINUX_DIR) install
endef

$(eval $(generic-package))
