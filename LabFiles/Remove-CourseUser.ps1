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
