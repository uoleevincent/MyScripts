#include <Constants.au3>
#include <GuiConstantsEx.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
;Version 1.0.1

;MsgBox($MB_ICONINFORMATION, "Initial M Unity Assests Setup tools", "Please run this program after you have installed and setup the Google drive. ")

GUICreate("Initial M Game Project Unity Assests Setup Tools", 400, 360)
GUISetIcon(@SystemDir & "\mmc.exe", 0)

GUICtrlCreateLabel("Connect Assests folder", 10, 15, 400)
GUICtrlSetFont(-1,14,700,4)

GUICtrlCreateLabel("Select the Unity Game Project folder :", 10, 55, 240)
GUICtrlSetFont(-1,12)
Local $idUAF = GUICtrlCreateButton("Browse",250,50,85,25)

GUICtrlCreateLabel("Select the Google Drive Game Assests folder :", 10, 90, 300)
GUICtrlSetFont(-1,12)
Local $idGAF = GUICtrlCreateButton("Browse",305,85,85,25)

Local $idConnect = GUICtrlCreateButton("CONNECT",150,130,85,25)
GUICtrlSetState(-1,$GUI_DISABLE)

GUICtrlCreateGraphic(5,185,390,1,$SS_BLACKRECT)

GUICtrlCreateLabel("Disconnect Assests folder", 10, 220, 400)
GUICtrlSetFont(-1,14,700,4)

GUICtrlCreateLabel("Select the Unity Game Project folder :", 10, 260, 240)
GUICtrlSetFont(-1,12)
Local $idUAF2 = GUICtrlCreateButton("Browse",250,255,85,25)

Local $idDisconnect = GUICtrlCreateButton("DISCONNECT",150,315,85,25)
GUICtrlSetState(-1,$GUI_DISABLE)



Local $UnityAssetsFolder
Local $GoogleAssetsFolder


GUISetState(@SW_SHOW)
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop

		 Case $idUAF
			$UnityAssetsFolder = FileSelectFolder ( "dialog text", "")


		 Case $idGAF
			$GoogleAssetsFolder = FileSelectFolder ( "dialog text", "")
			If $UnityAssetsFolder And $GoogleAssetsFolder Then GUICtrlSetState($idConnect,$GUI_ENABLE)
		 Case $idUAF2
			$UnityAssetsFolder2 = FileSelectFolder ( "dialog text", "")
			If $UnityAssetsFolder2 Then GUICtrlSetState($idDisconnect,$GUI_ENABLE)

		 Case $idConnect
			;MsgBox($MB_OK,"test", 'mklink /j "'& $UnityAssetsFolder &'\Folder1" "'& $GoogleAssetsFolder & '\Folder1"')
			Local $CommandLine = StringLeft($GoogleAssetsFolder,2) & ' && ' & _
								 'cd ' & $GoogleAssetsFolder & ' && ' & _
								 'for /d %i in ("*") do mklink /j "' & $UnityAssetsFolder & '\%i" "' & $GoogleAssetsFolder & '\%i"'
								 ;'mklink /j "'& $UnityAssetsFolder &'\Animations" "'& $GoogleAssetsFolder & '\Animations" && ' & _
								 ;'mklink /j "'& $UnityAssetsFolder &'\Audio" "'& $GoogleAssetsFolder & '\Audio" && ' & _
								 ;'mklink /j "'& $UnityAssetsFolder &'\Fonts" "'& $GoogleAssetsFolder & '\Fonts" && ' & _
								 ;'mklink /j "'& $UnityAssetsFolder &'\UI" "'& $GoogleAssetsFolder & '\UI" && ' & _
								 ;'mklink /j "'& $UnityAssetsFolder &'\Sprites" "'& $GoogleAssetsFolder & '\Sprites" && ' & _
								 ;'pause'
			RunWait('"'&@ComSpec&'" /c ' & $CommandLine)
			Local $CommandLine = 'explorer "' & $UnityAssetsFolder & '"'
			RunWait('"'&@ComSpec&'" /c ' & $CommandLine)
		 Case $idDisconnect
			Local $CommandLine = 'rd "' & $UnityAssetsFolder2 & '\Animations" && ' & _
								 'rd "' & $UnityAssetsFolder2 & '\Audio" && ' & _
								 'rd "' & $UnityAssetsFolder2 & '\Fonts" && ' & _
								 'rd "' & $UnityAssetsFolder2 & '\UI" && ' & _
								 'rd "' & $UnityAssetsFolder2 & '\Sprites" && ' & _
								 'Echo Connection removed. && ' & _
								 'pause'
			RunWait('"'&@ComSpec&'" /c ' & $CommandLine)
	EndSwitch

WEnd

GUIDelete()


;Local $UnityAssetsFolder = FileSelectFolder ( "dialog text", "")
;MsgBox($MB_OK, "Game project folder", $UnityAssetsFolder)