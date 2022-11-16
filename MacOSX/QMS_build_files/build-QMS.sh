#!/bin/sh

######################################################################## 
# build QMapShack
#
# Prerequisite:
# QMapShack downloaded from git, and possibly patched

source $QMS_BUILD_FILES/env_build_vars.sh

cd $QMSDEVDIR

mkdir build_QMapShack
cd ./build_QMapShack

# export CPATH=$LOCAL_ENV/include:$CPATH

# Creating Makefile with cmake
CMAKE_PAR="-DCMAKE_PREFIX_PATH=$QT_DIR -DCMAKE_MACOSX_RPATH=ON -DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_DEPLOYMENT_TARGET -DROUTINO_DEV_PATH=$ROUTINO_LIB_DIR -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -DGDAL_CONFIG=$GDAL_DIR/bin/gdal-config -DGDAL_INCLUDE_DIR=$GDAL_DIR/include -DGDAL_LIBRARY=$GDAL_DIR/lib/libgdal.dylib  -DPROJ_DIR=$PROJ_DIR/lib/cmake/proj -DQuaZip-Qt5_DIR=$QUAZIP_LIB_DIR/lib/cmake/QuaZip-$QUAZIP_Version"

echo "${GREEN} cmake ../qmapshack ${CMAKE_PAR}${NC}"

if [[ $XCODE_PROJECT -eq 0 ]]
then
    cmake ../qmapshack $CMAKE_PAR
    # building QMapShack
    echo "${GREEN}Building QMapShack - can take very long ...${NC}"
    cd $QMSDEVDIR/build_QMapShack
    make
else
# Creade Xcode project for debugging    
    export Qt5Widgets_DIR=/$QT_DIR/lib/cmake/Qt5Widgets
    export Qt5Xml_DIR=$QT_DIR/lib/cmake/Qt5Xml
    export Qt5Sql_DIR=$QT_DIR/lib/cmake/Qt5Sql
    export Qt5LinguistTools_DIR=$QT_DIR/lib/cmake/Qt5LinguistTools
    export Qt5PrintSupport_DIR=/$QT_DIR/lib/cmake/Qt5PrintSupport
    export Qt5UiTools_DIR=/$QT_DIR/lib/cmake/Qt5UiTools
    export Qt5Network_DIR=$QT_DIRlib/cmake/Qt5Network
    export Qt5WebEngineWidgets_DIR=$QT_DIR/lib/cmake/Qt5WebEngineWidgets
    export Qt5Help_DIR=$QT_DIR/lib/cmake/Qt5Help
    cmake ../qmapshack -G Xcode $CMAKE_PAR
fi

