-- # info
-- quick and dirty hacks to make it build w/ VS2019
-- 1. controller.c -> controller.cc
-- 2. remove C99 (Vector3){1,2,3} or it won't build

-- # build
-- 1. get latest raylib (https://github.com/raysan5/raylib) along side this repo
--	  commit `8e599908` would work
-- 2. build its bundled VS2019 solution with `DEBUG` settings
-- 3. get `genie` https://github.com/bkaradzic/GENie
-- 	  run `genie vs2019` and build

solution 'motionmatching'
	platforms {'x64'}
    configurations {'Debug'}
	flags {'Symbols'}
	language 'C++'

	location './genie/build'
	targetdir './genie/bin'
	debugdir './genie/bin'
	objdir './genie/obj'

	includedirs {
		'./',
		'../raylib/src',
		'../raylib/src/extras',
	}

	configuration { "vs*" }
		buildoptions {'/std:latest'}
	    defines({"_CRT_SECURE_NO_WARNINGS"})
	    libdirs {
	    	'../raylib/projects/VS2019/build/raylib/bin/x64/Debug'
	    }
	    links({'winmm', 'raylib'}) 

	project 'motionmatching'
		kind 'ConsoleApp'
		targetname 'motionmatching'

		files {
			'./**.h',
			'./**.cc',
		}
