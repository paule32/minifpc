@echo off
echo start compiler tasks ...
<nul set/p "_dummy=compile fpcinit.asm: "
nasm -fwin64 -o fpcinit.obj fpcinit.asm
if %errorlevel% neq 0 (echo an error was found, script stopped ! &exit /b 1)
echo ok.
<nul set/p "_dummy=compile Strings.asm: "
nasm -fwin64 -o Strings.obj Strings.asm
if %errorlevel% neq 0 (echo an error was found, script stopped ! &exit /b 1)
echo ok.
fpc -n -a -Fu. test1.pas
gcc -nostartfiles -Wl,--entry=TEST1_$$_ENTRYPOINT -o test1.exe test1.o -L. -limptest1
echo done.

echo test ...
strip test1.exe
test1.exe
if %errorlevel% == 100 (echo error 1000 &exit /b 1)
if %errorlevel% == 21  (echo error 2100 &exit /b 1)
if %errorlevel% == 42  (echo error 4200 &exit /b 1)
echo okay.
