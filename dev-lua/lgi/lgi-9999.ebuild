EAPI=3
inherit git eutils

EGIT_REPO_URI="git://github.com/pavouk/lgi.git"

DESCRIPTION="Lua binding to GObject based libraries."
HOMEPAGE="https://github.com/pavouk/lgi"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/lua-5.1"

src_unpack()
{
	git_src_unpack
	echo -n "`git --git-dir="${GIT_DIR}" describe`-gentoo" > ${S}/.version_stamp
}

src_prepare()
{
	sed -i "s:^LUA_LIBDIR.*$:LUA_LIBDIR = $(pkg-config --variable INSTALL_CMOD lua):" \
		"${S}/lgi/Makefile" || die "LUA_LIBDIR sed failed"
	sed -i	\
		"s:^LUA_SHAREDIR.*$:LUA_SHAREDIR = $(pkg-config --variable INSTALL_LMOD lua):" \
		"${S}/lgi/Makefile" || die "LUA_SHAREDIR sed failed"
	emake || die
}

src_install()
{
	emake	\
		DESTDIR="${D}"	\
		install || die
}
