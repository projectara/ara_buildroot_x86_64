################################################################################
#
# libsoc
#
################################################################################

LIBUSBG_VERSION = master
LIBUSBG_SITE = $(call github,libusbg,libusbg,$(LIBUSBG_VERSION))
LIBUSBG_LICENSE = LGPLv2.1
LIBUSBG_LICENSE_FILES = COPYING
LIBUSBG_AUTORECONF = YES
LIBUSBG_INSTALL_STAGING = YES

$(eval $(autotools-package))
