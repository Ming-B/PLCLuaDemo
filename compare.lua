-- who doesn't love some fibonnaci numbers

local function fibonacci(n) return n<2 and n or fibonacci(n-1)+fibonacci(n-2) end

local time = os.clock()
local fibs = {}
for i=1,30 do 
	fibs[i] = fibonacci(i)
end
print("Lua finished in: "..1000*(os.clock()-time).." milliseconds")
