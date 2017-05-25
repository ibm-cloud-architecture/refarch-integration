
##############################################################################
##
##  script to perform installation for the needed dependencies
##
##############################################################################


REPO_PORTAL="refarch-caseinc-app"

echo -e '\nPerform dependencies installation for Case Inc Portal project'
REPO=${REPO_PORTAL}
PROJECT=$(echo ${REPO})
cd ../${REPO}
npm update
npm install -g nodemon
npm install
npm build
