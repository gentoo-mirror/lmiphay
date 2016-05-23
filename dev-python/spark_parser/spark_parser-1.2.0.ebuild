# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4})

inherit distutils-r1

DESCRIPTION="An Early-Algorithm Context-free grammar Parser"
HOMEPAGE="https://github.com/rocky/python-spark"
SRC_URI="https://github.com/rocky/python-spark/archive/release-${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README.md"

S="${WORKDIR}/python-spark-release-${PV}"
