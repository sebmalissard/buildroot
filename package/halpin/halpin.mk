################################################################################
#
# halpin
#
################################################################################

ifeq ($(BR2_PACKAGE_HALPIN_CUSTOM_GIT),y)
HALPIN_VERSION = $(BR2_PACKAGE_HALPIN_CUSTOM_GIT_VERSION)
HALPIN_SITE = $(BR2_PACKAGE_HALPIN_CUSTOM_GIT_REPOSITORY)
HALPIN_SITE_METHOD = git
else ifeq ($(BR2_PACKAGE_HALPIN_CUSTOM_LOCAL),y)
HALPIN_SITE = $(BR2_PACKAGE_HALPIN_CUSTOM_LOCAL_DIRECTORY)
HALPIN_SITE_METHOD = local
else
HALPIN_VERSION = master
HALPIN_SITE = https://bitbucket.org/bearteamrobotics/halpin
HALPIN_SITE_METHOD = git
endif


HALPIN_KCONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_HALPIN_CUSTOM_CONFIG_FILE))
HALPIN_KCONFIG_DEFCONFIG = $(call qstrip,$(BR2_PACKAGE_HALPIN_CONFIG))
HALPIN_KCONFIG_EDITORS = menuconfig


HALPIN_INSTALL_STAGING = YES
HALPIN_INSTALL_TARGET = YES

ifeq ($(BR2_PACKAGE_HALPIN_BUILD_TESTS),y)
define HALPIN_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) build
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) build-tests
endef
else
define HALPIN_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) build
endef
endif

define HALPIN_INSTALL_STAGING_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) install-staging
endef

define HALPIN_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) install-target
endef

$(eval $(kconfig-package))
