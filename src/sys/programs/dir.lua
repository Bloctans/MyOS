baseshell.new("Dir of ".._G.ROOT.._G.SYSROOT.."programs/")
baseshell.new("NAME:")

for i,v in pairs(_G.component.filesystem.list(_G.ROOT.._G.SYSROOT.."programs/")) do
    baseshell.new(v)
end