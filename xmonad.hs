import Graphics.X11.Xinerama
import XMonad.Layout.BoringWindows
import XMonad.Layout.LayoutHints
import XMonad
import XMonad.Layout.Spacing
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicHooks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M

myLayout = tiled ||| Mirror tiled ||| Full
      where 
               tiled   = Tall nmaster delta ratio
               nmaster = 2
               ratio   = 2/3
	       delta   = 3/100

myWorkspaces = ["1:Terminal","2:Work","3:Media","4:Search"]
myManageHook = composeAll [
				className =? "firefox"  --> doShift "1:Search",
			        appName =? "eclipse"  --> doShift "2:Work",
				className =? "amarok" --> doShift "3:Media"
			  ]
myFadeHook   = composeAll [isUnfocused -->  transparency 0.45   ]

--keysToAdd x = [((mod1Mask, xK_f), spawn "firefox")]
--newKeys x   = M.union(keys defaultConfig x)(M.fromList(keysToAdd x))
main = do 
	xmproc <- spawnPipe "/usr/bin/xmobar /etc/X11/xinit/xmobarrc"
	xmonad $ defaultConfig  {
	workspaces         = myWorkspaces,
--	keys		   = keysToAdd <+> keys defaultConfig,
	manageHook         = manageDocks <+> myManageHook,
	layoutHook         =  avoidStruts $ layoutHook defaultConfig,
	logHook		   = fadeWindowsLogHook myFadeHook <+> dynamicLogWithPP xmobarPP {ppOutput = hPutStrLn xmproc, ppTitle = xmobarColor "green" "" . shorten 50}, 
	handleEventHook	   = fadeWindowsEventHook,
	normalBorderColor  = "white",
	focusedBorderColor = "white"
}

