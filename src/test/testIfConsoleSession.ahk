#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

;This script tests a function which can indicate whether this script itself is running from a console session or not (it seems), in Windows 7 (and/or Vista)? This problem does not apply in Windows XP (I believe); this is a problem (really a security solution by Microsoft) for Windows 7, being session isolation. Ordinarily, the screen and graphics card are only accessible to a program if runs in a console (or active?) session.

;The simple test this script executes displays a box with the value of variable indicating whether it is running in a console session.

;To run this directly in an inactive session, do this: log on to Windows 7 under two different user accounts. Under the second user account, bring up a command prompt and type: <query user>. This will give you the session ID of the session which runs under the other user. Next, obtain the free PaExec tool (a less restricted variant of PsExec), and copy it to the same directory as this script. Then, run this command:

;PaExec \\<YOURCOMPUTERNAME> -d -i 2 -u <YOURDOMAINNAME>\<TheOtherUsername> -p <TheOtherUserName'sPassword> <FullPathOfThisScript'sDirectory>\testIfConsoleSession.exe

	;--DOMAIN/LOCAL LOGIN DETAILS DETOUR: In that command, <YOURCOMPUTERNAME> is the name of your computer which you can find under the properties panel of "My Computer," and where <YOURDOMAINNAME> is optional if your computer is not connected to a Domain network. If your computer *is* connected to a Domain network, <YOURDOMAINNAME> can be substituted with <YOURCOMPUTERNAME>\<aLocalLogin> to login to an account which is local to that computer (and not part of the Domain network, for example not part of any Active Directory collection of user logins). As mentioned, <YOURCOMPUTERNAME> may be optional if your computer is not part of a Domain network--in that case, you can probably use just <TheOtherUsername> credentials.

;Hopefully you'll get this message: "PAExec returning exit code 0." Now, press CTRL+ALT+DELETE, start the Task Manager, go to the "Users" tab, right-click the other user, click "Connect," and type in that user's password. Hopefully, you'll then connect to that session, and see a message box from this script which reads: "MsgBox, isConsoleBool value is <a nonzero value--probably 1> [or, if this is executing as hoped, nonzero], which indicates that this script was not run from a console session (probably an "inactive" session).

;Another way to check this is to simply execute two instances of this script, one from each login, and switch between the logins as they each run--because they run in a loop (the message box reappears every seventeen seconds). Why then did I bother to go into that detail about using PaExec.exe to test this? Because in case you didn't know, that showed you how you can use PaExec to execute a program in another session . . . including on another computer, if you have the proper credentials, which can be very handy :) How? Instead of <YOURCOMPUTERNAME> in the given PaExec command, enter <SOMEOTHERCOMPUTERNAME>.

;Other documentation: "4096 	SM_REMOTESESSION: This system metric is used in a Terminal Services environment. If the calling process is associated with a Terminal Services client session, the return value is nonzero. If the calling process is associated with the Terminal Server console session, the return value is zero. The console session is not necessarily the physical console. Windows NT 4.0 SP3 and earlier, Windows Me/98/95: The retrieved value is always 0." Re: http://www.autohotkey.com/docs/commands/SysGet.htm

loop
{

SysGet, isConsoleBool, 4096
if (isConsoleBool == 0)
	{
	MsgBox, 4, , isConsoleBool value is %isConsoleBool% [or, if this is executing as hoped, zero], which indicates that this script runs from a console session. It would be more difficult to execute this script otherwise, but there are ways . . . see the comments of this script to read about one way. Continue this test (if you continue, this message will reappear in 17 seconds)?
	IfMsgBox No
    return
	}
else
	{
	MsgBox, 4, , isConsoleBool value is %isConsoleBool% [or, if this is executing as hoped, nonzero], which indicates that this script was not run from a console session (probably an "inactive" session) Continue this test (if you continue, this message will reappear in 17 seconds)?
	IfMsgBox No
    return
	}

Sleep, 17000
}