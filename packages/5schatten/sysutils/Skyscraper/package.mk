# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="Skyscraper"
PKG_VERSION="3.2.1"
PKG_SHA256="cf505ae1628062d35d873f89dcfac77b8c57607ebe91d3369fa086fddc7abcff"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/muldjord/skyscraper"
PKG_URL="https://github.com/muldjord/skyscraper/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain qt-everywhere"
PKG_LONGDESC="A powerful and versatile yet easy to use game scraper written in C++ for use with multiple frontends running on a Linux system."
PKG_TOOLCHAIN="make"

configure_target() {
  # Fix install paths
  sed -e "s#target.path=/usr/local/bin#target.path=${INSTALL}/usr/bin#"                                                       -i ${PKG_BUILD}/skyscraper.pro
  sed -e "s#examples.path=/usr/local/etc/skyscraper#examples.path=${INSTALL}/usr/share/skyscraper#"                           -i ${PKG_BUILD}/skyscraper.pro
  sed -e "s#cacheexamples.path=/usr/local/etc/skyscraper/cache#cacheexamples.path=${INSTALL}/usr/share/skyscraper/cache#"     -i ${PKG_BUILD}/skyscraper.pro
  sed -e "s#impexamples.path=/usr/local/etc/skyscraper/import#impexamples.path=${INSTALL}/usr/share/skyscraper/import#"       -i ${PKG_BUILD}/skyscraper.pro
  sed -e "s#resexamples.path=/usr/local/etc/skyscraper/resources#resexamples.path=${INSTALL}/usr/share/skyscraper/resources#" -i ${PKG_BUILD}/skyscraper.pro

  # Generate qmake config
  rm -rf .qmake.stash
  qmake ${PKG_BUILD}/skyscraper.pro
}

post_makeinstall_target() {
  # Install scripts 
  mv ${INSTALL}/usr/bin/Skyscraper ${INSTALL}/usr/bin/skyscraper-bin
  ln -sf /usr/bin/skyscraper       ${INSTALL}/usr/bin/Skyscraper
  cp ${PKG_DIR}/scripts/*          ${INSTALL}/usr/bin/

  # Install config
  mkdir -p ${INSTALL}/usr/config/skyscraper
  cp ${PKG_DIR}/config/* ${INSTALL}/usr/config/skyscraper/
}
