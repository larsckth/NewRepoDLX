class MyCustomClass {
    [string] $Name
    [Int] $Age
    hidden [Int] $Shoesize

    MyCustomClass() { }

    #Method:
    MyCustomClass([string]$Name, [int]$Age) {
        $this.Name = $Name
        $this.Age = $Age
        $this.Shoesize = Get-Random -Minimum 34 -Maximum 48
    }

#    [string] OutString() {
#        return "$($this.Name) is $($this.Age) young"
#    }

# Hur gömde du shoesize?

    [string] ToString() {
        return "$($this.Name) is $($this.Age) old"
    }

}

enum Colours {
    Blue = 2
    Red = 1
    Green = 3
    White = 0
}
function MyThing {
    param (
        [Colours]$Colour
    )
    Write-Output $Colour
}