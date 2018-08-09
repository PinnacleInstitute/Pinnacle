@echo off

IF "%1"=="" GOTO error
SET name=%1

REM Business class
If Exist .\GEN\%name%\%name%Busn.vbp (
	echo compiling %name%Busn ...
	"C:\Program Files (x86)\Microsoft Visual Studio\vb98\vb6.exe" /makedll .\GEN\%name%\%name%Busn.vbp
)

REM User class
If Exist .\GEN\%name%\%name%User.vbp (
	echo compiling %name%User ...
	"C:\Program Files (x86)\Microsoft Visual Studio\vb98\vb6.exe" /makedll .\GEN\%name%\%name%User.vbp
)

REM AuthUser
If Exist .\GEN\%name%\%name%.vbp (
	echo compiling %name% ...
	"C:\Program Files (x86)\Microsoft Visual Studio\vb98\vb6.exe" /makedll .\GEN\%name%\%name%.vbp
)


:error
