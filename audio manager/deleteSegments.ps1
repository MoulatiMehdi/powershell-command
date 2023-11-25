cd C:\Users\dell\Desktop


$files = @(
    @{
        input    = 'alkahf.m4a'
        output   = 'alkahf_output.m4a'
        segments = @("0:00", "5:18", "5:28", "5:58", "6:01", "7:00", '7:03', "7:23", "7:34", "8:45.95")
    }, @{
        input    = '30-40.m4a'
        output   = '30-40_output.m4a'
        segments = @("0:00", "1:01", "1:11", "3:10")
    }
)


function convert-second {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, Mandatory)]
        [string]
        $time,
        
        [Parameter(Position = 2)]
        [string]
        $date
    )
    
    if ($time -match "^\d+(:\d{1,2}){0,2}(\.\d{1,2})?$") {

        $t = $time -split ":"    
        $duration = 0
    
        for ($i = 0 ; $i -lt ($t.Length - 1) ; $i++) {
            $duration += 60 * [double]$t[$i]
        }
        $duration = $t[$t.Length - 1]

        return  $duration
    }
    else {
        throw "string is not a valid format"
    }
}

function get-SecondBetween {
    [CmdletBinding()]
    param (
        [Parameter(Position = 1, Mandatory)]
        [string]
        $start,
        [Parameter(Position = 2, Mandatory)]
        [string]
        $end
    )
    
    $time1 = convert-second $end
    $time2 = convert-second $start
    $result = $time1 - $time2
    return   [Math]::Abs($result)
}

function deleteSegments {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 1)]
        [string]
        $Source,

        [Parameter(Mandatory, Position = 2)]
        [string]
        $Output,

        [Parameter(Mandatory, Position = 2)]
        [array]
        $Segments
    )

    $option = "aselect='"

    for ($i = 0 ; $i -lt $Segments.Length ; $i += 2) {
        $t1 = convert-second $Segments[$i] 
        $t2 = convert-second $Segments[$i + 1] 
        $option += "between(t,$t1,$t2)"
        if ( $i + 2 -lt $Segments.Length) {
            $option += "+"
        }
    }

    write-host "$source ---> $output :$option"
    
    $option += "',asetpts=N/SR/TB"

    ffmpeg -i $Source -af $option $output
}

$str = ""
$FilePaths = "list.txt"

foreach ($file in $files) {
    deleteSegments -Source $file.input -Output $file.output -Segments $file.segments
    $str += "file '$($file.output)'`n"
}
Set-Content $FilePaths -Value $str 

ffmpeg -f concat -i $FilePaths -acodec copy "concat.m4a"



