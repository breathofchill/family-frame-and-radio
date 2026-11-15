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
    m.toastSubLabel = m.top.findNode("toastSubLabel")
    m.photoHeaderLabel = m.top.findNode("photoHeaderLabel")
    m.photoCounterLabel = m.top.findNode("photoCounterLabel")
    m.radioHeaderLabel = m.top.findNode("radioHeaderLabel")
    m.radioStatusLabel = m.top.findNode("radioStatusLabel")
    m.slideshowTimer = m.top.findNode("slideshowTimer")
    m.toastTimer = m.top.findNode("toastTimer")
    m.radioPlayer = m.top.findNode("radioPlayer")

    ' Slideshow State (Engineered for 200+ to 1,000+ Photos)
    m.photos = []
    m.currentPhotoIndex = 0
    m.activePoster = "A"
    m.isSlideshowPaused = false
    m.pendingPoster = ""

    ' =========================================================================
    ' 9 MAIN GRANDPARENT-FRIENDLY RADIO GENRES
    ' Includes 100.3 K-LOVE LA, Classical KUSC 91.5 LA, Golden Oldies,
    ' LA News (LAist 89.3 KPCC & KCRW 89.9), plus 5 more beloved genres!
    ' =========================================================================
    m.vibes = [
        {
            label: "Christian & Encouraging (K-LOVE)",
            tag: "christian",
            searchName: "K-LOVE",
            curated: [
                { name: "100.3 K-LOVE Los Angeles", url: "https://maestro.emfcdn.com/stream_for/k-love/tunein", format: "aac" },
                { name: "100.3 K-LOVE LA (Main Feed)", url: "https://maestro.emfcdn.com/stream_for/k-love/iheart/aac", format: "aac" },
                { name: "100.3 K-LOVE LA (Backup Feed)", url: "https://maestro.emfcdn.com/stream_for/k-love/airable/aac", format: "aac" },
                { name: "K-LOVE 80s & Classic Christian", url: "https://maestro.emfcdn.com/stream_for/k-love-80s/airable/aac", format: "aac" },
                { name: "Air1 Worship Music (K-LOVE Network)", url: "https://maestro.emfcdn.com/stream_for/air1/airable/aac", format: "aac" }
            ]
        },
        {
            label: "Classical Symphony (91.5 KUSC LA)",
            tag: "classical",
            searchName: "KUSC",
            curated: [
                { name: "Classical KUSC 91.5 FM Los Angeles", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/KUSCMP256.mp3", format: "mp3" },
                { name: "Classical KUSC 91.5 FM LA (Standard)", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/KUSCMP128.mp3", format: "mp3" },
                { name: "Classical KUSC 91.5 FM LA (AAC)", url: "https://playerservices.streamtheworld.com/api/livestream-redirect/KUSCAAC64.aac", format: "aac" },
                { name: "WQXR 105.9 FM Classical Philharmonic", url: "https://stream.wqxr.org/wqxr-web", format: "mp3" }
            ]
        },
        {
            label: "50s & 60s Golden Oldies",
            tag: "oldies",
            searchName: "",
            curated: [
                { name: "Back To The 50s & 60s Golden Oldies", url: "http://strm112.1.fm/60s_70s_mobile_mp3", format: "mp3" },
                { name: ".977 Golden Oldies Hits", url: "http://29318.live.streamtheworld.com/977_OLDIES_SC", format: "mp3" },
                { name: "NonStop 50s & 60s Oldies", url: "https://ais-sa2.cdnstream1.com/2383_128.mp3", format: "mp3" },
                { name: "Classic Vinyl HD (Golden Era)", url: "https://icecast.walmradio.com:8443/classic", format: "mp3" }
            ]
        },
        {
            label: "Los Angeles News & Talk",
            tag: "npr",
            searchName: "KPCC",
            curated: [
                { name: "LAist 89.3 FM KPCC (LA Public Radio News)", url: "https://laist.streamguys1.com/kpcc-mp3?aw_0_1st.playerId=laist", format: "mp3" },
                { name: "LAist 89.3 FM KPCC Pasadena/LA (Backup)", url: "https://playerservices.streamtheworld.com/api/livestream-redirect/KPCC_FM.mp3", format: "mp3" },
                { name: "KCRW 89.9 FM Los Angeles / Santa Monica", url: "https://streams.kcrw.com/kcrw_mp3?aw_0_1st.playerid=radio-browser.info", format: "mp3" },
                { name: "KFI AM 640 Los Angeles News & Talk", url: "http://stream.revma.ihrhls.com/zc177", format: "aac" }
            ]
        },
        {
            label: "Smooth Jazz & LA Jazz",
            tag: "smooth jazz",
            searchName: "",
            curated: [
                { name: "101 Smooth Jazz (Mellow Mix)", url: "http://jking.cdnstream1.com/b22139_128mp3", format: "mp3" },
                { name: "101 Smooth Jazz (Main Lounge)", url: "http://streaming.live365.com/b48071_128mp3", format: "mp3" },
                { name: "KJAZZ 88.1 FM Los Angeles / Long Beach", url: "https://streaming.live365.com/a49833/playlist.m3u8", format: "hls" },
                { name: "WWOZ 90.7 FM Traditional Jazz", url: "https://wwoz-sc.streamguys1.com/wwoz-hi.mp3", format: "mp3" }
            ]
        },
        {
            label: "Big Band, Swing & Sinatra",
            tag: "big band",
            searchName: "",
            curated: [
                { name: "Exclusively Frank Sinatra & Standards", url: "https://2.mystreaming.net/er/franksinatra/icecast.audio", format: "mp3" },
                { name: "Classic Vinyl HD (1940s & 50s Big Band)", url: "https://icecast.walmradio.com:8443/classic", format: "mp3" },
                { name: "Instrumentals Forever Orchestra", url: "http://quincy.torontocast.com:1910/stream", format: "mp3" }
            ]
        },
        {
            label: "Classic Country Legends",
            tag: "classic country",
            searchName: "",
            curated: [
                { name: "Highway 181 (Classic Country Legends)", url: "http://listen.181fm.com/181-highway_128k.mp3", format: "mp3" },
                { name: "1.FM Classic Country Hall of Fame", url: "http://strm112.1.fm/ccountry_mobile_mp3", format: "mp3" }
            ]
        },
        {
            label: "Classic Motown & 60s Soul",
            tag: "motown",
            searchName: "",
            curated: [
                { name: "24/7 Classic Motown & Soul", url: "http://antares.dribbcast.com:4237/stream", format: "mp3" },
                { name: "Stax & Motown Legends Radio", url: "http://jazz-wr15.ice.infomaniak.ch/jazz-wr15-128.mp3", format: "mp3" },
                { name: "Motown Classics Nonstop", url: "http://94.23.159.187:9990/;", format: "mp3" }
            ]
        },
        {
            label: "70s Soft Rock & Easy Listening",
            tag: "easy listening",
            searchName: "",
            curated: [
                { name: "Left Coast 70s (Mellow 70s Soft Rock)", url: "https://ice2.somafm.com/seventies-320-mp3", format: "mp3" },
                { name: "Gold Easy Listening & Timeless Hits", url: "https://media-ssl.musicradio.com/GoldMP3", format: "mp3" },
                { name: "Instrumentals Forever Easy Listening", url: "http://quincy.torontocast.com:1910/stream", format: "mp3" }
            ]
        }
    ]

    m.currentVibeIndex = 0
    m.currentStationList = []
    m.currentStationIndex = 0
    m.isMuted = false

    ' Set up Timers, Texture Cleanup Observers, and Audio Observers
    m.slideshowTimer.ObserveField("fire", "onSlideshowTimerFire")
    m.toastTimer.ObserveField("fire", "onToastTimerFire")
    m.radioPlayer.ObserveField("state", "onAudioStateChange")
    m.fadeAtoB.ObserveField("state", "onFadeAtoBState")
    m.fadeBtoA.ObserveField("state", "onFadeBtoAState")
    m.posterA.ObserveField("loadStatus", "onPosterALoadStatus")
    m.posterB.ObserveField("loadStatus", "onPosterBLoadStatus")

    ' Discover all 200+ family photos in pkg:/images/
    discoverPhotos()

    ' Start playing Genre 1 immediately
    loadCurrentVibe()
end sub

' =============================================================================
' 200+ PHOTO SLIDESHOW ENGINE WITH GPU TEXTURE MEMORY RECYCLING
' =============================================================================

sub discoverPhotos()
    m.photos = []
    rawFiles = ListDir("pkg:/images/")

    if type(rawFiles) = "roList" or type(rawFiles) = "roArray"
        ' Build sortable array with natural numeric sort keys so photo2.jpg comes before photo10.jpg and photo200.jpg
        sortableList = []
        for each fileName in rawFiles
            lowerName = LCase(fileName)
            isSystemAsset = (Left(lowerName, 8) = "channel_" or Left(lowerName, 7) = "splash_")
            if not isSystemAsset
                if Right(lowerName, 4) = ".jpg" or Right(lowerName, 5) = ".jpeg" or Right(lowerName, 4) = ".png"
                    sortableList.Push({
                        name: fileName,
                        sortKey: makeNaturalSortKey(lowerName)
                    })
                end if
            end if
        end for

        ' Sort using natural numeric order
        sortableList.SortBy("sortKey")

        for each entry in sortableList
            m.photos.Push("pkg:/images/" + entry.name)
        end for
    end if

    if m.photos.Count() = 0
        m.emptyStateGroup.visible = true
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM"
        m.photoCounterLabel.text = "No Photos Found"
        m.slideshowTimer.control = "stop"
    else
        m.emptyStateGroup.visible = false
        m.currentPhotoIndex = 0
        m.posterA.uri = m.photos[0]
        m.posterA.opacity = 1.0
        m.posterB.opacity = 0.0
        m.posterB.uri = ""
        m.activePoster = "A"
        updatePhotoCounterHUD()

        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
        end if
    end if
end sub

' Zero-pads embedded numbers in filenames so 1..200+ sort in true numerical order
function makeNaturalSortKey(name as String) as String
    result = ""
    numBuf = ""
    for i = 1 to Len(name)
        ch = Mid(name, i, 1)
        code = Asc(ch)
        if code >= 48 and code <= 57
            numBuf = numBuf + ch
        else
            if numBuf <> ""
                while Len(numBuf) < 8
                    numBuf = "0" + numBuf
                end while
                result = result + numBuf
                numBuf = ""
            end if
            result = result + ch
        end if
    end for
    if numBuf <> ""
        while Len(numBuf) < 8
            numBuf = "0" + numBuf
        end while
        result = result + numBuf
    end if
    return result
end function

sub showPhotoAtIndex(newIndex as Integer)
    photoCount = m.photos.Count()
    if photoCount = 0 then return

    ' Wrap index cleanly around album bounds (supports 200+ photos)
    while newIndex < 0
        newIndex = newIndex + photoCount
    end while
    while newIndex >= photoCount
        newIndex = newIndex - photoCount
    end while

    m.currentPhotoIndex = newIndex
    nextUri = m.photos[m.currentPhotoIndex]

    ' Stop any in-flight crossfade animation before starting a new transition
    m.fadeAtoB.control = "stop"
    m.fadeBtoA.control = "stop"

    if m.activePoster = "A"
        m.pendingPoster = "B"
        if m.posterB.uri = nextUri and m.posterB.loadStatus = "ready"
            startCrossfadeToB()
        else
            m.posterB.uri = nextUri
        end if
    else
        m.pendingPoster = "A"
        if m.posterA.uri = nextUri and m.posterA.loadStatus = "ready"
            startCrossfadeToA()
        else
            m.posterA.uri = nextUri
        end if
    end if

    updatePhotoCounterHUD()
end sub

sub onPosterBLoadStatus()
    if m.pendingPoster <> "B" then return
    status = m.posterB.loadStatus
    if status = "ready"
        startCrossfadeToB()
    else if status = "failed"
        ' Skip unreadable photo automatically
        m.pendingPoster = ""
        if m.photos.Count() > 1
            showPhotoAtIndex(m.currentPhotoIndex + 1)
        end if
    end if
end sub

sub onPosterALoadStatus()
    if m.pendingPoster <> "A" then return
    status = m.posterA.loadStatus
    if status = "ready"
        startCrossfadeToA()
    else if status = "failed"
        ' Skip unreadable photo automatically
        m.pendingPoster = ""
        if m.photos.Count() > 1
            showPhotoAtIndex(m.currentPhotoIndex + 1)
        end if
    end if
end sub

sub startCrossfadeToB()
    m.pendingPoster = ""
    m.activePoster = "B"
    m.fadeAtoB.control = "start"
end sub

sub startCrossfadeToA()
    m.pendingPoster = ""
    m.activePoster = "A"
    m.fadeBtoA.control = "start"
end sub

' Free the off-screen Poster texture from GPU RAM once crossfade finishes
sub onFadeAtoBState()
    if m.fadeAtoB.state = "stopped" and m.activePoster = "B"
        m.posterA.opacity = 0.0
        m.posterB.opacity = 1.0
        m.posterA.uri = ""
    end if
end sub

sub onFadeBtoAState()
    if m.fadeBtoA.state = "stopped" and m.activePoster = "A"
        m.posterB.opacity = 0.0
        m.posterA.opacity = 1.0
        m.posterB.uri = ""
    end if
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
        showToast("PHOTO SLIDESHOW PAUSED", "Staying on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Press [OK] or [Play] Anytime to Resume Slideshow")
    else
        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
        end if
        showToast("PHOTO SLIDESHOW RESUMED", "Changing Photos Every 12 Seconds", "Use [Left / Right] for Next Photo or [Rew / FF] to Jump 10 Photos")
    end if
    updatePhotoCounterHUD()
end sub

sub updatePhotoCounterHUD()
    total = m.photos.Count()
    if total = 0
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM"
        m.photoCounterLabel.text = "No Photos Found"
        return
    end if

    if m.isSlideshowPaused
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM  •  PAUSED"
        m.photoCounterLabel.color = "0xFFD54FFF"
    else
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM"
        m.photoCounterLabel.color = "0xFFFFFFFF"
    end if

    m.photoCounterLabel.text = "Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + total.ToStr()
end sub

' =============================================================================
' ENDLESS LIVE RADIO (9 Genres + Instant Curated Streams + Radio Browser API)
' =============================================================================

sub loadCurrentVibe()
    vibe = m.vibes[m.currentVibeIndex]
    genreNum = (m.currentVibeIndex + 1).ToStr() + " OF " + m.vibes.Count().ToStr()

    ' Immediately load the curated flagship streams so playback starts right away!
    m.currentStationList = []
    if vibe.DoesExist("curated") and type(vibe.curated) = "roArray"
        for each s in vibe.curated
            m.currentStationList.Push(s)
        end for
    end if
    m.currentStationIndex = 0

    if m.currentStationList.Count() > 0
        playCurrentStation()
    else
        m.radioPlayer.control = "stop"
        m.radioHeaderLabel.text = "GENRE " + genreNum + "  •  " + UCase(vibe.label)
        m.radioStatusLabel.text = "Tuning " + vibe.label + "..."
        showToast("GENRE " + genreNum + "  •  " + UCase(vibe.label), "Tuning Live Radio...", "Press [UP / DOWN] to Change Genre   •   Press [ * ] for Next Station")
    end if

    ' Also run background RadioTask to append additional live backup stations from Radio Browser API
    m.radioTask = CreateObject("roSGNode", "RadioTask")
    m.radioTask.searchTag = vibe.tag
    if vibe.DoesExist("searchName")
        m.radioTask.searchName = vibe.searchName
    end if
    m.radioTask.curatedStations = m.currentStationList
    m.radioTask.ObserveField("status", "onRadioTaskStatus")
    m.radioTask.control = "RUN"
end sub

sub onRadioTaskStatus()
    if m.radioTask = invalid then return
    status = m.radioTask.status

    if status = "ready"
        wasEmpty = (m.currentStationList.Count() = 0)
        m.currentStationList = m.radioTask.stations
        if wasEmpty and m.currentStationList.Count() > 0
            m.currentStationIndex = 0
            playCurrentStation()
        end if
    else if status = "error" and m.currentStationList.Count() = 0
        vibe = m.vibes[m.currentVibeIndex]
        m.radioStatusLabel.text = "Unavailable (" + vibe.label + ") - Press Up/Down"
        showToast("RADIO CONNECTION ISSUE", "Could not reach " + vibe.label, "Please press [UP] or [DOWN] to try another genre")
    end if
end sub

sub playCurrentStation()
    vibe = m.vibes[m.currentVibeIndex]
    genreNum = (m.currentVibeIndex + 1).ToStr() + " OF " + m.vibes.Count().ToStr()

    if m.currentStationList = invalid or m.currentStationList.Count() = 0
        m.radioStatusLabel.text = "No working streams for " + vibe.label
        return
    end if

    if m.currentStationIndex >= m.currentStationList.Count()
        m.currentStationIndex = 0
    end if

    station = m.currentStationList[m.currentStationIndex]

    streamFormat = "mp3"
    if station.DoesExist("format") and station.format <> ""
        streamFormat = station.format
    end if

    content = CreateObject("roSGNode", "ContentNode")
    content.url = station.url
    content.title = station.name
    content.streamFormat = streamFormat

    m.radioPlayer.control = "stop"
    m.radioPlayer.content = content
    m.radioPlayer.mute = m.isMuted
    m.radioPlayer.control = "play"

    updateRadioHUD()
    stationNumText = "Station " + (m.currentStationIndex + 1).ToStr() + " in Genre   •   Press [UP / DOWN] for Other Genres   •   Press [ * ] for Next Station"
    showToast("GENRE " + genreNum + "  •  " + UCase(vibe.label), station.name, stationNumText)
end sub

sub nextStationInGenre()
    if m.currentStationList = invalid or m.currentStationList.Count() <= 1
        vibe = m.vibes[m.currentVibeIndex]
        showToast(UCase(vibe.label), "Searching for more stations...", "Press [UP / DOWN] to switch between all 9 Radio Genres")
        return
    end if

    m.currentStationIndex = m.currentStationIndex + 1
    if m.currentStationIndex >= m.currentStationList.Count()
        m.currentStationIndex = 0
    end if
    playCurrentStation()
end sub

sub onAudioStateChange()
    state = m.radioPlayer.state

    if state = "error"
        ' Automatically fall back to the next station in this genre if a stream fails
        if m.currentStationList <> invalid and m.currentStationList.Count() > 1
            m.currentStationIndex = m.currentStationIndex + 1
            if m.currentStationIndex < m.currentStationList.Count()
                playCurrentStation()
            end if
        end if
    else if state = "playing" or state = "buffering"
        updateRadioHUD()
    end if
end sub

sub toggleMute()
    m.isMuted = not m.isMuted
    m.radioPlayer.mute = m.isMuted

    if m.isMuted
        showToast("RADIO AUDIO MUTED", "Music is Currently Muted", "Press [Replay] on Your Remote to Unmute Music")
    else
        vibe = m.vibes[m.currentVibeIndex]
        stationName = vibe.label
        if m.currentStationList.Count() > m.currentStationIndex
            stationName = m.currentStationList[m.currentStationIndex].name
        end if
        showToast("RADIO AUDIO UNMUTED", stationName, "Playing Live on " + vibe.label)
    end if

    updateRadioHUD()
end sub

sub updateRadioHUD()
    vibe = m.vibes[m.currentVibeIndex]
    genreNum = (m.currentVibeIndex + 1).ToStr() + " OF " + m.vibes.Count().ToStr()
    m.radioHeaderLabel.text = "GENRE " + genreNum + "  •  " + UCase(vibe.label)

    stationName = "Connecting..."
    if m.currentStationList <> invalid and m.currentStationList.Count() > m.currentStationIndex
        stationName = m.currentStationList[m.currentStationIndex].name
    end if

    statePrefix = ""
    if m.isMuted
        statePrefix = "[MUTED]  "
    else if m.radioPlayer.state = "buffering"
        statePrefix = "[Loading]  "
    end if

    m.radioStatusLabel.text = statePrefix + stationName
end sub

' =============================================================================
' TOAST BANNER HELPER
' =============================================================================

sub showToast(title as String, message as String, subText = "" as String)
    m.toastTitleLabel.text = title
    m.toastMessageLabel.text = message
    if subText <> ""
        m.toastSubLabel.text = subText
    else
        m.toastSubLabel.text = "Press [UP / DOWN] to Change Genre   •   Press [ * ] for Next Station in This Genre"
    end if
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

    ' Rewind (<<) / FastForward (>>): Jump Back / Forward 10 Photos (Great for 200+ photo albums!)
    else if key = "rewind"
        if m.photos.Count() > 0
            showPhotoAtIndex(m.currentPhotoIndex - 10)
            resetSlideshowTimer()
            showToast("JUMPED BACK 10 PHOTOS", "Now on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Use [Left / Right] for Single Photos or [Rew / FF] to Jump 10")
        end if
        return true
    else if key = "fastforward"
        if m.photos.Count() > 0
            showPhotoAtIndex(m.currentPhotoIndex + 10)
            resetSlideshowTimer()
            showToast("JUMPED AHEAD 10 PHOTOS", "Now on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Use [Left / Right] for Single Photos or [Rew / FF] to Jump 10")
        end if
        return true

    ' Up / Down: Switch between the 9 Main Radio Genres
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

    ' Star (*) / Options: Switch to Next Radio Station within the Current Genre
    else if key = "options"
        nextStationInGenre()
        return true

    ' OK or Play: Pause / Resume the Photo Slideshow
    else if key = "OK" or key = "play"
        toggleSlideshowPause()
        return true

    ' Replay / InstantReplay: Mute / Unmute Radio Audio
    else if key = "replay" or key = "instantreplay"
        toggleMute()
        return true
    end if

    return false
end function
