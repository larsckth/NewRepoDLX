# 05 API: Get

Invoke-RestMethod "https://jsonplaceholder.typicode.com/posts"

Invoke-RestMethod "https://jsonplaceholder.typicode.com/posts/21"

Invoke-WebRequest "https://jsonplaceholder.typicode.com/posts/21"

# Maybe...? 
$Endpoint = 'https://jsonplaceholder.typicode.com'

Invoke-RestMethod "$Endpoint/posts"

Invoke-RestMethod "$Endpoint/posts/21"

Invoke-WebRequest "$Endpoint/posts/21"

# 05 API: Post

$JsonStuff = @{
    title = 'post'
    body = 'text'
    userId = 1
} | ConvertTo-Json

Invoke-RestMethod -Method Post -ContentType 'application/json' -Body $JsonStuff -Uri 'https://jsonplaceholder.typicode.com/posts'

# 05 API: XML

#  https://www.w3schools.com/xml/cd_catalog.xml

function Select-CDInfoAsJson {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        $CD
    )

    process {
        Write-Output $CD | Select-Object TITLE,ARTIST | ConvertTo-Json
    }
}

$CDs.CATALOG.CD | Select-CDInfoAsJson
