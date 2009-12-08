# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit linux-info linux-mod

DESCRIPTION="Nouveau DRM Kernel Modules for X11"
HOMEPAGE="http://nouveau.freedesktop.org/"
SRC_URI=""

LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="virtual/linux-sources
	!x11-base/x11-drm"
DEPEND="${RDEPEND}
	dev-util/git"

S=${WORKDIR}/master

CONFIG_CHECK="~AGP ~BACKLIGHT_CLASS_DEVICE ~DEBUG_FS !DRM ~FB_CFB_FILLRECT ~FB_CFB_COPYAREA ~FB_CFB_IMAGEBLIT ~FRAMEBUFFER_CONSOLE ~!FB_VESA ~!FB_UVESA ~I2C_ALGOBIT"

pkg_setup() {
	linux-mod_pkg_setup
	if kernel_is lt 2 6 32; then
		eerror "You need at least kernel 2.6.32"
		die "Kernel too old"
	else
		elog "Nouveau DRM is based on the latest development kernels. Upgrade"
		elog "to a newer kernel if the build fails."
	fi
}

src_unpack() {
	wget "http://people.freedesktop.org/~pq/nouveau-drm/master.tar.gz" || die "wget failed"
	tar xfz master.tar.gz -C "${WORKDIR}" || die "untar failed"
	mkdir "${S}"/nouveau || die "mkdir failed"
	wget -O "${S}"/nouveau/Makefile "http://cgit.freedesktop.org/nouveau/linux-2.6/plain/nouveau/Makefile?h=master-compat" || die "wget failed"
}

src_compile() {
	cd nouveau || die "cd failed"
	set_arch_to_kernel
	emake \
		LINUXDIR="${KERNEL_DIR}" \
		GIT_REVISION="$(zcat ${WORKDIR}/master.tar.gz | git get-tar-commit-id)" \
		|| die "Compiling kernel modules failed"
}

src_install() {
	insinto /lib/modules/${KV_FULL}/${PN}
	doins drivers/gpu/drm/{*/,}*.ko || die "doins failed"
}
