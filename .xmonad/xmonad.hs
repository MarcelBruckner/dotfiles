import XMonad
import XMonad.Config.Kde
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns

import qualified XMonad.StackSet as W -- to shift and float windows
import qualified Data.Map        as M

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
    -- close focused window
      ((modm .|. shiftMask      , xK_q      ), kill)
    , ((modm                    , xK_w      ), kill)
    , ((modm .|. controlMask    , xK_s      ), spawn "systemsettings" )

    , ((modm                    , xK_z      ), spawn "alacritty -t timew -e timew_startup")
    , ((modm .|. shiftMask      , xK_z      ), spawn "timew stop")
    , ((modm .|. shiftMask      , xK_t      ), spawn "alacritty -t task_add -e task_add")
    , ((modm .|. controlMask    , xK_t      ), spawn "alacritty -t task_done -e task_done")

    , ((modm .|. controlMask    , xK_Return ), spawn "chromium" )
    , ((modm                    , xK_s      ), spawn "ferdium")
    , ((modm                    , xK_p      ), spawn "krunner")
    , ((modm                    , xK_i      ), spawn "intellij-idea")
    , ((modm                    , xK_d      ), spawn "dmenu_run")
    , ((modm                    , xK_r      ), spawn "alacritty -e ranger")
    
    ]

myManageHook = composeAll . concat $
    [
      [ title       =? c                --> doRectFloat (W.RationalRect 0.4 0.4 0.2 0.02)   | c <- oneLineApps]
    , [ title       =? c                --> doRectFloat (W.RationalRect 0.4 0.4 0.2 0.2)    | c <- middleFloatApps]

    , [ className   =? c --> doFloat            | c <- floatsByClassName]
    , [ title       =? t --> doFloat            | t <- floatsByTitle]
    , [ className   =? c --> doF (W.shift "9")  | c <- messengingApps]
    , [ className   =? c --> doF (W.shift "3")  | c <- ircApps]
    ]
  where floatsByClassName   = ["MPlayer", "Gimp", "Nvidia-settings", "plasmashell", "ksmserver-logout-greeter", "Google-chrome", "SpeedCrunch", "kcalc", "systemsettings"]
        floatsByTitle       = ["alsamixer", "timew"]
        messengingApps      = ["Ferdium"] -- open on desktop 2 <-- Empty to remember later
        ircApps             = [""] -- open on desktop 3
        oneLineApps         = ["timew", "task_add"]
        middleFloatApps     = ["SpeedCrunch", "task_done"]

myLayout = avoidStruts ( master ||| Mirror master ||| threeCol ||| Grid ||| Full )
    where
        -- default tiling algorithm partitions the screen into two panes
        master   = Tall nmaster delta ratio

        threeCol = ThreeColMid nmaster delta ratio

        -- The default number of windows in the master pane
        nmaster = 1

        -- Default proportion of screen occupied by master pane
        ratio   = 1/2

        -- Percent of screen to increment by when resizing panes
        delta   = 3/100

myStartupHook = do
    spawn "picom --experimental-backends &"

------------------------------------------------------------------------
-- 
------------------------------------------------------------------------
main = xmonad kde4Config
    { 
        -- simple stuff
        terminal           = "alacritty"
        , focusFollowsMouse  = False
        , clickJustFocuses   = False
        , borderWidth        = 2
        , modMask            = mod4Mask
        , workspaces         = workspaces kde4Config
        , normalBorderColor  = normalBorderColor kde4Config
        , focusedBorderColor = "#fd7b34"
            
        -- key bindings
        , keys               = myKeys <+> keys kde4Config
        , mouseBindings      = mouseBindings kde4Config

        -- hooks, layouts
        , layoutHook         = spacingWithEdge 2 $ myLayout
        , manageHook         = manageHook kde4Config <+> myManageHook
        , handleEventHook    = handleEventHook kde4Config
        , logHook            = logHook kde4Config
        , startupHook        = startupHook kde4Config <+> myStartupHook
    }
