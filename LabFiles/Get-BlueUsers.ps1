function Get-BlueUsers {          
    [CmdletBinding()]
    param (
        [ValidateSet('Red','Blue','Green')]
        $Color = 'Blue'
    )

    begin {
    }
    process {
    }
    end {
    $MyUserList = Get-UserDatabase
    # $MyUserList = ".\MyLabFile.csv"
    Write-Verbose "Hello World"
    $MyUserList | Where-Object -Property Color -eq $Color
    }
}