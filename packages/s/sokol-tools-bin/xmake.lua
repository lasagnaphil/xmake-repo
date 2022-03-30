package("sokol-tools-bin")
    set_kind("binary")

    add_urls("https://github.com/floooh/sokol-tools-bin.git")

    on_install("windows", function (package)
        os.cp("bin/win32/sokol-shdc.exe", package:installdir("bin"))
        package:addenv("PATH", "bin/win32")
    end)

    on_install("macosx", function (package)
        import("core.project.config")

        local arch = config.get("arch")
        if arch == "x86_64" then
            os.cp("bin/osx/sokol-shdc", package:installdir("bin"))
            package:addenv("PATH", "bin/osx")
        elseif arch == "arm64" then
            os.cp("bin/osx_arm64/sokol-shdc", package:installdir("bin"))
            package:addenv("PATH", "bin/osx_arm64")
        end
    end)

    on_install("linux", function (package)
        os.cp("bin/linux/sokol-shdc", package:installdir("bin"))
        package:addenv("PATH", "bin/linux")
    end)

    on_test(function (package)
        os.vrun("sokol-shdc --help")
    end)