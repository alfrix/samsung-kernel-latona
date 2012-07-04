#!/bin/bash -x
CYANOGENMOD=../../..

# Make mrproper
make mrproper

# Set config
make latona_galaxysl_defconfig

# Make modules
nice -n 10 make -j4 modules

# Strip modules
find -name '*.ko' -exec -print $CYANOGENMOD/prebuilt/linux-x86/toolchain/linaro-4.6/bin/arm-eabi-strip --strip-unneeded {} \;

# Copy modules
find -name '*.ko' -exec cp -av {} $CYANOGENMOD/device/samsung/galaxysl/modules/ \;

# Build kernel
nice -n 10 make -j4 zImage

# Copy kernel
cp arch/arm/boot/zImage $CYANOGENMOD/device/samsung/galaxysl/kernel

# Make mrproper
make mrproper

