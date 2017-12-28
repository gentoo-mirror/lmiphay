# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python2_7 python3_{4,5,6})

inherit eutils distutils-r1

DESCRIPTION="Calculations for the position of the sun and moon"
HOMEPAGE=""
SRC_URI="https://github.com/sffjunkie/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README"

src_prepare() {
	sed -i -e 's;version=versioneer.get_version();version="1.4.1";' "setup.py"
	sed -i -e 's;versioneer.get_cmdclass();{};' "setup.py"

	eapply_user
}
