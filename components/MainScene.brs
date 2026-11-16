sub init()
    m.top.setFocus(true)

    m.posterA = m.top.findNode("posterA")
    m.posterB = m.top.findNode("posterB")
    m.fadeAtoB = m.top.findNode("fadeAtoB")
    m.fadeBtoA = m.top.findNode("fadeBtoA")
    m.emptyStateGroup = m.top.findNode("emptyStateGroup")
    m.toastGroup = m.top.findNode("toastGroup")
    m.toastTitleLabel = m.top.findNode("toastTitleLabel")
    m.toastMessageLabel = m.top.findNode("toastMessageLabel")
    m.toastSubLabel = m.top.findNode("toastSubLabel")
    m.toastSlideAnim = m.top.findNode("toastSlideAnim")
    m.clockGroup = m.top.findNode("clockGroup")
    m.clockTimeLabel = m.top.findNode("clockTimeLabel")
    m.clockDateLabel = m.top.findNode("clockDateLabel")
    m.photoHeaderLabel = m.top.findNode("photoHeaderLabel")
    m.photoCounterLabel = m.top.findNode("photoCounterLabel")
    m.photoSubLabel = m.top.findNode("photoSubLabel")
    m.radioHeaderLabel = m.top.findNode("radioHeaderLabel")
    m.radioStatusLabel = m.top.findNode("radioStatusLabel")
    m.nowPlayingLabel = m.top.findNode("nowPlayingLabel")
    m.hudAlbumGroup = m.top.findNode("hudAlbumGroup")
    m.hudAlbumPoster = m.top.findNode("hudAlbumPoster")
    m.slideshowTimer = m.top.findNode("slideshowTimer")
    m.toastTimer = m.top.findNode("toastTimer")
    m.clockTimer = m.top.findNode("clockTimer")
    m.nowPlayingTimer = m.top.findNode("nowPlayingTimer")
    m.radioPlayer = m.top.findNode("radioPlayer")

    m.stationsOverlay = m.top.findNode("stationsOverlay")
    m.stationsContentGroup = m.top.findNode("stationsContentGroup")
    m.stationsHeaderTitle = m.top.findNode("stationsHeaderTitle")
    m.stationsNowPlayingLabel = m.top.findNode("stationsNowPlayingLabel")
    m.stationsSongLabel = m.top.findNode("stationsSongLabel")
    m.stationsGenreLabel = m.top.findNode("stationsGenreLabel")
    m.heroAlbumGroup = m.top.findNode("heroAlbumGroup")
    m.heroAlbumPoster = m.top.findNode("heroAlbumPoster")
    m.heroBadgeLabel = m.top.findNode("heroBadgeLabel")
    m.searchBoxGroup = m.top.findNode("searchBoxGroup")
    m.searchBoxBorder = m.top.findNode("searchBoxBorder")
    m.searchBoxBg = m.top.findNode("searchBoxBg")
    m.micBadgeBg = m.top.findNode("micBadgeBg")
    m.searchBoxLabel = m.top.findNode("searchBoxLabel")
    m.showAllBtnGroup = m.top.findNode("showAllBtnGroup")
    m.showAllBtnBorder = m.top.findNode("showAllBtnBorder")
    m.showAllBtnBg = m.top.findNode("showAllBtnBg")
    m.shuffleBtnBorder = m.top.findNode("shuffleBtnBorder")
    m.shuffleBtnBg = m.top.findNode("shuffleBtnBg")
    m.shuffleBtnLabel = m.top.findNode("shuffleBtnLabel")
    m.stationsGridGroup = m.top.findNode("stationsGridGroup")
    m.gridFocusRing = m.top.findNode("gridFocusRing")
    m.stationsEmptyLabel = m.top.findNode("stationsEmptyLabel")
    m.stationsPageLabel = m.top.findNode("stationsPageLabel")

    m.overlayOpenAnim = m.top.findNode("overlayOpenAnim")
    m.overlayCloseAnim = m.top.findNode("overlayCloseAnim")
    m.focusMoveAnim = m.top.findNode("focusMoveAnim")
    m.focusMoveInterp = m.top.findNode("focusMoveInterp")
    m.pageSlideAnim = m.top.findNode("pageSlideAnim")
    m.pageSlideInterp = m.top.findNode("pageSlideInterp")
    m.searchFocusAnim = m.top.findNode("searchFocusAnim")
    m.searchScaleInterp = m.top.findNode("searchScaleInterp")
    m.artPopAnim = m.top.findNode("artPopAnim")
    m.eqPulseAnim = m.top.findNode("eqPulseAnim")

    m.orderedPhotos = []
    m.photos = []
    m.currentPhotoIndex = 0
    m.activePoster = "A"
    m.isSlideshowPaused = false
    m.isShuffleMode = false
    m.pendingPoster = ""
    m.currentSongTitle = ""
    m.currentVibeIndex = 0
    m.currentStationList = []
    m.currentStationIndex = 0
    m.isMuted = false

    m.allStations = getAll100Stations()
    m.filteredStations = m.allStations
    m.isStationsOpen = false
    m.stationsFocusArea = "grid"
    m.stationsTopFocusIdx = 0
    m.stationsSelectedIdx = 0
    m.lastPageStart = 0
    m.stationsSearchQuery = ""
    m.activePlayingUrl = ""
    m.lastArtQuery = ""
    m.stationCards = []
    buildStationGridUI()

    m.vibes = [
        { label: "Christian & Encouraging (K-LOVE)", tag: "christian", searchName: "K-LOVE", curated: [
            { name: "100.3 K-LOVE Los Angeles", url: "https://maestro.emfcdn.com/stream_for/k-love/tunein", format: "aac" },
            { name: "100.3 K-LOVE LA (Main Feed)", url: "https://maestro.emfcdn.com/stream_for/k-love/iheart/aac", format: "aac" },
            { name: "100.3 K-LOVE LA (Backup Feed)", url: "https://maestro.emfcdn.com/stream_for/k-love/airable/aac", format: "aac" },
            { name: "K-LOVE 80s & Classic Christian", url: "https://maestro.emfcdn.com/stream_for/k-love-80s/airable/aac", format: "aac" },
            { name: "Air1 Worship Music (K-LOVE Network)", url: "https://maestro.emfcdn.com/stream_for/air1/airable/aac", format: "aac" }
        ]},
        { label: "Classical Symphony (91.5 KUSC LA)", tag: "classical", searchName: "KUSC", curated: [
            { name: "Classical KUSC 91.5 FM Los Angeles", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/KUSCMP256.mp3", format: "mp3" },
            { name: "Classical KUSC 91.5 FM LA (Standard)", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/KUSCMP128.mp3", format: "mp3" },
            { name: "Classical KUSC 91.5 FM LA (AAC)", url: "https://playerservices.streamtheworld.com/api/livestream-redirect/KUSCAAC64.aac", format: "aac" },
            { name: "WQXR 105.9 FM Classical Philharmonic", url: "https://stream.wqxr.org/wqxr-web", format: "mp3" }
        ]},
        { label: "50s & 60s Golden Oldies", tag: "oldies", searchName: "", curated: [
            { name: "1.FM Back to the 50s & 60s Oldies", url: "http://strm112.1.fm/60s_70s_mobile_mp3", format: "mp3" },
            { name: ".977 50s & 60s Golden Oldies", url: "http://29318.live.streamtheworld.com/977_OLDIES_SC", format: "mp3" },
            { name: "NonStop Oldies (50s & 60s Hits)", url: "https://ais-sa2.cdnstream1.com/2383_128.mp3", format: "mp3" },
            { name: "Classic Vinyl HD Vintage Hits", url: "https://icecast.walmradio.com:8443/classic", format: "mp3" }
        ]},
        { label: "Los Angeles News & Talk", tag: "npr", searchName: "KPCC", curated: [
            { name: "LAist 89.3 FM (KPCC Southern California News)", url: "https://laist.streamguys1.com/kpcc-mp3?aw_0_1st.playerId=laist", format: "mp3" },
            { name: "LAist 89.3 FM KPCC (Alternate Stream)", url: "https://playerservices.streamtheworld.com/api/livestream-redirect/KPCC_FM.mp3", format: "mp3" },
            { name: "KCRW 89.9 FM Los Angeles News & Culture", url: "https://streams.kcrw.com/kcrw_mp3?aw_0_1st.playerid=radio-browser.info", format: "mp3" },
            { name: "KFI AM 640 Los Angeles Local News & Talk", url: "https://stream.revma.ihrhls.com/zc177", format: "mp3" }
        ]},
        { label: "Smooth Jazz & LA Jazz", tag: "smooth jazz", searchName: "", curated: [
            { name: "101 Smooth Jazz Mellow Mix", url: "http://jking.cdnstream1.com/b22139_128mp3", format: "mp3" },
            { name: "KJAZZ 88.1 FM Los Angeles & Long Beach", url: "https://streaming.kkjz.org/kkjz-128.mp3", format: "mp3" },
            { name: "WWOZ 90.7 FM Traditional & Classic Jazz", url: "https://wwoz-sc.streamguys1.com/wwoz-hi.mp3", format: "mp3" }
        ]},
        { label: "Big Band, Swing & Sinatra", tag: "big band", searchName: "", curated: [
            { name: "Exclusively Frank Sinatra Standards", url: "https://2.mystreaming.net/er/franksinatra/icecast.audio", format: "mp3" },
            { name: "Classic Vinyl HD Big Band & Crooners", url: "https://icecast.walmradio.com:8443/classic", format: "mp3" },
            { name: "Instrumentals Forever Lush Orchestra", url: "http://quincy.torontocast.com:1910/stream", format: "mp3" }
        ]},
        { label: "Classic Country Legends", tag: "classic country", searchName: "", curated: [
            { name: "181.FM Highway 181 (Classic Country Legends)", url: "http://listen.181fm.com/181-highway_128k.mp3", format: "mp3" },
            { name: "1.FM Classic Country Radio", url: "http://strm112.1.fm/ccountry_mobile_mp3", format: "mp3" }
        ]},
        { label: "Classic Motown & 60s Soul", tag: "motown", searchName: "", curated: [
            { name: "24/7 Motown Classics & Soul Legends", url: "http://stream.zeno.fm/49y7s0y32v8uv", format: "mp3" },
            { name: "SomaFM Seven Inch Soul (60s Soul)", url: "https://ice6.somafm.com/7soul-128-mp3", format: "mp3" },
            { name: "181.FM Classic Soul", url: "https://listen.181fm.com/181-soul_128k.mp3", format: "mp3" }
        ]},
        { label: "70s Soft Rock & Easy Listening", tag: "easy listening", searchName: "", curated: [
            { name: "Left Coast 70s (Mellow 70s Soft Rock)", url: "https://ice2.somafm.com/seventies-320-mp3", format: "mp3" },
            { name: "Gold Easy Listening & Timeless Hits", url: "https://media-ssl.musicradio.com/GoldMP3", format: "mp3" },
            { name: "Instrumentals Forever Easy Listening", url: "http://quincy.torontocast.com:1910/stream", format: "mp3" }
        ]},
        { label: "Christmas Classics & Holiday", tag: "christmas", searchName: "", curated: [
            { name: "181.FM Christmas Classics", url: "http://listen.181fm.com/181-xtraditional_128k.mp3", format: "mp3" },
            { name: "Classical Christmas FM", url: "https://christmasfm.cdnstream1.com/2550_128.mp3?aw_0_1st.playerid=esPlayer&aw_0_1st.skey=1605423292", format: "mp3" },
            { name: "1.FM Always Christmas Radio", url: "http://strm112.1.fm/christmas_mobile_mp3", format: "mp3" },
            { name: "Sky Radio Christmas", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/SRGSTR08.mp3", format: "mp3" }
        ]}
    ]

    m.slideshowTimer.ObserveField("fire", "onSlideshowTimerFire")
    m.toastTimer.ObserveField("fire", "onToastTimerFire")
    m.clockTimer.ObserveField("fire", "updateLivingRoomClock")
    m.nowPlayingTimer.ObserveField("fire", "onNowPlayingTimerFire")
    m.radioPlayer.ObserveField("state", "onAudioStateChange")
    m.radioPlayer.ObserveField("timedMetaData", "onTimedMetaData")
    m.radioPlayer.ObserveField("timedMetaData2", "onTimedMetaData")
    m.fadeAtoB.ObserveField("state", "onFadeAtoBState")
    m.fadeBtoA.ObserveField("state", "onFadeBtoAState")
    m.posterA.ObserveField("loadStatus", "onPosterALoadStatus")
    m.posterB.ObserveField("loadStatus", "onPosterBLoadStatus")
    m.heroAlbumPoster.ObserveField("loadStatus", "onAlbumArtLoadStatus")
    m.overlayCloseAnim.ObserveField("state", "onOverlayCloseAnimState")

    updateLivingRoomClock()
    m.clockTimer.control = "start"
    m.nowPlayingTimer.control = "start"
    m.eqPulseAnim.control = "start"
    discoverPhotos()
    loadCurrentVibe()
end sub

function addNode(parent as Object, nodeType as String, fields as Object) as Object
    n = CreateObject("roSGNode", nodeType)
    if fields <> invalid then n.setFields(fields)
    if parent <> invalid then parent.appendChild(n)
    return n
end function

' =============================================================================
' LIVING-ROOM CLOCK & 200+ PHOTO SLIDESHOW ENGINE
' =============================================================================

sub updateLivingRoomClock()
    dt = CreateObject("roDateTime")
    dt.ToLocalTime()
    h24 = dt.GetHours()
    mnt = dt.GetMinutes()
    ampm = "AM"
    if h24 >= 12 then ampm = "PM"
    h12 = h24 mod 12
    if h12 = 0 then h12 = 12
    minStr = mnt.ToStr()
    if mnt < 10 then minStr = "0" + minStr
    m.clockTimeLabel.text = h12.ToStr() + ":" + minStr + " " + ampm
    months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    mIdx = dt.GetMonth() - 1
    mName = "Jan"
    if mIdx >= 0 and mIdx < months.Count() then mName = months[mIdx]
    m.clockDateLabel.text = dt.GetWeekday() + ", " + mName + " " + dt.GetDayOfMonth().ToStr()
end sub

sub discoverPhotos()
    m.orderedPhotos = []
    m.photos = []
    rawFiles = ListDir("pkg:/images/")
    if type(rawFiles) = "roList" or type(rawFiles) = "roArray"
        sortableList = []
        for each fileName in rawFiles
            ln = LCase(fileName)
            if Left(ln, 8) <> "channel_" and Left(ln, 7) <> "splash_" and (Right(ln, 4) = ".jpg" or Right(ln, 5) = ".jpeg" or Right(ln, 4) = ".png")
                sortableList.Push({ name: fileName, sortKey: makeNaturalSortKey(ln) })
            end if
        end for
        sortableList.SortBy("sortKey")
        for each entry in sortableList
            uri = "pkg:/images/" + entry.name
            m.orderedPhotos.Push(uri)
            m.photos.Push(uri)
        end for
    end if

    if m.photos.Count() = 0
        m.emptyStateGroup.visible = true
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
        if m.photos.Count() > 1 then m.slideshowTimer.control = "start"
    end if
end sub

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
    while newIndex < 0
        newIndex = newIndex + photoCount
    end while
    while newIndex >= photoCount
        newIndex = newIndex - photoCount
    end while
    m.currentPhotoIndex = newIndex
    nextUri = m.photos[m.currentPhotoIndex]
    m.fadeAtoB.control = "stop"
    m.fadeBtoA.control = "stop"

    if m.activePoster = "A"
        m.pendingPoster = "B"
        m.posterB.uri = nextUri
        if m.posterB.loadStatus = "ready" then startCrossfadeToB()
    else
        m.pendingPoster = "A"
        m.posterA.uri = nextUri
        if m.posterA.loadStatus = "ready" then startCrossfadeToA()
    end if
    updatePhotoCounterHUD()
end sub

sub onPosterBLoadStatus()
    if m.pendingPoster <> "B" then return
    if m.posterB.loadStatus = "ready"
        startCrossfadeToB()
    else if m.posterB.loadStatus = "failed" and m.photos.Count() > 1
        showPhotoAtIndex(m.currentPhotoIndex + 1)
    end if
end sub

sub onPosterALoadStatus()
    if m.pendingPoster <> "A" then return
    if m.posterA.loadStatus = "ready"
        startCrossfadeToA()
    else if m.posterA.loadStatus = "failed" and m.photos.Count() > 1
        showPhotoAtIndex(m.currentPhotoIndex + 1)
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
    if not m.isSlideshowPaused and m.photos.Count() > 1 then showPhotoAtIndex(m.currentPhotoIndex + 1)
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
        showToast("PHOTO SLIDESHOW PAUSED", "Staying on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Press [Play] Anytime to Resume Slideshow")
    else
        if m.photos.Count() > 1 then m.slideshowTimer.control = "start"
        showToast("PHOTO SLIDESHOW RESUMED", "Changing Photos Every 12 Seconds", "Use [Left / Right] for Next Photo or [Rew / FF] to Jump 10 Photos")
    end if
    updatePhotoCounterHUD()
end sub

sub toggleShuffleMode()
    if m.orderedPhotos.Count() <= 1 then return
    currentUri = m.photos[m.currentPhotoIndex]
    m.isShuffleMode = not m.isShuffleMode
    if m.isShuffleMode
        pool = []
        for each uri in m.orderedPhotos
            if uri <> currentUri then pool.Push(uri)
        end for
        for i = pool.Count() - 1 to 1 step -1
            j = Rnd(i + 1) - 1
            tmp = pool[i]
            pool[i] = pool[j]
            pool[j] = tmp
        end for
        m.photos = [currentUri]
        for each uri in pool
            m.photos.Push(uri)
        end for
        m.currentPhotoIndex = 0
        showToast("SHUFFLE MODE ON", "Showing Family Photos in Random Order", "Press [OK] Anytime to Return to Storybook Order")
    else
        m.photos = []
        foundIdx = 0
        for i = 0 to m.orderedPhotos.Count() - 1
            uri = m.orderedPhotos[i]
            m.photos.Push(uri)
            if uri = currentUri then foundIdx = i
        end for
        m.currentPhotoIndex = foundIdx
        showToast("STORYBOOK ORDER ON", "Showing Family Photos in Numerical Order", "Press [OK] Anytime to Shuffle Photos")
    end if
    updatePhotoCounterHUD()
end sub

sub updatePhotoCounterHUD()
    total = m.photos.Count()
    if total = 0 then return
    modeText = "STORYBOOK ORDER"
    if m.isShuffleMode then modeText = "SHUFFLE MODE"
    if m.isSlideshowPaused
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM  •  PAUSED"
        m.photoCounterLabel.color = "0xFFD54FFF"
        m.photoSubLabel.text = modeText + "  •  Press [Play] to Resume"
    else
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM  •  " + modeText
        m.photoCounterLabel.color = "0xFFFFFFFF"
        m.photoSubLabel.text = "[Left/Right] Photo  •  [OK] Shuffle  •  [Play] Pause"
    end if
    m.photoCounterLabel.text = "Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + total.ToStr()
end sub

' =============================================================================
' LIVE RADIO & REAL-TIME ALBUM COVER ART ENGINE
' =============================================================================

sub loadCurrentVibe()
    vibe = m.vibes[m.currentVibeIndex]
    m.currentStationList = vibe.curated
    m.currentStationIndex = 0
    playCurrentStation()

    if m.radioTask <> invalid then m.radioTask.control = "stop"
    m.radioTask = CreateObject("roSGNode", "RadioTask")
    m.radioTask.searchTag = vibe.tag
    m.radioTask.searchName = vibe.searchName
    m.radioTask.curatedStations = vibe.curated
    m.radioTask.ObserveField("status", "onRadioTaskStatus")
    m.radioTask.control = "RUN"
end sub

sub onRadioTaskStatus()
    if m.radioTask = invalid or m.radioTask.status <> "ready" then return
    stations = m.radioTask.stations
    if type(stations) = "roArray" and stations.Count() > 0
        m.currentStationList = stations
        if m.radioPlayer.state = "error" or m.radioPlayer.state = "none"
            m.currentStationIndex = 0
            playCurrentStation()
        else
            updateRadioHUD()
        end if
    end if
end sub

sub playCurrentStation()
    if m.currentStationList = invalid or m.currentStationList.Count() = 0 then return
    if m.currentStationIndex >= m.currentStationList.Count() then m.currentStationIndex = 0
    station = m.currentStationList[m.currentStationIndex]
    vibe = m.vibes[m.currentVibeIndex]
    genreNum = (m.currentVibeIndex + 1).ToStr() + " OF " + m.vibes.Count().ToStr()
    streamFormat = "mp3"
    if station.DoesExist("format") and station.format <> "" then streamFormat = station.format

    content = CreateObject("roSGNode", "ContentNode")
    content.url = station.url
    content.title = station.name
    content.streamFormat = streamFormat
    content.live = true

    m.currentSongTitle = ""
    m.activePlayingUrl = station.url

    m.radioPlayer.control = "stop"
    m.radioPlayer.content = content
    m.radioPlayer.mute = m.isMuted
    m.radioPlayer.control = "play"

    m.hudAlbumPoster.uri = ""
    m.heroAlbumPoster.uri = ""
    m.lastArtQuery = ""
    artQ = getDefaultArtQueryForStation(station.name, vibe.label)
    requestAlbumArt("", artQ, station.url)
    updateRadioHUD()
    showToast("GENRE " + genreNum + "  •  " + UCase(vibe.label), station.name, "Press [UP / DOWN] for Other Genres   •   Press [ OK ] for 100 Stations & Voice Search")
end sub

sub onAudioStateChange()
    state = m.radioPlayer.state
    if state = "error" and m.currentStationList <> invalid and m.currentStationList.Count() > 1
        m.currentStationIndex = m.currentStationIndex + 1
        if m.currentStationIndex < m.currentStationList.Count() then playCurrentStation()
    else if state = "playing" or state = "buffering"
        updateRadioHUD()
    end if
end sub

sub toggleMute()
    m.isMuted = not m.isMuted
    m.radioPlayer.mute = m.isMuted
    if m.isMuted
        m.eqPulseAnim.control = "stop"
        showToast("RADIO AUDIO MUTED", "Music is Currently Muted", "Press [Replay] on Your Remote to Unmute Music")
    else
        m.eqPulseAnim.control = "start"
        showToast("RADIO AUDIO UNMUTED", m.radioStatusLabel.text, "Playing Live Radio")
    end if
    updateRadioHUD()
end sub

function extractTitleFromMeta(meta as Dynamic) as String
    if type(meta) <> "roAssociativeArray" then return ""
    songTitle = ""
    artistName = ""
    for each k in ["title", "Title", "StreamTitle", "TIT2"]
        if songTitle = "" and meta.DoesExist(k) and meta[k] <> invalid
            metaVal = meta[k]
            if type(metaVal) = "roString" or type(metaVal) = "String"
                songTitle = metaVal.Trim()
            end if
        end if
    end for
    for each k in ["artist", "Artist", "TPE1"]
        if artistName = "" and meta.DoesExist(k) and meta[k] <> invalid
            metaVal = meta[k]
            if type(metaVal) = "roString" or type(metaVal) = "String"
                artistName = metaVal.Trim()
            end if
        end if
    end for
    fullText = songTitle
    if artistName <> "" and songTitle <> "" then fullText = artistName + " - " + songTitle
    if fullText <> "" and fullText <> "-" and fullText <> " - " and Instr(1, LCase(fullText), "commercial") = 0 and Instr(1, LCase(fullText), "promo") = 0
        return fullText
    end if
    return ""
end function

sub onTimedMetaData()
    fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData)
    if fullText = "" then fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData2)
    if fullText <> ""
        if fullText <> m.currentSongTitle
            m.currentSongTitle = fullText
            requestAlbumArt(fullText, "", "")
        end if
    else
        m.currentSongTitle = ""
    end if
    updateRadioHUD()
end sub

sub onNowPlayingTimerFire()
    if m.activePlayingUrl = "" then return
    fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData)
    if fullText = "" then fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData2)
    if fullText <> ""
        if fullText <> m.currentSongTitle
            m.currentSongTitle = fullText
            requestAlbumArt(fullText, "", "")
            updateRadioHUD()
        end if
        return
    end if
    ' Poll live ICY StreamTitle in background for http:// streams
    requestAlbumArt("", "", m.activePlayingUrl)
end sub

sub requestAlbumArt(query as String, fallbackQuery = "" as String, streamUrl = "" as String)
    if query <> "" and query = m.lastArtQuery then return
    if query <> "" then m.lastArtQuery = query
    if m.artTask <> invalid then m.artTask.control = "stop"
    m.artTask = CreateObject("roSGNode", "ArtworkTask")
    m.artTask.query = query
    m.artTask.fallbackQuery = fallbackQuery
    m.artTask.streamUrl = streamUrl
    m.artTask.ObserveField("songTitle", "onArtworkSongTitleReady")
    m.artTask.ObserveField("artworkUrl", "onArtworkUrlReady")
    m.artTask.control = "RUN"
end sub

sub onArtworkSongTitleReady()
    if m.artTask = invalid or m.artTask.songTitle = "" then return
    if m.artTask.songTitle <> m.currentSongTitle
        m.currentSongTitle = m.artTask.songTitle
        m.lastArtQuery = m.artTask.songTitle
        updateRadioHUD()
    end if
end sub

sub onArtworkUrlReady()
    if m.artTask = invalid or m.artTask.artworkUrl = "" then return
    artUrl = m.artTask.artworkUrl
    if artUrl <> m.hudAlbumPoster.uri
        m.hudAlbumPoster.uri = artUrl
        m.heroAlbumPoster.uri = artUrl
    end if
end sub

sub onAlbumArtLoadStatus()
    if m.heroAlbumPoster.loadStatus = "ready" then m.artPopAnim.control = "start"
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
    m.stationsNowPlayingLabel.text = stationName

    if m.currentSongTitle <> ""
        m.nowPlayingLabel.text = "Now Playing: " + m.currentSongTitle + "   •   [OK] 100 Stations"
        m.stationsSongLabel.text = m.currentSongTitle
    else
        m.nowPlayingLabel.text = "Live Broadcast   •   Press [ OK ] for 100 Stations & Voice Search"
        m.stationsSongLabel.text = "Live Broadcast Stream"
    end if
end sub

sub showToast(title as String, message as String, subText = "" as String)
    if m.isStationsOpen then return
    m.toastTitleLabel.text = title
    m.toastMessageLabel.text = message
    if subText <> ""
        m.toastSubLabel.text = subText
    else
        m.toastSubLabel.text = "Press [UP / DOWN] to Change Genre   •   Press [ * ] for 100 Stations"
    end if
    m.clockGroup.visible = false
    m.toastGroup.visible = true
    m.toastSlideAnim.control = "start"
    m.toastTimer.control = "stop"
    m.toastTimer.control = "start"
end sub

sub onToastTimerFire()
    m.toastGroup.visible = false
    m.clockGroup.visible = true
end sub

' =============================================================================
' POLISHED PANDORA-FOR-TV 100-STATION BROWSER, VOICE MIC & ANIMATIONS
' =============================================================================

sub buildStationGridUI()
    m.stationCards = []
    colX = [80, 670, 1260]
    rowY = [224, 452, 680]
    for i = 0 to 8
        cx = colX[i mod 3]
        ry = rowY[Int(i / 3)]
        cardGroup = addNode(m.stationsGridGroup, "Group", { translation: [cx, ry] })
        border = addNode(cardGroup, "Rectangle", { width: 560, height: 204, color: "0x243248FF" })
        bg = addNode(cardGroup, "Rectangle", { translation: [4, 4], width: 552, height: 196, color: "0x101828FF" })
        accent = addNode(cardGroup, "Rectangle", { translation: [4, 4], width: 16, height: 196, color: "0xFFD54FFF" })
        numBadge = addNode(cardGroup, "Label", { translation: [34, 18], width: 496, height: 28, font: "font:SmallestBoldSystemFont", color: "0x80DEEAFF" })
        titleLbl = addNode(cardGroup, "Label", { translation: [34, 48], width: 496, height: 92, font: "font:MediumBoldSystemFont", color: "0xFFFFFFFF", wrap: true })
        playingLbl = addNode(cardGroup, "Label", { translation: [34, 154], width: 496, height: 30, font: "font:SmallestBoldSystemFont", color: "0x00E676FF", text: "" })
        m.stationCards.Push({ group: cardGroup, border: border, bg: bg, accent: accent, numBadge: numBadge, titleLbl: titleLbl, playingLbl: playingLbl, cardCoords: [cx, ry] })
    end for
end sub

sub openStationsBrowser()
    m.isStationsOpen = true
    m.toastGroup.visible = false
    m.stationsOverlay.visible = true
    if m.filteredStations.Count() > 0
        m.stationsFocusArea = "grid"
    else
        m.stationsFocusArea = "search"
        m.stationsTopFocusIdx = 0
    end if
    syncSearchFocusAnim()
    renderStationsGrid(false, 0)
    m.overlayOpenAnim.control = "start"
end sub

sub closeStationsBrowser()
    m.overlayCloseAnim.control = "start"
end sub

sub onOverlayCloseAnimState()
    if m.overlayCloseAnim.state = "stopped"
        m.isStationsOpen = false
        m.stationsOverlay.visible = false
        m.clockGroup.visible = true
        m.top.setFocus(true)
    end if
end sub

sub syncSearchFocusAnim()
    if m.stationsFocusArea = "search" and m.stationsTopFocusIdx = 0
        m.searchScaleInterp.keyValue = [[1.0, 1.0], [1.028, 1.028]]
        m.searchFocusAnim.control = "start"
    else
        m.searchScaleInterp.keyValue = [[1.028, 1.028], [1.0, 1.0]]
        m.searchFocusAnim.control = "start"
    end if
end sub

sub renderStationsGrid(animateFocus = true as Boolean, pageDir = 0 as Integer)
    total = m.filteredStations.Count()
    if m.stationsSearchQuery <> ""
        m.stationsHeaderTitle.text = "SEARCH: " + UCase(m.stationsSearchQuery) + "  (" + total.ToStr() + ")"
        m.searchBoxLabel.text = "Search: " + m.stationsSearchQuery + "   (Press OK for Mic / Keyboard)"
        m.searchBoxLabel.color = "0xFFFFFFFF"
    else
        m.stationsHeaderTitle.text = "PANDORA RADIO  •  " + total.ToStr() + " STATIONS"
        m.searchBoxLabel.text = "Press OK to Speak into Remote Mic or Type..."
        m.searchBoxLabel.color = "0xB0BEC5FF"
    end if

    m.searchBoxBorder.color = "0x28354AFF"
    m.searchBoxBg.color = "0x111A2BFF"
    m.micBadgeBg.color = "0x1E88E5FF"
    m.showAllBtnBorder.color = "0x28354AFF"
    m.showAllBtnBg.color = "0x111A2BFF"
    m.shuffleBtnBorder.color = "0x28354AFF"
    m.shuffleBtnBg.color = "0x111A2BFF"
    if m.isShuffleMode
        m.shuffleBtnLabel.text = "Order: Shuffle"
    else
        m.shuffleBtnLabel.text = "Order: Storybook"
    end if
    if m.stationsFocusArea = "search"
        if m.stationsTopFocusIdx = 0
            m.searchBoxBorder.color = "0xFFD54FFF"
            m.searchBoxBg.color = "0x1B2B48FF"
            m.micBadgeBg.color = "0x00E676FF"
        else if m.stationsTopFocusIdx = 1
            m.showAllBtnBorder.color = "0xFFD54FFF"
            m.showAllBtnBg.color = "0x1B2B48FF"
        else
            m.shuffleBtnBorder.color = "0xFFD54FFF"
            m.shuffleBtnBg.color = "0x1B2B48FF"
        end if
    end if

    if total = 0
        m.stationsEmptyLabel.visible = true
        m.gridFocusRing.visible = false
        for i = 0 to 8
            m.stationCards[i].group.visible = false
        end for
        m.stationsPageLabel.text = "0 Stations Found   •   Move Right to 'Show All 100' or Press [ Back ] to Return to Photos"
        return
    end if

    m.stationsEmptyLabel.visible = false
    if m.stationsSelectedIdx < 0 then m.stationsSelectedIdx = 0
    if m.stationsSelectedIdx >= total then m.stationsSelectedIdx = total - 1

    pageStart = Int(m.stationsSelectedIdx / 9) * 9
    pageEnd = pageStart + 8
    if pageEnd >= total then pageEnd = total - 1
    if pageDir <> 0 or pageStart <> m.lastPageStart
        offsetX = 36
        if pageDir < 0 or pageStart < m.lastPageStart then offsetX = -36
        m.pageSlideInterp.keyValue = [[offsetX, 0], [0, 0]]
        m.pageSlideAnim.control = "start"
        m.lastPageStart = pageStart
    end if

    for i = 0 to 8
        idx = pageStart + i
        card = m.stationCards[i]
        if idx < total
            st = m.filteredStations[idx]
            card.group.visible = true
            card.numBadge.text = "STATION " + (idx + 1).ToStr() + "  •  " + UCase(st.genre)
            card.titleLbl.text = st.name
            card.accent.color = st.color
            if st.url = m.activePlayingUrl
                card.playingLbl.text = "NOW PLAYING LIVE"
                card.playingLbl.color = "0x00E676FF"
            else
                card.playingLbl.text = "Press [OK] to Listen"
                card.playingLbl.color = "0x78909CFF"
            end if

            isCardFocused = (m.stationsFocusArea = "grid" and idx = m.stationsSelectedIdx)
            if isCardFocused
                card.border.color = "0xFFD54FFF"
                card.bg.color = "0x1A2942FF"
                if animateFocus
                    curCoords = m.gridFocusRing.translation
                    m.focusMoveInterp.keyValue = [[curCoords[0], curCoords[1]], card.cardCoords]
                    m.focusMoveAnim.control = "start"
                else
                    m.gridFocusRing.translation = card.cardCoords
                end if
            else
                card.border.color = "0x243248FF"
                card.bg.color = "0x101828FF"
            end if
        else
            card.group.visible = false
        end if
    end for

    m.gridFocusRing.visible = (m.stationsFocusArea = "grid")
    m.stationsPageLabel.text = "Stations " + (pageStart + 1).ToStr() + "-" + (pageEnd + 1).ToStr() + " of " + total.ToStr() + "   •   [UP] at Top Row = Mic Search   •   [OK] Play   •   [Rew/FF] Page   •   [ Back ] Photos"
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false
    if m.isStationsOpen then return handleStationsKeyEvent(key)

    if key = "left" and m.photos.Count() > 0
        showPhotoAtIndex(m.currentPhotoIndex - 1)
        resetSlideshowTimer()
        return true
    else if key = "right" and m.photos.Count() > 0
        showPhotoAtIndex(m.currentPhotoIndex + 1)
        resetSlideshowTimer()
        return true
    else if key = "rewind" and m.photos.Count() > 0
        showPhotoAtIndex(m.currentPhotoIndex - 10)
        resetSlideshowTimer()
        showToast("JUMPED BACK 10 PHOTOS", "Now on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Use [Left / Right] for Single Photos or [Rew / FF] to Jump 10")
        return true
    else if key = "fastforward" and m.photos.Count() > 0
        showPhotoAtIndex(m.currentPhotoIndex + 10)
        resetSlideshowTimer()
        showToast("JUMPED AHEAD 10 PHOTOS", "Now on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Use [Left / Right] for Single Photos or [Rew / FF] to Jump 10")
        return true
    else if key = "up"
        m.currentVibeIndex = (m.currentVibeIndex - 1 + m.vibes.Count()) mod m.vibes.Count()
        loadCurrentVibe()
        return true
    else if key = "down"
        m.currentVibeIndex = (m.currentVibeIndex + 1) mod m.vibes.Count()
        loadCurrentVibe()
        return true
    else if key = "OK"
        openStationsBrowser()
        return true
    else if key = "play"
        toggleSlideshowPause()
        return true
    else if key = "replay" or key = "instantreplay"
        toggleMute()
        return true
    end if
    return false
end function

function handleStationsKeyEvent(key as String) as Boolean
    total = m.filteredStations.Count()
    if key = "back"
        closeStationsBrowser()
        return true
    else if key = "replay" or key = "instantreplay"
        toggleMute()
        return true
    end if

    if m.stationsFocusArea = "search"
        if key = "left" and m.stationsTopFocusIdx > 0
            m.stationsTopFocusIdx = m.stationsTopFocusIdx - 1
            syncSearchFocusAnim()
            renderStationsGrid(false, 0)
        else if key = "right" and m.stationsTopFocusIdx < 2
            m.stationsTopFocusIdx = m.stationsTopFocusIdx + 1
            syncSearchFocusAnim()
            renderStationsGrid(false, 0)
        else if key = "down" and total > 0
            m.stationsFocusArea = "grid"
            syncSearchFocusAnim()
            renderStationsGrid(true, 0)
        else if key = "OK"
            if m.stationsTopFocusIdx = 0
                openStationSearchDialog()
            else if m.stationsTopFocusIdx = 1
                filterStationsByQuery("")
                m.stationsFocusArea = "grid"
                syncSearchFocusAnim()
                renderStationsGrid(true, -1)
            else
                toggleShuffleMode()
                renderStationsGrid(false, 0)
            end if
        end if
        return true
    end if

    if key = "left" and m.stationsSelectedIdx > 0
        m.stationsSelectedIdx = m.stationsSelectedIdx - 1
        renderStationsGrid(true, 0)
    else if key = "right" and m.stationsSelectedIdx < total - 1
        m.stationsSelectedIdx = m.stationsSelectedIdx + 1
        renderStationsGrid(true, 0)
    else if key = "up"
        if (m.stationsSelectedIdx mod 9) < 3
            m.stationsFocusArea = "search"
            m.stationsTopFocusIdx = 0
            syncSearchFocusAnim()
            renderStationsGrid(false, 0)
        else
            m.stationsSelectedIdx = m.stationsSelectedIdx - 3
            renderStationsGrid(true, 0)
        end if
    else if key = "down"
        if m.stationsSelectedIdx + 3 < total
            m.stationsSelectedIdx = m.stationsSelectedIdx + 3
        else if m.stationsSelectedIdx < total - 1
            m.stationsSelectedIdx = total - 1
        end if
        renderStationsGrid(true, 0)
    else if key = "rewind"
        m.stationsSelectedIdx = m.stationsSelectedIdx - 9
        if m.stationsSelectedIdx < 0 then m.stationsSelectedIdx = 0
        renderStationsGrid(false, -1)
    else if key = "fastforward"
        m.stationsSelectedIdx = m.stationsSelectedIdx + 9
        if m.stationsSelectedIdx >= total then m.stationsSelectedIdx = total - 1
        renderStationsGrid(false, 1)
    else if key = "OK" and total > 0
        playStationFromCatalog(m.filteredStations[m.stationsSelectedIdx])
        renderStationsGrid(false, 0)
    end if
    return true
end function

sub playStationFromCatalog(st as Object)
    streamFormat = "mp3"
    if st.DoesExist("format") and st.format <> "" then streamFormat = st.format
    content = CreateObject("roSGNode", "ContentNode")
    content.url = st.url
    content.title = st.name
    content.streamFormat = streamFormat
    content.live = true

    m.currentSongTitle = ""
    m.activePlayingUrl = st.url
    m.currentStationList = [st]
    m.currentStationIndex = 0
    m.radioPlayer.control = "stop"
    m.radioPlayer.content = content
    m.radioPlayer.mute = m.isMuted
    m.radioPlayer.control = "play"

    m.radioHeaderLabel.text = "100-STATION BROWSER  •  " + UCase(st.genre)
    m.radioStatusLabel.text = st.name
    m.nowPlayingLabel.text = "Live Broadcast   •   Press [ OK ] for 100 Stations"
    m.stationsNowPlayingLabel.text = st.name
    m.stationsSongLabel.text = "Connecting Live Stream..."
    m.hudAlbumPoster.uri = ""
    m.heroAlbumPoster.uri = ""
    m.lastArtQuery = ""
    artQ = getDefaultArtQueryForStation(st.name, st.genre)
    requestAlbumArt("", artQ, st.url)
end sub

sub openStationSearchDialog()
    dlg = CreateObject("roSGNode", "KeyboardDialog")
    dlg.title = "Voice or Text Search (100 Stations)"
    dlg.message = ["Hold the Mic button on your Roku Remote to speak, or type a station/artist (K-LOVE, Sinatra, Jazz, News, Christmas):"]
    dlg.text = m.stationsSearchQuery
    dlg.buttons = ["Search", "Show All 100", "Cancel"]
    dlg.ObserveField("buttonSelected", "onSearchDialogButton")
    m.searchDialog = dlg
    m.top.getScene().dialog = dlg
end sub

sub onSearchDialogButton()
    if m.searchDialog = invalid then return
    btn = m.searchDialog.buttonSelected
    query = m.searchDialog.text
    m.searchDialog.close = true
    m.searchDialog = invalid
    if btn = 0
        filterStationsByQuery(query)
        if m.filteredStations.Count() > 0 then m.stationsFocusArea = "grid"
    else if btn = 1
        filterStationsByQuery("")
        m.stationsFocusArea = "grid"
    end if
    syncSearchFocusAnim()
    renderStationsGrid(true, 1)
    m.top.setFocus(true)
end sub

sub filterStationsByQuery(query as String)
    cleanQ = LCase(query.Trim())
    m.stationsSearchQuery = query.Trim()
    m.stationsSelectedIdx = 0
    if cleanQ = ""
        m.filteredStations = m.allStations
        return
    end if
    matches = []
    for each st in m.allStations
        if Instr(1, LCase(st.name + " " + st.genre), cleanQ) > 0 then matches.Push(st)
    end for
    m.filteredStations = matches
end sub
