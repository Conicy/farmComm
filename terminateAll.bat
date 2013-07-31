ECHO OFF
FOR /F "delims=" %%A IN (allProcessesList.txt) DO (
START Process.exe -k %%A.exe

)