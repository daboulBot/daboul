serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_daboul = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_daboul = function() 
local Create_Info = function(Token,Sudo,UserName)  
local daboul_Info_Sudo = io.open("sudo.lua", 'w')
daboul_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
daboul_Info_Sudo:close()
end  
if not database:get(Server_daboul.."Token_daboul") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_daboul.."Token_daboul",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_daboul.."Id_daboul") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
database:set(Server_daboul.."Id_daboul",UserName)
else
io.write('\n\27[1;31mThe id was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
local function Files_daboul_Info()
Create_Info(database:get(Server_daboul.."Token_daboul"),database:get(Server_daboul.."Id_daboul"),database:get(Server_daboul.."UserName_daboul"))   
local Rundaboul = io.open("daboul", 'w')
Rundaboul:write([[
#!/usr/bin/env bash
cd $HOME/daboul
token="]]..database:get(Server_daboul.."Token_daboul")..[["
rm -fr daboul.lua
wget "https://raw.githubusercontent.com/daboulBot/daboul/main/daboul/daboul.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./daboul.lua -p PROFILE --bot=$token
done
]])
Rundaboul:close()
local RunTs = io.open("tk", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/daboul
while(true) do
rm -fr ../.telegram-cli
screen -S daboul -X kill
screen -S daboul ./daboul
done
]])
RunTs:close()
end
Files_daboul_Info()
database:del(Server_daboul.."Token_daboul");database:del(Server_daboul.."Id_daboul");database:del(Server_daboul.."UserName_daboul")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_daboul()  
var = true
else   
f:close()  
database:del(Server_daboul.."Token_daboul");database:del(Server_daboul.."Id_daboul");database:del(Server_daboul.."UserName_daboul")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
var = false
end  
return var
end
Load_File()
