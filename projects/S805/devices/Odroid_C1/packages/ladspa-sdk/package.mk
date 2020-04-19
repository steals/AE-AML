# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ladspa-sdk"
PKG_VERSION="1.15"
#PKG_SHA256="7e87134fac428d2c3a44423119e273d189ef08ee35f4873d7d88d64610af3e0a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.ladspa.org/"
PKG_URL="http://www.ladspa.org/download/ladspa_sdk_$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain alsa-lib libsndfile:host"
PKG_LONGDESC="The LADSPA SDK, including the ladspa.h API header file, ten example LADSPA plugins and three example programs (applyplugin, analyseplugin and listplugins)."
PKG_TOOLCHAIN="manual"

make_target() {
  cd src/
  make
}

make_host() {
 cd src/
 make
}

makeinstall_target() {
  mkdir -p $TOOLCHAIN/include
  mkdir -p $INSTALL/usr/lib/ladspa/include
  cp -r ../plugins/* $INSTALL/usr/lib/ladspa/
  cp ladspa.h $TOOLCHAIN/include/
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/include
  cp ladspa.h $TOOLCHAIN/include
}
