@echo off
setlocal

if "%2"=="" (
  set output=-
) else (
  set output=%2
)

sox %1 -t raw %output%

endlocal