farmComm
========

PROBLEM:
Petahashes or more of potential computational power lie dormant in the world, even an extremely tiny fraction of which power could be put to evil and greedy purposes, in the right hands.

SOLUTION:
THIS TOOLSET!

(These hands are now YOUR hands!)

(Problems this solution does not solve: running processes with access to graphics cards (an "active" session) when users are logged out, but the computer is on. Examine BitMoose as a possible means to solve that problem (I was halfway through coding farmComm when I discovered BitMoose, and at this writing I do not actually know whether I have tried to solve many of the problems which BitMoose may have already solved).

farmComm description: Spawns arbitrary, configurable processes, partly hidden, when any user is idle for 8.5 minutes (default). Terminates those processes when user resumes activity. (Planned: an option to briefly suspend the processes if the idle interrupt is brief.) User must be logged in. Terminates and re-spawns those processes on user switch (to always run the processes in the active session, and therefore maintain access to the graphics hardware--which in Windows 7, becomes unavailable to processes when users disconnect). Default installation runs processes in the secure desktop (session 0, which *does* have continuous access to graphics hardware), so that processes respond to user activity/inactivity even when the workstation is locked.

Built with AutoHotkey_L, designed for Windows 7.

Released under the Absa-freaking-lutely-anything License 1.0, an instance of . . . no license! . . . the text of which is available at:
http://www.earthbound.io/legal/absa-freaking-lutely-anything-license1.0.txt

Contact: artdev@inboxalias.com

DISCLAIMER: While I have tested this sufficiently that I believe it works, it is not guaranteed to be fit for any purpose, and it may cause several people to dislike you. Actually, the abuse of this toolset could *really* get you in trouble.

Useful for objectives like managing 3D render farm slave node tasks (please add another noun to that phrase, just for good measure!), fractal flame renderers, or cryptocurrency miners. However, it can be used to spawn and terminate essentially anything on user inactivity/activity.

What is meant by processes spawned as "partly hidden" is that while they run and function normally (other than any functionality which *requires* user interaction), their user interfaces do not appear--not anywhere. However, they will still be ordinarily detectable, for example they will be listed in the Windows Task Manager.

=v0.9.7 INITIAL RELEASE 2013-07-31 TOO FREAKING EARLY IN THE MORNING=

This toolset can for example dramatically increase cryptocurrency mining uptime via use of shared but idle workstations. If you find great use for it, I'd greatly appreciate donations to any of the following cryptocurrency addresses:

Bitcoin:		1CoRdDm9KyDTfhnaTNoeM5HiNtRHBaKoy9
Litecoin:		LNpsi5T9UuSP9Su4yahhgT5CfY5vCExhmP
Feathercoin:	6ekB56KQJfgFZGM2qWvVRt77EHLGr5C3EN
Novacoin:		4Z123Y8QZXPVvfA7LVDySunJoEG2dnUHFV

==INSTALLATION AND USE==

Navigate to the /setup folder, launch an elavated (or *maybe* mereley administrative) command prompt thereto, and run INSTALL.bat. Follow the configuration details given here and see if it works. If it doesn't work, alter INSTALL.bat per the comments therein to try for a "USER" (instead of "SYSTEM") install. If that doesn't work either, cry, because you are not evil and/or lucky enough. Drop me a line and tell me your woes. I won't give you any pity, but at least you'll get to indulge in self-pity.

A SYSTEM setup runs this toolset's processes in session 0, so they will spawn and terminate even when the computer is locked (because the lock screen is in session 0), but again only if the user is logged in (with thier session locked *or* unlocked). This is achieved via systemSpawn.exe, and the processes it launches. A USER setup accomplishes much the same, by instead launching spawn.exe at user login, but spawn.exe doesn't run in session 0, it runs in the user session, and therefore cannot respond to user activity when the computer is locked.

Whichever setup you use, create these folders in Windows:

C:\farm\Local

-- and copy this extracted farmComm distribution to that folder (so that it has the path C:\farm\Local\farmComm, and if you prefer to install to another directory, I'll later explain how.) Note the miners.7z archive therein (meta!), which you must extract with a free program you must go through the pain of downloading if you don't already use it but why on earth aren't you using it, it's superior to the winzip library, 7-zip (free from 7-zip.org). Place executables you wish to spawn at user inactivity under sub-folders of this main distribution, for example farmComm\cpuminer\minerd.exe (with all of the other files that executable depends on. Just such a preconfigured ;) example is provided in miners.7z). Then write the command(s) to start your custom executable(s) into localComm\COMM1.txt, etc. (note also the preconfigured examples provided therein--only three commands are supported at this writing).

Lastly, be sure to write the image name (without the .exe extension) of each executable you wrote in the COMM~.txt files--write those image names in processSpawnList.txt, one image per line. See again the defaults provided therein for examples. NOTE: If you do not do this, these processes will not terminate upon user activity resuming from idle!

To check whether your configuration will properly run, assuming it is a resource-hungry application (e.g. it uses a lot of CPU and/or GPU power), first run a resource monitor tool like Open Hardware Monitor, and then run runProc.exe, and see if hardware (for example CPU) activity spikes as a result. You should also see your custom configured process(es) running, or listed in, Windows Task Manager (you can get to that via CTRL+ALT+DEL).

NOTE: if you have logged off and then on after initial setup, killCheck.exe may be running, which if it is will very quickly terminate your processes, owing to your own user activity! To kill that process and also spawnCheck.exe, run killControlProcesses.exe, which terminates all the processes listed in controllerProcessList.txt.

You can install this toolset and run it from any directory (it is designed to do so); you will just need to configure it to start up from whichever other folder you choose, by editing the .xml task files in the \setup folder before you install them. It may be possible to effectively run this toolset by other automatic startup means. I tried startup registry entries, which made PaExec sometimes fart loudly when I switched logins.

terminateAll.bat and killControllerProcesses.exe are your emergency exits if program execution in this toolset goes wonky (hopefully, not). The former does not always work it seems; try running it as an administrator if so. As a last resort, temporarily copy everything in allProcessesList.txt to controllerProcessList.txt and run killControllerProcesses.exe with elavated priveleges.

Examine also mineall.bat and the other batch files which it works with (some in subfolders), which are designed (and which I use) for dedicated cryptocurrency mining. These can easily be rewritten to spawn and terminate other dedicated processes.

==Dependencies==

These scripts (compiled to executables) rely on free utilities (including AutoHotkey to compile them):

1) PaExec, which is available for free use for any purpose, and of which a version is included. The license for it is here:
http://www.poweradmin.com/paexec/paexec_eula.txt

--and you may download it yourself, here:
http://www.poweradmin.com/paexec/

2) Process.exe, a very effective process lister/suspender/executor/closer/killer. It is available for download and listed as "freeware," here:
http://retired.beyondlogic.org/consulting/processutil/processutil.htm

==TO DO:==

URGENT BUGFIX: Instead of having spawn.exe (or) systemSpawn.exe launch both spawnCheck and killCheck, have spawnCheck periodically check for the existence of the killCheck process, suspend its own functionality if that process is not found, attempt to launch the process any time it is not found, and resume its own functionality when that process if found. (LONG-TERM OBJECTIVE, BETTER SOLUTION; wrap all this functionality into one program, so that multiple executables do not need to be managed (wherever possible). With my first try at that, I couldn't seem to get simultaneous timers (and dependent functions) running properly in different threads). Otherwise, if spawnCheck.exe runs alone, it can spawn processes while the user is active, which it *should not.*

Add configurable CPU/GPU load check functionality, for example do not spawn processes if the CPU and/or GPU load (from other processes?) are over fifteen percent. Possibly see the source code for how Open Hardware Monitor checks loads as a start point for this.

Option to self-nuke the entire farmComm directory and all its contents if a reference file's timestamp is more than X days old. (This reference file could for example be periodically refreshed remotely--from another computer--else the entire toolset self-destruct to no longer burden the computer.) See development in test/selfNuke-test.ahk (I already have a script that nukes a directory, not yet included).

Invoke/configure processes according to settings read (and written to?) an .ini file (see the work in progress in src/test/create-ini-test.ahk). At this writing, spawn.ahk (/.exe) *expects* to receive an instruction that begins with directory\executable; it will parse the string before the slash and append that to %A_WorkingDir% to set the executable's working directory. However, because of the way parsing is set up, it will not find the executable if it is more than one subfolder deep.

30 second suspend timer; when a user resumes from idle, suspend rather than kill processes, and only terminate them if user activity continues beyond 30 seconds (if they are *not idle* for 30 seconds.

Possibly optionally run a resource monitor in session zero to behold how enslaved the machine even when it is locked.

Possibly many other things.

=DEVELOPER NOTES=

==COMPILATION==
AutoHotkey_L must be installed on your system to compile the .ahk source scripts under the \src folder. Run call-ahkrip.bat in that folder, to compile every .ahk script in that directory to an .exe file. This batch will also move the resultant executables to the intended target folder, ..\.

The idle timout (span of time of user inactivity before processes are launched) is hard-coded near the top of spawnCheck.ahk; the variable is IdleTimeout. It represent milliseconds, so 1000 would be one millisecond. I've set it to 510000 (8.5 minutes) for production; for testing you may want a shorter wait ;) like 3500.

The icon file was created (or can be recreated) via the AHK script and image in src/iconConverter. Note that ahkrip.bat is the place where this is configured to be used when compiling to .exe files.

==HOW IT WORKS==
systemSpawn.exe, intended to launch at user logon, launches two processes, killCheck.exe and spawnCheck.exe, into the secure desktop as SYSTEM (this is accomplished through PaExec.exe). killCheck continuously checks if the user has been active in any three second period. If the user is active, it checks for and terminates any of the processes listed in processSpawnList.txt. spawnCheck continuously checks if the user has been idle for more than a time period (default is 8.5 minutes). If the user is idle, it calls runProc.exe, which reads launches the processes specified (and configurable) in localComm\COMM1.txt, COMM2.txt, and COMM3.txt. Thus, between killCheck and spawnCheck, the executables given in the COMM~.txt and ~list.txt will be executed at user idle, and terminated at user activity. (Note also that at first launch, systemSpawn calls killSpawns).

A USER install achieves the same by instead executing spawn.exe at user login. At first launch, spawn.exe writes the pseudo-username SecretNinja5603 to user.txt, and checks for and terminates any running processes listed in ~list.txt. Thereafter, it periodically checks if it is running in an active session, and also reads the username written in user.txt. At any time the name in user.txt does not match the username under which spawn.exe runs, it writes the username (of the user under which it runs) to user.txt, and launches killCheck and spawnCheck, which perform the work already described. user.txt therefore functions as a file that effectively says "This user last spawned the processes listed in \localComm\COMM1-3.txt, from an active session." Because it does this, if in its periodic checks of user.txt it finds a match (user.txt lists the same user who last spawned tasks), it can do nothing (and indeed in this condition it does nothing), and it therefore avoids duplicate spawns of the processes. On the other hand (as described), at any time it is "aware" that it is in an active session, and did not last spawn any processes, it will terminate those processes, and start the cycle over again to check for thier execution.

Because the functionality of checking whether it runs under an active session is built into both systemSpawn and spawn, they both solve two problems: 1) Responding to user activity only in the active session (*not* in any other sessions) and 2) Terminating processes in other sessions if another user becomes the active user (if sessions are switched). The latter is enabled by the handy fact that the process killer used (Process.exe) will terminate processes in other sessions, whether the running user has administrative credentials or not (not all process killers are so powerful, it seems).

At this writing, a limitation of the localComm\COMM1-3.txt files is that they must reference executables only (and possibly exactly) one subfolder deep. Place subfolders containing whatever executables you wish to run at user activity under the main folder (farmComm), with all their dependencies, and write the commands to execute them (prefixed with the subfolder path\) in the COMM1-3.txt files (again, see the defaults given in those files with this distribution for examples).

==OTHER NOTES==
I have no idea why this is so, but depending on the version of PaExec used, certain commands these executables rely on must be executed differently in order to work as hoped. PaExec 1.1 will only interact with the Secure Deskstop (session 0) if you explicitly tell it to, using the argument -d 0. However, PaExec v1.1, it seems will *not* honor that parameter (is this a bug??), yet, if you omit the -d 0 parameter, it properly interacts with the Secure Desktop (by default, I guess)! At this writing, this project relies on and uses PaExec v1.2, without using the -d 0 parameter in said setting.