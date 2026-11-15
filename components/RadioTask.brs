sub init()
    m.top.functionName = "fetchStations"
end sub

sub fetchStations()
    if m.top.artworkQuery <> ""
        fetchArtwork()
        return
    end if

    m.top.status = "loading"
    combinedStations = []
    seenUrls = {}
    curated = m.top.curatedStations
    if type(curated) = "roArray"
        for each item in curated
            if type(item) = "roAssociativeArray" and item.DoesExist("url") and item.url <> ""
                fmt = "mp3"
                if item.DoesExist("format") and item.format <> ""
                    fmt = item.format
                end if
                combinedStations.Push({
                    name: item.name,
                    url: item.url,
                    format: fmt
                })
                seenUrls[item.url] = true
            end if
        end for
    end if

    hosts = [
        "https://de1.api.radio-browser.info",
        "https://nl1.api.radio-browser.info",
        "https://at1.api.radio-browser.info"
    ]
    searchName = m.top.searchName
    searchTag = m.top.searchTag
    if searchTag = ""
        searchTag = "oldies"
    end if
    queries = []
    if searchName <> ""
        queries.Push("/json/stations/search?name=" + UrlEncode(searchName) + "&hidebroken=true&order=votes&reverse=true&limit=5")
    end if
    queries.Push("/json/stations/search?tag=" + UrlEncode(searchTag) + "&codec=MP3&hidebroken=true&order=votes&reverse=true&limit=8")

    for each queryPath in queries
        for each host in hosts
            body = httpGet(host + queryPath, 5500)
            if body <> ""
                jsonArray = ParseJson(body)
                if type(jsonArray) = "roArray" and jsonArray.Count() > 0
                    for each item in jsonArray
                        if type(item) = "roAssociativeArray"
                            streamUrl = ""
                            if item.DoesExist("url_resolved") and item.url_resolved <> invalid and item.url_resolved <> ""
                                streamUrl = item.url_resolved
                            else if item.DoesExist("url") and item.url <> invalid
                                streamUrl = item.url
                            end if
                            stationName = "Live Radio"
                            if item.DoesExist("name") and item.name <> invalid and item.name.Trim() <> ""
                                stationName = item.name.Trim()
                            end if
                            codec = "mp3"
                            if item.DoesExist("codec") and item.codec <> invalid
                                lc = LCase(item.codec)
                                if Instr(1, lc, "aac") > 0
                                    codec = "aac"
                                else if Instr(1, lc, "hls") > 0 or Right(LCase(streamUrl), 5) = ".m3u8"
                                    codec = "hls"
                                end if
                            end if
                            if streamUrl <> "" and not seenUrls.DoesExist(streamUrl)
                                seenUrls[streamUrl] = true
                                combinedStations.Push({
                                    name: stationName,
                                    url: streamUrl,
                                    format: codec
                                })
                            end if
                        end if
                    end for
                    exit for
                end if
            end if
        end for
    end for

    m.top.stations = combinedStations
    if combinedStations.Count() > 0
        m.top.status = "ready"
    else
        m.top.status = "error"
    end if
end sub

sub fetchArtwork()
    queries = []
    q1 = cleanArtworkQuery(m.top.artworkQuery)
    q2 = cleanArtworkQuery(m.top.fallbackArtQuery)
    if q1 <> "" then queries.Push(q1)
    if q2 <> "" and q2 <> q1 then queries.Push(q2)

    for each q in queries
        entities = ["song", "album"]
        for each entity in entities
            url = "https://itunes.apple.com/search?term=" + UrlEncode(q) + "&media=music&entity=" + entity + "&limit=1"
            body = httpGet(url, 4500)
            if body <> ""
                json = ParseJson(body)
                if type(json) = "roAssociativeArray" and json.DoesExist("results") and type(json.results) = "roArray" and json.results.Count() > 0
                    first = json.results[0]
                    if type(first) = "roAssociativeArray" and first.DoesExist("artworkUrl100") and first.artworkUrl100 <> invalid
                        rawArt = first.artworkUrl100
                        if type(rawArt) = "roString" or type(rawArt) = "String"
                            m.top.artworkUrl = rawArt.Replace("100x100bb", "400x400bb")
                            return
                        end if
                    end if
                end if
            end if
        end for
    end for
end sub

function httpGet(url as String, timeoutMs as Integer) as String
    http = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    http.SetMessagePort(port)
    http.SetUrl(url)
    http.SetCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/3.0 (GrandparentEdition)")
    http.AddHeader("Accept", "application/json")
    if http.AsyncGetToString()
        msg = wait(timeoutMs, port)
        if type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200
            return msg.GetString()
        end if
        http.AsyncCancel()
    end if
    return ""
end function

function cleanArtworkQuery(raw as String) as String
    if raw = invalid then return ""
    out = ""
    for i = 1 to Len(raw)
        ch = Mid(raw, i, 1)
        c = Asc(ch)
        if (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122) or c = 32
            out = out + ch
        else
            out = out + " "
        end if
    end for
    out = out.Trim()
    if Len(out) > 60
        out = Left(out, 60)
    end if
    return out
end function

function UrlEncode(str as String) as String
    xfer = CreateObject("roUrlTransfer")
    return xfer.Escape(str)
end function
