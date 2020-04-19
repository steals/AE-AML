# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="blop"
PKG_VERSION="0.2.8"
PKG_SHA256="7e87134fac428d2c3a44423119e273d189ef08ee35f4873d7d88d64610af3e0a"
PKG_LICENSE="GPL"
PKG_SITE="http://blop.sourceforge.net/"
PKG_URL="https://downloads.sourceforge.net/sourceforge/project/blop/blop/0.2/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib ladspa-sdk:host"
PKG_LONGDESC="Bandlimited oscillator plugins for LADSPA-aware audio applications"
PKG_AUTORECONG="yes"
PKG_TOOLCHAIN="configure"

#PKG_CONFIGURE_OPTS_TARGET="--prefix=$SYSROOT_PREFIX/usr --with-ladspa-prefix=$SYSROOT_PREFIX/usr --with-ladspa-plugin-dir=/usr/lib/ladspa"

pre_configure_target() {
 export CFLAGS="$CFLAGS -DNO_DEBUG -fPIC -DPIC" 
 cd $PKG_BUILD
}

configure_target() {
 ./configure --host="armv7a-libreelec-linux-gnueabi" --build="x86_64-linux-gnu" --prefix="$SYSROOT_PREFIX/usr" --disable-static --enable-shared --with-ladspa-prefix="$SYSROOT_PREFIX/usr" --with-ladspa-plugin-dir="/usr/lib/ladspa"
}

