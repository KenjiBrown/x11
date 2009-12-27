# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit linux-info x-modular-r2

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://cgit.freedesktop.org/xorg/driver/xf86-input-synaptics/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="hal"

RDEPEND="
	>=x11-base/xorg-server-1.6
	>=x11-libs/libXi-1.2
	x11-libs/libXtst
	hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	>=sys-apps/sed-4"

src_install() {
	DOCS="INSTALL TODO README"
	x-modular-r2_src_install

	if use hal ; then
		insinto /usr/share/hal/fdi/policy/10osvendor
		doins "${S}"/fdi/11-x11-synaptics.fdi
	fi
}

pkg_postinst() {
	x-modular-r2_pkg_postinst
	# Just a friendly warning
	if linux_config_exists; then
		if ! linux_chkconfig_present INPUT_EVDEV; then
			echo
			ewarn "This driver requires event interface support in your kernel"
			ewarn "  Device Drivers --->"
			ewarn "    Input device support --->"
			ewarn "      <*>     Event interface"
			echo
		fi
	fi
	if use hal ; then
		elog "If you want to modify Synaptics settings, please create an fdi file in:"
		elog "/etc/hal/fdi/policy/"
		echo
		ewarn "The current default are set by :"
		ewarn "/usr/share/hal/fdi/policy/10osvendor/11-x11-synaptics.fdi"
		ewarn "You can use this file for inspiration, but DO NOT EDIT IT directly."
	fi
}
