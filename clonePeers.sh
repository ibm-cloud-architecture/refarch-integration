#!/usr/bin/env bash

##############################################################################
##
##  Wrapper script to pull all peer git repositories
##
##############################################################################

if [ -z "$1" ]; then
    MYBRANCH=`git rev-parse --abbrev-ref HEAD`
else
    MYBRANCH=$1
fi

BASEREPO="https://github.com/ibm-cloud-architecture/refarch-integration"
REPO_DB2="https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2"
REPO_DAL="https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal"
REPO_TESTS="https://github.com/ibm-cloud-architecture/refarch-integration-tests"
REPO_API="https://github.com/ibm-cloud-architecture/refarch-integration-api"
REPO_PORTAL="https://github.com/ibm-cloud-architecture/refarch-caseinc-app"

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

echo -e '\nClone Brown Compute tests project'
REPO=${REPO_TESTS}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Brown Compute API Connect project'
REPO=${REPO_API}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Case Inc Portal project'
REPO=${REPO_PORTAL}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}


echo -e '\nCloned all peer projects successfully!\n'
ls ../ | grep refarch
