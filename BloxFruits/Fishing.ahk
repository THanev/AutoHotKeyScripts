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

    FishReelReadyCheck()
    {
        u.ShowToolTip("Reel ready check", 1000)

        reelReady := false

        Loop 20
        {
            reelCheckColor := u.GetColorRgbAt(Config.reelReadyCheckX, Config.reelReadyCheckY)

            colorMatches := u.ColorMatch(reelCheckColor, Config.reelReadyColor, Config.reelReadyColorTolerance)

            if (colorMatches)
            {
                Click
                return true
            }

            Sleep 1000
        }

        return false
    }

    FishReel()
    {
        u.ShowToolTip("Reeling", 500)

        Loop 50
        {
            indicatorInfo := this.GetReelIndicatorInfo()
            fishInfo := this.GetFishInfo()

            u.ShowToolTip(
                "Indicator - " "color: " indicatorInfo.color " x: " indicatorInfo.x " y: " indicatorInfo.y "`n"
                "Fish - pos: " fishInfo.pos " x: " fishInfo.x " y: " fishInfo.y, 
                1000
            )

            if(indicatorInfo.color = "unknown" && fishInfo.pos = "unknown")
            {
                u.ShowToolTip("All indicators unknown - aborting", 1000)
                return
            }
        }

    }

    Fish()
    {
        this.FishToolFix()
        this.FishThrow()

        ready := this.FishReelReadyCheck()

        if (!ready)
        {
            u.ShowToolTip("Reeling failed on ready check", 1000)
            return
        }
        
        this.FishReel()
    }

    GetReelIndicatorInfo()
    {
        widthIncrements := 5

        leftX := Config.reelBoxMinX
        rightX := Config.reelBoxMaxX

        while(leftX < rightX)
        {
            color := u.GetColorRgbAt(leftX, Config.reelBoxAvgY)

            if(u.ColorMatch(color, Config.reelBoxIndicatorGrey, 10))
                return {color: "gray", x: leftX, y: Config.reelBoxAvgY}

            if (u.ColorMatch(color, Config.reelBoxIndicatorGreen, 10))
                return {color: "green", x: leftX, y: Config.reelBoxAvgY}

            leftX += widthIncrements
            ;u.ShowToolTip("X: " leftX " Y: " Config.reelBoxAvgY " R:" color.r " G:" color.g " B:" color.b, 500)
        }

        return {color: "unknown", x: 0, y: 0}
    }

    GetFishInfo()
    {
        widthIncrements := 5

        leftX := Config.reelBoxMinX
        rightX := Config.reelBoxMaxX

        while(leftX < rightX)
        {
            color := u.GetColorRgbAt(leftX, Config.reelBoxAvgY)

            if(u.ColorMatch(color, Config.fishColorOutside, 10))
                return {pos: "outside", x: leftX, y: Config.reelBoxAvgY}

            leftX += widthIncrements
            ;u.ShowToolTip("X: " leftX " Y: " Config.reelBoxAvgY " R:" color.r " G:" color.g " B:" color.b, 500)
        }

        return {pos: "unknown", x: leftX, y: Config.reelBoxAvgY}
    }
}