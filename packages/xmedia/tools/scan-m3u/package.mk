# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="scan-m3u"
PKG_VERSION="latest"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alexelec.in.ua"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain jq"
PKG_LONGDESC="scan-m3u: create IPTV channels list for Torrent-TV."
PKG_TOOLCHAIN="manual"

pre_make_target(){
  CONFIG_FILE="$ROOT/private/$PKG_NAME/ttv.conf"
  if [ -f "$CONFIG_FILE" ]; then
    . $CONFIG_FILE
    sed -e "s|@TTV_WORD@|$TTV_WORD|g; s|@TTV_LOGIN@|$TTV_LOGIN|g; s|@TTV_PASSW@|$TTV_PASSW|g" -i $PKG_BUILD/ttv-logo.src
    sed -e "s|@TTV_WORD@|$TTV_WORD|g; s|@TTV_LOGIN@|$TTV_LOGIN|g; s|@TTV_PASSW@|$TTV_PASSW|g" -i $PKG_BUILD/ttv-xmltv.src
  else
    sed -e "s|@TTV_WORD@|code_word|g; s|@TTV_LOGIN@|code_login|g; s|@TTV_PASSW@|code_password|g" -i $PKG_BUILD/ttv-logo.src
    sed -e "s|@TTV_WORD@|code_word|g; s|@TTV_LOGIN@|code_login|g; s|@TTV_PASSW@|code_password|g" -i $PKG_BUILD/ttv-xmltv.src
  fi
}

make_target() {
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvget-live.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvget-direct.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvstream.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttv-logo.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttv-xmltv.src
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp ttvget-live.src.x $INSTALL/usr/bin/ttvget-live
    cp ttvget-direct.src.x $INSTALL/usr/bin/ttvget-direct
    cp ttvstream.src.x $INSTALL/usr/bin/ttvstream
      ln -sf ttvstream $INSTALL/usr/bin/ttvstream-direct
    cp ttv-logo.src.x $INSTALL/usr/bin/ttv-logo
    cp ttv-xmltv.src.x $INSTALL/usr/bin/ttv-xmltv
  mkdir -p $INSTALL/usr/config/acestream
    cp $PKG_DIR/config/* $INSTALL/usr/config/acestream

  # youtube-dl
  mkdir -p $INSTALL/usr/config/youtube-dl
    cp $PKG_DIR/scripts/* $INSTALL/usr/config/youtube-dl
    ln -sf /storage/.config/youtube-dl/youtube-play $INSTALL/usr/bin/youtube-play
    ln -sf /storage/.config/youtube-dl/youtube-dl $INSTALL/usr/bin/youtube-dl
}
