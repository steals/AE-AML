# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cmt"
PKG_VERSION="1.17"
#PKG_SHA256="7e87134fac428d2c3a44423119e273d189ef08ee35f4873d7d88d64610af3e0a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.ladspa.org/"
PKG_URL="http://www.ladspa.org/download/cmt_$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain alsa-lib ladspa-sdk"
PKG_LONGDESC="The Computer Music Toolkit (CMT) is a collection of LADSPA plugins for use with software synthesis and recording packages on Linux."
PKG_TOOLCHAIN="manual"

make_target() {
  cd src/
  make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/ladspa/
  cp -r ../plugins/* $INSTALL/usr/lib/ladspa/
}
