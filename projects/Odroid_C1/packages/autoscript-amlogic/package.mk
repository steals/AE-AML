# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="autoscript-amlogic"
PKG_VERSION="s8xx"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain u-boot-tools:host"
PKG_LONGDESC="Autoscript package for Amlogic devices"
PKG_TOOLCHAIN="manual"

make_target() {
  #mkdir -p $RELEASE_DIR/target
  $TOOLCHAIN/bin/mkimage -A arm -T ramdisk -n RootFS\ [$PROJECT] -C none -d $INSTALL/../initramfs.cpio \
    $RELEASE_DIR/target/INITRD
  ( cd $RELEASE_DIR; md5sum -t target/INITRD > target/INITRD.md5; )
}

makeinstall_target() {
  mkdir -p $RELEASE_DIR/3rdparty/bootloader
  if [ -e $BUILD/u-boot-*/$UBOOT_CONFIGFILE ]; then
    cp -PR $BUILD/u-boot-*/$UBOOT_CONFIGFILE $RELEASE_DIR/3rdparty/bootloader
  fi

  cp -PR $BUILD/u-boot-*/SPL* $RELEASE_DIR/3rdparty/bootloader 2>/dev/null || :
  cp -PR $BUILD/u-boot-*/u-boot*.imx $RELEASE_DIR/3rdparty/bootloader 2>/dev/null || :
  cp -PR $BUILD/u-boot-*/u-boot*.img $RELEASE_DIR/3rdparty/bootloader 2>/dev/null || :

  cp -PR $PROJECT_DIR/$PROJECT/bootloader/uEnv*.txt $RELEASE_DIR/3rdparty/bootloader 2>/dev/null || :

  cp -PR $BUILD/linux-*/arch/$TARGET_KERNEL_ARCH/boot/dts/*.dtb $RELEASE_DIR/3rdparty/bootloader 2>/dev/null || :

  case $PROJECT in
    Odroid_C2)
      cp -PR $BUILD/$BOOTLOADER-*/u-boot.bin $RELEASE_DIR/3rdparty/bootloader/u-boot
      cp -PR $PROJECT_DIR/$PROJECT/bootloader/boot.ini $RELEASE_DIR/3rdparty/bootloader
      if [ -f $PROJECT_DIR/$PROJECT/splash/boot-logo.bmp.gz ]; then
        cp -PR $PROJECT_DIR/$PROJECT/splash/boot-logo.bmp.gz $RELEASE_DIR/3rdparty/bootloader
      elif [ -f $DISTRO_DIR/$DISTRO/splash/boot-logo.bmp.gz ]; then
        cp -PR $DISTRO_DIR/$DISTRO/splash/boot-logo.bmp.gz $RELEASE_DIR/3rdparty/bootloader
      fi
      ;;
    Odroid_C1)
      cp -PR $BUILD/$BOOTLOADER-*/sd_fuse/bl1.bin.hardkernel $RELEASE_DIR/3rdparty/bootloader/bl1
      cp -PR $BUILD/$BOOTLOADER-*/sd_fuse/u-boot.bin $RELEASE_DIR/3rdparty/bootloader/u-boot
      cp -PR $PROJECT_DIR/$PROJECT/bootloader/boot.ini $RELEASE_DIR/3rdparty/bootloader
      ;;
  esac

}
