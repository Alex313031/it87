#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must run this with superuser priviliges.  Try \"sudo ./dkms-install.sh\"" 2>&1
  exit 1
else
  echo "About to run dkms install steps..."
fi

DRV_NAME=$(basename $(pwd))
DRV_VERSION=$(git describe --long).$(date -u -d "$(git show -s --format=%ci HEAD)" +%Y%m%d)
DKMS_DIR=/usr/src/${DRV_NAME}-${DRV_VERSION}

make -f Makefile DRIVER=$DRV_NAME DRIVER_VERSION=$DRV_VERSION DKMS_ROOT_PATH=$DKMS_DIR dkms

echo "Finished running dkms install steps."

exit $RESULT
