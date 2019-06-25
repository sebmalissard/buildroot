################################################################################
#
# robot-credentials
#
################################################################################

ROBOT_CREDENTIALS_VERSION = 35ff401120f9d9646570278846e97c99013b6825
ROBOT_CREDENTIALS_SITE = git@bitbucket.org:sebmalissard/robot-credentials.git
ROBOT_CREDENTIALS_SITE_METHOD = git

define ROBOT_CREDENTIALS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
