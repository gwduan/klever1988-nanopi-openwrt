#!/bin/bash
#Require:
#  1 build environment(ref: https://github.com/QiuSimons/R2S-OpenWrt)
#  2 sudo without password

#Initialization Environment
/bin/bash custom/1_initialization_environment-custom.sh

#Clone Source
/bin/bash custom/2_clone_source-custom.sh master-v19.07.1 rk3328 < /dev/null

#Patch Kernel
/bin/bash patch_kernel_5.4.sh

#Mods
/bin/bash custom/mods_lean-custom.sh

#Build FriendlyWrt
begin_time=`date`
/bin/bash 4_build_image.sh friendlywrt-rk3328 nanopi_r2s.mk
end_time=`date`

echo "Build time:"
echo "Begin: $begin_time"
echo "End:   $end_time"

exit 0
