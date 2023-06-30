echo Ejecutar PEDRO-VUC

@echo echo Se ejecutara PEDRO-VUC
:
@echo off

TIMEOUT /T 10

cd C:\Users\PEDRO-VUC\AppData\Local\Programs\UiPath\Studio
UiRobot.exe -p PEDRO-VUC
TIMEOUT /T 15

exit
