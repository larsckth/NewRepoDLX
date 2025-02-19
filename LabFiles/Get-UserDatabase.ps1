function Get-UserDatabase {          
    param (
    $MyUserListFile = ".\MyLabFile.csv"
    )
     
    Get-Content -Path $MyUserListFile | ConvertFrom-CSV
    }