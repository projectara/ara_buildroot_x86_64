################################################################################
#
# gbutils
#
################################################################################

GBUTILS_VERSION = master
GBUTILS_LICENSE = LGPLv2.1
GBUTILS_LICENSE_FILES = COPYING

GBUTILS_SITE = $(call github,projectara,gb-utils,$(GBUTILS_VERSION))
# Uncomment the lines bellow and comment line above if you want to use a local
# clone of the gbutils
#GBUTILS_SITE = $(GBUTILSDIR)
#GBUTILS_SITE_METHOD = local

define GBUTILS_INSTALL_TARGET_CMDS
        cd $(TARGET_DIR) && ln -s . system
	cd $(@D) && cp lsgb $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
