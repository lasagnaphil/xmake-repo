package("quirrel")
    set_kind("library")

    add_urls("https://github.com/lasagnaphil/quirrel.git")

    add_deps("cmake")
    add_includedirs("include")

    on_install("macosx", "linux", "windows", "mingw", function(package)
        local configs = {"-DDISABLE_DYNAMIC=ON"}
        import("package.tools.cmake").install(package, configs)
    end)