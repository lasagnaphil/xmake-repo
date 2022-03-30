package("sokol")
    set_kind("library", {headeronly = true})

    add_urls("https://github.com/floooh/sokol.git")

    on_install("macosx", "linux", "windows", "mingw", function (package)
        os.cp("*.h", package:installdir("include"))
        os.cp("util/*.h", package:installdir("include"))
    end)