running := false

F8::
{
    ToolTip "Starting mining"
    Sleep (1000)
    ToolTip

    global running
    if (running)  ; prevent double-start
        return

    running := true
    startTime := A_TickCount
    duration := 60000  ; 1 minute

    keys := ["a", "s", "d"]
    
    while (running && A_TickCount - startTime < duration)
    {        
        Click
        Sleep Random(300, 500)
        
        if (Mod(A_TickCount, 10) == 0)
        {
            SimulateMovement(keys)
        }

        else if(Mod(A_TickCount, 11) == 0)
        {
            rotationCount := Random(3, 5)
            SimulateRotation(rotationCount)
        }

        else if(Mod(A_TickCount, 12) == 0)
        {
            SimulateAfk(1000, 2500)
        }
        
        else if(Mod(A_TickCount, 20) == 0)
        {
            SimulateAfk(3500, 5000)
        }
    }

    running := false
}

F9::
{
    global running
    running := false

    ToolTip "Aborting"
    Sleep(1000)
    ToolTip
}

F10::ExitApp

SimulateMovement(keys)
{
    ToolTip "Simulating movement"
    Sleep (1000)
    ToolTip

    holdTimeSimulated := Random(150, 250)

    firstMovement := keys[Random(1, keys.Length)]
    secondMovement := OppositeMovement(firstMovement)

    HoldKeyDown(firstMovement, holdTimeSimulated)
    HoldKeyDown(secondMovement, holdTimeSimulated)

    ; Fix position orientation to be facing forward
    holdTimePositionFix := Random(250, 350)

    HoldKeyDown("s", holdTimePositionFix)
    HoldKeyDown("w", holdTimePositionFix)
}

SimulateAfk(randomLow, randomHigh)
{
    randomDelay := Random(randomLow, randomHigh)

    ToolTip "Simulating AFK " . randomDelay . " ms"

    Sleep(randomDelay)

    ToolTip
}

SimulateRotation(count)
{
    ToolTip "Simulating " . count . " rotations"
    Sleep (1000)
    ToolTip

    for i, _ in 1..count
    {
        ToolTip "Rotation " . i . " of " . count
        Sleep(500)
        ToolTip
    }
    
    ;holdTimeRotation := Random(100, 200)

    ;HoldKeyDown("a", holdTimeRotation)
    ;HoldKeyDown("d", holdTimeRotation)
}

OppositeMovement(key)
{
    Switch key
    {
        Case "w", "W":
            return "s"

        Case "a", "A":
            return "d"
            
        Case "s", "S":
            return "w"

        Case "d", "D":
            return "a"

        Default:
            return "a"
    }
}

HoldKeyDown(key, duration)
{
    Send "{" key " down}"
    Sleep duration
    Send "{" key " up}"
}