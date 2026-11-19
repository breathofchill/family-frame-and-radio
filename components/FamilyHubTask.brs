sub init()
    m.top.functionName = "runFamilyHubSync"
end sub

sub runFamilyHubSync()
    runMode = m.top.mode
    if runMode = "" then runMode = "all"

    if runMode = "all" or runMode = "verse"
        fetchBibleVerse()
    end if

    if runMode = "all" or runMode = "messages"
        fetchIncomingMessage()
    end if

    if runMode = "all" or runMode = "contacts"
        fetchEmergencyContacts()
    end if

    if runMode = "all" or runMode = "trivia"
        fetchTriviaCards()
    end if

    m.top.status = "ready"
end sub

sub fetchTriviaCards()
    raw = httpGetJson("https://raw.githubusercontent.com/breathofchill/family-frame-and-radio/main/family_trivia.json", 4000)
    if raw <> invalid
        parsed = ParseJson(raw)
        if type(parsed) = "roAssociativeArray" and parsed.DoesExist("cards") and type(parsed.cards) = "roArray" and parsed.cards.Count() > 0
            m.top.triviaCards = parsed.cards
        end if
    end if
end sub

function httpGetJson(url as String, timeoutMs = 5000 as Integer) as Dynamic
    http = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    http.SetMessagePort(port)
    http.SetUrl(url)
    http.SetCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/5.0")
    http.AddHeader("Accept", "application/json")
    if http.AsyncGetToString()
        msg = wait(timeoutMs, port)
        if type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200
            return msg.GetString()
        else
            http.AsyncCancel()
        end if
    end if
    return invalid
end function

sub fetchBibleVerse()
    raw = httpGetJson("https://beta.ourmanna.com/api/v1/get?format=json&order=daily", 4500)
    if raw <> invalid
        json = ParseJson(raw)
        if type(json) = "roAssociativeArray" and json.DoesExist("verse") and type(json.verse) = "roAssociativeArray"
            vObj = json.verse
            if vObj.DoesExist("details") and type(vObj.details) = "roAssociativeArray"
                det = vObj.details
                if det.DoesExist("text") and det.DoesExist("reference")
                    m.top.verseText = det.text.Trim()
                    m.top.verseRef = det.reference.Trim()
                    return
                end if
            end if
        end if
    end if

    ' Curated rotating daily fallback verses if offline
    dt = CreateObject("roDateTime")
    dt.ToLocalTime()
    dayIdx = dt.GetDayOfMonth()
    fallbacks = [
        { t: "The Lord is my shepherd; I shall not want.", r: "Psalm 23:1" },
        { t: "This is the day that the Lord has made; let us rejoice and be glad in it.", r: "Psalm 118:24" },
        { t: "Give thanks to the Lord, for he is good; his love endures forever.", r: "Psalm 107:1" },
        { t: "I can do all things through Christ who strengthens me.", r: "Philippians 4:13" },
        { t: "Be strong and courageous. Do not be afraid, for the Lord your God goes with you.", r: "Deuteronomy 31:6" },
        { t: "Trust in the Lord with all your heart and lean not on your own understanding.", r: "Proverbs 3:5" },
        { t: "The joy of the Lord is your strength.", r: "Nehemiah 8:10" }
    ]
    pick = fallbacks[dayIdx mod fallbacks.Count()]
    m.top.verseText = pick.t
    m.top.verseRef = pick.r
end sub

sub fetchIncomingMessage()
    ' Check live instant push channel first (ntfy.sh JSON lines - works from WhatsApp/Phone Shortcuts!)
    rawNtfy = httpGetJson("https://ntfy.sh/whitehead-family-tv-msg/json?poll=1&since=6h", 4000)
    if rawNtfy <> invalid and rawNtfy.Trim() <> ""
        lines = rawNtfy.Split(Chr(10))
        latestObj = invalid
        for each ln in lines
            tr = ln.Trim()
            if tr <> ""
                parsed = ParseJson(tr)
                if type(parsed) = "roAssociativeArray" and parsed.DoesExist("event") and parsed.event = "message"
                    latestObj = parsed
                end if
            end if
        end for
        if latestObj <> invalid and latestObj.DoesExist("message")
            msgBody = latestObj.message.Trim()
            msgTitle = "Family Message"
            if latestObj.DoesExist("title") and latestObj.title <> invalid and latestObj.title <> ""
                msgTitle = latestObj.title.Trim()
            end if
            msgIdVal = ""
            if latestObj.DoesExist("id") and latestObj.id <> invalid then msgIdVal = latestObj.id.ToStr()
            if msgBody <> "" and msgIdVal <> ""
                m.top.msgId = "ntfy-" + msgIdVal
                m.top.msgSender = msgTitle
                m.top.msgText = msgBody
                return
            end if
        end if
    end if

    ' Fallback to GitHub family_message.json
    rawGh = httpGetJson("https://raw.githubusercontent.com/breathofchill/family-frame-and-radio/main/family_message.json", 4000)
    if rawGh <> invalid
        ghJson = ParseJson(rawGh)
        if type(ghJson) = "roAssociativeArray" and ghJson.DoesExist("id") and ghJson.DoesExist("message")
            m.top.msgId = ghJson.id.ToStr()
            if ghJson.DoesExist("sender") then m.top.msgSender = ghJson.sender
            m.top.msgText = ghJson.message
        end if
    end if
end sub

sub fetchEmergencyContacts()
    raw = httpGetJson("https://raw.githubusercontent.com/breathofchill/family-frame-and-radio/main/family_contacts.json", 4000)
    if raw <> invalid
        parsed = ParseJson(raw)
        if type(parsed) = "roAssociativeArray"
            m.top.contacts = parsed
            return
        end if
    end if
    m.top.contacts = {
        homeAddress: "Update family_contacts.json on GitHub",
        primaryContactName: "Family Member (Primary)",
        primaryContactPhone: "(310) 555-0100",
        secondaryContactName: "Family Member (Backup)",
        secondaryContactPhone: "(310) 555-0101",
        doctorName: "Primary Care Doctor",
        doctorPhone: "(310) 555-0102",
        pharmacyName: "Local Pharmacy",
        pharmacyPhone: "(310) 555-0103",
        notes: "For life-threatening emergencies, always dial 911 immediately."
    }
end sub
