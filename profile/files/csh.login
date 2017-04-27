# IBM_PROLOG_BEGIN_TAG 
# This is an automatically generated prolog. 
#  
# bos610 src/bos/etc/csh.login/csh.login 1.1 
#  
# Licensed Materials - Property of IBM 
#  
# COPYRIGHT International Business Machines Corp. 1994 
# All Rights Reserved 
#  
# US Government Users Restricted Rights - Use, duplication or 
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
#  
# @(#)14	1.1  src/bos/etc/csh.login/csh.login, cmdcsh, bos610 8/9/94 16:04:51
# IBM_PROLOG_END_TAG 
#
# COMPONENT_NAME: (CMDCSH) C Shell
#
# FUNCTIONS:
#
# ORIGINS: 27
#
# (C) COPYRIGHT International Business Machines Corp. 1994
# All Rights Reserved
# Licensed Materials - Property of IBM
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
#
################################################################

# System wide set up file for the C shell. All variables set here may
# be overridden by user's personal .cshrc file and .login file in their
# $HOME directory. However, all commands here will be executed at login
# regardless. This file is executed only once at login.

# If LC_MESSAGES is set to "C@lft" and TERM is not set to "lft",
# unset LC_MESSAGES. 
if ($?LC_MESSAGES) then
	if ("$LC_MESSAGES" == "C@lft" && "$TERM" != "lft") then 
		unsetenv LC_MESSAGES
	endif
endif
