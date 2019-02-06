################################################################################
#
# halpin
#
################################################################################

ifeq ($(BR2_HALPIN_CUSTOM_GIT),y)
HALPIN_VERSION = $(BR2_HALPIN_CUSTOM_GIT_VERSION)
HALPIN_SITE = $(BR2_HALPIN_CUSTOM_GIT_REPOSITORY)
HALPIN_SITE_METHOD = git
else ifeq ($(BR2_HALPIN_CUSTOM_LOCAL),y)
HALPIN_SITE = $(BR2_HALPIN_CUSTOM_LOCAL_DIRECTORY)
HALPIN_SITE_METHOD = local
else
HALPIN_VERSION = master
HALPIN_SITE = https://bitbucket.org/bearteamrobotics/halpin
HALPIN_SITE_METHOD = git
endif

HALPIN_INSTALL_STAGING = YES
HALPIN_INSTALL_TARGET = YES

define HALPIN_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) build
endef

define HALPIN_INSTALL_STAGING_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) install-staging
endef

define HALPIN_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) install-target
endef

$(eval $(generic-package))
