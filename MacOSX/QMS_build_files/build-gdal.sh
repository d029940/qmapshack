#!/bin/sh

source $QMS_BUILD_FILES/env_build_vars.sh

######################################################################## 
# build GDAL (experimental: now using cmake)
if [[] "$1" == "gdal" ]]; then
    echo "${RED}Building GDAL ...${NC}"
    cd $QMSDEVDIR
    https://github.com/OSGeo/gdal.git
# --> folder $QMSVERDIR/gdal/ created
    cd $QMSDEVDIR/gdal
    mkdir build
    cd ./build
    cmake ..  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$GDAL_DIR
      -DGDAL_SET_INSTALL_RELATIVE_RPATH=ON?
      -DGDAL_USE_INTERNAL_LIBS=ON
      -DGDAL_USE_EXTERNAL_LIBS=OFF
    cmake --build . -j4
    cmake --build . --target install
    cd $QMSDEVDIR
fi