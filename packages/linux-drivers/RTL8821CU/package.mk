# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="RTL8821CU"
PKG_VERSION="45a8b43"
#PKG_SHA256="29d3e053dd1fad37ee03de65e4ed2b25a4fb9aaf8bb6bd435da477753d03ad26"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/brektrou/rtl8821CU"
PKG_URL="https://github.com/brektrou/rtl8821CU/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="rtl8821CU-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_LONGDESC="Realtek RTL8821CU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
  sed -i '102s|CONFIG_MP_VHT_HW_TX_MODE = y|CONFIG_MP_VHT_HW_TX_MODE = n|' Makefile
}

make_target() {
  make \
       ARCH=$TARGET_KERNEL_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
