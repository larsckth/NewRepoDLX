# My version of the MyFunctions run

function GetUserData {
    $MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
    $MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
    $MyUserList
}


function Get-CourseUser {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Name,
        
        [Parameter()]
        [int]$OlderThan = "65"
    )

    $Result = GetUserData

    if (-not [string]::IsNullOrEmpty($Name)) {
        $Result = $Result | Where-Object -Property Name -Like "*$Name*"
    }
    
    if ($OlderThan) {
        $Result = $Result | Where-Object -Property Age -ge $OlderThan
    }

    $Result
}

function Add-CourseUser {
    [CmdletBinding()]
    param (
        $DatabaseFile = "MyLabFile.csv",

        [Parameter(Mandatory,HelpMessage="Go, Girl!")]
        [string]$Name,
        
        [Parameter(Mandatory)]
        [int]$Age,

        [Parameter(Mandatory)]
        [ValidateSet('red','green','blue','yellow')]
        [String]$Color,

        $UserID = (Get-Random -Minimum 8 -Maximum 1000)
        )

$NewUser = "$Name, $Age" -f $Color, $UserID
$NewCSv = Get-Content $DatabaseFile -Raw
$NewCSv += $NewUser

Set-Content -Value $NewCSv -Path $DatabaseFile
}


function Remove-CourseUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param (
        $DatabaseFile = "MyLabFile.csv"
    )

    $MyUserList = Get-Content -Path $DatabaseFile | ConvertFrom-Csv
    $RemoveUser = $MyUserList | Out-ConsoleGridView -OutputMode Single
        
    if ($PSCmdlet.ShouldProcess([string]$RemoveUser.Name)) {
        $MyUserList = $MyUserList | Where-Object {
            -not (
                $_.Name -eq $RemoveUser.Name -and
                $_.Age -eq $RemoveUser.Age -and
                $_.Color -eq $RemoveUser.Color -and
                $_.Id -eq $RemoveUser.Id
            )
        }
        Set-Content -Value $($MyUserList | ConvertTo-Csv -notypeInformation) -Path $MyUserListFile -WhatIf
    }
    else {
        Write-Output "Did not remove user $($RemoveUser.Name)"
    }
}