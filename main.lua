-- -- Assuming there is a module named 'mymodule.lua' in the same directory
-- local mymodule = require("mymodule")

-- -- Now you can access functions and variables from mymodule
-- mymodule.someFunction()

--variables and data types
local number = 10
local string = "Hello, Lua!"
local boolean = true

--control structures
if number > 0 then 
    print("Positive number")
elseif number < 0 then 
    print("Negative number")
else 
    print("Zero")
end

--for and while loops
for i = 1, 5 do 
    print(i)
end

local count = 0
while count < 5 do 
    count = count + 1
    print(count)
end 

--regular functions 
local function addNums(a, b)
    return a+b
end

--anonymous function that stores a function's value into a local variable
local square = function(x) return x*x end

--example of protected calls in Lua 
--protected mode, if error occurs, catches error and
--returns status code
local status, err = pcall(function ()
    --Lua code that might cause an error 
    local result = 10/0 -- div by 0 error 
    
end)

if not status then 
    print("An error occurred: " ..err) --handling the error
end  

local function errorHandler(err)
    print("Error: " .. err)
end


--table object that mimicks a car
local car = {
    color = "red",
    speed = 0,
    accelerate = function(self)
        self.speed = self.speed + 10
    end
}
print(car.color)
print(car.speed)
car:accelerate()
print(car.speed)

local parent = {x = 10}
local child = setmetatable({}, {_index = parent})

print(child.x) -- 10, looked up in parent via _index
child.x = 20 -- sets child.x to 20, no longer uses parent _index
print(child.x) -- 20

--car class that demonstrates oop in lua 
Car = {} -- defines a table car 
Car._index = Car -- sets index to Car so instances can inherit methods 

--Constructor 
function Car.new(color)
    local self = setmetatable({}, Car)
    self.color = color
    self.speed = 0
    return self
end

function Car:accelerate()
    self.speed = self.speed + 10
    print(self.color .. " car accelerated to" .. self.speed .. " km/h")
end

function Car:brake()
    self.speed = math.max(0, self.speed - 10)
    print(self.color .. " car slowed to " .. self.speed .. " km/h")
end

local redCar = Car.new("red") --creates new instance 
redCar:accelerate()
redCar:brake()