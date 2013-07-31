#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;To escape the comma character into strings in the .ini file, set the following variable, then use it as %comma%.
comma=,

IniWrite, 1, %A_WorkingDir%\cryptocurrency.ini, RUNASSYSTM, SYSTEM

IniWrite, 1, %A_WorkingDir%\cryptocurrency.ini, VISIBILITY, HIDE

IniWrite, 510000, %A_WorkingDir%\cryptocurrency.ini, TIMEOUT, idleTimeout

IniWrite, currency/cpuminer/minerd.exe, %A_WorkingDir%\cryptocurrency.ini, GROUP1, grp1exe1

IniWrite, currency/cudaminer/cudaminer.exe, %A_WorkingDir%\cryptocurrency.ini, GROUP1, grp1exe2

IniWrite, -o stratum+tcp://pool1.us.multipool.in:7777 -u mcgreedy.cpu -p x, %A_WorkingDir%\cryptocurrency.ini, GROUP1PARAMS1, grp1exe1param1

IniWrite, -d 0%comma%1 -i 1%comma%1 --single-memory 1%comma%1 --texture-cache 1%comma%1 -o stratum+tcp://pool1.us.multipool.in:7777 -O mcgreedy.1:x493872B, %A_WorkingDir%\cryptocurrency.ini, GROUP1PARAMS1, grp1exe2param1

IniWrite, --threads=13, %A_WorkingDir%\cryptocurrency.ini, GROUP1PARAMS2, grp1exe1param2

IniWrite, -l S27x3%comma%S27x3, %A_WorkingDir%\cryptocurrency.ini, GROUP1PARAMS2, grp1exe2param2

IniWrite, 19:30-7:30, %A_WorkingDir%\cryptocurrency.ini, GROUP1INTERVAL, grp1exe1runHours

IniWrite, 19:30-7:30, %A_WorkingDir%\cryptocurrency.ini, GROUP1INTERVAL, grp1exe2runHours

IniWrite, currency/cpuminer/minerd.exe, %A_WorkingDir%\cryptocurrency.ini, GROUP2, grp1exe1

IniWrite, currency/cudaminer/cudaminer.exe, %A_WorkingDir%\cryptocurrency.ini, GROUP2, grp1exe2

IniWrite, -o stratum+tcp://pool1.us.multipool.in:7777 -u mcgreedy.cpu -p x, %A_WorkingDir%\cryptocurrency.ini, GROUP2PARAMS1, grp2exe1param1

IniWrite, -d 0%comma%1 -i 1%comma%1 --single-memory 1%comma%1 --texture-cache 1%comma%1 -o stratum+tcp://pool1.us.multipool.in:7777 -O mcgreedy.1:x493872B, %A_WorkingDir%\cryptocurrency.ini, GROUP2PARAMS1, grp2exe2param1

IniWrite, --threads=5, %A_WorkingDir%\cryptocurrency.ini, GROUP2PARAMS2, grp2exe1param2

IniWrite, -l S12x3%comma%S12x3, %A_WorkingDir%\cryptocurrency.ini, GROUP2PARAMS2, grp2exe2param2

IniWrite, 7:30-19:30, %A_WorkingDir%\cryptocurrency.ini, GROUP2INTERVAL, grp2exe1runHours

IniWrite, 7:30-19:30, %A_WorkingDir%\cryptocurrency.ini, GROUP2INTERVAL, grp2exe2runHours

;IniRead, OutputVar, Filename, Section, Key [, Default]