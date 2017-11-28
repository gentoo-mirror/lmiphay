# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} pypy )

inherit distutils-r1 git-r3

DESCRIPTION="unlock an open console kit session via dbus"
HOMEPAGE="https://github.com/lmiphay/ckunlock"
EGIT_REPO_URI="https://github.com/lmiphay/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-tasks test"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.6.3[${PYTHON_USEDEP}]
	tasks? ( >=dev-python/invoke-0.21.0[${PYTHON_USEDEP}] )
	test? (
	  >=dev-python/coverage-4.2[${PYTHON_USEDEP}]
	  >=dev-python/flake8-2.5.4[${PYTHON_USEDEP}]
	  >=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
	  >=dev-python/pylint-1.6.5[${PYTHON_USEDEP}]
	)
	${RDEPEND}
"

DOCS="README.md"

src_test() {
	./runtests.sh || die
}
