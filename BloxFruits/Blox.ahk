#Requires AutoHotkey v2.0
#SingleInstance Force

#Include Fishing.ahk
#Include Config.ahk
#Include ..\common\Utils.ahk

running := false

u := Utils(Config.showToolTips)

F1::
{
    color := u.GetColorRgbAtMousePos()
    MsgBox "MouseX: " color.mouseX " Y: " color.mouseY " R=" color.r " G=" color.g " B=" color.b
}

+1::
{
    u.ShowToolTip("Start attacking", 500)
    global running

    if (running)  ; prevent double-start
        return

    running := true
    
    while (running)
    {
        Click
        Sleep Random(100, 200)
    }

    running := false
}

+2::
{
    global running
    running := false

    u.ShowToolTip("Aborting", 500)
}

+3::
{
    u.ShowToolTip("Start fishing", 500)

    global running

    if (running)  ; prevent double-start
        return

    running := true

    Fish.FishZoomFix()

    while (running)
    {
        f := Fish()
        f.Fish()

        Sleep 1000
    }

    running := false
}

F10::ExitApp