echo Ejecutar PEDRO-VUC

TASKILL /IM
UiPath.Service.UserHost.exe /F
TASKILL /IM
UiPath.RobotJS.UserHost.exe /F
TASKILL /IM
UiPath.Executor.exe /F
TASKILL /IM
UiPath.Service.Agent.exe /F
TASKILL /IM
UiPath.Service.Assistant.exe /F

@echo echo Se ejecutara PEDRO-VUC
:
@echo off

cd C:\Users\PEDRO-VUC\AppData\Local\Programs\UiPath\Studio
UiRobot.exe -p PEDRO-VUC

TIMEOUT /T 15

exit