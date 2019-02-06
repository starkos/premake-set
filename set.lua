---
-- set/set.lua
--
-- Sets behave like a hybrid array and table. Values may be indexed like an array
-- and are returned in the order in which they are added. Each value may only
-- occur once; duplicate values are discarded and only the first is kept.
--
-- Author Jason Perkins
-- Copyright (c) 2019 Jason Perkins and the Premake project
---

	local m = {}


---
-- Construct a new Set object.
---

	function m.new(...)
		local self = {}

		local n = select('#', ...)
		for i = 1, n do
			m.add(self, select(i, ...))
		end

		return self
	end


---
-- Add a new value to the set. If the value is already in the set, it is not
-- added again.
---

	function m.add(self, value)
		if self[value] == nil then
			local index = #self + 1
			self[index] = value  -- store in an array to maintain ordering
			self[value] = index  -- store in map for quick lookups
		end
		return self
	end


---
-- Does the specified item exist in the set?
---

	function m.contains(self, value)
		return (self[value] ~= nil)
	end


---
-- Iterator, enumerates all items in order
---

	function m.each(self)
		local i = 0

		return function ()
			i = i + 1
			if i <= #self then
				return self[i]
			end
		end
	end


---
-- Call the provided function for each item in the set, in order
---

	function m.forEach(self, func)
		local n = #self
		for i = 1, n do
			func(self[i])
		end
	end


---
-- Is the set empty?
---

	function m.isEmpty(self)
		return (#self == 0)
	end


---
-- Call the provided function for each item in the set, in order, and replace
-- the item with the return value of the function. If a `nil` is returned,
-- the item is removed from the set.
---

	function m.map(self, func)
		local i = 1
		while i <= #self do
			local newValue = func(self[i])
			if newValue ~= nil then
				self[i] = newValue
				i = i + 1
			else
				m.remove(self, self[i])
			end
		end
	end


---
-- Remove a value from the set.
---

	function m.remove(self, value)
		local index = self[value]
		if index ~= nil then
			table.remove(self, index)
			self[value] = nil
		end
	end


---
-- Remove the value at the given array index from the set.
---

	function m.removeAt(self, index)
		local value = self[index]
		table.remove(self, index)
		self[value] = nil
	end


---
-- Add all items from a second set that aren't present in this one.
---

	function m.union(self, other)
		local n = #other
		for i = 1, n do
			local value = other[i]
			m.add(self, value)
		end
	end


---
-- End of module
---

	return m