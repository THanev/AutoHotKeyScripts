class Utils
{
    __New(showToolTips := true)
    {
        this.showToolTips := showToolTips
    }

    ShowToolTip(message, duration)
    {
        if (this.showToolTips)
        {
            ToolTip message
            Sleep duration
            ToolTip
        }
    }

    GetColorRgbAtMousePos()
    {
        MouseGetPos &x, &y
        color := this.GetColorRgbAt(x, y)

        return color
    }

    GetColorRgbAt(x, y)
    {
        color := PixelGetColor(x, y, "RGB")

        return {
            mouseX: x,
            mouseY: y,
            r: (color >> 16) & 0xFF,
            g: (color >> 8) & 0xFF,
            b: color & 0xFF
        }
    }

    ColorMatch(color1, color2, tolerance)
    {
        redInTolerance := Abs(color1.r - color2.r) <= tolerance
        greenInTolerance := Abs(color1.g - color2.g) <= tolerance
        blueInTolerance := Abs(color1.b - color2.b) <= tolerance

        return (redInTolerance && greenInTolerance && blueInTolerance)
    }
}