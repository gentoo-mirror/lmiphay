# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="UPnP Dev Kit with patches for castbridge"
HOMEPAGE="http://pupnp.sourceforge.net/"
SRC_URI="mirror://sourceforge/pupnp/libupnp-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux"
IUSE="debug doc ipv6 static-libs"

RDEPEND="
"
DEPEND="${RDEPEND}
	!net-libs/libupnp
"

DOCS="NEWS README ChangeLog"

S="${WORKDIR}/libupnp-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-suse.patch
	epatch "${FILESDIR}"/${P}-httpreadwrite.c.patch
	epatch "${FILESDIR}"/${P}-upnp.h.patch
	epatch "${FILESDIR}"/${P}-webserver.c.patch

	# fix tests
	chmod +x ixml/test/test_document.sh || die

	eautoreconf
}

src_configure() {
	use x86-fbsd &&	append-flags -O1
	# w/o docdir to avoid sandbox violations
	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable static-libs static) \
		$(use_with doc documentation "${EPREFIX}/usr/share/doc/${PF}")
}

src_install () {
	default
	dobin upnp/sample/.libs/tv_{combo,ctrlpt,device}
	use static-libs || prune_libtool_files
}

pkg_postinst() {
	ewarn "Please remember to run revdep-rebuild when upgrading"
	ewarn "from libupnp 1.4.x to libupnp 1.6.x , so packages"
	ewarn "gets linked with the new library."
	echo ""
	ewarn "The revdep-rebuild script is part of the"
	ewarn "app-portage/gentoolkit package."
}
