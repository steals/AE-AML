# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)

PKG_NAME="simplejson"
PKG_VERSION="3.15.0"
PKG_SHA256="ad332f65d9551ceffc132d0a683f4ffd12e4bc7538681100190d577ced3473fb"
PKG_LICENSE="OSS"
PKG_SITE="http://pypi.org/project/simplejson"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="A simple, fast, complete, correct and extensible JSON encoder and decoder for Python 2.5+."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export PYTHON_VERSION="2.7"
  export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
  export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION"
  export LDSHARED="$CC -shared"
  export CPPFLAGS="$CPPFLAGS $PYTHON_CPPFLAGS"
  export LDFLAGS="$LDFLAGS $PYTHON_LDFLAGS"
  mkdir -p $PKG_BUILD/.python3
  cp -r $PKG_BUILD/* .python3

  python setup.py build --cross-compile
  python setup.py install --root=$INSTALL --prefix=/usr
}

make_target() {
  export PYTHON_VERSION="3.7"
  export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
  export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION"
  export LDSHARED="$CC -shared"
  export CPPFLAGS="$CPPFLAGS $PYTHON_CPPFLAGS"
  export LDFLAGS="$LDFLAGS $PYTHON_LDFLAGS"

  cd $PKG_BUILD/.python3
  python3 setup.py build
}

makeinstall_target() {
  cd $PKG_BUILD/.python3
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
  rm -rf $INSTALL/usr/lib/python*/site-packages/$PKG_NAME-*.egg-info
}
