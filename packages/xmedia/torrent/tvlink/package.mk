# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="tvlink"
PKG_VERSION="latest"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/AlexELEC/TVLINK-aml"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain vlc Python2 requests pycryptodome pycountry pyisodate pysocks pywebsocket pysix"
PKG_LONGDESC="TVLink: IPTV channel aggregator."
PKG_TOOLCHAIN="manual"

make_target() {
  : # nothing to make here
}

makeinstall_target() {
  : # nothing to install here
}

post_install() {
  enable_service tvlink.service
}
