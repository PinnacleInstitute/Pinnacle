# Usage: ConvertImage -file 1 -ext gif
 
 param (
    [string]$file = "",
    [string]$ext = ""
 )

 if( $file -ne "" ) {

     $UploadPath = "images\barter\Upload\"
     $ImagePath = "images\barter\"
     $filename = $UploadPath + $file + "." + $ext

     # Create Thumbnail 50x50
     $newfilename = $ImagePath + $file + "s." + $ext
     &  "convert" $filename -thumbnail 50x50> -background white -gravity center -extent 50x50 $newfilename

     # Create medium size 200x150 
     $newfilename = $ImagePath + $file + "m." + $ext
     &  "convert" $filename -resize 200x150> -background white -gravity center -extent 200x150 $newfilename

     # Create large size 600x450 
     $newfilename = $ImagePath + $file + "l." + $ext
     &  "convert" $filename -resize 600x450> -background white -gravity center -extent 600x450 $newfilename
  
 }
