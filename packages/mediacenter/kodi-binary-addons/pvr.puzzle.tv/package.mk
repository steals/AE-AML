# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present AlexELEC (http://alexelec.in.ua)

PKG_NAME="pvr.puzzle.tv"
PKG_VERSION="fecc5dc"
PKG_SHA256="e288891ce30be449549cfd3a8ea13b84ea5dcb579478add78ee658a0f085f5ec"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/srg70/pvr.puzzle.tv"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform zlib curl rapidjson"
PKG_SECTION=""
PKG_SHORTDESC="pvr.puzzle.tv"
PKG_LONGDESC="pvr.puzzle.tv: IPTV Live TV and Radio PVR client addon for Kodi."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
                       -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr"
