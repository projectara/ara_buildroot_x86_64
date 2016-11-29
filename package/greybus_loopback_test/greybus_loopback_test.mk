################################################################################
#
# greybus_loopback_test
#
################################################################################

GREYBUS_LOOPBACK_DIR_STAGING = $(LINUX_DIR)/drivers/staging/greybus
GREYBUS_LOOPBACK_TEST_INSTALL_TARGET = YES

define GREYBUS_LOOPBACK_TEST_BUILD_CMDS
	$(Q)if test ! -f $(GREYBUS_LOOPBACK_DIR_STAGING)/tools/Makefile ; then \
		echo "Your kernel version is too old and does not have the greybus loopback tool." ; \
		echo "At least kernel 4.9 must be used." ; \
		exit 1 ; \
	fi
	$(TARGET_MAKE_ENV) $(MAKE) -C $(GREYBUS_LOOPBACK_DIR_STAGING)/tools \
		loopback_test
endef

define GREYBUS_LOOPBACK_TEST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(GREYBUS_LOOPBACK_DIR_STAGING)/tools/loopback_test \
		$(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
