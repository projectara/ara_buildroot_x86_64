################################################################################
#
# libsoc
#
################################################################################

GBSIM_VERSION = master
GBSIM_SITE = $(GBSIMDIR)
GBSIM_SITE_METHOD = local
GBSIM_LICENSE = LGPLv2.1
GBSIM_LICENSE_FILES = COPYING
GBSIM_AUTORECONF = YES
GBSIM_INSTALL_STAGING = YES

define GBSIM_CLEAN_BEFORE
	cd $(@D) && make clean
endef
GBSIM_POST_CONFIGURE_HOOKS += GBSIM_CLEAN_BEFORE
GBSIM_DEPENDENCIES += host-automake host-autoconf host-libtool libsoc libusbg

$(eval $(autotools-package))
