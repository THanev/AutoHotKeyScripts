#Requires AutoHotkey v2.0

#Include Config.ahk
#Include ..\common\Utils.ahk

class Fish
{
    static u := Utils(Config.showToolTips)

    static FishZoomFix()
    {
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

        reelReady := false

        Loop 20
        {
            reelCheckColor := u.GetColorRgbAt(Config.reelReadyCheckX, Config.reelReadyCheckY)

            colorMatches := u.ColorMatch(reelCheckColor, Config.reelReadyColor, Config.reelReadyColorTolerance)

            if (colorMatches)
            {
                return true
            }

            Sleep 500
        }

        u.ShowToolTip("Reeling failed", 1000)
        return false
    }

    Fish()
    {
        this.FishToolFix()
        this.FishThrow()

        reeled := this.FishReel()

        if (!reeled)
            return

        u.ShowToolTip("Fish reeled in!", 1000)
    }
}15