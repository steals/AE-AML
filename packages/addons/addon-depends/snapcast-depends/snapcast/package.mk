# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="snapcast"
PKG_VERSION="0.18.1"
PKG_SHA256="425afb7e24768ca08c247dc394aaa25fd2a6886e6789e18c6f024eabd7e0f688"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/badaix/snapcast"
PKG_URL="https://github.com/badaix/snapcast/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain aixlog alsa-lib avahi flac libvorbis opus"
PKG_LONGDESC="Synchronous multi-room audio player."
PKG_TOOLCHAIN="make"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
  CXXFLAGS="$CXXFLAGS -pthread \
                      -I$(get_build_dir aixlog)/include \
                      -I$(get_build_dir asio)/asio/include \
                      -I$(get_build_dir popl)/include"
}

makeinstall_target() {
  :
}
