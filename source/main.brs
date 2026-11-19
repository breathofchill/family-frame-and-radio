sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' Create and display the main SceneGraph scene
    scene = screen.CreateScene("MainScene")
    screen.show()

    di = CreateObject("roDeviceInfo")
    di.SetMessagePort(m.port)
    di.EnableAppFocusEvent(true)
    di.EnableScreensaverExitedEvent(true)

    ' Keep the channel running until the user exits with the Home button
    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roDeviceInfoEvent"
            if msg.isStatusMessage()
                info = msg.GetInfo()
                if type(info) = "roAssociativeArray"
                    if info.DoesExist("appFocused") then scene.appActive = (info.appFocused = true)
                    if info.DoesExist("exitedScreensaver") and info.exitedScreensaver = true then scene.appActive = true
                end if
            end if
        end if
    end while
end sub
