package("imgui")
    set_homepage("https://github.com/ocornut/imgui")
    set_description("Bloat-free Immediate Mode Graphical User interface for C++ with minimal dependencies (Without any backend)")
    set_license("MIT")

    add_urls("https://github.com/ocornut/imgui/archive/$(version).tar.gz",
            "https://github.com/ocornut/imgui.git")
    add_versions("v1.87", "b54ceb35bda38766e36b87c25edf7a1cd8fd2cb8c485b245aedca6fb85645a20")

    add_includedirs("include", "include/imgui")

    if is_plat("windows", "mingw") then
        add_syslinks("imm32")
    end

    on_install("macosx", "linux", "windows", "mingw", "android", "iphoneos", function (package)
        local xmake_lua = [[
            add_rules("mode.debug", "mode.release")
            add_rules("utils.install.cmake_importfiles")
            target("imgui")
                set_kind("static")
                add_files("*.cpp")
                add_includedirs(".")
                add_headerfiles("*.h")
        ]]
        io.writefile("xmake.lua", xmake_lua)
        import("package.tools.xmake").install(package)
    end)
