function GetUserData {
    $MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
    $MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
    $MyUserList
}
