# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 )
DISTUTILS_USE_PEP517=poetry
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml
inherit distutils-r1

DESCRIPTION="A Linux compatible UI for the Elgato Stream Deck"
HOMEPAGE="https://github.com/timothycrosley/streamdeck-ui"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/timothycrosley/streamdeck-ui.git"
else
	SRC_URI="https://github.com/timothycrosley/streamdeck-ui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	#S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT Apache-2.0"
SLOT="0"
IUSE=""

RESTRICT="test"

DEPEND="${PYTHON_DEPS}
		dev-libs/hidapi
		dev-python/filetype[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pynput[${PYTHON_USEDEP}]
		dev-python/pyside2[${PYTHON_USEDEP},designer]
		dev-python/python-xlib[${PYTHON_USEDEP}]
		media-gfx/cairosvg[${PYTHON_USEDEP}]
		media-libs/elgato-streamdeck[${PYTHON_USEDEP}]
		"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest

src_prepare() {
	sed -i "s#os.path.dirname(os.path.abspath(__file__))#'/usr/share/streamdeck-ui'#" streamdeck_ui/config.py
	distutils-r1_src_prepare
}

src_install() {
	insinto /usr/share/streamdeck-ui
	doins streamdeck_ui/logo.png
	doins -r streamdeck_ui/fonts
	distutils-r1_src_install
}
