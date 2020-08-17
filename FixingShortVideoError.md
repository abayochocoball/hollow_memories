# Fixing Short Video Error
For the following video, https://www.youtube.com/watch?v=FztEmE7F68Q, `youtube-dl` does not create a final video file that plays correctly. This has to due with ffmpeg incorrectly muxing the audio and video streams that it gets from youtube. To work around  this:
1. Add `-k` to your youtube-dl command to keep the audio and video streams.
2. Download avconv from https://libav.org/documentation
3. Combine the video and audio streams into one file `avconv.exe -i .\video.mp4 -i .\audio.m4a -acodec copy -vcodec copy merged.mp4`
