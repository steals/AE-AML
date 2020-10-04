# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="aceproxy"
PKG_VERSION="e5fc845"
PKG_SHA256="3671ecce8f1b8c4925570f6d48ec6b0c086903241e02878f3f03cb285aa4146b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/AndreyPavlenko/aceproxy"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain gevent psutil M2Crypto requests"
PKG_LONGDESC="AceProxy: Ace Stream HTTP Proxy."
PKG_TOOLCHAIN="manual"

make_target() {
  : # nothing to make here
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/aceproxy
    cp -PR $PKG_BUILD/aceclient \
           $PKG_BUILD/plugins \
           $PKG_BUILD/vlcclient \
           $PKG_BUILD/*.py \
           $INSTALL/usr/config/aceproxy

  rm -f $INSTALL/usr/config/aceproxy/setup_win32.py
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service aceproxy.service
}
