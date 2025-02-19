
enum ColorEnum {
    red
    green
    blue
    yellow
}

class User {
    [string] $Name
    [int] $Age
    [ColorEnum] $Color 
#    [int] $Id
    [int] $UserID
    
    User([String]$Name, [int]$Age, [ColorEnum]$Color, [int]$UserId) {
        $This.Name = $Name
        $This.Age = $Age
        $This.Color = $Color
        $This.Id = $UserId
     #   $This.Id = $Id
        $This.Id = $UserId
    }

    [string] ToString() {
        Return '{0},{1},{2},{3}' -f $This.Name, $This.Age, $This.Color, $This.Id
    }

}
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
        [int]$OlderThan
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
    Param (
        $DatabaseFile = "$PSScriptRoot\MyLabFile.csv",

        [Parameter(Mandatory)]
        [ValidatePattern({'^[A-Z][\w\-\s]*$'}, ErrorMessage = 'Name needs to be in a correct format, lead-in capital letter, no numbers or spaces')]
        [string]$Name,

        [Parameter(Mandatory)]
        [Int]$Age,

    #    [Parameter(Mandatory)]
    #    [ValidateSet('red', 'green', 'blue', 'yellow')]
    #    [string]$Color,

        [Parameter(Mandatory)]
        [ColorEnum]$Color,

        $UserID = (Get-Random -Minimum 10 -Maximum 100000)
    )
    # $MyCsvUser = "$Name,$Age,{0},{1}" -f $Color, $UserId
   
    $MyNewUser = [User]::new($Name, $Age, $Color, $UserId)
    $MyCsvUser = $MyNewUser.ToString() 

    $NewCSv = Get-Content $DatabaseFile -Raw
    $NewCSv += $MyCsvUser

    Set-Content -Value $NewCSv -Path $DatabaseFile
}

function Remove-CourseUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param (
        $DatabaseFile = "$PSScriptRoot\MyLabFile.csv"
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

function Confirm-CourseID {
    Param (
    )
    
    $AllUsers = GetUserData

    ForEach ($User in $AllUsers) {
        if ($User -notmatch '^\d+$') {
            Write-Output "User $($User.Name) has mismatching id: $($User.Id)"
        }
    }
}
 

