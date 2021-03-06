EAPI=4

inherit eutils java-utils-2

MY_P=gwt-${PV}

DESCRIPTION="Development toolkit for building and optimizing complex browser-based applications"
HOMEPAGE="http://code.google.com/webtoolkit/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.zip"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}/${MY_P}

src_install() {
	local exes="benchmarkViewer i18nCreator webAppCreator"
	local files="*.jar *.dtd *.war"

	insinto /opt/${PN}
	exeinto /opt/${PN}

	for i in $files; do
		doins $i
	done

	for i in $exes; do
		doexe $i
		make_wrapper $i /opt/${PN}/$i "" "" /opt/bin
	done

	dodoc about.{txt,html} release_notes.html

	if use doc; then
		java-pkg_dojavadoc doc/javadoc
	fi

	# TODO: Compile examples, rather than using the distributed class files
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r samples
	fi
}
