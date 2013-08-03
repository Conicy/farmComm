farmComm
========

PROBLEM: Petahashes or more of potential computational power lie dormant in the world, even an extremely tiny fraction of which power could be put to evil and greedy purposes, in the right hands.

SOLUTION: THIS TOOLSET!

(These hands are now YOUR hands!)

farmComm: launches arbitrary (you choose), configurable processes, partly hidden,* when any user is idle for 8.5 minutes (default). Terminates those processes when user resumes activity. Installs by default as a service which accesses graphics hardware even if no user is logged in! If the user session (login) it started in becomes inactive (disconnected), it migrates to access whichever session may be active, or if no session is active, it responds to the Secure Desktop (session 0). It therefore always appropriately responds to user idle/activity.

This functionality may be particularly useful for the automation of very resource-intensive tasks, e.g. 3D renders, fractal flame renders, or cryptocurrency mining--tasks which would use up a computer's resources and make it useless for everyday user computing tasks.

At this writing, it has been tested and confirmed to behave as described for cryptocurrency mining.

Built with AutoHotkey_L, designed for Windows 7.

*What is meant by "partly hidden" is that essentiall any program launched by farmComm will run and function normally (other than any functionality which requires user interaction), but no part of the user interface of the program will appear--not anywhere. However, the program will still be detectable without a lot of investigation, e.g. it will be listed in the Windows Task Manager.

Please see the LICENSE file for license details and a DISCLAIMER (hint: you are completely free to use the source code and binaries of this for absa-freaking-lutely-any purpose--except for purposes which are, like, illegal (and you shouldn't actually do anything wrong or evil with this program--that was *irony* in the "PROBLEM" caption, silly), and I can't be held accountable for any bad consequences whatsoever which may stem from your use of this software.

Contact: artdev@inboxalias.com.

Because farmComm can for example dramatically increase cryptocurrency mining uptime, if you get good use out of it for that (or any) purpose, please consider sending any amount to any of my cryptocurrency donation addresses:

Bitcoin:		1CoRdDm9KyDTfhnaTNoeM5HiNtRHBaKoy9
Litecoin:		LNpsi5T9UuSP9Su4yahhgT5CfY5vCExhmP
Feathercoin:	6ekB56KQJfgFZGM2qWvVRt77EHLGr5C3EN
Novacoin:		4Z123Y8QZXPVvfA7LVDySunJoEG2dnUHFV

==INSTALLATION AND USE==

==SETUP==

To upgrade from a previous version, delete all the files in the root of your distribution (except perhaps mineall.bat and delayed-killmine.bat, if you have customized those), then copy all the root files from this distribution into that root folder. Also delete the \setup folder form the install, and copy the new \setup folder from this distribution.

Create these folders in Windows:

C:\farm\Local\farmComm

-- and extract the files in this distribution thereto. If properly done, systemSpawn.exe will be at C:\farm\Local\farmComm\systemSpawn.exe.

If you prefer to install to another directory, you'll need to replace the install path I put into all the .bat and .xml setup files with your chosen install path.

Read the comments in setup\INSTALL.bat and follow their instructions. When you decide which setup you want (I strongly recommend the default if possible), execute setup\INSTALL.bat with Administrative privileges (either from an account so privileged, or cmd.exe run as Administrator).

Follow the configuration details given here and see if it works. If it doesn't work, alter INSTALL.bat per the comments therein to try for the next least recommended install option. If that doesn't work, try the next. If none of them work, cry, because you are not evil and/or lucky enough. Drop me a line and tell me your woes. I won't give you any pity, but at least you'll get to indulge in self-pity.

Here's how the different install options behave:

SYSTEM SERVICE: As first boasted in this README.md file. For example, if you simply boot the computer and leave it idle for the idle timeout duration, farmComm will launch the configured processes unseen--and if those processes need to use for example a Graphics Processor Unit, THEY WILL! (I hope. I verified at least that console cryptocurrency miners, which make heavy use of GPUs--those worked this way.)

SYSTEM AT LOGON: When a user logs on, a Scheduled Task will execute systemSpawn.exe, which exploits PaExec.exe to launch farmComm.exe into session 0, interacting with the Secure Desktop *and* the user desktop (apparently). farmComm will now do its work whether users are logged in or not. It's just that it won't do any work if you only boot up the computer and don't log in.

USER REGISTRY AT LOGON: farmComm will launch via a registry entry for any/all users (I think?), when they log on. When a user logs off, the instance of farmComm which ran under their account terminates and no longer does its work.

USER TASK AT LOGON: farmComm will launch via a Windows Task Scheduler task at log on of any user, behaving the same as described for USER REGISTRY AT LOGON.

Note the miners.7z archive in the root of this distribution (meta!), which you must extract with a free program you must go through the pain of downloading if you don't already use it but why on earth aren't you using it, it's superior to the winzip library, 7-zip (free from 7-zip.org). Place executables you wish to spawn at user inactivity under sub-folders of this main distribution, for example farmComm\cpuminer\minerd.exe (with all of the other files that executable depends on. Just such a preconfigured ;) example is provided in miners.7z). Then write the command(s) to start your custom executable(s) into localComm\COMM1.txt, etc. (note also the preconfigured examples provided therein--only three commands are supported at this writing).

Lastly, be sure to write the image name (without the .exe extension) of each executable you wrote in the COMM~.txt files--write those image names in processSpawnList.txt, one image name per line. See again the defaults provided therein for examples. NOTE: If you do not do this, these processes will not terminate upon user activity resuming from idle!

To check whether your configuration will properly run, assuming it is a resource-hungry application (e.g. it uses a lot of CPU and/or GPU power), first run a resource monitor tool like Open Hardware Monitor, and then run terminateAll.bat, and see if hardware (for example CPU) activity spikes as a result. You should also see your custom configured process(es) running, or listed in, Windows Task Manager (you can get to that via CTRL+ALT+DEL).

NOTE: if farmComm.exe is running, you may not see your processes start--because farmComm observed your user activity . . . and terminated the processes! This is why you should first run terminateAll.bat before testing.

You can install this toolset and run it from any directory (it is designed to do so); you will just need to configure it to start up from whichever other folder you choose, by editing the setup .bat and .xml installer/config files (as mentioned before) in the \setup folder, before you run INSTALL.bat.

It may be possible to effectively run this toolset by other automatic startup means. It's probably not worth the experiment though. (In earlier development of this toolset, when I tried startup registry entries it made PaExec sometimes fart loudly when I switched logins.)

terminateAll.bat is your emergency exit if program execution in this toolset goes wonky (hopefully, not). If terminateAll.bat doesn't kill everything when run ordinarily, run it as an administrator, or at worst, open a command shell and type:

RUNAS /USER:Administrator CMD

(--Where Administrator is the name of the Administrator account--which is usually exactly that, Administrator.) -- and type in the password, and then type:

CD C:\farm\Local\farmComm
terminateAll.bat

-- and if *that* doesn't work, I don't know what to do.

Examine also mineall.bat and the other batch files which it works with (some in subfolders), which are designed (and which I use) for dedicated cryptocurrency mining. These can easily be rewritten to spawn and terminate other dedicated processes.

==Dependencies==

These scripts (compiled to executables) rely on free utilities:

# AutoHotkey to compile them (you won't need that unless you want to alter my .ahk source scripts--which you will note are under the src folder--and recompile them).

# LaunchServ, a free tool which allows you to run ordinary executables (console applications only?) as services. farmComm uses this to create a service which launches systemSpawn.exe, which continuously runs, and periodically checks whether farmComm.exe is running. At any time farmComm.exe is found not to be running, it re-launches it. Moreover, at any time systemSpawn.exe is found not to be running, the LaunchServ service re-launches *that.*

# PaExec, which is available for free use for any purpose, and of which a version is included (which version, by the way, may exhibit peculiarity upon which this whole toolchain depends, whereas other versions of PaExec may *not* enable this toolchain). The license for it is here:
http://www.poweradmin.com/paexec/paexec_eula.txt

--and you may download it yourself, here:
http://www.poweradmin.com/paexec/

# Process.exe, a very effective process lister/suspender/executor/closer/killer. It is available for download and listed as "freeware," here:
http://retired.beyondlogic.org/consulting/processutil/processutil.htm

==TO DO:==

Option to self-nuke the entire farmComm directory and all its contents if a reference file's timestamp is more than X days old. (This reference file could for example be periodically refreshed remotely--from another computer--else the entire toolset self-destruct to no longer burden the computer.) See development in test/selfNuke-test.ahk (I already have a script that nukes a directory, not yet included).

Add configurable CPU/GPU load check functionality, for example do not spawn processes if the CPU and/or GPU load (from other processes?) are over fifteen percent. Possibly see the source code for how Open Hardware Monitor checks loads as a start point for this.

Run/termination logging.

Invoke/configure processes according to settings read (and written to?) an .ini file (see the work in progress in src/test/create-ini-test.ahk). At this writing, spawn.ahk (/.exe) *expects* to receive an instruction that begins with directory\executable; it will parse the string before the slash and append that to %A_WorkingDir% to set the executable's working directory. However, because of the way parsing is set up, it will not find the executable if it is more than one subfolder deep.

30 second suspend timer; when a user resumes from idle, suspend rather than kill processes, and only terminate them if user activity continues beyond 30 seconds (if they are *not idle* for 30 seconds.

Possibly optionally run a resource monitor in session zero to behold how enslaved the machine even when it is locked.

Possibly many other things.

=RELEASE HISTORY=

In reverse chronological order:

==v0.9.0.4==

Default install now runs as a service, and accesses graphics hardware whether users are logged in or not! The service is actually LaunchServ, which launches systemSpawn.exe (a compiled AutoHotkey script), which checks whether farmComm.exe is running, which if it isn't, systemSpawn.exe uses PaExec.exe to launch farmComm.exe in Session 0, interacting with the Secure Desktop!

Added LaunchServe service install/uninstall folder to subfolder of \setup.

Added LaunchServ (the launcher service) to allProcessesList.txt, used by terminateAll.bat.

Added the following line to terminateAll.bat, to try to stop LaunchServ nicely before brutal termination attempts:
pathToLaunchServe\LaunchServ.exe -stop

Updated INSTALLER.bat to uninstall any previous versions, then install with the above described configuration (to use LaunchServ).

Made all batches much more visually prominent about what they're doing.

Updated farmComm.ahk to call the killSpawns() function immediately at program start, so that any running spawned processes are terminated in any situation where the user switches, but an instance of farmComm.exe (in the session switched from) did not observe any user activity, and therefore did not properly kill those processes itself.

==v0.9.0.2==

Done: "LONG-TERM OBJECTIVE, BETTER SOLUTION," re the below previous item in the TO DO list. Functionality of multiple executables rolled into one executable, farmComm.exe (exploiting AutoHotkey timer functionality, which I figured out better--see src\test\timerTest.ahk.) Left one process as its own executable though; runProcesses.exe: handy for manually running processes whenever you wish and/or as called via farmComm.exe.

Unfortunately for anyone using this without admin privileges, the "USER" install described is at least temporarily suspended, because that uses a whole other branch of logic not-so-easy to either integrate into farmComm.exe or into a variant for that purpose. Double-unfortunately, the previous release intended for that purpose had a critical bug: if you want this function, you must either beg me or adapt the code yourself.

	REFERENCE: URGENT BUGFIX: Instead of having spawn.exe (or) systemSpawn.exe launch both spawnCheck and killCheck, have spawnCheck periodically check for the existence of the killCheck process, suspend its own functionality if that process is not found, attempt to launch the process any time it is not found, and resume its own functionality when that process if found. (LONG-TERM OBJECTIVE, BETTER SOLUTION; wrap all this functionality into one program, so that multiple executables do not need to be managed (wherever possible). With my first try at that, I couldn't seem to get simultaneous timers (and dependent functions) running properly in different threads). Otherwise, if spawnCheck.exe runs alone, it can spawn processes while the user is active, which it *should not.*

==v0.9.0.1 bug fix==

Spawn.exe--was still coded to kill processes via killSpawns.exe, notwithstanding killSpawns.exe no longer exists, as its functionality was rolled into killCheck.exe. Updated spawn.exe to fix.

==v0.9.7 INITIAL RELEASE 2013-07-31 TOO FREAKING EARLY IN THE MORNING==

First general release.

=DEVELOPER NOTES=

==COMPILATION==

AutoHotkey_L must be installed on your system to compile the .ahk source scripts under the \src folder. Run call-ahkrip.bat in that folder, to compile every .ahk script in that directory to an .exe file. This batch will also move the resultant executables to the intended target folder, ..\.

The idle timout (span of time of user inactivity before processes are launched) is hard-coded near the top of spawnCheck.ahk; the variable is IdleTimeout. It represents milliseconds, so 1000 (or 1000 ms) would be one second. I've set it to 510000 (8.5 minutes) for production; for testing you may want a shorter wait ;) like 3500.

The icon file was created (or can be recreated) via the AHK script and image in src/iconConverter. Note that ahkrip.bat is the place where this is configured to be used when compiling to .exe files.

==HOW IT WORKS==

farmComm.exe, a compiled AutoHotkey script, has three internal timer functions: one waits for when user idle time (no mouse or keyboard use) reaches 8.5 minutes, and launches processes through . . . aw, forget it. Examine the code, if you really want to know.

Bug fix version 0.9.0.1 eliminated a lot of painfully strung logic, previously written here.

At this writing, a limitation of the localComm\COMM1-3.txt files is that they must reference executables only (and possibly exactly) one subfolder deep. Place subfolders containing whatever executables you wish to run at user activity under the main folder (farmComm), with all their dependencies, and write the commands to execute them (prefixed with the subfolder path\) in the COMM1-3.txt files (again, see the defaults given in those files with this distribution for examples).

==OTHER NOTES==

I have no idea why this is so, but depending on the version of PaExec used, certain commands these executables rely on must be executed differently in order to work as hoped. PaExec 1.1 will only interact with the Secure Deskstop (session 0) if you explicitly tell it to, using the argument -d 0. However, PaExec v1.1, it seems will *not* honor that parameter (is this a bug??), yet, if you omit the -d 0 parameter, it properly interacts with the Secure Desktop (by default, I guess)! At this writing, this project relies on and uses PaExec v1.2, without using the -d 0 parameter in said setting.