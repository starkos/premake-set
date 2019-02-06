---
-- set/tests/test_set.lua
--
-- Author Jason Perkins
-- Copyright (c) 2019 Jason Perkins and the Premake project
---

	local suite = test.declare('set')

	local Set = require('set')


---
-- Can construct a new Set object
---

	function suite.new_returnsNewSet()
		local s = Set.new()
		test.isnotnil(s)
	end


---
-- Can populate set with constructor arguments
---

	function suite.new_populatesArray()
		local s = Set.new('A', 'B', 'C')
		test.isequal(3, #s)
		test.isequal('A', s[1])
		test.isequal('B', s[2])
		test.isequal('C', s[3])
	end


---
-- Can add a value and fetch it back via array indexing
---

	function suite.add_addsItemToArray()
		local s = Set.new()
		Set.add(s, 'value')

		test.isequal(1, #s)
		test.isequal('value', s[1])
	end


---
-- Add should not allow duplicate values
---

	function suite.add_preventsDuplicates()
		local s = Set.new()
		Set.add(s, 'value')
		Set.add(s, 'value')

		test.isequal(1, #s)
		test.isequal('value', s[1])
	end


---
-- Add should allow unique values
---

	function suite.add_allowsUnique()
		local s = Set.new()
		Set.add(s, 'value1')
		Set.add(s, 'value2')

		test.isequal(2, #s)
		test.isequal('value1', s[1])
		test.isequal('value2', s[2])
	end


---
-- `contains` should return true if the item is in the set, and false when not
---

	function suite.contains_returnsTrueIfPresent()
		local s = Set.new('A', 'B', 'C')
		test.istrue(Set.contains(s, 'B'))
	end

	function suite.contains_returnsFalseIfNotPresent()
		local s = Set.new('A', 'B', 'C')
		test.isfalse(Set.contains(s, 'X'))
	end


---
-- `each` enumerates each item in the order it was added
---

	function suite.each_enumeratesAllItems()
		local result = ''

		local s = Set.new('A', 'B', 'C')
		for item in Set.each(s) do
			result = result .. item
		end

		test.isequal('ABC', result)
	end


---
-- `forEach` calls a function for each item in the order it was added
---

	function suite.forEach_enumeratesAllItems()
		local result = ''

		local s = Set.new('A', 'B', 'C')
		Set.forEach(s, function(item)
			result = result .. item
		end)

		test.isequal('ABC', result)
	end


---
-- `isEmpty` should return true when empty and false when not
---

	function suite.isEmpty_returnsTrueIfEmpty()
		local s = Set.new()
		test.istrue(Set.isEmpty(s))
	end

	function suite.isEmpty_returnsFalseIfNotEmpty()
		local s = Set.new('A', 'B', 'C')
		test.isfalse(Set.isEmpty(s))
	end


---
-- `map` should call a function for each item, in order, and
-- replace the item with the return value of the function
---

	function suite.map_replacesEachValueWithReturn()
		local s = Set.new('A', 'B', 'C')
		Set.map(s, function(item) return string.lower(item) end)

		test.isequal('a', s[1])
		test.isequal('b', s[2])
		test.isequal('c', s[3])
	end

	function suite.map_removesItem_onNilReturn()
		local s = Set.new('A', 'B', 'C')
		Set.map(s, function(item)
			if item ~= 'B' then
				return string.lower(item)
			end
		end)

		test.isequal(2, #s)
		test.isequal('a', s[1])
		test.isequal('c', s[2])
	end


---
-- `remove` should remove the item from the array
---

	function suite.remove_removesItem()
		local s = Set.new('A', 'B', 'C')
		Set.remove(s, 'B')

		test.isequal(2, #s)
		test.isequal('A', s[1])
		test.isequal('C', s[2])
	end


---
-- `removeAt` should remove the item at the given array index
---

	function suite.removeAt_removesItemAtIndex()
		local s = Set.new('A', 'B', 'C')
		Set.removeAt(s, 2)

		test.isequal(2, #s)
		test.isequal('A', s[1])
		test.isequal('C', s[2])
	end


---
-- `union` should add items that aren't already present
---

	function suite.union_addsMissingItems()
		local s = Set.new('A', 'B', 'C')
		local t = Set.new('B', 'C', 'D')
		Set.union(s, t)

		test.isequal(4, #s)
		test.isequal('A', s[1])
		test.isequal('B', s[2])
		test.isequal('C', s[3])
		test.isequal('D', s[4])
	end
