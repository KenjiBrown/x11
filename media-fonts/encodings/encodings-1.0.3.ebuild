# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/encodings/encodings-1.0.3.ebuild,v 1.2 2009/10/12 19:46:32 scarabeus Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

EAPI=2
inherit x-modular-r2

DESCRIPTION="X.Org font encodings"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale
	>=media-fonts/font-util-1.1.1-r1
	>=x11-misc/util-macros-1.3.0"

ECONF_SOURCE="${S}"

src_compile() {
	mkdir "${S}"/build
	cd "${S}"/build
	x-modular-r2_src_compile
}

src_install() {
	cd "${S}"/build
	x-modular-r2_src_install
}
