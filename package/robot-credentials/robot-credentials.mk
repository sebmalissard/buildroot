################################################################################
#
# robot-credentials
#
################################################################################

ROBOT_CREDENTIALS_VERSION = 6949ba10c6ab9963bd12e0cb92ea955951d7b70c
ROBOT_CREDENTIALS_SITE = git@bitbucket.org:sebmalissard/robot-credentials.git
ROBOT_CREDENTIALS_SITE_METHOD = git

define ROBOT_CREDENTIALS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
