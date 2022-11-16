#!/bin/sh

source $QMS_BUILD_FILES/env_build_vars.sh

######################################################################## 
# clean up
echo "${RED}Cleaning build artifacts ...${NC}"

if [[ $MACPORTS -eq 1 ]]
then
    rm $QMSDEVDIR/portlist*.txt
     echo "${RED}Installed Macports are listed in ports*.diff${NC}"
else
    rm $QMSDEVDIR/brewlist*.txt
    echo "${RED}Installed homebrew packages are listed in brewdiff*.diff${NC}"
fi

rm -rf $QMSDEVDIR/quazip
rm -rf $LOCAL_ENV
rm -rf $ROUTINO_ORG
rm -rf $QMSDEVDIR/qmapshack 
rm -rf $QMSDEVDIR/build_QMapShack



