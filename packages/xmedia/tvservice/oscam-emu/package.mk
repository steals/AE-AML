# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="oscam-emu"
PKG_VERSION="80a4352"
PKG_LICENSE="GPL"
PKG_SITE="http://www.streamboard.tv/svn/oscam"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain pcsc-lite openssl"
PKG_LONGDESC="OSCam is Open Source Conditional Access Modul."

#colors
  YELLOW="\033[1;33m"
  ENDCOLOR="\033[0m"

unpack() {
  git clone https://github.com/oscam-emu/oscam-patched.git $PKG_BUILD
  cd $PKG_BUILD
  git reset --hard $PKG_VERSION
  cd $ROOT
}

post_patch() {
  cd $PKG_BUILD
  OSCAM_REVISION=`./config.sh --oscam-revision`
  echo "-----------------------------------------------------------"
  echo -e $YELLOW"****** Oscam revision: $OSCAM_REVISION ******"$ENDCOLOR
  echo "-----------------------------------------------------------"
  echo $OSCAM_REVISION > oscam.revision
  cd $ROOT
}

PKG_CMAKE_OPTS_TARGET="-DLIBUSBDIR=$SYSROOT_PREFIX/usr \
                       -DCMAKE_INSTALL_PREFIX=/usr \
                       -DWITH_SSL=1 \
                       -DHAVE_LIBCRYPTO=1 \
                       -DHAVE_DVBAPI=1 \
                       -DWITH_STAPI=0 \
                       -DWEBIF=1 \
                       -DWITH_EMU=1 \
                       -DWITH_DEBUG=0 \
                       -DOPTIONAL_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include \
                       -DSTATIC_LIBUSB=1 \
                       -DCLOCKFIX=0 \
                       -DCARDREADER_DB2COM=OFF"

makeinstall_target() {
  mkdir -p  $INSTALL/usr/config/oscam
    cp -a $PKG_DIR/bin $INSTALL/usr/config/oscam
    cp -a $PKG_DIR/config $INSTALL/usr/config/oscam

  OSCAM_REVISION=`cat $PKG_BUILD/oscam.revision`
    sed -e "s|@OSCAM_REVISION@|$OSCAM_REVISION|g" -i $INSTALL/usr/config/oscam/config/oscam.conf
    sed -e "s|@OSCAM_REVISION@|$OSCAM_REVISION|g" -i $INSTALL/usr/config/oscam/config/oscam.server
    sed -e "s|@OSCAM_REVISION@|$OSCAM_REVISION|g" -i $INSTALL/usr/config/oscam/config/oscam.user

  mkdir -p  $INSTALL/usr/bin
    cp $PKG_BUILD/.$TARGET_NAME/oscam $INSTALL/usr/bin
    cp $PKG_BUILD/.$TARGET_NAME/utils/list_smargo $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service oscam.service
}
