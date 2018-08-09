IF %1 == "" GOTO usage
IF %2 == "" GOTO usage

Convert images/barter/upload/%1.%2 -thumbnail 50x50> -background white -gravity center -extent 50x50 images/barter/%1s.%2
Convert images/barter/upload/%1.%2 -resize 200x150> -background white -gravity center -extent 200x150 images/barter/%1m.%2
Convert images/barter/upload/%1.%2 -resize 600x450> -background white -gravity center -extent 600x450 images/barter/%1l.%2
GOTO done

:usage
@echo ConvertImage [file_number] [file_ext]
:done
