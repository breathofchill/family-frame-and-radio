sub init()
    m.top.functionName = "fetchCloudPhotos"
end sub

sub fetchCloudPhotos()
    apiUrl = m.top.repoApiUrl
    if apiUrl = invalid or apiUrl = ""
        m.top.status = "error"
        return
    end if

    http = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    http.SetMessagePort(port)
    http.SetUrl(apiUrl)
    http.SetCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.AddHeader("User-Agent", "FamilyFrameAndRadioRoku/4.1")
    http.AddHeader("Accept", "application/vnd.github.v3+json")

    urls = []
    if http.AsyncGetToString()
        msg = wait(8000, port)
        if type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200
            items = ParseJson(msg.GetString())
            if type(items) = "roArray"
                sortable = []
                for each item in items
                    if type(item) = "roAssociativeArray" and item.DoesExist("name") and item.DoesExist("download_url")
                        fname = item.name
                        dl = item.download_url
                        if type(fname) = "roString" and type(dl) = "roString" and dl <> ""
                            ln = LCase(fname)
                            if Left(ln, 8) <> "channel_" and Left(ln, 7) <> "splash_" and (Right(ln, 4) = ".jpg" or Right(ln, 5) = ".jpeg" or Right(ln, 4) = ".png")
                                sortable.Push({ name: ln, url: dl })
                            end if
                        end if
                    end if
                end for
                sortable.SortBy("name")
                for each entry in sortable
                    urls.Push(entry.url)
                end for
            end if
        else
            http.AsyncCancel()
        end if
    end if

    m.top.photoUrls = urls
    if urls.Count() > 0
        m.top.status = "ready"
    else
        m.top.status = "empty"
    end if
end sub
