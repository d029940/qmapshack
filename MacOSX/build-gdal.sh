#!/bin/sh

source $QMSDEVDIR/qmapshack/MacOSX/config.sh   # check for important paramters
echo "${ATTN}Building GDAL ...${NC}"
echo "${ATTN}-----------------${NC}"

######################################################################## 
# build GDAL (experimental: now using cmake)
    echo "${ATTN}Building GDAL ...${NC}"
    cd $QMSDEVDIR
    git clone -b "release/$GDAL_RELEASE" https://github.com/OSGeo/gdal.git
# --> folder $QMSVERDIR/gdal/ created
    cd $QMSDEVDIR/gdal
    mkdir build
    cd ./build
    # Boost headers need to be in the include path
    CPATH="$LOCAL_ENV/include:$PACKAGES_PATH/include:${CPATH}"
    $PACKAGES_PATH/bin/cmake ..  -DCMAKE_PREFIX_PATH=$GDAL -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$GDAL -DGDAL_SET_INSTALL_RELATIVE_RPATH=ON -DGDAL_USE_INTERNAL_LIBS=ON -DGDAL_USE_EXTERNAL_LIBS=OFF -DCMAKE_DISABLE_FIND_PACKAGE_Arrow=ON -DOGR_BUILD_OPTIONAL_DRIVERS=OFF
    $PACKAGES_PATH/bin/cmake --build . -j4
    $PACKAGES_PATH/bin/cmake --build . --target install
    cd $QMSDEVDIR