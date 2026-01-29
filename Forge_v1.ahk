running := false
showToolTips := true

F6::
{
    SimulateRotation()
}

F7::
{
    ShowToolTip("Start clicking", 1000)

    global running

    if (running)  ; prevent double-start
        return

    running := true
    startTime := A_TickCount
    duration := 120000  ; 2 minutes
    
    while (running && A_TickCount - startTime < duration)
    {
        SendMouseClick()
        Sleep Random(300, 500)
    }

    running := false
}

F8::
{
    ShowToolTip("Start mining", 1000)

    global running

    if (running)  ; prevent double-start
        return

    running := true
    startTime := A_TickCount
    duration := 600000  ; 10 minutes
    
    while (running && A_TickCount - startTime < duration)
    {
        SimulateMining(A_TickCount)
    }

    running := false
}

F9::
{
    global running
    running := false

    ShowToolTip("Aborting", 1000)
}

F10::ExitApp

SimulateMining(tickCount)
{
    SendMouseClick()
    Sleep Random(500, 700)
    
    if (Mod(tickCount, 33) == 0)
    {
        ;SimulateMovement()
    }
    else if(Mod(tickCount, 31) == 0)
    {
        SimulateRotation()
    }
    else if(Mod(tickCount, 11) == 0)
    {
        ;SimulateJump()
    }

    if(Mod(tickCount, 25) == 0)
    {
        SimulateAfk(3500, 4500)
    }
    else if(Mod(tickCount, 13) == 0)
    {
        SimulateAfk(1000, 1500)
    }
}

SimulateMovement()
{
    ShowToolTip("Simulating movement", 1000)

    movementDelayMin := 100
    movementDelayMax := 300

    keys := ["a", "s", "d"]

    holdTimeSimulated := Random(250, 350)

    firstMovement := keys[Random(1, keys.Length)]
    secondMovement := OppositeMovement(firstMovement)

    HoldKeyDown(firstMovement, holdTimeSimulated)
    Sleep Random(movementDelayMin, movementDelayMax)

    HoldKeyDown(secondMovement, holdTimeSimulated)
    Sleep Random(movementDelayMin, movementDelayMax)

    ; Fix position orientation to be facing forward
    SimulateRotation()
}

SimulateJump()
{
    ShowToolTip("Simulating jump", 1000)
    HoldKeyDown("Space", 5)
}

SimulateAfk(randomLow, randomHigh)
{
    randomDelay := Random(randomLow, randomHigh)

    ShowToolTip("Simulating AFK " . randomDelay . " ms", randomDelay)
}

SimulateRotation()
{
    ShowToolTip("Simulating rotation", 1000)

    rotationKeys := ["d", "s", "a", "w", "d"]

    holdKeyTime := 8
    holdKeyCount := 8
    
    for index, key in rotationKeys
    {
        i := 1

        ; Last rotation should be held shorted for forward facing
        if(index == rotationKeys.Length)
        {
            while(i <= 50)
            {
                Send(key)
                i++
                Sleep Random(1, 10)
            }
        }
        else if()
        {
            while(i <= holdKeyCount)
            {
                HoldKeyDown(key, holdKeyTime)    
                i++
            }
        }
    }
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

SendMouseClick()
{
    Click
}

HoldKeyDown(key, duration)
{
    Send "{" key " down}"
    Sleep duration
    Send "{" key " up}"
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