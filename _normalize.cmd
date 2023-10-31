@echo off

set FILE_NAME=%~1
set FILE_NAME_WITHOUT_EXT=%~n1
set FILE_EXT=%~x1

set OUTPUT_FILE=%FILE_NAME_WITHOUT_EXT%_normalized%FILE_EXT%

REM 1. Разделение аудио и видео
ffmpeg -i "%FILE_NAME%" -c:v copy -an video.mp4
ffmpeg -i "%FILE_NAME%" -c:a copy -vn audio.mp4

REM 2. Повышение громкости аудио
ffmpeg -i audio.mp4 -filter:a "volume=20" audio_louder.mp4

REM 3. Сборка дорожек обратно
ffmpeg -i video.mp4 -i audio_louder.mp4 -shortest -c:v copy -c:a aac -strict experimental "%OUTPUT_FILE%"

REM 4. Удаление промежуточных файлов
del video.mp4
del audio.mp4
del audio_louder.mp4

echo Готово! Результат сохранен в %OUTPUT_FILE%
pause