sub init()
    m.top.functionName = "fetchStations"
end sub

sub fetchStations()
    tag = m.top.searchTag
    if tag = "" then tag = "smooth jazz"

    m.top.status = "loading"

    ' Primary and fallback Radio Browser API mirrors
    hosts = [
        "https://de1.api.radio-browser.info",
        "https://nl1.api.radio-browser.info",
        "https://at1.api.radio-browser.info"
    ]

    encodedTag = UrlEncode(tag)
    queryPath = "/json/stations/search?tag=" + encodedTag + "&codec=MP3&hidebroken=true&order=votes&reverse=true&limit=5"

    parsedStations = []

    for each host in hosts
        url = host + queryPath
        http = CreateObject("roUrlTransfer")
        port = CreateObject("roMessagePort")
        http.SetMessagePort(port)
        http.SetUrl(url)

        ' Enable HTTPS certificate verification on Roku OS
        http.SetCertificatesFile("common:/certs/ca-bundle.crt")
        http.InitClientCertificates()

        ' Custom User-Agent as requested by Radio Browser API documentation
        http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/1.0 (GrandparentEdition)")
        http.AddHeader("Accept", "application/json")

        if http.AsyncGetToString()
            msg = wait(8000, port)
            if type(msg) = "roUrlEvent"
                responseCode = msg.GetResponseCode()
                if responseCode = 200
                    body = msg.GetString()
                    jsonArray = ParseJson(body)
                    if type(jsonArray) = "roArray" and jsonArray.Count() > 0
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

                                if streamUrl <> ""
                                    parsedStations.Push({
                                        name: stationName,
                                        url: streamUrl
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

        if parsedStations.Count() > 0 then exit for
    end for

    if parsedStations.Count() > 0
        m.top.stations = parsedStations
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
