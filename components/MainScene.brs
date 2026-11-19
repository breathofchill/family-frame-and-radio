sub init()
    m.top.setFocus(true)

    m.posterA = m.top.findNode("posterA")
    m.posterB = m.top.findNode("posterB")
    m.fadeAtoB = m.top.findNode("fadeAtoB")
    m.fadeBtoA = m.top.findNode("fadeBtoA")
    m.kenBurnsA = m.top.findNode("kenBurnsA")
    m.kenBurnsB = m.top.findNode("kenBurnsB")
    m.photoProgressAnim = m.top.findNode("photoProgressAnim")
    m.photoProgressBar = m.top.findNode("photoProgressBar")
    m.emptyStateGroup = m.top.findNode("emptyStateGroup")
    m.toastGroup = m.top.findNode("toastGroup")
    m.toastTitleLabel = m.top.findNode("toastTitleLabel")
    m.toastMessageLabel = m.top.findNode("toastMessageLabel")
    m.toastSubLabel = m.top.findNode("toastSubLabel")
    m.toastSlideAnim = m.top.findNode("toastSlideAnim")
    m.clockGroup = m.top.findNode("clockGroup")
    m.clockGreetingLabel = m.top.findNode("clockGreetingLabel")
    m.clockTimeLabel = m.top.findNode("clockTimeLabel")
    m.clockDateLabel = m.top.findNode("clockDateLabel")
    m.holidayGroup = m.top.findNode("holidayGroup")
    m.holidayBadgeLabel = m.top.findNode("holidayBadgeLabel")
    m.holidayTextLabel = m.top.findNode("holidayTextLabel")
    m.holidayEffectGroup = m.top.findNode("holidayEffectGroup")
    m.holidayEmblemIcon = m.top.findNode("holidayEmblemIcon")
    m.holidayEmblemTitle = m.top.findNode("holidayEmblemTitle")
    m.holidayFxAnim = m.top.findNode("holidayFxAnim")
    m.fxParticles = []
    for i = 1 to 12
        p = m.top.findNode("fxP" + i.ToStr())
        if p <> invalid then m.fxParticles.Push(p)
    end for
    m.photoHeaderLabel = m.top.findNode("photoHeaderLabel")
    m.photoCounterLabel = m.top.findNode("photoCounterLabel")
    m.photoSubLabel = m.top.findNode("photoSubLabel")
    m.radioHeaderLabel = m.top.findNode("radioHeaderLabel")
    m.radioStatusLabel = m.top.findNode("radioStatusLabel")
    m.nowPlayingLabel = m.top.findNode("nowPlayingLabel")
    m.hudEqGroup = m.top.findNode("hudEqGroup")
    m.hudAlbumGroup = m.top.findNode("hudAlbumGroup")
    m.hudAlbumPoster = m.top.findNode("hudAlbumPoster")
    m.slideshowTimer = m.top.findNode("slideshowTimer")
    m.toastTimer = m.top.findNode("toastTimer")
    m.clockTimer = m.top.findNode("clockTimer")
    m.nowPlayingTimer = m.top.findNode("nowPlayingTimer")
    m.photoSyncTimer = m.top.findNode("photoSyncTimer")
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
    m.showAllBtnBorder = m.top.findNode("showAllBtnBorder")
    m.showAllBtnBg = m.top.findNode("showAllBtnBg")
    m.favBtnBorder = m.top.findNode("favBtnBorder")
    m.favBtnBg = m.top.findNode("favBtnBg")
    m.favBtnLabel = m.top.findNode("favBtnLabel")
    m.shuffleBtnBorder = m.top.findNode("shuffleBtnBorder")
    m.shuffleBtnBg = m.top.findNode("shuffleBtnBg")
    m.shuffleBtnLabel = m.top.findNode("shuffleBtnLabel")
    m.speedBtnBorder = m.top.findNode("speedBtnBorder")
    m.speedBtnBg = m.top.findNode("speedBtnBg")
    m.speedBtnLabel = m.top.findNode("speedBtnLabel")
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
    m.speedOptions = [8, 12, 20, 30]
    m.speedIdx = 1
    m.pendingPoster = ""
    m.currentSongTitle = ""
    m.currentVibeIndex = 0
    m.currentStationList = []
    m.currentStationIndex = 0
    m.isMuted = false
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

    m.slideshowTimer.ObserveField("fire", "onSlideshowTimerFire")
    m.toastTimer.ObserveField("fire", "onToastTimerFire")
    m.clockTimer.ObserveField("fire", "updateLivingRoomClock")
    m.nowPlayingTimer.ObserveField("fire", "onNowPlayingTimerFire")
    m.photoSyncTimer.ObserveField("fire", "syncCloudPhotos")
    m.radioPlayer.ObserveField("state", "onAudioStateChange")
    m.radioPlayer.ObserveField("timedMetaData", "onTimedMetaData")
    m.radioPlayer.ObserveField("timedMetaData2", "onTimedMetaData")
    m.fadeAtoB.ObserveField("state", "onFadeAtoBState")
    m.fadeBtoA.ObserveField("state", "onFadeBtoAState")
    m.posterA.ObserveField("loadStatus", "onPosterALoadStatus")
    m.posterB.ObserveField("loadStatus", "onPosterBLoadStatus")
    m.heroAlbumPoster.ObserveField("loadStatus", "onAlbumArtLoadStatus")
    m.overlayCloseAnim.ObserveField("state", "onOverlayCloseAnimState")

    loadSavedPreferences()
    applySlideshowSpeed(false)
    updateLivingRoomClock()
    m.clockTimer.control = "start"
    m.nowPlayingTimer.control = "start"
    m.photoSyncTimer.control = "start"
    m.eqPulseAnim.control = "start"
    discoverPhotos()
    syncCloudPhotos()

    if not resumeSavedStation()
        loadCurrentVibe()
    end if
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
        applyHolidayAtmosphere(bestH, bestDiff)
    else
        m.hasHolidayReminder = false
        m.holidayGroup.visible = false
        if m.holidayEffectGroup <> invalid then m.holidayEffectGroup.visible = false
        if m.holidayFxAnim <> invalid then m.holidayFxAnim.control = "stop"
    end if
end sub

sub applyHolidayAtmosphere(holidayObj as Object, diffDays as Integer)
    if m.holidayEffectGroup = invalid or m.holidayFxAnim = invalid then return
    hName = holidayObj.name

    ' Trigger atmosphere for holidays within 14 days (or active day of)
    if diffDays > 14
        m.holidayEffectGroup.visible = false
        m.holidayFxAnim.control = "stop"
        return
    end if

    m.holidayEffectGroup.visible = true
    m.holidayFxAnim.control = "start"

    if hName = "Thanksgiving"
        m.holidayEmblemIcon.text = "TURKEY & CORNUCOPIA"
        if diffDays = 0
            m.holidayEmblemTitle.text = "Happy Thanksgiving Feast!"
        else
            m.holidayEmblemTitle.text = "Harvest & Thanksgiving"
        end if
        ' Golden Autumn Harvest Leaves particle theme
        palette = ["0xFFB300EE", "0xFF8F00EE", "0xD84315EE", "0xE65100EE", "0xF4511EEE", "0xFFC107EE"]
        for i = 0 to m.fxParticles.Count() - 1
            p = m.fxParticles[i]
            p.color = palette[i mod palette.Count()]
            p.width = 12
            p.height = 7
        end for
    else if hName = "Christmas Day" or hName = "Christmas Eve"
        m.holidayEmblemIcon.text = "WINTER SNOW & PINES"
        if diffDays = 0
            m.holidayEmblemTitle.text = "Merry Christmas Day!"
        else
            m.holidayEmblemTitle.text = "Christmas Season"
        end if
        ' Gentle Falling White & Ice-Blue Snowflakes
        palette = ["0xFFFFFFFF", "0xE0F7FAEE", "0xE1F5FFEE", "0xBBDEFBEE", "0xFFFFFFDD", "0xE0F2F1EE"]
        for i = 0 to m.fxParticles.Count() - 1
            p = m.fxParticles[i]
            p.color = palette[i mod palette.Count()]
            p.width = 8 + (i mod 5)
            p.height = p.width
        end for
    else if hName = "4th of July"
        m.holidayEmblemIcon.text = "FIREWORKS & SPARKLERS"
        if diffDays = 0
            m.holidayEmblemTitle.text = "Happy 4th of July!"
        else
            m.holidayEmblemTitle.text = "Independence Celebration"
        end if
        ' Red, White & Blue Fireworks Sparks
        palette = ["0xFF1744FF", "0xFFFFFFFF", "0x2979FFFF", "0xFF5252FF", "0xFFD600FF", "0x00E676FF"]
        for i = 0 to m.fxParticles.Count() - 1
            p = m.fxParticles[i]
            p.color = palette[i mod palette.Count()]
            p.width = 6 + (i mod 6)
            p.height = 6 + (i mod 6)
        end for
    else if hName = "New Year's Eve" or hName = "New Year's Day"
        m.holidayEmblemIcon.text = "GOLDEN PARTY CONFETTI"
        m.holidayEmblemTitle.text = "Happy New Year!"
        ' Gold, Silver & Emerald Celebration Confetti
        palette = ["0xFFD54FFF", "0xFFC107FF", "0xFFFFFFFF", "0x00E676FF", "0xFFEE58FF", "0xFFD700FF"]
        for i = 0 to m.fxParticles.Count() - 1
            p = m.fxParticles[i]
            p.color = palette[i mod palette.Count()]
            p.width = 10
            p.height = 6
        end for
    else if hName = "Halloween"
        m.holidayEmblemIcon.text = "JACK-O'-LANTERN"
        m.holidayEmblemTitle.text = "Happy Halloween!"
        palette = ["0xFF6D00FF", "0xFFAB00FF", "0x7C4DFFFF", "0xFF3D00FF", "0x00E676FF", "0x212121FF"]
        for i = 0 to m.fxParticles.Count() - 1
            p = m.fxParticles[i]
            p.color = palette[i mod palette.Count()]
            p.width = 10
            p.height = 10
        end for
    else
        m.holidayEmblemIcon.text = "HOLIDAY CELEBRATION"
        m.holidayEmblemTitle.text = holidayObj.name
        palette = ["0xFFD54FFF", "0xFFFFFFFF", "0x80DEEAFF", "0xF48FB1FF"]
        for i = 0 to m.fxParticles.Count() - 1
            p = m.fxParticles[i]
            p.color = palette[i mod palette.Count()]
            p.width = 8
            p.height = 8
        end for
    end if
end sub

sub applySlideshowSpeed(notify as Boolean)
    secs = m.speedOptions[m.speedIdx]
    m.slideshowTimer.duration = secs * 1.0
    m.kenBurnsA.duration = secs * 1.0
    m.kenBurnsB.duration = secs * 1.0
    m.photoProgressAnim.duration = secs * 1.0
    if not m.isSlideshowPaused and m.photos.Count() > 1
        resetSlideshowTimer()
        restartPhotoProgress()
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

sub restartPhotoProgress()
    m.photoProgressAnim.control = "stop"
    m.photoProgressBar.width = 0
    if not m.isSlideshowPaused and m.photos.Count() > 1
        m.photoProgressAnim.control = "start"
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
        m.photoProgressAnim.control = "stop"
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
        m.photoProgressAnim.control = "stop"
        m.kenBurnsA.control = "stop"
        m.kenBurnsB.control = "stop"
        showToast("PHOTO SLIDESHOW PAUSED", "Staying on Photo " + (m.currentPhotoIndex + 1).ToStr() + " of " + m.photos.Count().ToStr(), "Press [Play] Anytime to Resume Slideshow")
    else
        if m.photos.Count() > 1
            m.slideshowTimer.control = "start"
            restartPhotoProgress()
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
    state = m.radioPlayer.state
    if state = "playing"
        m.retryCount = 0
        if not m.isMuted then m.hudEqGroup.visible = true
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
    m.radioPlayer.mute = m.isMuted
    if m.isMuted
        m.eqPulseAnim.control = "stop"
        m.hudEqGroup.visible = false
        showToast("RADIO AUDIO MUTED", "Music is Currently Muted", "Press [Replay] on Your Remote to Unmute Music")
    else
        m.eqPulseAnim.control = "start"
        m.hudEqGroup.visible = true
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

    m.searchBoxBorder.color = "0x28354AFF"
    m.searchBoxBg.color = "0x111A2BFF"
    m.micBadgeBg.color = "0x1E88E5FF"
    m.showAllBtnBorder.color = "0x28354AFF"
    m.showAllBtnBg.color = "0x111A2BFF"
    m.favBtnBorder.color = "0x28354AFF"
    m.favBtnBg.color = "0x111A2BFF"
    m.shuffleBtnBorder.color = "0x28354AFF"
    m.shuffleBtnBg.color = "0x111A2BFF"
    m.speedBtnBorder.color = "0x28354AFF"
    m.speedBtnBg.color = "0x111A2BFF"

    m.favBtnLabel.text = "Favorites (" + getFavoritesCount().ToStr() + ")"
    if m.isShuffleMode
        m.shuffleBtnLabel.text = "Shuffle"
    else
        m.shuffleBtnLabel.text = "Storybook"
    end if
    m.speedBtnLabel.text = "Speed: " + m.speedOptions[m.speedIdx].ToStr() + "s"

    if m.stationsFocusArea = "search"
        if m.stationsTopFocusIdx = 0
            m.searchBoxBorder.color = "0xFFD54FFF"
            m.searchBoxBg.color = "0x1B2B48FF"
            m.micBadgeBg.color = "0x00E676FF"
        else if m.stationsTopFocusIdx = 1
            m.showAllBtnBorder.color = "0xFFD54FFF"
            m.showAllBtnBg.color = "0x1B2B48FF"
        else if m.stationsTopFocusIdx = 2
            m.favBtnBorder.color = "0xFFD54FFF"
            m.favBtnBg.color = "0x1B2B48FF"
        else if m.stationsTopFocusIdx = 3
            m.shuffleBtnBorder.color = "0xFFD54FFF"
            m.shuffleBtnBg.color = "0x1B2B48FF"
        else
            m.speedBtnBorder.color = "0xFFD54FFF"
            m.speedBtnBg.color = "0x1B2B48FF"
        end if
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
        else if key = "right" and m.stationsTopFocusIdx < 4
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
            else
                cycleSlideshowSpeed()
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
    m.activePlayingUrl = st.url
    m.currentStationList = [st]
    m.currentStationIndex = 0
    m.retryCount = 0
    m.radioPlayer.control = "stop"
    m.radioPlayer.content = content
    m.radioPlayer.mute = m.isMuted
    m.radioPlayer.control = "play"

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
