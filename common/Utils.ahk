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
}