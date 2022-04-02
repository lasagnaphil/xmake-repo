package("imgui-sdl-opengl3")

    set_homepage("https://github.com/ocornut/imgui")
    set_description("Bloat-free Immediate Mode Graphical User interface for C++ with minimal dependencies")
    set_license("MIT")

    add_urls("https://github.com/ocornut/imgui/archive/$(version).tar.gz",
             "https://github.com/ocornut/imgui.git")
    add_versions("v1.87-docking", "1ee252772ae9c0a971d06257bb5c89f628fa696a")

    add_includedirs("include", "include/imgui", "include/backends")

    if is_plat("windows", "mingw") then
        add_syslinks("imm32")
    end

    on_load("macosx", "linux", "windows", "mingw", "android", "iphoneos", function (package)
        package:add("deps", "glad")
        package:add("defines", "IMGUI_IMPL_OPENGL_LOADER_CUSTOM")
        package:add("defines", "IMGUI_IMPL_OPENGL_LOADER_GLAD")
        package:add("deps", "libsdl")
        package:set("urls", {"https://github.com/ocornut/imgui.git"})
    end)

    on_install("macosx", "linux", "windows", "mingw", "android", "iphoneos", function (package)
        local xmake_lua = [[
            add_rules("mode.debug", "mode.release")
            add_rules("utils.install.cmake_importfiles")
            add_requires("libsdl", "glad")
            target("imgui-glfw-opengl3")
                set_kind("static")
                add_files("*.cpp", "backends/imgui_impl_sdl.cpp", "backends/imgui_impl_opengl3.cpp")
                add_packages("libsdl", "glad")
                add_includedirs(".")
                add_headerfiles("*.h")
                add_headerfiles("backends/imgui_impl_sdl.h", "backends/imgui_impl_opengl3.h")
        ]]

        io.writefile("xmake.lua", xmake_lua)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test() {
                IMGUI_CHECKVERSION();
                ImGui::CreateContext();
                ImGuiIO& io = ImGui::GetIO();
                ImGui::NewFrame();
                ImGui::Text("Hello, world!");
                ImGui::ShowDemoWindow(NULL);
                ImGui::Render();
                ImGui::DestroyContext();
            }
        ]]}, {configs = {languages = "c++17"}, includes = {"imgui.h"}}))
    end)