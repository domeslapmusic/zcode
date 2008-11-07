@echo off

echo Compiling AIR app...

REM // Line below created the self signed certificate. And no, that is not the actual password :)
REM adt -certificate -cn SelfSigned 1024-RSA ZLog.pfx myPassword

adt -package -storetype pkcs12 -keystore ZLog.pfx ZLog.air air-descriptor.xml ZLog.html elements icons