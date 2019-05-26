# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present AlexELEC (http://alexelec.in.ua)

PKG_NAME="pvr.puzzle.tv"
PKG_VERSION="e3ace87"
PKG_SHA256="65f097a06d9fb910ff754cc0b6e552a34a3b8515b93c2f5fca95f5de70d1fb97"
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
