import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.SetWMName

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Hooks.EwmhDesktops

myTerminal = "terminator"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myBorderWidth = 0

myModMask = mod4Mask

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myNormalBorderColor = "#dddddd"
myFocusedBorderColor = "#ff0000"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ((modm, xK_p ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modm, xK_p ), spawn "exe=`dmenu_run -nb '#000' -nf '#fff' -sb '#333' -sf '#fff'` && eval \"exec $exe\"")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p ), spawn "gmrun")

    , ((modm , xK_Up ), spawn "amixer -q sset Master 10%+ unmute")
    , ((modm , xK_Down ), spawn "amixer -q sset Master 10%- unmute")

    -- close focused window
    , ((modm .|. shiftMask, xK_c ), kill)

     -- Rotate through the available layout algorithms
    , ((modm, xK_space ), sendMessage NextLayout)

    -- Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm, xK_n ), refresh)

    -- Move focus to the next window
    , ((modm, xK_Tab ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm, xK_j ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm, xK_k ), windows W.focusUp )

    -- Move focus to the master window
    , ((modm, xK_m ), windows W.focusMaster )

    -- Swap the focused window and the master window
    , ((modm, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j ), windows W.swapDown )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k ), windows W.swapUp )

    -- Shrink the master area
    , ((modm, xK_h ), sendMessage Shrink)

    -- Expand the master area
    , ((modm, xK_l ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm, xK_t ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm , xK_q ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]


myLayout = Full ||| tiled ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio = 1/2

     -- Percent of screen to increment by when resizing panes
     delta = 3/100

-- myEventHook = mempty
myEventHook = fullscreenEventHook

myLogHook = return ()

myStartupHook = setWMName "LG3D"

main = xmonad defaults

defaults = defaultConfig {

        terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        modMask = myModMask,
        workspaces = myWorkspaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys = myKeys,
        mouseBindings = myMouseBindings,

        layoutHook = myLayout,
        handleEventHook = myEventHook,
        logHook = myLogHook,
        startupHook = myStartupHook
    }
