package("mshio")
    set_kind("library")
    set_description("A tiny C++ library to read/write ASCII/binary MSH format files. ")
    set_license("Apache-2.0")

    add_urls("https://github.com/qnzhou/MshIO.git")

    add_deps("cmake")
    add_includedirs("include")

    on_install("macosx", "linux", "windows", "mingw", function (package)
        import("package.tools.cmake").install(package)
    end)