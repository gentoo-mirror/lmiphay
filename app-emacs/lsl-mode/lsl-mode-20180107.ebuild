# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit readme.gentoo-r1 elisp git-r3

DESCRIPTION="Major mode for editing Linden Scripting Language"
HOMEPAGE="http://www.buildersbrewery.com/"

EGIT_REPO_URI="https://github.com/buildersbrewery/linden-scripting-language.git"
EGIT_COMMIT="120b7ebd905a81df9dc9c2c32a40bc399a42112e"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-emacs/yasnippet"
DEPEND="${RDEPEND}"

DOCS="README.md"

S="${WORKDIR}/${P}/emacs"

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="
An external editor can be configured using the ExternalEditor debug setting
or the LL_SCRIPT_EDITOR environment variable; e.g.
   export LL_SCRIPT_EDITOR='/usr/bin/emacsclient -a emacs %s'
"

src_install() {
	insinto /usr/share/emacs/etc/yasnippet-snippets
	doins -r yasnippet/snippets/lsl-mode
	elisp_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
