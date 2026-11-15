sub init()
    m.top.functionName = "fetchStations"
end sub

sub fetchStations()
    m.top.status = "loading"
    combinedStations = []
    seenUrls = {}
    curated = m.top.curatedStations
    if type(curated) = "roArray"
        for each item in curated
            if type(item) = "roAssociativeArray" and item.DoesExist("url") and item.url <> ""
                fmt = "mp3"
                if item.DoesExist("format") and item.format <> "" then fmt = item.format
                combinedStations.Push({ name: item.name, url: item.url, format: fmt })
                seenUrls[item.url] = true
            end if
        end for
    end if

    hosts = ["https://de1.api.radio-browser.info", "https://nl1.api.radio-browser.info", "https://at1.api.radio-browser.info"]
    searchName = m.top.searchName
    searchTag = m.top.searchTag
    if searchTag = "" then searchTag = "oldies"
    queries = []
    if searchName <> "" then queries.Push("/json/stations/search?name=" + UrlEncode(searchName) + "&hidebroken=true&order=votes&reverse=true&limit=5")
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
                            if item.DoesExist("name") and item.name <> invalid and item.name.Trim() <> "" then stationName = item.name.Trim()
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
                                combinedStations.Push({ name: stationName, url: streamUrl, format: codec })
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
    q = cleanArtworkQuery(m.top.artworkQuery)
    if q = "" then return
    for each entity in ["song", "album"]
        url = "https://itunes.apple.com/search?term=" + UrlEncode(q) + "&media=music&entity=" + entity + "&limit=1"
        body = httpGet(url, 4500)
        if body <> ""
            json = ParseJson(body)
            if type(json) = "roAssociativeArray" and type(json.results) = "roArray" and json.results.Count() > 0
                first = json.results[0]
                if type(first) = "roAssociativeArray" and first.DoesExist("artworkUrl100") and first.artworkUrl100 <> invalid
                    m.top.artworkUrl = first.artworkUrl100.ToStr().Replace("100x100bb", "400x400bb")
                    return
                end if
            end if
        end if
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
        if type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200 then return msg.GetString()
        http.AsyncCancel()
    end if
    return ""
end function

function cleanArtworkQuery(raw as String) as String
    if raw = invalid then return ""
    s = raw.Replace("—", " ").Replace("-", " ").Replace("|", " ").Replace("(", " ").Replace(")", " ").Replace("[", " ").Replace("]", " ").Trim()
    if Len(s) > 65 then s = Left(s, 65)
    return s
end function

function UrlEncode(str as String) as String
    return CreateObject("roUrlTransfer").Escape(str)
end function
