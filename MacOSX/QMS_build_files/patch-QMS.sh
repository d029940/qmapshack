#!/bin/sh

########################################################################
# Patching QMapShack

source $QMS_build_files/env_build_vars.sh

# echo "${GREEN}Patching QMapShack MacOSX...${NC}"
# pushd $QMSDEVDIR/qmapshack
# # Macports uses a different cmake filename for quazip
# cp CMakeLists.txt CMakeLists.txt.org
# cp $QMS_build_files/qmapshack-build-patch/CMakeLists.txt .
# popd

# Patching QMapShack files for bundling, since while using package managers (Homebrew, MacPorts) 
# a) ALL bin files are copied to the bundle
# b) libgeos.dylib is not copied to the bundle
echo "${GREEN}Patching QMapShack MacOSX bundling...${NC}"
pushd $QMSDEVDIR/qmapshack/MacOSX
# cp bundle-qmapshack.sh bundle-qmapshack.sh.org
patch bundle-qmapshack.sh $QMSDEVDIR/QMS_build_files/qmapshack-bundle-patch/bundle-qmapshack.patch
# cp $QMS_build_files/qmapshack-bundle-patch/*.sh .
popd
# Debugging
# cp $QMS_build_files/qmapshack-bundle-patch/CRouterBRouterSetupWizard.cpp $QMSDEVDIR/qmapshack/src/qmapshack/gis/rte/router/brouter/

