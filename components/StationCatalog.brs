' =============================================================================
' StationCatalog.brs — 100 Curated, Grandparent-Friendly Radio Stations
' Organized into 10 Main Genres (10 Stations per Genre = 100 Total Stations)
' =============================================================================

function getAll100Stations() as Object
    return [
        ' --- 1. CHRISTIAN & ENCOURAGING (Stations 1 - 10) ---
        { name: "100.3 K-LOVE Los Angeles", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://maestro.emfcdn.com/stream_for/k-love/tunein", format: "aac" },
        { name: "100.3 K-LOVE LA (Main Feed)", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://maestro.emfcdn.com/stream_for/k-love/iheart/aac", format: "aac" },
        { name: "K-LOVE 80s & Classic Christian", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://maestro.emfcdn.com/stream_for/k-love-80s/airable/aac", format: "aac" },
        { name: "Air1 Worship Music", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://maestro.emfcdn.com/stream_for/air1/airable/aac", format: "aac" },
        { name: "CBN Classic Christian Radio", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://streams.cbnradio.com/Classic-Christian-128K?app=cbnplayer", format: "mp3" },
        { name: "CBN Southern Gospel", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://streams.cbnradio.com//southern-gospel-128K", format: "mp3" },
        { name: "Affirm Southern Gospel Radio", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://ais-sa2.cdnstream1.com/1708_128", format: "mp3" },
        { name: "Big R Radio Gospel Channel", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "http://bigrradio.cdnstream1.com/5199_128", format: "mp3" },
        { name: "Cape Christian Radio", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://ice64.securenetsystems.net/CCR1MP3", format: "mp3" },
        { name: "3ABN Christian Music", genre: "Christian & Encouraging", color: "0x1E88E5FF", url: "https://war.streamguys1.com:7185/MC01", format: "mp3" },

        ' --- 2. CLASSICAL SYMPHONY & PIANO (Stations 11 - 20) ---
        { name: "Classical KUSC 91.5 FM Los Angeles", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/KUSCMP256.mp3", format: "mp3" },
        { name: "Classical KUSC 91.5 LA (Standard)", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/KUSCMP128.mp3", format: "mp3" },
        { name: "WQXR 105.9 FM Classical NY", genre: "Classical Symphony", color: "0x8E24AAFF", url: "https://stream.wqxr.org/wqxr-web", format: "mp3" },
        { name: "Your Classical - Relax", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://relax.stream.publicradio.org/relax.mp3", format: "mp3" },
        { name: "Classic FM UK", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://media-ice.musicradio.com/ClassicFMMP3", format: "mp3" },
        { name: "France Musique Classique", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://direct.francemusique.fr/live/francemusique-midfi.mp3", format: "mp3" },
        { name: "Calm Radio - Solo Piano", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://streams.calmradio.com:1228/", format: "mp3" },
        { name: "Radio Art - Solo Piano", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://live.radioart.com/fSolo_piano.mp3", format: "mp3" },
        { name: "Radio Art - Violin, Piano & Cello", genre: "Classical Symphony", color: "0x8E24AAFF", url: "http://air.radioart.com/fRelaxing.mp3", format: "mp3" },
        { name: "Romantic Piano Classics", genre: "Classical Symphony", color: "0x8E24AAFF", url: "https://stream.epic-piano.com/romantic-piano?ref=radiobrowser", format: "mp3" },

        ' --- 3. 50s & 60s GOLDEN OLDIES (Stations 21 - 30) ---
        { name: "1.FM Back to the 50s & 60s", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://strm112.1.fm/60s_70s_mobile_mp3", format: "mp3" },
        { name: ".977 50s & 60s Golden Oldies", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://29318.live.streamtheworld.com/977_OLDIES_SC", format: "mp3" },
        { name: "NonStop Oldies 50s & 60s", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "https://ais-sa2.cdnstream1.com/2383_128.mp3", format: "mp3" },
        { name: "Classic Vinyl HD", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "https://icecast.walmradio.com:8443/classic", format: "mp3" },
        { name: "Gold UK Timeless Oldies", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "https://media-ssl.musicradio.com/GoldMP3", format: "mp3" },
        { name: "Doo Wop Forever", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://streams.calmradio.com:19028/stream", format: "mp3" },
        { name: "Beatles Radio", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://www.beatlesradio.com:8000/;", format: "mp3" },
        { name: "60s Radio Classics", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://listen.mrg.fm:8020/stream", format: "mp3" },
        { name: "1000 Oldies Radio", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://1000oldies.stream.laut.fm/1000oldies", format: "mp3" },
        { name: "Nostalgie Classic Hits", genre: "50s & 60s Oldies", color: "0xFB8C00FF", url: "http://c32.radioboss.fm:8139/stream", format: "mp3" },

        ' --- 4. LOS ANGELES & NATIONAL NEWS (Stations 31 - 40) ---
        { name: "LAist 89.3 FM (KPCC LA News)", genre: "LA & National News", color: "0xE53935FF", url: "https://laist.streamguys1.com/kpcc-mp3?aw_0_1st.playerId=laist", format: "mp3" },
        { name: "KPCC 89.3 Southern California", genre: "LA & National News", color: "0xE53935FF", url: "https://playerservices.streamtheworld.com/api/livestream-redirect/KPCC_FM.mp3", format: "mp3" },
        { name: "KCRW 89.9 FM Los Angeles", genre: "LA & National News", color: "0xE53935FF", url: "https://streams.kcrw.com/kcrw_mp3?aw_0_1st.playerid=radio-browser.info", format: "mp3" },
        { name: "KFI AM 640 Los Angeles News", genre: "LA & National News", color: "0xE53935FF", url: "https://stream.revma.ihrhls.com/zc177", format: "mp3" },
        { name: "NPR 24 Hour News Stream", genre: "LA & National News", color: "0xE53935FF", url: "http://npr-ice.streamguys1.com/live.mp3", format: "mp3" },
        { name: "BBC World Service News", genre: "LA & National News", color: "0xE53935FF", url: "http://29312.live.streamtheworld.com:3690/WRVOHD3_SC", format: "mp3" },
        { name: "C-SPAN 90.1 Washington News", genre: "LA & National News", color: "0xE53935FF", url: "http://26183.live.streamtheworld.com:3690/CSPANRADIO_SC", format: "mp3" },
        { name: "MSNBC Live Audio", genre: "LA & National News", color: "0xE53935FF", url: "https://tunein.cdnstream1.com/3511_96.mp3", format: "mp3" },
        { name: "WHYY 90.9 Public Radio News", genre: "LA & National News", color: "0xE53935FF", url: "http://whyy.streamguys1.com/whyy-mp3", format: "mp3" },
        { name: "Minnesota Public Radio News", genre: "LA & National News", color: "0xE53935FF", url: "http://nis.stream.publicradio.org/nis.mp3", format: "mp3" },

        ' --- 5. SMOOTH JAZZ & LA JAZZ (Stations 41 - 50) ---
        { name: "101 Smooth Jazz", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://jking.cdnstream1.com/b22139_128mp3", format: "mp3" },
        { name: "KJAZZ 88.1 FM Los Angeles", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "https://streaming.kkjz.org/kkjz-128.mp3", format: "mp3" },
        { name: ".977 Smooth Jazz", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://29319.live.streamtheworld.com/977_SMOOJAZZ_SC", format: "mp3" },
        { name: "101 Smooth Jazz Mellow Mix", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://streaming.live365.com/b48071_128mp3", format: "mp3" },
        { name: "Smooth Jazz 24/7", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://jking.cdnstream1.com/b75154_128mp3", format: "mp3" },
        { name: "WWOZ 90.7 New Orleans Jazz", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "https://wwoz-sc.streamguys1.com/wwoz-hi.mp3", format: "mp3" },
        { name: "Jazz Radio Piano Jazz", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://jzr-piano.ice.infomaniak.ch/jzr-piano.mp3", format: "mp3" },
        { name: "Jazz Lounge FM", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://eu8.fastcast4u.com:5068/;", format: "mp3" },
        { name: "Jazz London Radio", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "http://radio.canstream.co.uk:8075/live.mp3", format: "mp3" },
        { name: "#1 Splash Jazz", genre: "Smooth Jazz & LA Jazz", color: "0x00897BFF", url: "https://ais-sa2.cdnstream1.com/2346_128.mp3", format: "mp3" },

        ' --- 6. BIG BAND, SWING & CROONERS (Stations 51 - 60) ---
        { name: "Exclusively Frank Sinatra", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "https://2.mystreaming.net/er/franksinatra/icecast.audio", format: "mp3" },
        { name: "Exclusively Nat King Cole", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "https://streaming.exclusive.radio/er/natkingcole/icecast.audio", format: "mp3" },
        { name: "1940s Radio Big Band", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "https://cast2.asurahosting.com/proxy/1940sradio/stream", format: "mp3" },
        { name: "Radio Art - Big Bands", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "http://air-tunein.radioart.com/fBig_bands.mp3", format: "mp3" },
        { name: "Big Blue Swing", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "http://radio.bigblueswing.com:8002/;64bit.mp3", format: "mp3" },
        { name: "Radio 1920s & 1930s Swing", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "http://stream.laut.fm/radio1920", format: "mp3" },
        { name: "Jazz Radio Swing", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "http://jazz-wr04.ice.infomaniak.ch/jazz-wr04-128.mp3", format: "mp3" },
        { name: "Megaton Cafe Lounge & Swing", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "http://us2.internet-radio.com:8443/stream", format: "mp3" },
        { name: "Conyers Old Time Radio", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "https://s8.yesstreaming.net:17011/stream", format: "mp3" },
        { name: "0N Jazz & Swing Classics", genre: "Big Band & Sinatra", color: "0xD81B60FF", url: "https://0n-jazz.radionetz.de/0n-jazz.mp3", format: "mp3" },

        ' --- 7. CLASSIC COUNTRY LEGENDS (Stations 61 - 70) ---
        { name: "181.FM Highway 181 Classic Country", genre: "Classic Country", color: "0x6D4C41FF", url: "http://listen.181fm.com/181-highway_128k.mp3", format: "mp3" },
        { name: "1.FM Classic Country Radio", genre: "Classic Country", color: "0x6D4C41FF", url: "http://strm112.1.fm/ccountry_mobile_mp3", format: "mp3" },
        { name: ".977 Country Hits", genre: "Classic Country", color: "0x6D4C41FF", url: "http://24293.live.streamtheworld.com:3690/977_COUNTRY_SC", format: "mp3" },
        { name: "181.FM Kickin' Country", genre: "Classic Country", color: "0x6D4C41FF", url: "http://listen.181fm.com/181-kickincountry_128k.mp3", format: "mp3" },
        { name: "181.FM 90s Country Classics", genre: "Classic Country", color: "0x6D4C41FF", url: "http://listen.181fm.com/181-90scountry_128k.mp3", format: "mp3" },
        { name: "Country 108", genre: "Classic Country", color: "0x6D4C41FF", url: "http://tuner.country108.com/;", format: "mp3" },
        { name: "Radio Country Live NY", genre: "Classic Country", color: "0x6D4C41FF", url: "https://streaming.radiostreamlive.com/radiocountrylive_devices", format: "mp3" },
        { name: "181.FM Front Porch Bluegrass", genre: "Classic Country", color: "0x6D4C41FF", url: "http://listen.181fm.com/181-bluegrass_128k.mp3", format: "mp3" },
        { name: "181.FM US 181 Country", genre: "Classic Country", color: "0x6D4C41FF", url: "http://listen.181fm.com/181-us181_128k.mp3", format: "mp3" },
        { name: "181.FM Real Country", genre: "Classic Country", color: "0x6D4C41FF", url: "http://listen.181fm.com/181-realcountry_128k.mp3", format: "mp3" },

        ' --- 8. CLASSIC MOTOWN & 60s SOUL (Stations 71 - 80) ---
        { name: "24/7 Motown Classics", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "http://stream.zeno.fm/49y7s0y32v8uv", format: "mp3" },
        { name: "Radio Motown Classics", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "https://broadcast.miami/proxy/motown?mp=/stream/;", format: "mp3" },
        { name: "SomaFM Seven Inch Soul", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "https://ice6.somafm.com/7soul-128-mp3", format: "mp3" },
        { name: "181.FM Classic Soul", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "https://listen.181fm.com/181-soul_128k.mp3", format: "mp3" },
        { name: "Jazz Radio Soul", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "http://jazz-wr10.ice.infomaniak.ch/jazz-wr10-128.mp3", format: "mp3" },
        { name: "TSOP The Sound of Philadelphia", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "http://54.36.165.156:8650/stream", format: "mp3" },
        { name: "181.FM Jammin 181 Old School", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "http://listen.181fm.com/181-jammin_128k.mp3", format: "mp3" },
        { name: "Slow Jams Classics", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "http://stream.radiojar.com/ypargqan2qzuv", format: "mp3" },
        { name: "SomaFM Fluid Soul & Groove", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "https://ice6.somafm.com/fluid-128-mp3", format: "mp3" },
        { name: "0N 60s Soul & Pop", genre: "Motown & Soul", color: "0x7B1FA2FF", url: "https://0n-60s.radionetz.de/0n-60s.mp3", format: "mp3" },

        ' --- 9. 70s SOFT ROCK & EASY LISTENING (Stations 81 - 90) ---
        { name: "SomaFM Left Coast 70s", genre: "70s & Easy Listening", color: "0x43A047FF", url: "https://ice2.somafm.com/seventies-320-mp3", format: "mp3" },
        { name: "181.FM Super 70s", genre: "70s & Easy Listening", color: "0x43A047FF", url: "https://listen.181fm.com/181-70s_128k.mp3", format: "mp3" },
        { name: "181.FM Lite 80s", genre: "70s & Easy Listening", color: "0x43A047FF", url: "http://listen.181fm.com/181-lite80s_128k.mp3", format: "mp3" },
        { name: "181.FM Lite 90s", genre: "70s & Easy Listening", color: "0x43A047FF", url: "http://listen.181fm.com/181-lite90s_128k.mp3", format: "mp3" },
        { name: "Light Favorites Easy 108", genre: "70s & Easy Listening", color: "0x43A047FF", url: "https://ais-sa2.cdnstream1.com/1299_128", format: "mp3" },
        { name: "Instrumentals Forever", genre: "70s & Easy Listening", color: "0x43A047FF", url: "http://quincy.torontocast.com:1910/stream", format: "mp3" },
        { name: "The Wave Relaxing Radio", genre: "70s & Easy Listening", color: "0x43A047FF", url: "http://stream.thewaveradio.de/wave-live/mp3-128/radio-browser.info/", format: "mp3" },
        { name: "0N 70s Classics", genre: "70s & Easy Listening", color: "0x43A047FF", url: "https://0n-70s.radionetz.de/0n-70s.mp3", format: "mp3" },
        { name: "My70sRadio Soft Hits", genre: "70s & Easy Listening", color: "0x43A047FF", url: "http://usa14.fastcast4u.com:5132/stream", format: "mp3" },
        { name: "181.FM The Breeze (Soft Pop)", genre: "70s & Easy Listening", color: "0x43A047FF", url: "http://listen.181fm.com/181-breeze_128k.mp3", format: "mp3" },

        ' --- 10. CHRISTMAS CLASSICS & HOLIDAY (Stations 91 - 100) ---
        { name: "181.FM Christmas Classics", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://listen.181fm.com/181-xtraditional_128k.mp3", format: "mp3" },
        { name: "Classical Christmas FM", genre: "Christmas & Holiday", color: "0xC62828FF", url: "https://christmasfm.cdnstream1.com/2550_128.mp3?aw_0_1st.playerid=esPlayer&aw_0_1st.skey=1605423292", format: "mp3" },
        { name: "1.FM Always Christmas Radio", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://strm112.1.fm/christmas_mobile_mp3", format: "mp3" },
        { name: "Sky Radio Christmas", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://playerservices.streamtheworld.com/api/livestream-redirect/SRGSTR08.mp3", format: "mp3" },
        { name: "Christmas Vinyl HD", genre: "Christmas & Holiday", color: "0xC62828FF", url: "https://icecast.walmradio.com:8443/christmas", format: "mp3" },
        { name: "181.FM Christmas Smooth Jazz", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://listen.181fm.com/181-xsmoothjazz_128k.mp3", format: "mp3" },
        { name: "181.FM Christmas Gospel", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://listen.181fm.com/181-xgospel_128k.mp3", format: "mp3" },
        { name: "181.FM Christmas Country", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://listen.181fm.com/181-xcountry_128k.mp3", format: "mp3" },
        { name: "1000 Christmas Hits", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://1000christmashits.stream.laut.fm/1000christmashits", format: "mp3" },
        { name: "Christmas Radio FM", genre: "Christmas & Holiday", color: "0xC62828FF", url: "http://xmasfm1.dmd2streaming.com/christmasradiofm-128.mp3", format: "mp3" }
    ]
end function

function getDefaultArtQueryForStation(stationName as String, genreName as String) as String
    sn = LCase(stationName)
    gn = LCase(genreName)
    if Instr(1, sn, "sinatra") > 0 then return "Frank Sinatra Ultimate Sinatra"
    if Instr(1, sn, "nat king cole") > 0 then return "Nat King Cole Unforgettable"
    if Instr(1, sn, "beatles") > 0 then return "The Beatles Abbey Road"
    if Instr(1, sn, "doo wop") > 0 then return "The Platters Only You"
    if Instr(1, sn, "piano") > 0 then return "Ludovico Einaudi Solo Piano"
    if Instr(1, sn, "air1") > 0 then return "Elevation Worship Graves Into Gardens"
    if Instr(1, sn, "gospel") > 0 then return "Alan Jackson Precious Memories"
    if Instr(1, sn, "k-love 80s") > 0 then return "Amy Grant Lead Me On"
    if Instr(1, sn, "k-love") > 0 then return "MercyMe I Can Only Imagine"
    if Instr(1, sn, "kusc") > 0 then return "Yo-Yo Ma Bach Cello"
    if Instr(1, sn, "wqxr") > 0 then return "Beethoven Symphony 9"
    if Instr(1, sn, "kcrw") > 0 then return "Miles Davis Kind of Blue"
    if Instr(1, sn, "kjazz") > 0 then return "John Coltrane Blue Train"
    if Instr(1, sn, "wwoz") > 0 then return "Louis Armstrong What a Wonderful World"
    if Instr(1, sn, "bluegrass") > 0 then return "Alison Krauss Now That I Found You"
    if Instr(1, sn, "90s country") > 0 then return "Alan Jackson Greatest Hits"
    if Instr(1, sn, "motown") > 0 then return "The Temptations My Girl"
    if Instr(1, sn, "philadelphia") > 0 then return "The Spinners Best Of"
    if Instr(1, sn, "80s") > 0 then return "Fleetwood Mac Rumours"
    if Instr(1, sn, "70s") > 0 then return "Carpenters Singles"
    if Instr(1, sn, "christmas smooth jazz") > 0 then return "Kenny G Miracles Holiday"
    if Instr(1, sn, "christmas country") > 0 then return "Dolly Parton Hard Candy Christmas"
    if Instr(1, sn, "classical christmas") > 0 then return "Tchaikovsky Nutcracker"
    if Instr(1, gn, "christian") > 0 then return "Lauren Daigle Look Up Child"
    if Instr(1, gn, "classical") > 0 then return "Mozart Requiem"
    if Instr(1, gn, "oldies") > 0 then return "Elvis Presley 30 Hits"
    if Instr(1, gn, "news") > 0 then return "Aaron Copland Fanfare"
    if Instr(1, gn, "jazz") > 0 then return "George Benson Breezin"
    if Instr(1, gn, "big band") > 0 then return "Glenn Miller In The Mood"
    if Instr(1, gn, "country") > 0 then return "Johnny Cash Folsom Prison"
    if Instr(1, gn, "motown") > 0 or Instr(1, gn, "soul") > 0 then return "Marvin Gaye Whats Going On"
    if Instr(1, gn, "70s") > 0 or Instr(1, gn, "easy") > 0 then return "James Taylor Greatest Hits"
    if Instr(1, gn, "christmas") > 0 then return "Bing Crosby White Christmas"
    return "Frank Sinatra Fly Me To The Moon"
end function

