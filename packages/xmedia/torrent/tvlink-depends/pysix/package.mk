# SPDX-License-Identifier: GPL-2.0-or-later Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="PySix"
PKG_VERSION="1.15.0"
#PKG_SHA256="dcacea1b6a7bfd2cbb6c6a05743606b428f2739f37825e41fbf79af3cc2fd240"
PKG_LICENSE="Apache"
PKG_SITE="https://github.com/benjaminp/six"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="PySocks lets you send traffic through SOCKS proxy servers"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  python3 setup.py build
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/python*/site-packages/$PKG_NAME-*.egg-info
}

