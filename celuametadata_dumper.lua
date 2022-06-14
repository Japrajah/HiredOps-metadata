
--https://forum.cheatengine.org/viewtopic.php?p=5747559#5747559
function AOBScanAA(script, symbol)
  local success,disableInfo = autoAssemble(script)
  if not success then return nil, disableInfo end -- disableInfo is error message on failure
  local addr = getAddress(symbol)
  autoAssemble(script, disableInfo) -- disable script and unregister symbol
  return addr, 'success'
end
function AOBScanModule(bytestr, module)
  local script = ([[
  [ENABLE]
  aobscanmodule(luaAOBScanModuleSymbol,%s,%s)
  registersymbol(luaAOBScanModuleSymbol)
  [DISABLE]
  unregistersymbol(luaAOBScanModuleSymbol)
  ]]):format(module, bytestr)
  return AOBScanAA(script,'luaAOBScanModuleSymbol')
end
function getmetadatasize()
local gamepath = extractFilePath(enumModules()[1].PathToFile)
local gamedata = getFileList(gamepath,"global-metadata.dat" ,true)
local gamedatapath = gamedata[1]
print(gamedatapath)
local f = io.open(gamedatapath, 'rb');
if f == nil then
print("can't find metadata")
return 0
end
local size = f:seek('end')
f:close();
return size
end

function dumpmetadata()
-- 48 89 ? ? ? ? ? 48 89 ? ? ? ? ? 48 8B ? ? ? ? ? 48 63
local addr = AOBScanModule('48 89 05 * * * * 48 89 05 * * * * 48 8B 05 * * * * 48 63 48', "GameAssembly.dll")
if addr then
local hexaddr = ('%X'):format(addr);
 local dism = createDisassembler()
   dism.disassemble(hexaddr)
  local metadatamem = dism.decodeLastParametersToString()
local str = string.format('%s', metadatamem);
  local addrmetadata = string.sub(str, 2 ,string.len(str)-1)
     print(string.format('global-metadata.dat 0x%s',addrmetadata) )
local datasize = getmetadatasize()

if datasize ~= 0 then
local gamepath = extractFilePath(enumModules()[1].PathToFile)
writeRegionToFile(string.format("%s\\global-metadata.dat",gamepath),addrmetadata,datasize)
shellExecute(gamepath)
end

else
print('Cant Find AOB ;c')
end
end

dumpmetadata()