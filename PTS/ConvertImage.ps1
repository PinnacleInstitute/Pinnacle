 param (
    [string]$file = "",
    [string]$ext = ""
 )

 if( $file -ne "" ) {

 $str = $file + "." + $ext

 write $str


 }
