sub init()
    m.top.functionName = "runArtworkSearch"
end sub

sub runArtworkSearch()
    rawQuery = ""
    if m.top.query <> invalid then rawQuery = m.top.query.Trim()

    ' If no song query was provided by Roku <Audio>, poll live ICY StreamTitle from http:// stream
    if rawQuery = "" and m.top.streamUrl <> invalid and m.top.streamUrl <> ""
        icyTitle = fetchIcySongTitle(m.top.streamUrl)
        if icyTitle <> ""
            rawQuery = icyTitle
            m.top.songTitle = icyTitle
        end if
    end if

    if rawQuery = "" and m.top.fallbackQuery <> invalid
        rawQuery = m.top.fallbackQuery.Trim()
    end if
    if rawQuery = "" then return

    queries = buildSearchQueries(rawQuery, m.top.fallbackQuery)
    for each q in queries
        art = searchItunes(q)
        if art <> ""
            m.top.artworkUrl = art
            return
        end if
    end for
end sub

function buildSearchQueries(rawQuery as String, fallbackRaw as Dynamic) as Object
    queries = []
    seen = {}

    stripped = stripBrackets(rawQuery)
    dashIdx = Instr(1, stripped, " - ")
    if dashIdx > 0
        artistPart = cleanQuery(Left(stripped, dashIdx - 1))
        songPart = cleanQuery(Mid(stripped, dashIdx + 3))
        if artistPart <> "" and songPart <> ""
            addUniqueQuery(queries, seen, artistPart + " " + songPart)
            addUniqueQuery(queries, seen, songPart + " " + artistPart)
            addUniqueQuery(queries, seen, songPart)
            addUniqueQuery(queries, seen, artistPart)
        end if
    end if

    addUniqueQuery(queries, seen, cleanQuery(stripped))
    addUniqueQuery(queries, seen, cleanQuery(rawQuery))

    if fallbackRaw <> invalid
        addUniqueQuery(queries, seen, cleanQuery(fallbackRaw))
    end if
    return queries
end function

sub addUniqueQuery(listObj as Object, seenObj as Object, q as String)
    if q = "" or Len(q) < 2 then return
    k = LCase(q)
    if not seenObj.DoesExist(k)
        seenObj[k] = true
        listObj.Push(q)
    end if
end sub

function searchItunes(q as String) as String
    entities = ["song", "album"]
    for each entity in entities
        url = "https://itunes.apple.com/search?term=" + urlEnc(q) + "&media=music&entity=" + entity + "&limit=1&country=US"
        http = CreateObject("roUrlTransfer")
        port = CreateObject("roMessagePort")
        http.SetMessagePort(port)
        http.SetUrl(url)
        http.SetCertificatesFile("common:/certs/ca-bundle.crt")
        http.InitClientCertificates()
        http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/3.2")
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

function fetchIcySongTitle(streamUrl as String) as String
    if Left(LCase(streamUrl), 7) <> "http://" then return ""

    rest = Mid(streamUrl, 8)
    slashIdx = Instr(1, rest, "/")
    hostPort = rest
    path = "/"
    if slashIdx > 0
        hostPort = Left(rest, slashIdx - 1)
        path = Mid(rest, slashIdx)
    end if

    host = hostPort
    portNum = 80
    colonIdx = Instr(1, hostPort, ":")
    if colonIdx > 0
        host = Left(hostPort, colonIdx - 1)
        portStr = Mid(hostPort, colonIdx + 1)
        parsedPort = Val(portStr)
        if parsedPort > 0 then portNum = Int(parsedPort)
    end if
    if host = "" then return ""

    sock = CreateObject("roStreamSocket")
    addr = CreateObject("roSocketAddress")
    addr.SetHostName(host)
    addr.SetPort(portNum)
    sock.SetSendToAddress(addr)
    if not sock.Connect() then return ""

    crlf = Chr(13) + Chr(10)
    req = "GET " + path + " HTTP/1.0" + crlf
    req = req + "Host: " + hostPort + crlf
    req = req + "Icy-MetaData: 1" + crlf
    req = req + "User-Agent: VLC/3.0" + crlf
    req = req + "Connection: close" + crlf + crlf
    sock.SendStr(req)

    timer = CreateObject("roTimespan")
    allBytes = CreateObject("roByteArray")
    chunk = CreateObject("roByteArray")
    chunk[4095] = 0
    headerEnd = -1
    metaint = 0

    while timer.TotalMilliseconds() < 2800
        if sock.IsReadable()
            n = sock.Receive(chunk, 0, 4096)
            if n <= 0 then exit while
            for i = 0 to n - 1
                allBytes.Push(chunk[i])
            end for

            if headerEnd < 0 and allBytes.Count() >= 4
                headerStr = allBytes.ToAsciiString()
                hEnd = Instr(1, headerStr, crlf + crlf)
                if hEnd > 0
                    headerEnd = hEnd + 3
                    metaint = parseIcyMetaInt(Left(headerStr, hEnd))
                    if metaint <= 0 then exit while
                end if
            end if

            if headerEnd > 0 and metaint > 0
                needed = headerEnd + metaint + 1
                if allBytes.Count() >= needed
                    metaLenByte = allBytes[headerEnd + metaint]
                    metaLen = metaLenByte * 16
                    if metaLen = 0 then exit while
                    if allBytes.Count() >= needed + metaLen
                        metaSlice = CreateObject("roByteArray")
                        for i = 0 to metaLen - 1
                            metaSlice.Push(allBytes[needed + i])
                        end for
                        sock.Close()
                        return parseStreamTitle(metaSlice.ToAsciiString())
                    end if
                end if
            end if
        else
            sleep(30)
        end if
    end while

    sock.Close()
    return ""
end function

function parseIcyMetaInt(headers as String) as Integer
    lines = headers.Split(Chr(10))
    for each line in lines
        lowerLine = LCase(line.Trim())
        if Left(lowerLine, 12) = "icy-metaint:"
            valStr = Mid(lowerLine, 13).Trim()
            return Int(Val(valStr))
        end if
    end for
    return 0
end function

function parseStreamTitle(metaStr as String) as String
    marker = "StreamTitle='"
    startIdx = Instr(1, metaStr, marker)
    if startIdx = 0 then return ""
    rest = Mid(metaStr, startIdx + Len(marker))
    endIdx = Instr(1, rest, "';")
    if endIdx = 0 then endIdx = Instr(1, rest, "'")
    if endIdx > 1
        title = Left(rest, endIdx - 1).Trim()
        low = LCase(title)
        if title <> "" and title <> "-" and title <> " - " and Instr(1, low, "commercial") = 0 and Instr(1, low, "promo") = 0
            return title
        end if
    end if
    return ""
end function

function stripBrackets(raw as String) as String
    out = ""
    depthParen = 0
    depthBracket = 0
    for i = 1 to Len(raw)
        ch = Mid(raw, i, 1)
        if ch = "("
            depthParen = depthParen + 1
        else if ch = ")" and depthParen > 0
            depthParen = depthParen - 1
        else if ch = "["
            depthBracket = depthBracket + 1
        else if ch = "]" and depthBracket > 0
            depthBracket = depthBracket - 1
        else if depthParen = 0 and depthBracket = 0
            out = out + ch
        end if
    end for
    return out.Trim()
end function

function cleanQuery(raw as String) as String
    if raw = invalid then return ""
    out = ""
    prevSpace = false
    for i = 1 to Len(raw)
        ch = Mid(raw, i, 1)
        c = Asc(ch)
        if (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122)
            out = out + ch
            prevSpace = false
        else if not prevSpace and out <> ""
            out = out + " "
            prevSpace = true
        end if
    end for
    out = out.Trim()
    if Len(out) > 64 then out = Left(out, 64)
    return out
end function

function urlEnc(s as String) as String
    xfer = CreateObject("roUrlTransfer")
    return xfer.Escape(s)
end function
