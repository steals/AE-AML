# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycryptodome"
PKG_VERSION="3.9.8"
PKG_SHA256="0e24171cf01021bc5dc17d6a9d4f33a048f09d62cc3f62541e95ef104588bda4"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/pycryptodome"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="PyCryptodome is a self-contained Python package of low-level cryptographic primitives."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHON_VERSION="2.7"
  export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"
  export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
  export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION"
  export LDSHARED="$CC -shared"
  export CPPFLAGS="$CPPFLAGS $PYTHON_CPPFLAGS"
  export LDFLAGS="$LDFLAGS $PYTHON_LDFLAGS"
  export ac_python_version="$PYTHON_VERSION"
  export CFLAGS="$CFLAGS $PYTHON_CPPFLAGS $PYTHON_LDFLAGS"
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"

  mkdir -p $PKG_BUILD/.python3
  cp -r $PKG_BUILD/* .python3
  python setup.py build --cross-compile
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

  # Remove cpython-37-x86_64-linux-gnu from names
  find $INSTALL -name *.so -exec rename "s/\.cpython-37-x86_64-linux-gnu//;" "{}" \;

  # Remove SelfTest bloat
  find $INSTALL -type d -name SelfTest -exec rm -fr "{}" \; 2>/dev/null || true
  find $INSTALL -name SOURCES.txt -exec sed -i "/\/SelfTest\//d;" "{}" \;

  # Create Cryptodome as an alternative namespace to Crypto (Kodi addons may use either)
  ln -sf /usr/lib/$PKG_PYTHON_VERSION/site-packages/Crypto $INSTALL/usr/lib/$PKG_PYTHON_VERSION/site-packages/Cryptodome
  ln -sf /usr/lib/python3.7/site-packages/Crypto $INSTALL/usr/lib/python3.7/site-packages/Cryptodome
}

post_makeinstall_target() {
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/$PKG_NAME-*.egg-info
}
