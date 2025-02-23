function Add-CourseUser {
    [CmdletBinding()]
    param (
        $DatabaseFile = "./MyLabFile.csv"

        [Parameter(Mandatory)]
        [string]$Name,
        
        [Parameter(Mandatory)]
        [int]$Age,

        [Parameter(Mandatory)]
        [ValidateSet('red','green','blue','yellow')]
        [String]$Color,

        $UserID = (Get-Random -Minimum 8 -Maximum 102)
        )

$NewUser = "$Name, $Age, $Color, $UserID"
$NewCSv = Get-Content $DatabaseFile -Raw
$NewCSv += $NewUser
  
}