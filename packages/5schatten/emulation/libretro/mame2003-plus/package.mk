# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mame2003-plus"
PKG_VERSION="6ab46db7edcece9201e5d60819ec59e812c71ef5"
PKG_SHA256="671fdb4475b7d859bd2a739440d03b12c81fa588471d5fc0eb141c39cf1709e8"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="https://github.com/libretro/mame2003-plus-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Updated 2018 version of MAME (0.78) for libretro. with added game support plus many fixes and improvements"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="mame2003_plus_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    case ${DEVICE} in
      RPi2)
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
        ;;
      *)
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        ;;
    esac
  fi
  # Fix linking
  export LD="${CC}"
}

pre_make_target() {
  # Enable disclaimer skipping at default
  sed -e "s/\"Skip Disclaimer; disabled|enabled\"/\"Skip Disclaimer; enabled|disabled\"/" -i ${PKG_BUILD}/src/mame2003/mame2003.c
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
