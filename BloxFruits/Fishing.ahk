#Requires AutoHotkey v2.0

#Include Config.ahk
#Include ..\common\Utils.ahk

class Fish
{
    static u := Utils(Config.showToolTips)

    __New()
    {
        this.state := 0 ; 0 = idle, 1 = throwing, 2 = reeling
    }

    static FishZoomFix()
    {
        this.state := 1

        u.ShowToolTip("State " . this.state, 1000)

        Loop 10 
        {
            Send "{WheelUp}"
            Sleep 50
        }

        Loop 8 
        {
            Send "{WheelDown}"
            Sleep 50
        }
    }

    FishToolFix()
    {
        u.ShowToolTip("Fixing tool", 500)

        Send "1"
        Sleep Random(500, 800)
        Send "5"
    }

    FishThrow()
    {
        u.ShowToolTip("Throwing", 500)

        Send "{LButton down}"
        Sleep 700
        Send "{LButton up}"
    }

    FishReel()
    {
        u.ShowToolTip("Reeling", 1000)
    }

    Fish()
    {
        this.FishToolFix()
        this.FishThrow()
        this.FishReel()
    }
}