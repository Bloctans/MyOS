-- send a request to https://api.github.com/repos/Bloctans/MyOS/releases/latest

-- Update checker
-- check if version is not the same as current
-- if so, prompt user to update
-- if user accepts then start update.lua
-- if not then exit

-- Update runner
-- get the asset with label "update package"
-- update osver
-- rename init to osinit
-- get the lua update file from the api response (sorta like installist)
-- put update file in root
-- make new init that will boot into a updator wrapper
-- reboot
-- once lua update is done, delete init and rename osinit to init
-- reboot