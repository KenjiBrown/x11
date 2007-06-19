# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/libdrm-2.0.ebuild,v 1.8 2006/03/10 20:27:22 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit autotools x-modular git

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"
EGIT_BOOTSTRAP="eautoreconf"

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
SRC_URI=""
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}"

pkg_preinst() {
	x-modular_pkg_preinst

	if [[ -e ${ROOT}/usr/$(get_libdir)/libdrm.so.1 ]] ; then
		cp -pPR "${ROOT}"/usr/$(get_libdir)/libdrm.so.{1,1.0.0} "${IMAGE}"/usr/$(get_libdir)/
	fi
}

pkg_postinst() {
	x-modular_pkg_postinst

	if [[ -e ${ROOT}/usr/$(get_libdir)/libdrm.so.1 ]] ; then
		ewarn "You must re-compile all packages that are linked against"
		ewarn "libdrm 1 by using revdep-rebuild from gentoolkit:"
		ewarn "# revdep-rebuild --library libdrm.so.1"
		ewarn "After this, you can delete /usr/$(get_libdir)/libdrm.so.1"
		ewarn "and /usr/$(get_libdir)/libdrm.so.1.0.0 ."
		epause
	fi
}
