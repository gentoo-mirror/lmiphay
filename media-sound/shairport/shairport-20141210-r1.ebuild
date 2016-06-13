# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils user git-r3

DESCRIPTION="Emulates an AirPort Express to stream music from i-devices"
HOMEPAGE="http://www.mafipulation.org"

EGIT_REPO_URI="https://github.com/abrasive/shairport.git"
EGIT_COMMIT="d65b8e86e3048181d7c002bada4d879ee49f3f84"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ao +alsa +avahi +pulseaudio"

DEPEND="
	dev-libs/openssl
	ao? ( media-libs/libao )
	pulseaudio? ( media-sound/pulseaudio )
	alsa? ( media-libs/alsa-lib )
	avahi? ( net-dns/avahi )
"
RDEPEND="${DEPEND}
"

pkg_setup() {
	enewgroup shairport
	if use pulseaudio ; then
		enewuser shairport -1 -1 -1 "shairport"
	else
		enewuser shairport -1 -1 -1 "shairport,audio"
	fi
}

src_prepare () {
	use ao         || sed -i '/CONFIG_AO/d' configure
	use pulseaudio || sed -i '/CONFIG_PULSE/d' configure
	use alsa       || sed -i '/CONFIG_ALSA/d' configure
	use avahi      || sed -i '/do_pkg_config.*CONFIG_AVAHI/d' configure
	eapply_user
}

src_install() {
	dobin shairport
	dodoc README.md
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
