#!/bin/sh

source $QMS_BUILD_FILES/env_build_vars.sh

######################################################################## 
#
# install Macports (if needed) and packages

######################################################################## 
# install Macports  (https://www.macports.org)
# 

sudo port selfupdate

######################################################################## 
# install all necessary packages with homebrew.
# Attention: there will be installed additional packages due to dependencies
# First get all currently installed brew packages to be able to find out which packahes will be installed
# during QMS build
echo "${RED}Fetching brew packages (cmake, qt@5, proj, gdal, geos, svn and dependencies ...${NC}"
port list > $QMSDEVDIR/portlist-`date +%s`.txt
sudo port install qt5
sudo port install qt5-qtwebengine
sudo port install dbus
sudo port install proj6
sudo port install gdal
sudo port install geos
sudo port quazip

sudo port routino
port contents routino | grep bin | xargs -J % cp -v % $LOCAL_ENV/bin
port contents routino | grep lib | xargs -J % cp -v % $LOCAL_ENV/lib
port contents routino | grep include | xargs -J % cp -v % $LOCAL_ENV/include
port contents routino | grep share | xargs -J % cp -v % $LOCAL_ENV/xml

port list > $QMSDEVDIR/portlist-`date +%s`.txt
diff $QMSDEVDIR/portlist*.txt > $QMSDEVDIR/portdiff-`date +%s`.txt