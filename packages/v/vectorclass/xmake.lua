package("vectorclass")
	set_kind("library", {headeronly = true})

	add_urls("https://github.com/vectorclass/version2/archive/refs/tags/v2.01.04.zip")

	add_versions("2.01.04", "01E1CCE8E88DAE24D28FF2D8E150FC6606FCC43EC350FB2C90B66AEDB3A1BA06")

	on_install("macosx", "linux", "windows", "mingw", function (package)
		os.cp("*.h", package:installdir("include"))
	end)