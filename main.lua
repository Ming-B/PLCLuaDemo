-- -- Assuming there is a module named 'mymodule.lua' in the same directory
-- local mymodule = require("mymodule")

-- -- Now you can access functions and variables from mymodule
-- mymodule.someFunction()

-- single line comments
--[[multi
line
comments]]

--variables and data types
local prompt = "Enter an input, or skip:" -- note that there is no explicit type declaration, number is only the variable name

print(prompt);  -- semicolons allowed (but not required)
local input = io.read("*l") -- read the next line, stored implicitly as string type

--control structures
while (input ~= "skip") do    -- while syntax
    local asNumber = tonumber(input)    -- stores the input as number or false if input is strictly string
    local inType -- can declare a variable without assigning any type to it

    if(asNumber) then  -- can use paranthesis
        if asNumber > 0 then           -- but don't have to
            inType = "Positive number"
        elseif asNumber < 0 then      -- elseif is an explicit keyword
            inType = "Negative number"
        else                        -- else statements don't need "then"
            inType = "Zero nalue number"
        end                         -- one end for the whole statement
    else inType = type(input) -- can also be single line
    end
    print(input.. " is a:", inType) --[[ two methods of concatenating strings to print
    ".." concatenates normally, "," forms an array/table of the values, resulting in a tab separator ]]

    print("\nEnter an input:")  -- printing with a line break
    input = io.read("*l") -- read the next line
end

print() -- empty print statement still forms new line

-- tables
local genericTable = {"a", "b", "c","d"}    local keyedTable = {"a", "b", key3="c"} -- can include multiple assignments on one line (tables or otherwise)
local list = "" -- establish that it is an empty string to allow self-concatenation (doesn't work with nil)

-- for loops
print("Printing for loops:")
for i = 1,#genericTable do -- # is the length operator
    list = list..genericTable[i]    -- can concatenate directly (side effect!!) but must be ".." since "," is a table operator
end
print(list)

list = ""   -- clear list
for i = 1,#genericTable,2 do -- can also include increment
list = list..genericTable[i]    -- indentation is also optional
end
print(list)

print("Printing numerical indecies:")
for i,value in ipairs(keyedTable) do -- prints in order for numerical keys, stops at first nonnumeric key (including nil)
    print(i, value)
end
print("Printing all key-value pairs:")
for key,value in pairs(keyedTable) do print(key, value) end -- single line, but order is no longer certain
print()

--repeat loops
local gameTable = {"duck","duck","GOOSE!","duck","duck"}
local i   -- i be declared, but next(table,index) can take nil as input, operates the same as next(table)
repeat
    local val
    i, val = next(gameTable,i) -- get next index and val, may be  next numberic index, but not defined as such
    print(val)
until (val == "GOOSE!") -- val, which is local to repeat loop, still in scope here
print()

--regular functions 
local function addNums(a, b)
    return a+b
end

--anonymous function that stores a function's value into a local variable
local square = function(x) return x*x end

--[[ example of protected calls in Lua 
protected mode, if error occurs, catches error and
returns status code]] 
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

--sample couroutine, the coroutine table provides the create function
--often you find the argument to create is an anonymous function
local co = coroutine.create(function ()
    print ("hi!")
end)
print(co) --> should return a type thread
print(coroutine.status(co)) --> suspended
coroutine.resume(co) --> running
print(coroutine.status(co)) --> dead

local routine = coroutine.create(function ()
    for i = 1, 10 do 
        print("co", i)
        coroutine.yield()
    end
end)


--[[table object that mimicks a car
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
print(child.x) -- 20]]

--car class that demonstrates oop in lua 
Car = {} -- defines a table car 
Car._index = Car -- sets index to Car so instances can inherit methods 

--Constructor 
function Car:new(color)
    if(type(color) ~= "string") then print ("Invalid color form") return end

    local colors = {"green","red","blue","yellow","gray","grey","black"}
    local i = 1
    local valid -- declare valid before loop to keep in scope
    repeat
        valid = string.lower(color) == colors[i]    -- valid is boolean, true if color is string in colors
        i = i+1     -- no ++ operators
    until valid or i > #colors     -- "or" and "and" are keyword operators 
    if(not valid) then      -- "not" is also a keyword operator, separate from ~=
        print("Our cars don't come in that color") return   --returns nil if no car created
    end

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

local redCar = Car:new("red") --creates new instance 
if (redCar == nil) then
    print("Try again?:")
else
    redCar:accelerate()
    redCar:brake()
end

--Account class
local Account = {balance = 0}

function Account:new (o)
    o = o or {}
    setmetatable(o, self)
    self._index = self
    return o
end

function Account:deposit(amount)
    self.balance = self.balance + amount
end

function Account:withdraw(amount)
    if self.balance < amount then error"insufficient funds" end
    self.balance = self.balance - amount 
end

SpecialAccount = Account:new() --inherits new from Account, but the self will 
--index to special account
local s = SpecialAccount:new{limit = 1000.00} --metatable of is is specialaccount
s:deposit(100.00) --this function is found at Account, not present in s or specialAccount
