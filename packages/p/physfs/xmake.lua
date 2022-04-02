package("physfs")
    set_kind("library")

    add_urls("https://github.com/icculus/physfs.git")

    add_deps("cmake")
    add_includedirs("include")

    if is_plat("windows", "mingw") then
        add_syslinks("advapi32", "user32")
    end

    on_install("macosx", "linux", "windows", "mingw", function (package)
        import("package.tools.cmake").install(package)
    end)