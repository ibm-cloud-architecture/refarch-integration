#!/usr/bin/env bash

##############################################################################
##
##  Wrapper sript to pull all peer git repositories
##
##############################################################################

if [ -z "$1" ]; then
    MYBRANCH=`git rev-parse --abbrev-ref HEAD`
else
    MYBRANCH=$1
fi

BASEREPO="https://github.com/jbcodeforce/refarch-premsource"
REPO_DB2="https://github.com/jbcodeforce/refarch-premsource-inventory-db2"
REPO_DAL="https://github.com/jbcodeforce/refarch-premsource-inventory-dal"

echo 'Cloning peer projects...'

GIT_AVAIL=$(which git)
if [ ${?} -ne 0 ]; then
  echo "git is not available on your local system.  Please install git for your operating system and try again."
  exit 1
fi

DEFAULT_BRANCH=${MYBRANCH:-master}

echo -e '\nClone Brown Compute Data Access Layer project'
REPO=${REPO_DAL}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Brown Compute DB2 project'
REPO=${REPO_DB2}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nCloned all peer projects successfully!\n'
ls ../ | grep refarch-premsource
