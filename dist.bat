@echo off
if exist luapb_dist rd /s /q luapb_dist
md luapb_dist
copy test\luapb.dll luapb_dist\
copy lua-5.3.0\releasedll\*.exe luapb_dist\
copy lua-5.3.0\releasedll\*.dll luapb_dist\
copy test\test1.lua luapb_dist\
copy test\test.proto luapb_dist\
pause