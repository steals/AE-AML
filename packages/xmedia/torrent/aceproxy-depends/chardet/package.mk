# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="chardet"
PKG_VERSION="3.0.4"
PKG_SHA256="d5620025cfca430f6c2e28ddbc87c3c66a5c82fa65570ae975c92911c2190189"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/chardet/chardet"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="Python module for character encoding auto-detection."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  mkdir -p $PKG_BUILD/.python3
  cp -r $PKG_BUILD/* .python3
  python setup.py build --cross-compile
  cd $PKG_BUILD/.python3
  python3 setup.py build
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
  cd $PKG_BUILD/.python3
  python3 setup.py install --root=$INSTALL --prefix=/usr
  rm -fR $INSTALL/usr/bin
}

post_makeinstall_target() {
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/$PKG_NAME-*.egg-info
}
