@echo off
title 修复共享打印机 ——By IT摇篮曲：www.itylq.com
 
::切换到BAT脚本文件所在路径
cd /d "%~dp0"
%1 %2
ver|find "5.">nul&&goto :start
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :start","","runas",1)(window.close)&goto :eof
:start
title 修复共享打印机
echo 适用于修复共享打印机无法使用问题
 
echo 正在停止打印服务…………
net stop spooler
 
echo 正在获取打印文件权限…………
TAKEOWN /F C:\Windows\System32\localspl.dll /A
Icacls C:\windows\System32\localspl.dll /grant Administrators:F
TAKEOWN /F C:\Windows\System32\win32spl.dll /A
Icacls C:\windows\System32\win32spl.dll /grant Administrators:F
TAKEOWN /F C:\Windows\System32\spoolsv.exe /A
Icacls C:\windows\System32\spoolsv.exe /grant Administrators:F
 
echo 正在删除打印机文件…………
::备份原系统localspl.dll、win32spl.dll、spoolsv.exe文件
copy C:\windows\system32\localspl.dll C:\windows\system32\localspl.dll.backup
copy C:\windows\system32\win32spl.dll C:\windows\system32\win32spl.dll.backup
copy C:\windows\system32\spoolsv.exe C:\windows\system32\spoolsv.exe.backup
::删除文件
del /F /Q C:\windows\system32\localspl.dll
del /F /Q C:\windows\system32\win32spl.dll
del /F /Q C:\windows\system32\spoolsv.exe
 
echo 正在重载打印机文件…………
::替换文件
copy localspl.dll C:\windows\system32\localspl.dll
copy win32spl.dll C:\windows\system32\win32spl.dll
copy spoolsv.exe C:\windows\system32\spoolsv.exe
 
echo 正在启动打印服务…………
net start spooler
 
Echo --------------------------------------------------------------------------
Echo 完成操作，请进行打印测试吧！
Echo 更多软硬件维护知识，请关注https://www.itylq.com
pause
