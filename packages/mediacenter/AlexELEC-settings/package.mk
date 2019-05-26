# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2011-present AlexELEC (http://alexelec.in.ua)

PKG_NAME="AlexELEC-settings"
PKG_VERSION="ae6e23f"
PKG_SHA256="f007834ee3dffbb3c415d7f0883603399d2e0c46053c7553504fdd9decbbe215"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/AlexELEC/service.alexelec.settings"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 connman pygobject dbus-python bkeymaps"
PKG_LONGDESC="AlexELEC-settings: is a settings dialog for AlexELEC"

PKG_MAKE_OPTS_TARGET="DISTRONAME=$DISTRONAME ROOT_PASSWORD=$ROOT_PASSWORD"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/alexelec
    cp $PKG_DIR/scripts/* $INSTALL/usr/lib/alexelec

  ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons/service.alexelec.settings

  $TOOLCHAIN/bin/python -Wi -t -B $TOOLCHAIN/lib/$PKG_PYTHON_VERSION/compileall.py $ADDON_INSTALL_DIR/resources/lib/ -f
  rm -rf $(find $ADDON_INSTALL_DIR/resources/lib/ -name "*.py")

  $TOOLCHAIN/bin/python -Wi -t -B $TOOLCHAIN/lib/$PKG_PYTHON_VERSION/compileall.py $ADDON_INSTALL_DIR/oe.py -f
  rm -rf $ADDON_INSTALL_DIR/oe.py

  chmod -R +x $ADDON_INSTALL_DIR/resources/bin/*
}

post_install() {
  enable_service backup-restore.service
  enable_service factory-reset.service
}
