# Fixing Short Video Error
For the following video, https://www.youtube.com/watch?v=FztEmE7F68Q, `youtube-dl` does not create a final video file that plays correctly. This has to due with ffmpeg incorrectly muxing the audio and video streams that it gets from youtube. To work around  this:
1. Add `-k` to your youtube-dl command to keep the audio and video streams.
2. Download avconv from https://libav.org/documentation
3. Combine the video and audio streams into one file `avconv.exe -i .\video.mp4 -i .\audio.m4a -acodec copy -vcodec copy merged.mp4`
4. Re-add the metadata from original file produced by `youtube-dl/ffmpeg` `ffmpeg -i broken_original.mp4 -i merged.mp4 -map 1 -c copy -map_metadata 0 -map_metadata:s:v 0:s:v -map_metadata:s:a 0:s:a out.mp4`
5. Rename `out.mp4` and delete the other `.mp4` and `.m4a` files.
