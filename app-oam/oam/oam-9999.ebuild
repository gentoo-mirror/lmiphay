# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 pypy )

inherit user distutils-r1 bash-completion-r1 git-r3

DESCRIPTION="Operations and maintenance automation for gentoo servers"
HOMEPAGE="https://github.com/lmiphay/oam"
EGIT_REPO_URI="https://github.com/lmiphay/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lnav +ranger"

RDEPEND="
	${PYTHON_DEPS}
	lnav? ( app-admin/lnav )
	app-admin/logrotate
	ranger? ( app-misc/ranger )
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/portage-utils
	app-text/multitail
	dev-python/attrdict[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/eliot[${PYTHON_USEDEP}]
	dev-python/eliot-tree[${PYTHON_USEDEP}]
	dev-python/inotifyx[${PYTHON_USEDEP}]
	>=dev-python/invoke-0.22.0[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README.md"

pkg_setup() {
	enewgroup oam
}

python_install_all() {
	dodoc ${DOCS}
	newbashcomp etc/bash.completion oam
	distutils-r1_python_install_all

	keepdir /var/log/oam/old

	fowners -R "root:oam"  "/etc/oam"
	fowners -R "root:oam"  "/var/log/oam"
	fowners    "root:root" "/etc/cron.daily/oam"

	fperms 640 "/etc/oam/oam.yaml"
	fperms 750 "/etc/oam/conf.d" "/etc/oam/localtasks"
	# fperms 640 /etc/oam/conf.d/*.yaml /etc/oam/localtasks/*.py
	chmod 0640 "${ED}"/etc/oam/conf.d/*.yaml "${ED}"/etc/oam/localtasks/*.py || die
	fperms 770 "/var/log/oam"
	fperms 755 "/etc/cron.daily/oam"

	insinto /etc/logrotate.d
	newins etc/oam.logrotate oam
}

python_test() {
	true
}
