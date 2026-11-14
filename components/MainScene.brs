sub init()
    m.top.setFocus(true)

    ' Bind SceneGraph UI Nodes
    m.posterA = m.top.findNode("posterA")
    m.posterB = m.top.findNode("posterB")
    m.fadeAtoB = m.top.findNode("fadeAtoB")
    m.fadeBtoA = m.top.findNode("fadeBtoA")
    m.emptyStateGroup = m.top.findNode("emptyStateGroup")
    m.toastGroup = m.top.findNode("toastGroup")
    m.toastTitleLabel = m.top.findNode("toastTitleLabel")
    m.toastMessageLabel = m.top.findNode("toastMessageLabel")
    m.photoCounterLabel = m.top.findNode("photoCounterLabel")
    m.radioStatusLabel = m.top.findNode("radioStatusLabel")
    m.slideshowTimer = m.top.findNode("slideshowTimer")
    m.toastTimer = m.top.findNode("toastTimer")
    m.radioPlayer = m.top.findNode("radioPlayer")

    ' Slideshow State
    m.photos = []
    m.currentPhotoIndex = 0
    m.activePoster = "A"
    m.isSlideshowPaused = false

    ' Radio State: 4 Pre-Configured Grandparent-Friendly Vibes
    m.vibes = [
        { label: "Smooth Jazz", tag: "smooth jazz" },
        { label: "1950s & 60s Oldies", tag: "oldies" },
        { label: "Classical Piano", tag: "classical piano" },
        { label: "Classic Motown", tag: "motown" }
    ]
    m.currentVibeIndex = 0
    m.currentStationList = []
    m.currentStationIndex = 0
    m.isMuted = false

    ' Set up Timers and Audio Observers
    m.slideshowTimer.ObserveField("fire", "onSlideshowTimerFire")
    m.toastTimer.ObserveField("fire", "onToastTimerFire")
    m.radioPlayer.ObserveField("state", "onAudioStateChange")

    ' Initialize Dynamic Photo Slideshow from pkg:/images/
    discoverPhotos()

    ' Initialize Live Radio Background Task
    loadCurrentVibe()
end sub

' =============================================================================
' DYNAMIC PHOTO SLIDESHOW (pkg:/images/)
' =============================================================================

sub discoverPhotos()
    m.photos = []
    rawFiles = ListDir("pkg:/images/")

    if type(rawFiles) = "roList" or type(rawFiles) = "roArray"
        ' Copy to sortable array so photos display in predictable alphabetical order
        fileArray = []
        for each fileName in rawFiles
            fileArray.Push(fileName)
        end for
        fileArray.Sort("i")

        for each fileName in fileArray
            lowerName = LCase(fileName)
            ' Exclude channel icon/splash assets if named with prefix channel_ or splash_
            isSystemAsset = (Left(lowerName, 8) = "channel_" or Left(lowerName, 7) = "splash_")
            if not isSystemAsset
                if Right(lowerName, 4) = ".jpg" or Right(lowerName, 5) = ".jpeg" or Right(lowerName, 4) = ".png"
                    m.photos.Push("pkg:/images/" + fileName)
                end if
            end if
        end for
    end if

    if m.photos.Count() = 0
        ' Show friendly fallback notice if pkg:/images/ has no family photos
        m.emptyStateGroup.visible = true
        m.photoCounterLabel.text = "No Photos in pkg:/images/"
        m.slideshowTimer.control = "stop"
    else
        m.emptyStateGroup.visible = false
        m.currentPhotoIndex = 0
        m.posterA.uri = m.photos[0]
        m.posterA.opacity = 1.0
        m.posterB.opacity = 0.0
        m.activePoster = "A"
        updatePhotoCounterHUD()

        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
        end if
    end if
end sub

sub showPhotoAtIndex(newIndex as Integer)
    photoCount = m.photos.Count()
    if photoCount = 0 then return

    ' Wrap index cleanly around bounds
    if newIndex < 0
        newIndex = photoCount - 1
    else if newIndex >= photoCount
        newIndex = 0
    end if

    m.currentPhotoIndex = newIndex
    nextUri = m.photos[m.currentPhotoIndex]

    ' Stop any in-flight crossfade animation before starting a new transition
    m.fadeAtoB.control = "stop"
    m.fadeBtoA.control = "stop"

    if m.activePoster = "A"
        m.posterB.uri = nextUri
        m.fadeAtoB.control = "start"
        m.activePoster = "B"
    else
        m.posterA.uri = nextUri
        m.fadeBtoA.control = "start"
        m.activePoster = "A"
    end if

    updatePhotoCounterHUD()
end sub

sub onSlideshowTimerFire()
    if not m.isSlideshowPaused and m.photos.Count() > 1
        showPhotoAtIndex(m.currentPhotoIndex + 1)
    end if
end sub

sub resetSlideshowTimer()
    if not m.isSlideshowPaused and m.photos.Count() > 1
        m.slideshowTimer.control = "stop"
        m.slideshowTimer.control = "start"
    end if
end sub

sub toggleSlideshowPause()
    if m.photos.Count() = 0 then return

    m.isSlideshowPaused = not m.isSlideshowPaused
    if m.isSlideshowPaused
        m.slideshowTimer.control = "stop"
        showToast("SLIDESHOW PAUSED", "Press OK or Play to Resume Photos")
    else
        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
        end if
        showToast("SLIDESHOW RESUMED", "Auto-Advancing Every 12 Seconds")
    end if
    updatePhotoCounterHUD()
end sub

sub updatePhotoCounterHUD()
    total = m.photos.Count()
    if total = 0
        m.photoCounterLabel.text = "No Photos Found"
        return
    end if

    statusText = "Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + total.ToStr()
    if m.isSlideshowPaused
        statusText = statusText + "  (PAUSED)"
    end if
    m.photoCounterLabel.text = statusText
end sub

' =============================================================================
' ENDLESS LIVE RADIO (Radio Browser API + SceneGraph Audio Node)
' =============================================================================

sub loadCurrentVibe()
    vibe = m.vibes[m.currentVibeIndex]
    m.radioStatusLabel.text = "Radio: Tuning " + vibe.label + "..."
    showToast("TUNING RADIO STATION", vibe.label)

    ' Stop existing playback while fetching the new station list
    m.radioPlayer.control = "stop"

    ' Spawn a fresh RadioTask to query Radio Browser API
    m.radioTask = CreateObject("roSGNode", "RadioTask")
    m.radioTask.searchTag = vibe.tag
    m.radioTask.ObserveField("status", "onRadioTaskStatus")
    m.radioTask.control = "RUN"
end sub

sub onRadioTaskStatus()
    if m.radioTask = invalid then return
    status = m.radioTask.status

    if status = "ready"
        m.currentStationList = m.radioTask.stations
        m.currentStationIndex = 0
        playCurrentStation()
    else if status = "error"
        vibe = m.vibes[m.currentVibeIndex]
        m.radioStatusLabel.text = "Radio: Unavailable (" + vibe.label + ") - Press Up/Down"
        showToast("RADIO CONNECTION ISSUE", "Could not reach " + vibe.label + ". Try Up/Down.")
    end if
end sub

sub playCurrentStation()
    vibe = m.vibes[m.currentVibeIndex]

    if m.currentStationList = invalid or m.currentStationList.Count() = 0
        m.radioStatusLabel.text = "Radio: No working streams for " + vibe.label
        return
    end if

    if m.currentStationIndex >= m.currentStationList.Count()
        ' All 5 stations returned for this vibe failed; wrap around and notify user
        m.currentStationIndex = 0
        m.radioStatusLabel.text = "Radio: Stream error on " + vibe.label + " (Press Up/Down)"
        showToast("STREAM UNAVAILABLE", "Please press Up or Down for another station")
        return
    end if

    station = m.currentStationList[m.currentStationIndex]

    content = CreateObject("roSGNode", "ContentNode")
    content.url = station.url
    content.title = station.name
    content.streamFormat = "mp3"

    m.radioPlayer.content = content
    m.radioPlayer.mute = m.isMuted
    m.radioPlayer.control = "play"

    updateRadioHUD()
    showToast("NOW PLAYING: " + UCase(vibe.label), station.name)
end sub

sub onAudioStateChange()
    state = m.radioPlayer.state

    if state = "error"
        ' Automatic fallback to the next station returned for this vibe
        m.currentStationIndex = m.currentStationIndex + 1
        playCurrentStation()
    else if state = "playing" or state = "buffering"
        updateRadioHUD()
    end if
end sub

sub toggleMute()
    m.isMuted = not m.isMuted
    m.radioPlayer.mute = m.isMuted

    if m.isMuted
        showToast("RADIO MUTED", "Press Replay or * to Unmute Music")
    else
        vibe = m.vibes[m.currentVibeIndex]
        stationName = vibe.label
        if m.currentStationList.Count() > m.currentStationIndex
            stationName = m.currentStationList[m.currentStationIndex].name
        end if
        showToast("RADIO UNMUTED", stationName)
    end if

    updateRadioHUD()
end sub

sub updateRadioHUD()
    vibe = m.vibes[m.currentVibeIndex]
    stationName = "Connecting..."

    if m.currentStationList <> invalid and m.currentStationList.Count() > m.currentStationIndex
        stationName = m.currentStationList[m.currentStationIndex].name
    end if

    statePrefix = ""
    if m.isMuted
        statePrefix = "[MUTED] "
    else if m.radioPlayer.state = "buffering"
        statePrefix = "[Buffering] "
    end if

    m.radioStatusLabel.text = statePrefix + vibe.label + " — " + stationName
end sub

' =============================================================================
' TOAST BANNER HELPER
' =============================================================================

sub showToast(title as String, message as String)
    m.toastTitleLabel.text = title
    m.toastMessageLabel.text = message
    m.toastGroup.visible = true
    m.toastTimer.control = "stop"
    m.toastTimer.control = "start"
end sub

sub onToastTimerFire()
    m.toastGroup.visible = false
end sub

' =============================================================================
' GRANDPARENT-FRIENDLY REMOTE CONTROL MAPPING (onKeyEvent)
' =============================================================================

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false

    ' Left / Right: Previous / Next Family Photo (resets slideshow timer)
    if key = "left"
        if m.photos.Count() > 0
            showPhotoAtIndex(m.currentPhotoIndex - 1)
            resetSlideshowTimer()
        end if
        return true
    else if key = "right"
        if m.photos.Count() > 0
            showPhotoAtIndex(m.currentPhotoIndex + 1)
            resetSlideshowTimer()
        end if
        return true

    ' Up / Down: Switch between the 4 Radio Vibes
    else if key = "up"
        m.currentVibeIndex = m.currentVibeIndex - 1
        if m.currentVibeIndex < 0
            m.currentVibeIndex = m.vibes.Count() - 1
        end if
        loadCurrentVibe()
        return true
    else if key = "down"
        m.currentVibeIndex = m.currentVibeIndex + 1
        if m.currentVibeIndex >= m.vibes.Count()
            m.currentVibeIndex = 0
        end if
        loadCurrentVibe()
        return true

    ' OK or Play: Pause / Resume the Photo Slideshow
    else if key = "OK" or key = "play"
        toggleSlideshowPause()
        return true

    ' Replay / InstantReplay / Options (*): Mute / Unmute Radio Audio
    else if key = "replay" or key = "instantreplay" or key = "options"
        toggleMute()
        return true
    end if

    return false
end function
