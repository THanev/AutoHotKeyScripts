running := false
showToolTips := true

+1::
{
    ShowToolTip("Start attacking", 500)

    global running

    if (running)  ; prevent double-start
        return

    running := true
    startTime := A_TickCount
    duration := 300000  ; 5 minutes
    
    while (running && A_TickCount - startTime < duration)
    {
        SendMouseClick()
        Sleep Random(100, 200)
    }

    running := false
}

+2::
{
    global running
    running := false

    ShowToolTip("Aborting", 500)
}


F10::ExitApp

SendMouseClick()
{
    Click
}

ShowToolTip(message, duration)
{
    global showToolTips

    if (showToolTips)
    {
        ToolTip message
        Sleep duration
        ToolTip
    }
}