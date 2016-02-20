# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python{2_7,3_{3,4}})

inherit user distutils-r1 bash-completion-r1 git-r3

DESCRIPTION="Automatation for common tasks around gentoo server upkeep"
HOMEPAGE="https://github.com/lmiphay/gentoo-oam"
EGIT_REPO_URI="https://github.com/lmiphay/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+completion kernel +lnav +ranger"

# >=bash-4.3 is needed for 'local -n / declare -n'
RDEPEND="
	${PYTHON_DEPS}
	app-admin/eclean-kernel
	lnav? ( app-admin/lnav )
	app-admin/logrotate
	app-misc/screen
	ranger? ( app-misc/ranger )
	app-portage/eix
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/portage-utils
	>=app-shells/bash-4.3
	completion? ( app-shells/bash-completion )
	app-text/multitail
	dev-lang/perl
	dev-python/click
	dev-python/fabric
	dev-python/pyyaml
	sys-apps/moreutils[perl]
	sys-fs/inotify-tools
	kernel? ( || ( sys-kernel/gentoo-sources[symlink] sys-kernel/aufs-sources[symlink] ) )
	sys-process/mussh
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README.md"

pkg_setup() {
	enewgroup oam
}

src_install() {
	   # emake DESTDIR="${D}" install
	   # dodoc ${DOCS}
	   distutils-r1_src_install
	   newbashcomp etc/bash.completion oam
}

src_test() {
	true
}
