# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python2_7 python3_{5,6})

inherit distutils-r1 readme.gentoo-r1

MY_PN="ruamel.bws"

DESCRIPTION="Browser restore to workspace"
HOMEPAGE="https://bitbucket.org/ruamel/bws"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

# MIT as per pypi
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/namespace-ruamel[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	x11-misc/wmctrl
	${RDEPEND}
"

DOCS="README.rst"

S="${WORKDIR}/${MY_PN}-${PV}"

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="
  If browser state isn't being saved as expected check the basenamestart settings
  in ~/.config/bws/bws.ini
"

src_prepare() {
	# remove requirement for 'pip install .'
	sed -i '243,249d' setup.py
	# add 'chrome' as a recognised browser executable
	sed -i -e "s:'chromium-browser':'chrome', 'chromium-browser':" "browserworkspace.py"
	eapply_user
}

python_install_all() {
  distutils-r1_python_install_all
  find "${ED}" -name '*.pth' -delete || die
  readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
