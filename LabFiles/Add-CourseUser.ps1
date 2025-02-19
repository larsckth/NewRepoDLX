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