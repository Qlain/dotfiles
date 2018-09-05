-- default desktop configuration for Fedora

import qualified Data.Map as M
import Control.Monad (liftM2)          -- myManageHookShift
import Data.Monoid
import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleResize as Flex -- flexible resize
import XMonad.Actions.FloatKeys
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo

import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Layout
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.TwoPane

import XMonad.Prompt
import XMonad.Prompt.Window            -- pops up a prompt with window names
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.SpawnOnce

import Graphics.X11.ExtraTypes.XF86


myWorkspaces = ["1", "2", "3", "4", "5"]

-- Border width
myBorderWidth = 4

-- Border color
myNormalBorderColor  = "#262626"
myFocusedBorderColor = "#ededed"

-- Float window control width
moveWD = myBorderWidth
resizeWD = 2*myBorderWidth

-- Color Setting
colorBlue      = "#868bae"
colorGreen     = "#00d700"
colorRed       = "#ff005f"
colorGray      = "#666666"
colorWhite     = "#bdbdbd"
colorNormalbg  = "#1c1c1c"
colorfg        = "#a8b6b8"


gapwidth  = 4
gwU = 8
gwD = 8
gwL = 48
gwR = 48

myTerminal  = "urxvt"

myLayout = spacing gapwidth $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
           $ (ResizableTall 1 (1/200) (120/200) [])
             ||| (TwoPane (1/200) (120/200))
             ||| Simplest

-- -- For 10x20 character size
-- myLayout = spacing gapwidth $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
--            $ (ResizableTall 1 (1/181) (96/181) [])
--              ||| (TwoPane (1/181) (96/181))
--              ||| Simplest

myStartupHook = do
    spawnOnce "gnome-settings-daemon"
    spawnOnce "/home/qlain/.xsession"

myWsBar = "/usr/bin/xmobar /home/qlain/.xmobarrc"
wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorRed     colorNormalbg . \s -> "●"
                , ppUrgent          = xmobarColor colorGray    colorNormalbg . \s -> "●"
                , ppVisible         = xmobarColor colorRed     colorNormalbg . \s -> "⦿"
                , ppHidden          = xmobarColor colorGray    colorNormalbg . \s -> "●"
                , ppHiddenNoWindows = xmobarColor colorGray    colorNormalbg . \s -> "○"
                , ppTitle           = xmobarColor colorRed     colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = "  "
        }

main :: IO()

main = do
    --xmproc <- spawnPipe "/usr/bin/xmobar /home/qlain/.xmobarrc"  -- .xmoabrrcのパスを記述しておく
    wsbar <- spawnPipe myWsBar
    session <- getEnv "DESKTOP_SESSION"
    --xmonad $ maybe desktopConfig desktop session terminal
    xmonad $ ewmh desktopConfig {
          borderWidth           = myBorderWidth
        , terminal              = myTerminal
        , focusFollowsMouse     = True
        , normalBorderColor     = myNormalBorderColor
        , focusedBorderColor    = myFocusedBorderColor
        , startupHook           = myStartupHook
        , layoutHook            = avoidStruts $ ( toggleLayouts (noBorders Full) $ myLayout )
        , workspaces            = myWorkspaces
        , handleEventHook       = fullscreenEventHook
    }


desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig



----------------------------------------
-- vim: ft=haskell
