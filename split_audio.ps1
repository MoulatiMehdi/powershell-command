#these are the start times of the audio, observe one extra last element here, that is the total audio length
$timeSep = "00:00:00","00:02:00" , "00:05:46" , "00:09:35" , "00:12:37" , "00:15:31" , "00:18:42" , "00:20:53" , "00:23:10" , "00:25:39" , "00:27:41", "00:29:58"

# path of the audio 
$path = "C:\Users\dell\Desktop\a"

# since ffmpeg doesn't support path as an output name. you hav to direct to it 
cd $path 

 
for( $i = 1; $i -le $timeSep.length ; $i++){ 
 

	# name of the output audio 
    $name = "الكهف الجزء $('{0:D2}' -f $i)" 
    
  
	$Time1 = $timeSep[$i-1]
	$Time2 = $timeSep[$i]

  # get number of seconds between two timeline
	$tot= New-TimeSpan $Time1 $Time2 | Select-Object -ExpandProperty "TotalSe*" 
     
	# get the audio two timeline
	ffmpeg  -y -i 018.mp3 -ss $Time1 -t $tot -metadata title=$name  "$name.mp3"
}
