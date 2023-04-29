--Not Sleep Script

--全局变量
d1=60  --鼠标指针移动延迟
d2=500  --开关LED闪烁延迟
d3=5000  --运行时常延迟
d4=2000  --等待按键中断延迟
ctrlpressed=0  --按键按下状态
--开启的LED提示
function TurnOn()
    OutputLogMessage("Start \n")
    for i=0,2,1 do
        PressAndReleaseKey("numlock")
        Sleep(d2)
    end
    if ( IsKeyLockOn("numlock") )then
        Sleep(d2)
    else
        PressAndReleaseKey("numlock")
    end
         
end

--关闭的LED提示
function TurnOff()
    OutputLogMessage("Finish \n")
    for i=0,2,1 do
        PressAndReleaseKey("capslock")
        Sleep(d2)
    end
    if ( IsKeyLockOn("capslock") )then
        PressAndReleaseKey("capslock")
    end
end
--关闭按键监听函数
function Close()
    if IsModifierPressed("ctrl") then
        ctrlpressed=1
    end
end
--指针移动和循环函数
function ProcessOn()
    for i=0, 10 do
        MoveMouseRelative(0, -20) 
        Sleep(d1)
    end
    for j=0, 10 do
        MoveMouseRelative(0, 20) 
        Sleep(d1)
    end
end
function LoopCycle()
    repeat
        ProcessOn()
        OutputLogMessage(ctrlpressed)
        Sleep(d4)
        Close()
        OutputLogMessage("after %d \n",ctrlpressed)
        Sleep(d3)
    until ctrlpressed==1
end
--Main
function OnEvent(event, arg)
    if (event=="MOUSE_BUTTON_PRESSED" and arg==5) then
        TurnOn()
        LoopCycle()
    end
    TurnOff()
    ctrlpressed=0
 
end