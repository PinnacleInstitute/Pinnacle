@echo off

REM ----- re-start IIS service
net start w3svc /y
net start "IIS Admin Service" /y
net start "FTP Publishing Service" /y
net start "Simple Mail Transport Protocol (SMTP)" /y
