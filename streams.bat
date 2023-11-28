@echo off

set video=".\fireworks.mp4"
set target="rtmp://localhost/hls/stream_"

:menu
echo Vyberte možnost:
echo 1 - Spustit stream
echo 2 - Konec

set /p choice="Vaše volba: "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto end

echo Neplatná volba. Zkuste to znovu.
goto menu

:start
C:\ffmpeg\bin\ffmpeg -i %video% -threads 4 ^
-c:v libx264 -c:a aac -b:a 256k -vf "drawtext=fontfile=arial.ttf:text='1080p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20" -f flv %target%1080 ^
-c:v libx264 -c:a aac -b:a 192k -vf "drawtext=fontfile=arial.ttf:text='720p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20, scale=-2:720" -preset fast -f flv %target%720 ^
-c:v libx264 -c:a aac -b:a 128k -vf "drawtext=fontfile=arial.ttf:text='480p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20, scale=-2:480" -preset fast  -f flv %target%480 ^
-c:v libx264 -c:a aac -b:a 64k -vf "drawtext=fontfile=arial.ttf:text='360p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20, scale=-2:360" -preset fast  -f flv %target%360

timeout /t 10 /nobreak
goto menu

:end
