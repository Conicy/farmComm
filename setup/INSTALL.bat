REM You may probably need to run this batch at an elavated command prompt.
REM The default setting for this batch is to install farmComm to run in the SYSTEM account via a scheduled task (using "Windows Task Scheduler." Whichever installation method you'd like to use, "uncomment" the applicable lines below by removing the word "REM" (and the space after that) from said line. *Leave* the "REM" ("Remark") comments everywhere else.

REM Also note that you may be able to change the username in quotes after the /RU switch--in the SCHTASKS command, which creates a "Windows Task Scheduler" scheduled task via the command line--you may be able to change that to the username of an account local to the machine (and/or on a domain) by expressing the username as "LOCALCOMPUTERNAME\UsernameWithAdminRights," or for a Domain, "DOMAIN\Username." In those cases, you may need to provide a password, which you can do by adding this switch: /RP "ThePassword."

REM OPTIONAL: Enable Wake On Lan, via a vbscript (doesn't work for every computer), which is not necessarily (yet) pertinent to what this toolset does . . .
REM CTRLWOL.vbs ENABLE

REM == UNINSTALL PREVIOUS CONFIG--ONLY NECESSARY FOR PREVIOUS, UNPUBLISHED SETUPS--YOU MAY COMMENT THE FOLLOWING THREE LINES OUT ==
REG IMPORT noFarmComm.reg
SCHTASKS /DELETE /TN "killCheck"
SCHTASKS /DELETE /TN "runCheck"

REM ============ SYSTEM INSTALL ============
REM REGKEY METHOD--NOT RECOMMENDED!
REM REG IMPORT farmCommSystem.reg

REM TASK SCHEDULER METHOD, SYSTEM--RECOMMENDED
SCHTASKS /CREATE /RU "NT AUTHORITY\SYSTEM" /TN "systemSpawn" /XML "systemSpawn.xml"

REM ============ USER INSTALL ============
REM REG IMPORT farmCommUser.reg

REM TASK SCHEDULER METHOD, USER--RECOMMENDED POSSIBLE ALTERNATE SETUP
REM SCHTASKS /CREATE /RU "YourComputerName\AnAdministrator" /RP "ThatUsersPassword" /TN "systemSpawn" /XML "userSpawn.xml"