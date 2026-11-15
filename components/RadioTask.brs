sub init()
    m.top.functionName = "fetchStations"
end sub

sub fetchStations()
    m.top.status = "loading"

    combinedStations = []
    seenUrls = {}

    ' 1. First add curated flagship stations (e.g. 100.3 K-LOVE LA, Classical KUSC 91.5, LA News)
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

    ' 2. Query Radio Browser API mirrors for additional live stations in this genre
    hosts = [
        "https://de1.api.radio-browser.info",
        "https://nl1.api.radio-browser.info",
        "https://at1.api.radio-browser.info"
    ]

    searchName = m.top.searchName
    searchTag = m.top.searchTag
    if searchTag = "" then searchTag = "oldies"

    queries = []
    if searchName <> ""
        queries.Push("/json/stations/search?name=" + UrlEncode(searchName) + "&hidebroken=true&order=votes&reverse=true&limit=5")
    end if
    queries.Push("/json/stations/search?tag=" + UrlEncode(searchTag) + "&codec=MP3&hidebroken=true&order=votes&reverse=true&limit=8")

    for each queryPath in queries
        fetchedFromMirror = false
        for each host in hosts
            url = host + queryPath
            http = CreateObject("roUrlTransfer")
            port = CreateObject("roMessagePort")
            http.SetMessagePort(port)
            http.SetUrl(url)

            ' Enable HTTPS certificate verification on Roku OS
            http.SetCertificatesFile("common:/certs/ca-bundle.crt")
            http.InitClientCertificates()

            ' Custom User-Agent as requested by Radio Browser API docs
            http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/2.0 (GrandparentEdition)")
            http.AddHeader("Accept", "application/json")

            if http.AsyncGetToString()
                msg = wait(6000, port)
                if type(msg) = "roUrlEvent"
                    if msg.GetResponseCode() = 200
                        jsonArray = ParseJson(msg.GetString())
                        if type(jsonArray) = "roArray" and jsonArray.Count() > 0
                            fetchedFromMirror = true
                            for each item in jsonArray
                                if type(item) = "roAssociativeArray"
                                    streamUrl = ""
                                    if item.DoesExist("url_resolved") and item.url_resolved <> invalid and item.url_resolved <> ""
                                        streamUrl = item.url_resolved
                                    else if item.DoesExist("url") and item.url <> invalid and item.url <> ""
                                        streamUrl = item.url
                                    end if

                                    stationName = "Live Radio"
                                    if item.DoesExist("name") and item.name <> invalid and item.name.Trim() <> ""
                                        stationName = item.name.Trim()
                                    end if

                                    codec = "mp3"
                                    if item.DoesExist("codec") and item.codec <> invalid
                                        lowerCodec = LCase(item.codec)
                                        if Instr(1, lowerCodec, "aac") > 0
                                            codec = "aac"
                                        else if Instr(1, lowerCodec, "hls") > 0 or Right(LCase(streamUrl), 5) = ".m3u8"
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
                        end if
                    end if
                else
                    http.AsyncCancel()
                end if
            end if

            if fetchedFromMirror then exit for
        end for
    end for

    if combinedStations.Count() > 0
        m.top.stations = combinedStations
        m.top.status = "ready"
    else
        m.top.stations = []
        m.top.status = "error"
    end if
end sub

function UrlEncode(str as String) as String
    xfer = CreateObject("roUrlTransfer")
    return xfer.Escape(str)
end function
