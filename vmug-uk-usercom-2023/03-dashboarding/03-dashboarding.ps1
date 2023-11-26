#Acquire Authentication Token
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/auth/token/acquire"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
    }
    "Method"  = "POST"
    "body"    = @{
        username   = "<samaccount@domian>"
        authSource = "vIDMAuthSource"
        password   = "<password>"
    } | ConvertTo-JSON -Depth 6
}
Invoke-RestMethod @Splat -SkipCertificateCheck | Select-Object -expandproperty token

#Export Content
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/content/operations/export"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
        Authorization  = "vRealizeOpsToken 0bd65cc3-2561-48a6-9c2c-7aac9b3e6af5::a8f3bd7e-0d32-4ccc-8718-3cf0af8546b7"
    }
    "Method"  = "POST"
    "body"    = @{
        scope        = "ALL"
        contentTypes = "DASHBOARDS", "CUSTOM_GROUPS", "SUPER_METRICS"
    } | ConvertTo-JSON -Depth 6
}
Invoke-RestMethod @Splat -SkipCertificateCheck

#Download Content
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/content/operations/export/zip"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
        Authorization  = "vRealizeOpsToken 0bd65cc3-2561-48a6-9c2c-7aac9b3e6af5::a8f3bd7e-0d32-4ccc-8718-3cf0af8546b7"
    }
    "Method"  = "GET"
}
Invoke-RestMethod @Splat -SkipCertificateCheck -OutFile "content.zip"

#Import Content
$File = @{
    contentFile = Get-Item -Path "C:\Users\Administrator\content.zip"
}
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/content/operations/import"
    "Headers" = @{
        'Content-Type' = "multipart/form-data"
        'Accept'       = "*/*"
        Authorization  = "vRealizeOpsToken 0bd65cc3-2561-48a6-9c2c-7aac9b3e6af5::2137fc50-23c7-44da-b67c-5d6bfb1384ea"
    }
    "Method"  = "POST"
}
Invoke-RestMethod @Splat -SkipCertificateCheck -Form $File