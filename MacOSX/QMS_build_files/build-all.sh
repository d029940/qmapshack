#!/bin/sh

# Created by Git user d029940, Jul-2022
# Feel free to adjust it to your liking

########################################################################
# !!!! Attention
#
# Important settings are at the beginning of env_build_vars.sh
#
########################################################################


#
# First steps todo before running this script
# ----------
# 1. Create a build directory for QMS (refered here as QMSDEVDIR)
######################################################################## 
# Shell variables for the build process
# During the build process a lot of shell variables are needed to facilitate the process and thereby still offering flexibility for changes
# set to a folder, where the complete build of QMapShack and all parts (refer to first step in the beginning of this script)
# cd to this folder

# 2. cd into QMSDEVDIR
export QMSDEVDIR=$PWD
cd $QMSDEVDIR


# 3. Fetching QMapShack from Github
export GREEN=$(tput setaf 2)
echo "${GREEN}Fetching QMapShack ...${NC}"
# Fetching my fork of QMapShack from Github (again)
echo "${GREEN}Is cloned fork up-to-date?${NC}"
git clone https://github.com/d029940/qmapshack.git $QMSDEVDIR/QMapShack
export QMS_SRC_DIR=$QMSDEVDIR/QMapShack
export QMS_BUILD_FILES=$QMS_SRC_DIR/MacOSX/QMS_build_files

echo "${GREEN}If you didn't follow the README.mk, you can also cd to $QMS_BUILD_FILES ${NC}"
echo "${GREEN}and then run sh build-all.sh${NC}"

source $QMS_BUILD_FILES/env_build_vars.sh


######################################################################## 
# clean up
if [[ "$1" == "clean" ]]; then

    source $QMS_BUILD_FILES/clean.sh
    exit
fi

########################################################################
# Create local environment
source $QMS_BUILD_FILES/create_local_env.sh

########################################################################
# install homebrew (if needed) and packages 
cd $QMSDEVDIR
source  $QMS_BUILD_FILES/install-brew-packages.sh
cd $QMSDEVDIR

######################################################################## 
# build Quazip
cd $QMSDEVDIR
source $QMS_BUILD_FILES/build-quazip.sh
cd $QMSDEVDIR

######################################################################## 
# build GDAL (experimental: now using cmake)
if [[ $BUILD_GDAL -eq 1 ]]; then
    cd $QMSDEVDIR
    source $QMS_BUILD_FILES/build-gdal.sh
    cd $QMSDEVDIR
fi

######################################################################## 
# build Routino
cd $QMSDEVDIR
source $QMS_BUILD_FILES/build-routino.sh
cd $QMSDEVDIR

# build QMapShack
cd $QMSDEVDIR
source $QMS_BUILD_FILES/build-QMS.sh
cd $QMSDEVDIR

# Bundling QMapShack and QMapTool
source $QMS_BUILD_FILES/bundle.sh


######################################################################## 
# Last remark - Dark Mode

# If the system is running in dark mode, then buttons which appear on top of a map are not visible (e.g. while adjusting a track)
# These buttons are not dark-mode enabled.
# Solution:
echo "${RED}Remark: QMapShack cannot show buttons on the map in dark mode.${NC}"
# Add the following key to the "info.plist" file, i.e. completely opting out from dark mode
# <key>NSRequiresAquaSystemAppearance</key> <string>true</string>
# The "info.plist" file can be found in the bundle of the app under the "Contents" folder
echo "${GREEN}QMapShack can ignore dark mode by adding the following key to the \"info.plist\" file.${NC}"
echo "${GREEN}<key>NSRequiresAquaSystemAppearance</key> <string>true</string>${NC}"
echo "${GREEN}The \"info.plist\" file can be found in the bundle of the app under the \"Contents\" folder,${NC}"


