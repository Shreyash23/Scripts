#Script to launch Windows Parallels VM and connect usb-keyboard footcontroller to the VM
#It then connects the Mac to Windows VM via RTPMidi Bridge and launches iDisplay to remote display and then Mainstage for performing live.

#Works as tested on macOS Sierra

tell application "Parallels Desktop" to activate

delay 6

tell application "System Events"
	click button 3 of window 1 of application process "Parallels Desktop"
end tell


do shell script "/usr/local/bin/prlctl resume \"Windows 7\""
-- Connect Keyboard 1 and 2 after getting info
set keyboard1 to do shell script "/usr/local/bin/prlsrvctl info | grep 'USB Keyboard' | awk '{print $5}'"
set keyboard2 to do shell script "/usr/local/bin/prlsrvctl info | grep 'USB Keykoard' | awk '{print $5}'"
do shell script "/usr/local/bin/prlctl set \"Windows 7\" --device-connect " & keyboard1
do shell script "/usr/local/bin/prlctl set \"Windows 7\" --device-connect " & keyboard2

tell application "Audio MIDI Setup" to activate

tell application "System Events"
	tell application process "Audio MIDI Setup"
		#click radio button "Network"
		set position to {267, 183}
		perform action "AXRaise"
		tell window "MIDI Studio"
			
			set position to {267, 183}
			do shell script "/usr/local/bin/cliclick c:524,333" #select network
			
			tell toolbar 1
				click button "Show Info"
			end tell
		end tell
		
		tell window "MIDI Network Setup"
			set position to {267, 183}
			tell group 3
				do shell script "/usr/local/bin/cliclick c:405,405" #Select 1st computer
				click button "Connect"
				--set visible to false for MIDI STUDIO
				keystroke "h" using command down
			end tell
		end tell
	end tell
end tell
delay 1
do shell script "/usr/local/bin/cliclick c:34,44" #select network
tell application "iDisplay" to activate
--tell application "MainStage 3" to activate
