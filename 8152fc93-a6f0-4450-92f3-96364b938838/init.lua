-- Starts basic APIS and initalizes into boot file


local gpu = component.list("gpu")()

component.invoke(gpu,"fill",10,10,10,10,"H")


--_status(loadfile("/libraries/text.lua")(loadfile))

while true do
    computer.pullSignal()
end