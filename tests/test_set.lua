---
-- set/tests/test_set.lua
--
-- Author Jason Perkins
-- Copyright (c) 2019 Jason Perkins and the Premake project
---

	local suite = test.declare('set')
	local set = require('set')


---
-- Setup and teardown
---

	function suite.setup()
	end


---
-- Set up a dummy test just to get things started
---

	function suite.firstTest()
		test.isnil(nil)
	end
