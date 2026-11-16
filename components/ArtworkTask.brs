sub init()
    m.top.functionName = "runArtworkSearch"
end sub

sub runArtworkSearch()
    queries = []
    q1 = cleanQuery(m.top.query)
    q2 = cleanQuery(m.top.fallbackQuery)
    if q1 <> "" then queries.Push(q1)
    if q2 <> "" and q2 <> q1 then queries.Push(q2)

    for each q in queries
        art = searchItunes(q)
        if art <> ""
            m.top.artworkUrl = art
            return
        end if
    end for
end sub

function searchItunes(q as String) as String
    entities = ["song", "album"]
    for each entity in entities
        url = "https://itunes.apple.com/search?term=" + urlEnc(q) + "&media=music&entity=" + entity + "&limit=1"
        http = CreateObject("roUrlTransfer")
        port = CreateObject("roMessagePort")
        http.SetMessagePort(port)
        http.SetUrl(url)
        http.SetCertificatesFile("common:/certs/ca-bundle.crt")
        http.InitClientCertificates()
        http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/3.1")
        http.AddHeader("Accept", "application/json")
        if http.AsyncGetToString()
            msg = wait(5000, port)
            if type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200
                json = ParseJson(msg.GetString())
                if type(json) = "roAssociativeArray" and json.DoesExist("results") and type(json.results) = "roArray" and json.results.Count() > 0
                    first = json.results[0]
                    if type(first) = "roAssociativeArray" and first.DoesExist("artworkUrl100") and first.artworkUrl100 <> invalid
                        rawArt = first.artworkUrl100
                        if type(rawArt) = "roString" or type(rawArt) = "String"
                            return rawArt.Replace("100x100bb", "400x400bb")
                        end if
                    end if
                end if
            else
                http.AsyncCancel()
            end if
        end if
    end for
    return ""
end function

function cleanQuery(raw as String) as String
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
    if Len(out) > 60 then out = Left(out, 60)
    return out
end function

function urlEnc(s as String) as String
    xfer = CreateObject("roUrlTransfer")
    return xfer.Escape(s)
end function
