package("fmt")

    set_homepage("https://fmt.dev")
    set_description("fmt is an open-source formatting library for C++. It can be used as a safe and fast alternative to (s)printf and iostreams.")

    set_urls("https://github.com/fmtlib/fmt/releases/download/$(version)/fmt-$(version).zip")
    add_versions("8.1.1", "23778bad8edba12d76e4075da06db591f3b0e3c6c04928ced4a7282ca3400e5d")

    add_configs("header_only", {description = "Use header only version.", default = false, type = "boolean"})

    on_load(function (package)
        if package:config("header_only") then
            package:add("defines", "FMT_HEADER_ONLY=1")
        else
            package:add("deps", "cmake")
        end
        if package:config("shared") then
            package:add("defines", "FMT_EXPORT")
        end
    end)

    on_install(function (package)
        if package:config("header_only") then
            os.cp("include/fmt", package:installdir("include"))
            return
        end
        io.gsub("CMakeLists.txt", "MASTER_PROJECT AND CMAKE_GENERATOR MATCHES \"Visual Studio\"", "0")
        local configs = {"-DFMT_TEST=OFF", "-DFMT_DOC=OFF", "-DFMT_FUZZ=OFF", "-DCMAKE_CXX_VISIBILITY_PRESET=default"}
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <fmt/format.h>
            #include <string>
            #include <assert.h>
            static void test() {
                std::string s = fmt::format("{}", "hello");
                assert(s == "hello");
            }
        ]]}, {configs = {languages = "c++17"}, includes = "fmt/format.h"}))
    end)

