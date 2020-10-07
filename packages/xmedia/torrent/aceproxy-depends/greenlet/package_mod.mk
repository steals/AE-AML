# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="greenlet"
PKG_VERSION="0.4.15"
PKG_SHA256="9416443e219356e3c31f1f918a91badf2e37acf297e2fa13d24d1cc2380f8fbc"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.python.org/pypi/greenlet"
PKG_URL="https://files.pythonhosted.org/packages/f8/e8/b30ae23b45f69aa3f024b46064c0ac8e5fcb4f22ace0dca8d6f9c8bbe5e7/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="Lightweight in-process concurrent programming."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHON_VERSION="2.7"
  export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
  export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION -lpython$PYTHON_VERSION"
  export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"
  export ac_python_version="$PYTHON_VERSION"

  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
  export CFLAGS="$CFLAGS $PYTHON_CPPFLAGS $PYTHON_LDFLAGS"

  mkdir -p $PKG_BUILD/.python3
  cp -r $PKG_BUILD/* .python3
  python setup.py build
  python setup.py install --root=$INSTALL --prefix=/usr
}


make_target() {
  export PYTHON_VERSION="3.7"
  export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"
  export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
  export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION"
  export LDSHARED="$CC -shared"
  export CFLAGS=`echo $CFLAGS | sed -e "s|python2.7|python3.7|g"`
  export CPPFLAGS="$CPPFLAGS $PYTHON_CPPFLAGS"
  export LDFLAGS="$LDFLAGS $PYTHON_LDFLAGS"
  export ac_python_version="$PYTHON_VERSION"
  export CFLAGS="$CFLAGS $PYTHON_CPPFLAGS $PYTHON_LDFLAGS"

  cd $PKG_BUILD/.python3
  python3 setup.py build
}

makeinstall_target() {
  cd $PKG_BUILD/.python3
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/$PKG_NAME-*.egg-info
}
