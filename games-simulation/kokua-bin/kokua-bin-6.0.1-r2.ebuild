# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator

# check: https://sourceforge.net/projects/kokua.team-purple.p/files/Kokua-SL/Linux64Bit/
REVISION=44610

DESCRIPTION="An open source metaverse viewer"
HOMEPAGE="http://blog.kokuaviewer.org/"

MY_PV=$(get_version_component_range 1-3 $(replace_all_version_separators '_'))
MY_P="Kokua_RLV_${MY_PV}_${REVISION}_x86_64"
SRC_URI="mirror://sourceforge/kokua.team-purple.p/Kokua-SL/Linux64Bit/${MY_P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2-with-Linden-Lab-FLOSS-exception"
SLOT="0"
KEYWORDS="~amd64 -*"
IUSE="fmod"

INST_DIR="opt/kokua-bin"
QA_PREBUILT="${INST_DIR}/*"

RDEPEND="
	sys-libs/glibc
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/openssl
	dev-libs/boost
	media-libs/freetype
	media-libs/libogg
	media-libs/libpng:1.2
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/gstreamer
	media-plugins/gst-plugins-meta
	fmod? ( media-libs/fmod )
	net-libs/gnutls
	net-misc/curl
	net-dns/c-ares
	sys-libs/zlib
	virtual/glu
	virtual/opengl
"
DEPEND="${RDEPEND}
	app-admin/chrpath
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rm lib64/libpng12.so* lib64/libSDL-1.2.so.0* || die
	# shouldn't need to null RPATH with chrpath - but scanelf
	# reports 'Security problem NULL DT_RPATH' otherwise
	chrpath -r '' lib32/libalut.so.0.0.0
	scanelf -Xr lib32/libalut.so.0.0.0
	eapply_user
}

src_install() {
	mkdir -p "${D}/${INST_DIR}/"
	cp -a . "${D}/${INST_DIR}/" || die
	dobin "${FILESDIR}/kokua"
	make_desktop_entry /usr/bin/kokua "Kokua Viewer (bin)" /${INST_DIR}/kokua_icon.png
}
