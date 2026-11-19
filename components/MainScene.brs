sub init()
    m.top.setFocus(true)

    nodeIds = [
        "posterA", "posterB", "fadeAtoB", "fadeBtoA", "kenBurnsA", "kenBurnsB", "emptyStateGroup",
        "toastGroup", "toastTitleLabel", "toastMessageLabel", "toastSubLabel", "toastSlideAnim",
        "clockGroup", "clockGreetingLabel", "clockTimeLabel", "clockDateLabel",
        "holidayGroup", "holidayBadgeLabel", "holidayTextLabel",
        "photoHeaderLabel", "photoCounterLabel", "photoSubLabel", "radioHeaderLabel", "radioStatusLabel", "nowPlayingLabel", "hudEqGroup", "hudAlbumGroup", "hudAlbumPoster",
        "slideshowTimer", "toastTimer", "clockTimer", "nowPlayingTimer", "photoSyncTimer", "msgPollTimer", "ttsDuckTimer", "stationFadeTimer", "triviaTimer", "radioPlayer", "ttsPlayer",
        "triviaBannerGroup", "triviaCatLabel", "triviaTopicLabel", "triviaBodyLabel",
        "verseBannerGroup", "verseOuterRect", "verseInnerRect", "verseRefLabel", "verseBodyLabel",
        "ttsAlertGroup", "ttsAlertSenderLabel", "ttsAlertBodyLabel", "ttsSlideAnim",
        "familyInfoOverlay", "sosAddressLabel", "sosPrimaryLabel", "sosSecondaryLabel", "sosDoctorLabel", "sosPharmacyLabel", "sosNoteLabel",
        "stationsOverlay", "stationsContentGroup", "stationsHeaderTitle", "stationsNowPlayingLabel", "stationsSongLabel", "stationsGenreLabel", "heroAlbumGroup", "heroAlbumPoster", "heroBadgeLabel",
        "searchBoxGroup", "searchBoxBorder", "searchBoxBg", "micBadgeBg", "searchBoxLabel",
        "showAllBtnBorder", "showAllBtnBg", "favBtnBorder", "favBtnBg", "favBtnLabel", "shuffleBtnBorder", "shuffleBtnBg", "shuffleBtnLabel", "speedBtnBorder", "speedBtnBg", "speedBtnLabel", "hubBtnBorder", "hubBtnBg",
        "stationsGridGroup", "gridFocusRing", "stationsEmptyLabel", "stationsPageLabel",
        "overlayOpenAnim", "overlayCloseAnim", "focusMoveAnim", "focusMoveInterp", "pageSlideAnim", "pageSlideInterp", "searchFocusAnim", "searchScaleInterp", "artPopAnim", "eqPulseAnim"
    ]
    for each nid in nodeIds
        m[nid] = m.top.findNode(nid)
    end for

    m.savedRadioContent = invalid
    m.pendingTtsText = ""
    m.isAppActive = true
    m.pendingFamilyAlert = invalid
    m.triviaCards = get100FamilyTriviaCards()
    m.currentTriviaIdx = 0
    m.orderedPhotos = []
    m.photos = []
    m.currentPhotoIndex = 0
    m.activePoster = "A"
    m.isSlideshowPaused = false
    m.isShuffleMode = false
    m.speedOptions = [8, 12, 20, 30]
    m.speedIdx = 1
    m.pendingPoster = ""
    m.currentSongTitle = ""
    m.currentVibeIndex = 0
    m.currentStationList = []
    m.currentStationIndex = 0
    m.isMuted = false
    m.isCommercialMuted = false
    m.isTtsDucking = false
    m.lastSeenMsgId = ""
    m.isFamilyHubOpen = false
    m.pendingRadioContent = invalid
    m.favoriteUrls = {}
    m.isShowingFavorites = false
    m.retryCount = 0

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

    obs = [
        [m.top, "appActive", "onAppActiveChanged"],
        [m.slideshowTimer, "fire", "onSlideshowTimerFire"],
        [m.toastTimer, "fire", "onToastTimerFire"],
        [m.clockTimer, "fire", "updateLivingRoomClock"],
        [m.nowPlayingTimer, "fire", "onNowPlayingTimerFire"],
        [m.photoSyncTimer, "fire", "syncCloudPhotos"],
        [m.msgPollTimer, "fire", "pollFamilyMessages"],
        [m.ttsDuckTimer, "fire", "onTtsDuckTimerFire"],
        [m.stationFadeTimer, "fire", "onStationFadeTimerFire"],
        [m.triviaTimer, "fire", "onTriviaTimerFire"],
        [m.radioPlayer, "state", "onAudioStateChange"],
        [m.ttsPlayer, "state", "onTtsPlayerStateChange"],
        [m.radioPlayer, "timedMetaData", "onTimedMetaData"],
        [m.radioPlayer, "timedMetaData2", "onTimedMetaData"],
        [m.fadeAtoB, "state", "onFadeAtoBState"],
        [m.fadeBtoA, "state", "onFadeBtoAState"],
        [m.posterA, "loadStatus", "onPosterALoadStatus"],
        [m.posterB, "loadStatus", "onPosterBLoadStatus"],
        [m.heroAlbumPoster, "loadStatus", "onAlbumArtLoadStatus"],
        [m.overlayCloseAnim, "state", "onOverlayCloseAnimState"]
    ]
    for each o in obs
        o[0].ObserveField(o[1], o[2])
    end for

    loadSavedPreferences()
    applySlideshowSpeed(false)
    updateLivingRoomClock()
    showNextTriviaCard()
    for each tmr in [m.clockTimer, m.nowPlayingTimer, m.photoSyncTimer, m.msgPollTimer, m.triviaTimer, m.eqPulseAnim]
        tmr.control = "start"
    end for
    discoverPhotos()
    syncCloudPhotos()
    runFamilyHub("all")

    if not resumeSavedStation()
        loadCurrentVibe()
    end if
end sub

function isAppActiveForTts() as Boolean
    return (m.isAppActive = true and m.top.visible = true)
end function

sub onAppActiveChanged()
    m.isAppActive = (m.top.appActive = true)
    if isAppActiveForTts()
        if m.pendingFamilyAlert <> invalid
            pa = m.pendingFamilyAlert
            m.pendingFamilyAlert = invalid
            deliverFamilyAlert(pa.id, pa.sender, pa.text)
        end if
        pollFamilyMessages()
    end if
end sub

sub runFamilyHub(hubMode as String)
    if m.hubTask <> invalid then m.hubTask.control = "stop"
    m.hubTask = CreateObject("roSGNode", "FamilyHubTask")
    m.hubTask.mode = hubMode
    m.hubTask.ObserveField("status", "onFamilyHubStatus")
    m.hubTask.control = "RUN"
end sub

sub pollFamilyMessages()
    if not isAppActiveForTts() then return
    runFamilyHub("messages")
end sub

sub deliverFamilyAlert(incomingId as String, senderName as String, msgText as String)
    m.lastSeenMsgId = incomingId
    sec = CreateObject("roRegistrySection", "FamilyFramePrefs")
    prevSavedId = ""
    if sec <> invalid and sec.Exists("lastMsgId") then prevSavedId = sec.Read("lastMsgId")
    if sec <> invalid
        sec.Write("lastMsgId", incomingId)
        sec.Flush()
    end if
    if incomingId <> prevSavedId
        triggerTwitchStyleFamilyAlert(senderName, msgText)
    end if
end sub

sub onFamilyHubStatus()
    if m.hubTask = invalid or m.hubTask.status <> "ready" then return

    if m.hubTask.verseText <> "" and m.verseBannerGroup <> invalid
        verseStr = Chr(34) + m.hubTask.verseText + Chr(34)
        m.verseRefLabel.text = "VERSE OF THE DAY  •  " + UCase(m.hubTask.verseRef)
        m.verseBodyLabel.text = verseStr

        vLen = Len(verseStr)
        cardH = 168
        cardY = 696
        if vLen > 240
            cardH = 196
            cardY = 668
        end if
        m.verseBannerGroup.translation = [36, cardY]
        m.verseOuterRect.width = 1788
        m.verseOuterRect.height = cardH
        m.verseInnerRect.width = 1782
        m.verseInnerRect.height = cardH - 6
        m.verseBodyLabel.height = cardH - 50
        m.triviaBodyLabel.height = cardH - 72
        m.verseBannerGroup.visible = true
    end if

    if type(m.hubTask.contacts) = "roAssociativeArray" and m.hubTask.contacts.Count() > 0
        c = m.hubTask.contacts
        if c.DoesExist("homeAddress") then m.sosAddressLabel.text = "Home Address: " + c.homeAddress
        if c.DoesExist("primaryContactName") then m.sosPrimaryLabel.text = "Primary Contact: " + c.primaryContactName + "   •   " + c.primaryContactPhone
        if c.DoesExist("secondaryContactName") then m.sosSecondaryLabel.text = "Backup Contact: " + c.secondaryContactName + "   •   " + c.secondaryContactPhone
        if c.DoesExist("doctorName") then m.sosDoctorLabel.text = "Doctor: " + c.doctorName + "   •   " + c.doctorPhone
        if c.DoesExist("pharmacyName") then m.sosPharmacyLabel.text = "Pharmacy: " + c.pharmacyName + "   •   " + c.pharmacyPhone
        if c.DoesExist("notes") then m.sosNoteLabel.text = c.notes
    end if

    if type(m.hubTask.triviaCards) = "roArray" and m.hubTask.triviaCards.Count() > 0
        m.triviaCards = m.hubTask.triviaCards
    end if

    if m.hubTask.msgId <> "" and m.hubTask.msgText <> ""
        incomingId = m.hubTask.msgId
        if incomingId <> m.lastSeenMsgId
            if not isAppActiveForTts()
                m.pendingFamilyAlert = { id: incomingId, sender: m.hubTask.msgSender, text: m.hubTask.msgText }
                return
            end if
            deliverFamilyAlert(incomingId, m.hubTask.msgSender, m.hubTask.msgText)
        end if
    end if
end sub

function cleanSpeechText(rawText as String) as String
    if rawText = "" then return ""
    cleaned = rawText.Replace(Chr(10), " ").Replace(Chr(13), " ").Replace("#", "").Replace("*", "").Replace("_", " ")
    words = cleaned.Split(" ")
    outStr = ""
    for each w in words
        tr = w.Trim()
        lw = LCase(tr)
        if lw <> "" and Left(lw, 7) <> "http://" and Left(lw, 8) <> "https://"
            if outStr = ""
                outStr = tr
            else
                outStr = outStr + " " + tr
            end if
        end if
    end for
    return outStr
end function

sub triggerTwitchStyleFamilyAlert(senderName as String, msgText as String)
    if senderName = "" then senderName = "Family"
    m.ttsAlertSenderLabel.text = "From " + senderName + ":"
    m.ttsAlertBodyLabel.text = Chr(34) + msgText + Chr(34)
    m.ttsAlertGroup.visible = true
    if m.ttsSlideAnim <> invalid then m.ttsSlideAnim.control = "start"

    cleanBody = cleanSpeechText(msgText)
    if cleanBody = "" then cleanBody = msgText
    spoken = "Message from " + senderName + ". " + cleanBody
    if Len(spoken) > 190 then spoken = Left(spoken, 187) + "..."
    m.pendingTtsText = spoken

    ' Pause/stop radio decoder cleanly so ttsPlayer gets exclusive hardware audio playback
    m.isTtsDucking = true
    if m.radioPlayer.content <> invalid
        m.savedRadioContent = m.radioPlayer.content
    end if
    m.radioPlayer.control = "stop"
    m.eqPulseAnim.control = "stop"
    m.hudEqGroup.visible = false

    xfer = CreateObject("roUrlTransfer")
    escapedQ = xfer.Escape(spoken)
    ttsUrl = "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=en&q=" + escapedQ

    ttsContent = CreateObject("roSGNode", "ContentNode")
    ttsContent.url = ttsUrl
    ttsContent.streamFormat = "mp3"
    ttsContent.live = false

    m.ttsPlayer.control = "stop"
    m.ttsPlayer.content = ttsContent
    m.ttsPlayer.mute = false
    if m.ttsPlayer.HasField("volume") then m.ttsPlayer.volume = 85
    m.ttsPlayer.control = "play"

    ' Safety timeout in case stream hangs
    m.ttsDuckTimer.duration = 20.0
    m.ttsDuckTimer.control = "stop"
    m.ttsDuckTimer.control = "start"
end sub

sub onTtsPlayerStateChange()
    if m.ttsPlayer = invalid or not m.isTtsDucking then return
    st = m.ttsPlayer.state
    if st = "finished"
        finishTtsAlert()
    else if st = "error"
        ' Fallback to built-in Roku TTS if network TTS stream fails
        if m.ttsObj = invalid then m.ttsObj = CreateObject("roTextToSpeech")
        if m.ttsObj <> invalid and m.pendingTtsText <> ""
            m.ttsObj.Say(m.pendingTtsText)
        end if
        m.ttsDuckTimer.duration = 8.0
        m.ttsDuckTimer.control = "stop"
        m.ttsDuckTimer.control = "start"
    end if
end sub

sub finishTtsAlert()
    m.ttsDuckTimer.control = "stop"
    if m.ttsPlayer <> invalid then m.ttsPlayer.control = "stop"
    m.ttsAlertGroup.visible = false
    m.isTtsDucking = false
    m.pendingTtsText = ""

    if m.savedRadioContent <> invalid
        m.radioPlayer.content = m.savedRadioContent
        syncRadioMuteState()
        m.radioPlayer.control = "play"
    else
        syncRadioMuteState()
    end if
end sub

sub onTtsDuckTimerFire()
    finishTtsAlert()
end sub

sub syncCloudPhotos()
    if m.photoSyncTask <> invalid then m.photoSyncTask.control = "stop"
    m.photoSyncTask = CreateObject("roSGNode", "PhotoSyncTask")
    m.photoSyncTask.ObserveField("status", "onPhotoSyncStatus")
    m.photoSyncTask.control = "RUN"
end sub

sub onPhotoSyncStatus()
    if m.photoSyncTask = invalid or m.photoSyncTask.status <> "ready" then return
    cloudUrls = m.photoSyncTask.photoUrls
    if type(cloudUrls) <> "roArray" or cloudUrls.Count() = 0 then return

    ' Check if the cloud list is identical in count & first/last URL to avoid unnecessary resets
    if m.orderedPhotos.Count() = cloudUrls.Count() and m.orderedPhotos.Count() > 0
        if m.orderedPhotos[0] = cloudUrls[0] and m.orderedPhotos[m.orderedPhotos.Count() - 1] = cloudUrls[cloudUrls.Count() - 1]
            return
        end if
    end if

    m.orderedPhotos = cloudUrls
    if m.isShuffleMode and cloudUrls.Count() > 1
        shuffleCurrentPhotoList("")
    else
        m.photos = []
        for each u in cloudUrls
            m.photos.Push(u)
        end for
    end if

    m.emptyStateGroup.visible = false
    if m.currentPhotoIndex >= m.photos.Count() then m.currentPhotoIndex = 0
    updatePhotoCounterHUD()
    if m.photos.Count() > 1 and not m.isSlideshowPaused
        m.slideshowTimer.control = "start"
        restartPhotoProgress()
    end if
end sub

function addNode(parent as Object, nodeType as String, fields as Object) as Object
    n = CreateObject("roSGNode", nodeType)
    if fields <> invalid then n.setFields(fields)
    if parent <> invalid then parent.appendChild(n)
    return n
end function

' =============================================================================
' PERSISTENT PREFERENCES (REMEMBERS STATION, FAVORITES, SPEED & SHUFFLE)
' =============================================================================

sub loadSavedPreferences()
    sec = CreateObject("roRegistrySection", "FamilyFramePrefs")
    if sec = invalid then return

    if sec.Exists("speedIdx")
        idxVal = Int(Val(sec.Read("speedIdx")))
        if idxVal >= 0 and idxVal < m.speedOptions.Count() then m.speedIdx = idxVal
    end if

    if sec.Exists("shuffleMode") and sec.Read("shuffleMode") = "1"
        m.isShuffleMode = true
    end if

    if sec.Exists("favoritesJson")
        parsed = ParseJson(sec.Read("favoritesJson"))
        if type(parsed) = "roArray"
            for each u in parsed
                if type(u) = "roString" or type(u) = "String" then m.favoriteUrls[u] = true
            end for
        end if
    end if
end sub

sub savePreferences()
    sec = CreateObject("roRegistrySection", "FamilyFramePrefs")
    if sec = invalid then return
    sec.Write("speedIdx", m.speedIdx.ToStr())
    if m.isShuffleMode
        sec.Write("shuffleMode", "1")
    else
        sec.Write("shuffleMode", "0")
    end if

    favArr = []
    for each u in m.favoriteUrls
        if m.favoriteUrls[u] = true then favArr.Push(u)
    end for
    sec.Write("favoritesJson", FormatJson(favArr))
    sec.Flush()
end sub

sub saveLastStation(st as Object, genreLabel as String)
    sec = CreateObject("roRegistrySection", "FamilyFramePrefs")
    if sec = invalid or st = invalid then return
    sec.Write("lastUrl", st.url)
    sec.Write("lastName", st.name)
    sec.Write("lastGenre", genreLabel)
    fmt = "mp3"
    if st.DoesExist("format") and st.format <> "" then fmt = st.format
    sec.Write("lastFormat", fmt)
    sec.Flush()
end sub

function resumeSavedStation() as Boolean
    sec = CreateObject("roRegistrySection", "FamilyFramePrefs")
    if sec = invalid or not sec.Exists("lastUrl") then return false
    savedUrl = sec.Read("lastUrl")
    if savedUrl = "" then return false
    savedName = sec.Read("lastName")
    savedGenre = sec.Read("lastGenre")
    savedFmt = sec.Read("lastFormat")
    if savedFmt = "" then savedFmt = "mp3"
    st = { name: savedName, url: savedUrl, genre: savedGenre, format: savedFmt }
    playStationFromCatalog(st)
    showToast("WELCOME BACK", savedName, "Resumed Your Last Station  •  Press [OK] for 100 Stations & Favorites")
    return true
end function

function getFavoritesCount() as Integer
    cnt = 0
    for each u in m.favoriteUrls
        if m.favoriteUrls[u] = true then cnt = cnt + 1
    end for
    return cnt
end function

sub toggleFavoriteStation(st as Object)
    if st = invalid or not st.DoesExist("url") then return
    if m.favoriteUrls.DoesExist(st.url) and m.favoriteUrls[st.url] = true
        m.favoriteUrls.Delete(st.url)
    else
        m.favoriteUrls[st.url] = true
    end if
    savePreferences()
    if m.isShowingFavorites then applyFavoritesFilter()
    renderStationsGrid(false, 0)
end sub

sub applyFavoritesFilter()
    m.isShowingFavorites = true
    m.stationsSearchQuery = ""
    m.stationsSelectedIdx = 0
    favs = []
    for each st in m.allStations
        if m.favoriteUrls.DoesExist(st.url) and m.favoriteUrls[st.url] = true
            favs.Push(st)
        end if
    end for
    m.filteredStations = favs
end sub

' =============================================================================
' LIVING-ROOM CLOCK, GREETING & CINEMA KEN BURNS PHOTO SLIDESHOW ENGINE
' =============================================================================

sub updateLivingRoomClock()
    dt = CreateObject("roDateTime")
    dt.ToLocalTime()
    h24 = dt.GetHours()
    mnt = dt.GetMinutes()

    if h24 >= 5 and h24 < 12
        m.clockGreetingLabel.text = "GOOD MORNING"
    else if h24 >= 12 and h24 < 17
        m.clockGreetingLabel.text = "GOOD AFTERNOON"
    else
        m.clockGreetingLabel.text = "GOOD EVENING"
    end if

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
    updateHolidayReminder(dt)
end sub

function getEpochDay(y as Integer, mth as Integer, d as Integer) as Integer
    if mth <= 2
        y = y - 1
        mth = mth + 12
    end if
    return Int(365 * y) + Int(y / 4) - Int(y / 100) + Int(y / 400) + Int((153 * (mth - 3) + 2) / 5) + d
end function

function getNthWeekdayDay(y as Integer, mth as Integer, targetDow as Integer, nth as Integer) as Integer
    ' targetDow: 0=Sun, 1=Mon, ..., 4=Thu, 6=Sat (Sakamoto)
    t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
    yy = y
    if mth < 3 then yy = yy - 1
    dow1 = (yy + Int(yy / 4) - Int(yy / 100) + Int(yy / 400) + t[mth - 1] + 1) mod 7
    firstMatch = 1 + ((targetDow - dow1 + 7) mod 7)
    return firstMatch + (nth - 1) * 7
end function

sub updateHolidayReminder(dt as Object)
    yr = dt.GetYear()
    mo = dt.GetMonth()
    dy = dt.GetDayOfMonth()
    todayNum = getEpochDay(yr, mo, dy)

    holidays = []
    for each yOff in [0, 1]
        yCheck = yr + yOff
        holidays.Push({ name: "New Year's Day", badge: "HAPPY NEW YEAR!", dayNum: getEpochDay(yCheck, 1, 1) })
        holidays.Push({ name: "Valentine's Day", badge: "HAPPY VALENTINE'S DAY!", dayNum: getEpochDay(yCheck, 2, 14) })
        holidays.Push({ name: "St. Patrick's Day", badge: "HAPPY ST. PATRICK'S DAY!", dayNum: getEpochDay(yCheck, 3, 17) })
        holidays.Push({ name: "Mother's Day", badge: "HAPPY MOTHER'S DAY!", dayNum: getEpochDay(yCheck, 5, getNthWeekdayDay(yCheck, 5, 0, 2)) })
        holidays.Push({ name: "Father's Day", badge: "HAPPY FATHER'S DAY!", dayNum: getEpochDay(yCheck, 6, getNthWeekdayDay(yCheck, 6, 0, 3)) })
        holidays.Push({ name: "4th of July", badge: "HAPPY 4TH OF JULY!", dayNum: getEpochDay(yCheck, 7, 4) })
        holidays.Push({ name: "Halloween", badge: "HAPPY HALLOWEEN!", dayNum: getEpochDay(yCheck, 10, 31) })
        holidays.Push({ name: "Veterans Day", badge: "HAPPY VETERANS DAY!", dayNum: getEpochDay(yCheck, 11, 11) })
        holidays.Push({ name: "Thanksgiving", badge: "HAPPY THANKSGIVING!", dayNum: getEpochDay(yCheck, 11, getNthWeekdayDay(yCheck, 11, 4, 4)) })
        holidays.Push({ name: "Christmas Eve", badge: "MERRY CHRISTMAS EVE!", dayNum: getEpochDay(yCheck, 12, 24) })
        holidays.Push({ name: "Christmas Day", badge: "MERRY CHRISTMAS!", dayNum: getEpochDay(yCheck, 12, 25) })
        holidays.Push({ name: "New Year's Eve", badge: "HAPPY NEW YEAR'S EVE!", dayNum: getEpochDay(yCheck, 12, 31) })
    end for

    bestDiff = 9999
    bestH = invalid
    for each h in holidays
        diff = h.dayNum - todayNum
        if diff >= 0 and diff < bestDiff
            bestDiff = diff
            bestH = h
        end if
    end for

    if bestH <> invalid and bestDiff <= 45
        m.hasHolidayReminder = true
        if bestDiff = 0
            m.holidayBadgeLabel.text = "TODAY'S HOLIDAY"
            m.holidayTextLabel.text = bestH.badge
            m.holidayTextLabel.color = "0xFFD54FFF"
        else if bestDiff = 1
            m.holidayBadgeLabel.text = "TOMORROW!"
            m.holidayTextLabel.text = bestH.name + " is Tomorrow"
            m.holidayTextLabel.color = "0xFFFFFFFF"
        else
            m.holidayBadgeLabel.text = "HOLIDAY REMINDER"
            m.holidayTextLabel.text = bestDiff.ToStr() + " Days Until " + bestH.name
            m.holidayTextLabel.color = "0xFFFFFFFF"
        end if
        if not m.toastGroup.visible then m.holidayGroup.visible = true
    else
        m.hasHolidayReminder = false
        m.holidayGroup.visible = false
    end if
end sub

sub showNextTriviaCard(cardIdx = -1 as Integer)
    if m.triviaCards = invalid or m.triviaCards.Count() = 0 then return
    if m.triviaBannerGroup = invalid then return

    if cardIdx >= 0
        m.currentTriviaIdx = cardIdx mod m.triviaCards.Count()
    else
        m.currentTriviaIdx = (m.currentTriviaIdx + 1) mod m.triviaCards.Count()
    end if

    card = m.triviaCards[m.currentTriviaIdx]
    cId = m.currentTriviaIdx + 1
    if card.DoesExist("id") and card.id <> invalid then cId = card.id

    cCat = "DAILY FAMILY TRIVIA"
    if card.DoesExist("cat") and card.cat <> "" then cCat = UCase(card.cat)
    m.triviaCatLabel.text = cCat + "  •  #" + cId.ToStr() + " OF 100"

    cTopic = ""
    if card.DoesExist("topic") and card.topic <> "" then cTopic = card.topic
    m.triviaTopicLabel.text = cTopic

    cFact = ""
    if card.DoesExist("fact") and card.fact <> ""
        cFact = card.fact
    else if card.DoesExist("text") and card.text <> ""
        cFact = card.text
    end if
    m.triviaBodyLabel.text = cFact

    ' Style unified border subtly by trivia category
    if InStr(1, cCat, "HISTORY") > 0
        m.triviaCatLabel.color = "0xFFD54FFF"
    else if InStr(1, cCat, "RIDDLE") > 0 or InStr(1, cCat, "WORDPLAY") > 0
        m.triviaCatLabel.color = "0x80DEEAFF"
    else if InStr(1, cCat, "NATURE") > 0
        m.triviaCatLabel.color = "0x00E676FF"
    else if InStr(1, cCat, "NOSTALGIA") > 0 or InStr(1, cCat, "INVENTIONS") > 0
        m.triviaCatLabel.color = "0xFFB74DFF"
    else
        m.triviaCatLabel.color = "0xCE93D8FF"
    end if
    m.verseBannerGroup.visible = true
end sub

sub onTriviaTimerFire()
    showNextTriviaCard()
end sub

sub applySlideshowSpeed(notify as Boolean)
    secs = m.speedOptions[m.speedIdx]
    m.slideshowTimer.duration = secs * 1.0
    m.kenBurnsA.duration = secs * 1.0
    m.kenBurnsB.duration = secs * 1.0
    if not m.isSlideshowPaused and m.photos.Count() > 1
        resetSlideshowTimer()
    end if
    updatePhotoCounterHUD()
    if notify
        savePreferences()
        showToast("SLIDESHOW SPEED", "Showing Each Photo for " + secs.ToStr() + " Seconds", "Press [OK] Anytime to Adjust Speed, Shuffle, or Stations")
    end if
end sub

sub cycleSlideshowSpeed()
    m.speedIdx = (m.speedIdx + 1) mod m.speedOptions.Count()
    applySlideshowSpeed(true)
end sub

sub startKenBurnsForActivePoster()
    if m.isSlideshowPaused then return
    if m.activePoster = "A"
        m.kenBurnsB.control = "stop"
        m.posterA.scale = [1.0, 1.0]
        m.kenBurnsA.control = "stop"
        m.kenBurnsA.control = "start"
    else
        m.kenBurnsA.control = "stop"
        m.posterB.scale = [1.0, 1.0]
        m.kenBurnsB.control = "stop"
        m.kenBurnsB.control = "start"
    end if
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

    if m.isShuffleMode and m.photos.Count() > 1
        shuffleCurrentPhotoList("")
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
        m.posterA.scale = [1.0, 1.0]
        m.posterB.opacity = 0.0
        m.posterB.uri = ""
        m.activePoster = "A"
        updatePhotoCounterHUD()
        startKenBurnsForActivePoster()
        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
            restartPhotoProgress()
        end if
    end if
end sub

sub shuffleCurrentPhotoList(keepFirstUri as String)
    pool = []
    for each uri in m.orderedPhotos
        if uri <> keepFirstUri then pool.Push(uri)
    end for
    for i = pool.Count() - 1 to 1 step -1
        j = Rnd(i + 1) - 1
        tmp = pool[i]
        pool[i] = pool[j]
        pool[j] = tmp
    end for
    if keepFirstUri <> ""
        m.photos = [keepFirstUri]
    else
        m.photos = []
    end if
    for each uri in pool
        m.photos.Push(uri)
    end for
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
        m.posterB.scale = [1.0, 1.0]
        m.posterB.uri = nextUri
        if m.posterB.loadStatus = "ready" then startCrossfadeToB()
    else
        m.pendingPoster = "A"
        m.posterA.scale = [1.0, 1.0]
        m.posterA.uri = nextUri
        if m.posterA.loadStatus = "ready" then startCrossfadeToA()
    end if
    updatePhotoCounterHUD()
    restartPhotoProgress()
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
    startKenBurnsForActivePoster()
end sub

sub startCrossfadeToA()
    m.pendingPoster = ""
    m.activePoster = "A"
    m.fadeBtoA.control = "start"
    startKenBurnsForActivePoster()
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
        m.kenBurnsA.control = "stop"
        m.kenBurnsB.control = "stop"
        showToast("PHOTO SLIDESHOW PAUSED", "Staying on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Press [Play] Anytime to Resume Slideshow")
    else
        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
            startKenBurnsForActivePoster()
        end if
        secs = m.speedOptions[m.speedIdx]
        showToast("PHOTO SLIDESHOW RESUMED", "Changing Photos Every " + secs.ToStr() + " Seconds", "Use [Left / Right] for Next Photo or [Rew / FF] to Jump 10 Photos")
    end if
    updatePhotoCounterHUD()
end sub

sub toggleShuffleMode()
    if m.orderedPhotos.Count() <= 1 then return
    currentUri = m.photos[m.currentPhotoIndex]
    m.isShuffleMode = not m.isShuffleMode
    if m.isShuffleMode
        shuffleCurrentPhotoList(currentUri)
        m.currentPhotoIndex = 0
        showToast("SHUFFLE MODE ON", "Showing Family Photos in Random Order", "Saved Automatically for Next Time")
    else
        m.photos = []
        foundIdx = 0
        for i = 0 to m.orderedPhotos.Count() - 1
            uri = m.orderedPhotos[i]
            m.photos.Push(uri)
            if uri = currentUri then foundIdx = i
        end for
        m.currentPhotoIndex = foundIdx
        showToast("STORYBOOK ORDER ON", "Showing Family Photos in Numerical Order", "Saved Automatically for Next Time")
    end if
    savePreferences()
    updatePhotoCounterHUD()
end sub

sub updatePhotoCounterHUD()
    total = m.photos.Count()
    if total = 0 then return
    secs = m.speedOptions[m.speedIdx].ToStr() + "s"
    modeText = "STORYBOOK"
    if m.isShuffleMode then modeText = "SHUFFLE"
    if m.isSlideshowPaused
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM  •  PAUSED"
        m.photoCounterLabel.color = "0xFFD54FFF"
        m.photoSubLabel.text = modeText + "  •  Press [Play] to Resume  •  [OK] 100 Stations"
    else
        m.photoHeaderLabel.text = "FAMILY PHOTO ALBUM  •  " + modeText + "  •  " + secs
        m.photoCounterLabel.color = "0xFFFFFFFF"
        m.photoSubLabel.text = "[Left/Right] Photo  •  [OK] 100 Stations  •  [Play] Pause  •  [Replay] Mute"
    end if
    m.photoCounterLabel.text = "Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + total.ToStr()
end sub

' =============================================================================
' LIVE RADIO, STREAM AUTO-RECOVERY & EVERY-SONG HD ALBUM COVER ENGINE
' =============================================================================

sub loadCurrentVibe()
    vibe = m.vibes[m.currentVibeIndex]
    m.currentStationList = vibe.curated
    m.currentStationIndex = 0
    m.retryCount = 0
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

sub syncRadioMuteState()
    if m.radioPlayer.HasField("volume") then m.radioPlayer.volume = 65
    effectiveMute = (m.isMuted or m.isCommercialMuted or m.isTtsDucking or m.pendingRadioContent <> invalid)
    m.radioPlayer.mute = effectiveMute
    if effectiveMute
        m.eqPulseAnim.control = "stop"
        m.hudEqGroup.visible = false
    else if m.radioPlayer.state = "playing"
        m.eqPulseAnim.control = "start"
        m.hudEqGroup.visible = true
    end if
end sub

sub startCrossfadeRadioStream(content as Object)
    m.stationFadeTimer.control = "stop"
    if m.radioPlayer.state = "playing" or m.radioPlayer.state = "buffering"
        m.pendingRadioContent = content
        syncRadioMuteState()
        m.stationFadeTimer.control = "start"
    else
        m.pendingRadioContent = invalid
        m.radioPlayer.control = "stop"
        m.radioPlayer.content = content
        syncRadioMuteState()
        m.radioPlayer.control = "play"
    end if
end sub

sub onStationFadeTimerFire()
    if m.pendingRadioContent = invalid then return
    nextContent = m.pendingRadioContent
    m.pendingRadioContent = invalid
    m.radioPlayer.control = "stop"
    m.radioPlayer.content = nextContent
    syncRadioMuteState()
    m.radioPlayer.control = "play"
end sub

function isCommercialText(txt as String) as Boolean
    if txt = "" then return false
    l = LCase(txt.Trim())
    keywords = ["commercial", "ad break", "adbreak", "advertisement", "sponsored by", "sponsor", "promo ", " promo", "station id", "legal id", "spot break", "underwriting"]
    for each kw in keywords
        if Instr(1, l, kw) > 0 then return true
    end for
    if l = "promo" or l = "ad" or l = "ads" or l = "commercials" then return true
    return false
end function

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
    m.isCommercialMuted = false
    m.activePlayingUrl = station.url

    startCrossfadeRadioStream(content)
    saveLastStation(station, vibe.label)

    m.hudAlbumPoster.uri = ""
    m.heroAlbumPoster.uri = ""
    m.lastArtQuery = ""
    artQ = getDefaultArtQueryForStation(station.name, vibe.label)
    requestAlbumArt("", artQ, station.url)
    updateRadioHUD()
    showToast("GENRE " + genreNum + "  •  " + UCase(vibe.label), station.name, "Press [UP / DOWN] for Other Genres   •   Press [ OK ] for 100 Stations & Favorites")
end sub

sub onAudioStateChange()
    if m.pendingRadioContent <> invalid then return
    state = m.radioPlayer.state
    if state = "playing"
        m.retryCount = 0
        syncRadioMuteState()
        updateRadioHUD()
    else if state = "buffering"
        updateRadioHUD()
    else if state = "error" or state = "finished"
        if m.currentStationList <> invalid and m.currentStationList.Count() > 1 and m.retryCount < m.currentStationList.Count()
            m.retryCount = m.retryCount + 1
            m.currentStationIndex = (m.currentStationIndex + 1) mod m.currentStationList.Count()
            playCurrentStation()
        else if m.retryCount < 2 and m.activePlayingUrl <> ""
            m.retryCount = m.retryCount + 1
            m.radioPlayer.control = "stop"
            m.radioPlayer.control = "play"
        end if
    end if
end sub

sub toggleMute()
    m.isMuted = not m.isMuted
    syncRadioMuteState()
    if m.isMuted
        showToast("RADIO AUDIO MUTED", "Music is Currently Muted", "Press [Replay] on Your Remote to Unmute Music")
    else
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
    if fullText <> "" and fullText <> "-" and fullText <> " - "
        return fullText
    end if
    return ""
end function

sub handleIncomingTrackMetadata(fullText as String)
    if fullText = "" then return
    if isCommercialText(fullText)
        wasAdMuted = m.isCommercialMuted
        m.isCommercialMuted = true
        m.currentSongTitle = "[Ad Auto-Muted] Commercial Break"
        if not wasAdMuted then syncRadioMuteState()
        updateRadioHUD()
        return
    end if

    if m.isCommercialMuted
        m.isCommercialMuted = false
        syncRadioMuteState()
    end if
    if fullText <> m.currentSongTitle
        m.currentSongTitle = fullText
        requestAlbumArt(fullText, "", "")
    end if
    updateRadioHUD()
end sub

sub onTimedMetaData()
    fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData)
    if fullText = "" then fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData2)
    if fullText <> ""
        handleIncomingTrackMetadata(fullText)
    else
        m.currentSongTitle = ""
        updateRadioHUD()
    end if
end sub

sub onNowPlayingTimerFire()
    if m.activePlayingUrl = "" then return
    fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData)
    if fullText = "" then fullText = extractTitleFromMeta(m.radioPlayer.timedMetaData2)
    if fullText <> ""
        handleIncomingTrackMetadata(fullText)
        return
    end if
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
    if isCommercialText(m.artTask.songTitle)
        m.isCommercialMuted = true
        m.currentSongTitle = "[Ad Auto-Muted] Commercial Break"
        syncRadioMuteState()
        updateRadioHUD()
        return
    end if
    if m.isCommercialMuted
        m.isCommercialMuted = false
        syncRadioMuteState()
    end if
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
    else if m.isCommercialMuted
        statePrefix = "[AD MUTED]  "
    else if m.pendingRadioContent <> invalid or m.radioPlayer.state = "buffering"
        statePrefix = "[Loading]  "
    end if
    m.radioStatusLabel.text = statePrefix + stationName
    m.stationsNowPlayingLabel.text = stationName

    if m.currentSongTitle <> ""
        m.nowPlayingLabel.text = "Now Playing: " + m.currentSongTitle
        m.stationsSongLabel.text = m.currentSongTitle
    else
        m.nowPlayingLabel.text = "Live Broadcast   •   Press [ OK ] for 100 Stations & Favorites"
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
        m.toastSubLabel.text = "Press [UP / DOWN] to Change Genre   •   Press [ OK ] for 100 Stations"
    end if
    m.clockGroup.visible = false
    m.holidayGroup.visible = false
    m.toastGroup.visible = true
    m.toastSlideAnim.control = "start"
    m.toastTimer.control = "stop"
    m.toastTimer.control = "start"
end sub

sub onToastTimerFire()
    m.toastGroup.visible = false
    m.clockGroup.visible = true
    if m.hasHolidayReminder = true then m.holidayGroup.visible = true
end sub

' =============================================================================
' POLISHED 100-STATION BROWSER, FAVORITES, SPEED & VOICE SEARCH
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
    if m.isShowingFavorites
        m.stationsHeaderTitle.text = "FAVORITE STATIONS  (" + total.ToStr() + ")"
    else if m.stationsSearchQuery <> ""
        m.stationsHeaderTitle.text = "SEARCH: " + UCase(m.stationsSearchQuery) + "  (" + total.ToStr() + ")"
    else
        m.stationsHeaderTitle.text = "FAMILY RADIO  •  " + total.ToStr() + " STATIONS"
    end if

    if m.stationsSearchQuery <> ""
        m.searchBoxLabel.text = m.stationsSearchQuery
        m.searchBoxLabel.color = "0xFFFFFFFF"
    else
        m.searchBoxLabel.text = "Mic / Search..."
        m.searchBoxLabel.color = "0xB0BEC5FF"
    end if

    topBtns = [
        [m.searchBoxBorder, m.searchBoxBg], [m.showAllBtnBorder, m.showAllBtnBg],
        [m.favBtnBorder, m.favBtnBg], [m.shuffleBtnBorder, m.shuffleBtnBg],
        [m.speedBtnBorder, m.speedBtnBg], [m.hubBtnBorder, m.hubBtnBg]
    ]
    for each tb in topBtns
        tb[0].color = "0x28354AFF"
        tb[1].color = "0x111A2BFF"
    end for
    m.micBadgeBg.color = "0x1E88E5FF"

    m.favBtnLabel.text = "Favorites (" + getFavoritesCount().ToStr() + ")"
    if m.isShuffleMode then m.shuffleBtnLabel.text = "Shuffle" else m.shuffleBtnLabel.text = "Storybook"
    m.speedBtnLabel.text = "Speed: " + m.speedOptions[m.speedIdx].ToStr() + "s"

    if m.stationsFocusArea = "search"
        fIdx = m.stationsTopFocusIdx
        if fIdx < 0 or fIdx >= topBtns.Count() then fIdx = topBtns.Count() - 1
        topBtns[fIdx][0].color = "0xFFD54FFF"
        topBtns[fIdx][1].color = "0x1B2B48FF"
        if fIdx = 0 then m.micBadgeBg.color = "0x00E676FF"
    end if

    if total = 0
        m.stationsEmptyLabel.visible = true
        m.gridFocusRing.visible = false
        for i = 0 to 8
            m.stationCards[i].group.visible = false
        end for
        m.stationsPageLabel.text = "0 Stations Found   •   Select 'All 100' Above or Press [Back] for Photos"
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
            isFav = (m.favoriteUrls.DoesExist(st.url) and m.favoriteUrls[st.url] = true)
            favPrefix = ""
            if isFav then favPrefix = "★  "
            card.numBadge.text = favPrefix + "STATION " + (idx + 1).ToStr() + "  •  " + UCase(st.genre)
            if isFav
                card.numBadge.color = "0xFFD54FFF"
            else
                card.numBadge.color = "0x80DEEAFF"
            end if
            card.titleLbl.text = st.name
            card.accent.color = st.color
            if st.url = m.activePlayingUrl
                card.playingLbl.text = "NOW PLAYING LIVE"
                card.playingLbl.color = "0x00E676FF"
            else if isFav
                card.playingLbl.text = "★ FAVORITE  •  [OK] Listen  •  [Play] Unstar"
                card.playingLbl.color = "0xFFD54FFF"
            else
                card.playingLbl.text = "[OK] Listen   •   [Play] Star Favorite"
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
    m.stationsPageLabel.text = "Stations " + (pageStart + 1).ToStr() + "-" + (pageEnd + 1).ToStr() + " of " + total.ToStr() + "   •   [OK] Play   •   [Play] Star Favorite   •   [Rew/FF] Page   •   [Back] Photos"
end sub

sub openFamilyHubOverlay()
    m.isFamilyHubOpen = true
    m.familyInfoOverlay.visible = true
    runFamilyHub("contacts")
end sub

sub closeFamilyHubOverlay()
    m.isFamilyHubOpen = false
    m.familyInfoOverlay.visible = false
    m.top.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false
    if Left(LCase(key), 6) = "volume" then return false
    if m.isFamilyHubOpen
        if key = "back" or key = "OK" or key = "options"
            closeFamilyHubOverlay()
        end if
        return true
    end if
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
    else if key = "options"
        openFamilyHubOverlay()
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
    if Left(LCase(key), 6) = "volume" then return false
    total = m.filteredStations.Count()
    if key = "back"
        closeStationsBrowser()
        return true
    else if key = "options"
        openFamilyHubOverlay()
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
        else if key = "right" and m.stationsTopFocusIdx < 5
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
                m.isShowingFavorites = false
                filterStationsByQuery("")
                m.stationsFocusArea = "grid"
                syncSearchFocusAnim()
                renderStationsGrid(true, -1)
            else if m.stationsTopFocusIdx = 2
                applyFavoritesFilter()
                if m.filteredStations.Count() > 0 then m.stationsFocusArea = "grid"
                syncSearchFocusAnim()
                renderStationsGrid(true, 1)
            else if m.stationsTopFocusIdx = 3
                toggleShuffleMode()
                renderStationsGrid(false, 0)
            else if m.stationsTopFocusIdx = 4
                cycleSlideshowSpeed()
                renderStationsGrid(false, 0)
            else
                openFamilyHubOverlay()
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
    else if key = "play" and total > 0
        toggleFavoriteStation(m.filteredStations[m.stationsSelectedIdx])
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
    m.isCommercialMuted = false
    m.activePlayingUrl = st.url
    m.currentStationList = [st]
    m.currentStationIndex = 0
    m.retryCount = 0

    startCrossfadeRadioStream(content)

    stGenre = "Radio"
    if st.DoesExist("genre") and st.genre <> "" then stGenre = st.genre
    saveLastStation(st, stGenre)

    m.radioHeaderLabel.text = "100-STATION BROWSER  •  " + UCase(stGenre)
    m.radioStatusLabel.text = st.name
    m.nowPlayingLabel.text = "Live Broadcast   •   Press [ OK ] for 100 Stations & Favorites"
    m.stationsNowPlayingLabel.text = st.name
    m.stationsSongLabel.text = "Connecting Live Stream..."
    m.hudAlbumPoster.uri = ""
    m.heroAlbumPoster.uri = ""
    m.lastArtQuery = ""
    artQ = getDefaultArtQueryForStation(st.name, stGenre)
    requestAlbumArt("", artQ, st.url)
end sub

sub openStationSearchDialog()
    dlg = CreateObject("roSGNode", "StandardKeyboardDialog")
    if dlg = invalid
        dlg = CreateObject("roSGNode", "KeyboardDialog")
    end if
    dlg.title = "Voice or Text Search (100 Stations)"
    dlg.message = ["Tap the on-screen Mic icon (or focus the text box before holding your remote Mic button) so Roku searches this app instead of the whole TV:"]
    dlg.text = m.stationsSearchQuery
    if dlg.HasField("textEditBox") and dlg.textEditBox <> invalid
        te = dlg.textEditBox
        if te.HasField("hintText") then te.hintText = "Say or type station, artist, or genre..."
        if te.HasField("voiceEnabled") then te.voiceEnabled = true
        if te.HasField("voiceEntryType") then te.voiceEntryType = "alphanumeric"
    end if
    dlg.buttons = ["Search", "Show All 100", "Cancel"]
    dlg.ObserveField("buttonSelected", "onSearchDialogButton")
    dlg.ObserveField("wasClosed", "onSearchDialogWasClosed")
    m.searchDialog = dlg
    m.top.getScene().dialog = dlg
end sub

sub onSearchDialogButton()
    if m.searchDialog = invalid then return
    dlg = m.searchDialog
    btn = dlg.buttonSelected
    query = dlg.text
    m.searchDialog = invalid
    dlg.close = true
    if btn = 0
        m.isShowingFavorites = false
        filterStationsByQuery(query)
        if m.filteredStations.Count() > 0 then m.stationsFocusArea = "grid"
    else if btn = 1
        m.isShowingFavorites = false
        filterStationsByQuery("")
        m.stationsFocusArea = "grid"
    end if
    syncSearchFocusAnim()
    renderStationsGrid(true, 1)
    m.top.setFocus(true)
end sub

sub onSearchDialogWasClosed()
    m.searchDialog = invalid
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
