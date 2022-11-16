This directory contains:

Folders:
- routino-patch: contains files for patching Routino

Scripts for the overall build process:

- build-all.sh: automatically builds QMapShack. (calls sub build scripts, more modular)
        The only manual intervention is to pass the admin password for changing paths in dylibs

Scripts for building partial steps in the build process
- env_build_vars.sh: sets shell variables for the build process (needed by every build step)
- install-brew-packages.sh: installs homebrew (if needed) and packages for the build process
                            package files are also copied to local environment
- build-quazip.sh: builds Quazip
- build-routino.sh: builds Routino
- build-gdal.sh: builds GDAL (currently not used since brew packages is used instead)
- patch-QMS.sh: Patches QMapShack (ideally empty)
- build-QMS.sh: builds (patched) QMapShack
- bundle.sh: bundles and signs QMapShack

- clean.sh: cleans all build artifacts, except for brew*diff.txt (which lists brew packages installed for the build process)
- create_local_env: create a local environment where all external libs/packages can be saved
    (Idea: the libs can be downloaded via package managers and copied 
    or directly from the internet. 
    Subsequent build process will be from then on independent libs spread across the file system
    Build processes, like bundling have still to be adapted (WiP)).

- file "HowtoBuildOSX-d029940.txt" describes how to build QMapShack w/o using "build-QMS.sh"

To run the complete build process:
1. Create a dir to build QMapShack and cd into this directory
2. Download https://github.com/d029940/qmapshack/blob/dev/MacOSX/QMS_build_files/build-all.sh and put it into this dir
4. run "sh build-all.sh | tee log.txt"
5. ATTENTION: manual intervention is needed for:
        - applying admin password while changing dylibs (Apple requirement)
        - hitting ENTER to conform that QMapShack has uncommited changes (ref. to PATCH_QMapShack=1)
6. check log.txt if an error occured
7. check brew*.diff for unwanted packages installed by homebrew


   
