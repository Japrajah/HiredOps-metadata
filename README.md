# HiredOps-SDK [outdated]
Use Metadata to genetare sdk for new game version.
btw 
You can find guide how to decrypt metadata in
il2cpp Inspector Readme. https://katyscode.wordpress.com/2021/02/23/il2cpp-finding-obfuscated-global-metadata/
Just Find ( in Il2cpp init function)
shit looks like this
"qword_14096281 = sub_14099BA("global-metadata
dat");"
and in qword_14096281 you can find encrypted Metadata. 
You can use
HxD To dump it, just check size crypted metadata, and dump same count of bytes. 
After save this bytes as file. 
