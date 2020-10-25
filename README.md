# Youtube Archive Tutorial

This tutorial covers setting up and using `youtube-dl` to download videos, playlists and channels.

## Windows Setup
**Currently youtube-dl has been [taken down from github](https://github.com/github/dmca/blob/master/2020/10/2020-10-23-RIAA.md), which is why the instructions link to archive.org.**
### Get youtube-dl
1. Go to https://yt-dl.org/download.html
2. Download youtube-dl by clicking on windows exe.
3. From your `Downloads` folder, copy `youtube-dl.exe` to a location where you will permanently store it.
4. Open cmd with Administrator permissions
   * ⊞ windows key + cmd + right click on app and select `Run as administrator`
5. Modify the following command by replacing `<REPLACE THIS WITH YOUR youtube-dl DIRECTORY>` with folder where you are storing `youtube-dl.exe` and then run the command in the cmd window by pasting the command into the cmd window and pressing enter
   
```
setx /M PATH "%PATH%;<REPLACE THIS WITH YOUR youtube-dl DIRECTORY>"
```
Example:
If you were to store `youtube-dl.exe` in `C:\Program Files\youtube-dl` you would run the command `setx /M PATH "%PATH%;C:\Program Files\youtube-dl"`

1. Close the cmd window
2. Open new cmd window (not administrator mode)
3. run the command `youtube-dl --version`, you should get some output like `2020.07.28` if you set everything up correctly. 

### Get ffmpeg
1. Go to https://ffmpeg.org/download.html#build-windows
2. Use your brain to find the download
3. Extract the downloaded zip file
4. Copy the folder inside the folder that was extracted to a permanent location. You may want to rename the long folder name to `ffmpeg`. `ffmpeg.exe` is inside the `bin` folder inside the folder you copied.
5. Do steps 4 and 5 from the the `Get youtube-dl` section but this time using the folder for where `ffmpeg.exe` is.

Example:
If you were to store the folder at `C:\Program Files\ffmpeg` then you would run `setx /M PATH "%PATH%;C:\Program Files\ffmpeg\bin`. `ffmpeg.exe` should be located in `C:\Program Files\ffmpeg\bin`.
6. You should now be able to run the command `ffmpeg -version`.

### Get AtomicParsley
This is optional, it will allow you to create `.mp4` files with thumbnails from the youtube video. Currently this guide does not make use of `AtomicParsley`.
1. Go to http://atomicparsley.sourceforge.net/
2. Download latest version
3. Extract the zip
4. Inside the extracted files, copy the folder `AtomicParley-win32-0.9.0` to a permanent location. You may want to rename the folder to `AtomicParsley`.
5.  Do steps 4 and 5 from the the `Get youtube-dl` section but this time using the folder for where `AtomicParsley.exe` is.

Example: 
If you were to store the folder at `C:\Program Files\AtomicParsley` then you would run `setx /M PATH "%PATH%;C:\Program Files\AtomicParsley`. `AtomicParsley.exe` should be located in `C:\Program Files\AtomicParsley`.
**6**. You should now be able to run the command `AtomicParsley`.

## Using youtube-dl
The following examples download as `.mkv` files or `.mp4` files. See the FAQ section below on the difference. It is recommended to do use the `.mp4` version of the command for most videos and `.mkv` for content with video resolution higher than `1080p` and music videos.

### Download a single video
1. Open cmd
2. Run one of the following `youtube-dl` commands after replacing the youtube link with a link to the video you want to download.

Download it to the current directory (The path shown in cmd to the left of where you are typing)
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i
```
Download to a specific directory and use the video title as the file name. Replace the directory path `C:\Users\anon\Downloads\` with the path to the directory you want to download it to.
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i -o "C:\Users\anon\Downloads\%(title)s.%(ext)s"
```
Download a video to a specific directory along with metadata, video description embeded in the comment property as well as in a file, and the youtube thumbnail.
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i --add-metadata --write-thumbnail --write-description -o "C:\Users\anon\Downloads\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```
Same as the above but as an `.mp4` file.
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 --add-metadata --write-thumbnail --write-description -o "C:\Users\anon\Downloads\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Download a playlist
1. Open cmd
2. Run one of the following `youtube-dl` commands after replacing the youtube playlist link with a link to the youtube playlist you want to download.
   

Download a playlist to a folder of your choice wit hteh files in order of how they appear in the playlist. Replace `C:\Users\anon\Desktop\comet originals` with path to directory of your choice.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd -i -o "C:\Users\anon\Desktop\comet originals\%(playlist_index)s - %(title)s.%(ext)s"
```
Download a playlist to a folder named after the playlist with the files in order of how they appear in the playlist. Replace `C:\Users\anon\Desktop` with path to directory of your choice. A folder new folder with the same name as the playlist will be created there with the videos downloaded to it.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd -i -o "C:\Users\anon\Desktop\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```
Same as the scenario above but saves information about which files have already been downloaded so you can later run the same command again to update your downloaded playlist without redownloading everything. There are now two paths you must edit, one for the path to where the archive file is and one to where the videos will be downloaded. The folder of where the archive file will be located must exist prior to running this command, so create the folder if it doesn't already exist.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd --download-archive "C:\Users\anon\Desktop\archives\comet_originals_playlist.txt" -i -o "C:\Users\anon\Desktop\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```
Same as the scenario above but outputs an `.mp4` file.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd --download-archive "C:\Users\anon\Desktop\archives\comet_originals_playlist.txt" -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "C:\Users\anon\Desktop\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

### Download all playlists from a channel
In this example you will create a folder for the channel and all the playlists will be downloaded to their own folders inside the channel folder. An archive file is going to be used to prevent redownloading if `youtube-dl` stops working (such as your computer going to sleep). Because there is only one archive file, any video that shows up in more than one playlist will only be downloaded to the first playlist downloaded that contains the video. If you do not want this behavior, then refer to instructions for downloading specific playlists and run the commands for each of the playlists in the channel. Generally, videos are not repeated between play lists on their channels. The download speed will also be controllable.

1. Create a folder for the channel you want to target.
2. Open cmd
3. Run the following `youtube-dl` command, replacing the channel's playlists url with the playlists url of your choice. It is assumed in the following example that the folder you want to download to is `C:\Users\anon\Desktop\comet\`. The speed is limited to 1MB per second, you can change it accordingly or remove `-r 1M` entirely to disable the throttling. Examples of some speeds (50K, 4.2M).
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A/playlists -r 1M --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -o "C:\Users\anon\Desktop\comet\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```
Same as the scenario above but outputs an `.mp4` file.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A/playlists -r 1M --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "C:\Users\anon\Desktop\comet\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

### Archiving a channel
In this example you will download every video uploaded by the channel into a single folder. This will not include videos uploaded by other channels that have been included in playlists of your target channel. This means you may miss out on collabs such as duet songs. Unlisted videos will not be downloaded. Members only videos will not be downloaded. The videos will be downloaded with file names in the following format `[ChannelName][Upload Date] Video Title (Youtube video id).mkv`. Example: `[anon ch][20201231] anon sings (oqbyL3JRaHo).mkv`
1. Create a folder for the channel you want to target.
2. Open cmd
3. Run the following `youtube-dl` command, replacing the channel url with the channel url of your choice. Replace the path `C:\Users\anon\Desktop\comet` with to folder you created for the channel. The speed is limited to 1MB per second, you can change it accordingly or remove `-r 1M` entirely to disable the throttling. Examples of some speeds (50K, 4.2M). `--add-metadata` will add the video description to the downloaded video's comment property and set the date modified of the file to the date it was uploaded. `--write-info-json` will create a file with some information that might be useful later on. `--write-thumbnail` will download the image that is used as the thumbnail for the video. `--write-description` will create a file with the video description in it.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A -r 1M --add-metadata --write-info-json --write-thumbnail --write-description --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -o "C:\Users\anon\Desktop\comet\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```
Same as the scenario above but outputs an `.mp4` file.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A -r 1M --add-metadata --write-info-json --write-thumbnail --write-description --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "C:\Users\anon\Desktop\comet\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

To get a more complete collection of the channel will require some ingenuity on your part. You can download all the play lists on the channel and then run the command command for archiving the channel to download all the videos that are not in a playlist on the channel. Long as `youtube-dl` command targets the same archive file for the `--download-archive FILE`, it will not download a video already listed in the archive file. 

To get members content you will have to use [authentication options](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#authentication-options) with `youtube-dl`.

Unlisted videos can be downloaded using the direct video downloading instructions. Use `[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s` as the file name to get the same file name format as the command above.

Livestreams can be captured as they are airing.

You can create scheduled tasks to periodically run your archival commands to stay up to date automatically. 

`youtube-dl` also has options to download the thumbnail image and using the post `youtube-dl`'s post processing options you can run `ffmpeg` to add the thumbnail as cover art for the `.mkv` video.

### Download a members only video
In this example we will download a single members only video.
1. Have access to membership for the channel.
2. Install the plugin `cookies.txt` [FireFox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) [Chrome](https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg). This will let us extract cookies from youtube which will be used to authenticate `youtube-dl`.
3. Log into youtube.
4. Click on the `cookies.txt` plugin in the top right hand corner of the browser and get cookies for `Current Site`. Save the cookies to a location of your choice. In this example we will use `C:\Users\anon\Desktop\youtube-cookies.txt`
5. Follow the steps from [Download a single video](#download-a-single-video) and add `--cookies C:\Users\anon\Desktop\youtube-cookies.txt` to any of the commands . Example for downloading the video to the current directory
```
youtube-dl https://www.youtube.com/watch?v=TEoslCqshuQ -i --cookies C:\Users\anon\Desktop\youtube-cookies.txt
```

You may find that sometimes authentication will fail. This is most likely due to old cookies. Simply get new cookies and replace your current cookie file.

### Download a live stream as it is occuring
See [this guide](archiving_livestreams.md).

## FAQ
### What -f option do I need to pass to get the highest quality video and audio?
None. New versions of youtube-dl will automatically pick the best quality available when no -f option is presented.

### What options do I need to pass to get the highest quality `.mp4`?
`-f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4` You can add this after the `-i` on any of the above commands.

### What difference is there between the highest quality `.mp4` and `.mkv`?
Using `.mkv` will get access to `48kHz Opus audio` if it is available while `.mp4` will get `44.1kHZ AAC audio`. Using `.mkv` will get access to higher quality visual streams and resolutions above `1080p` if they are available while `.mp4` will be limited to `1080p`*. There are only a handful of videos that are above `1080p` and most are short music videos as opposed to long live streams.

*These limitations are due to the streams available from youtube and container type that can contain the streams.

### How do I... ?
Read the manuals
1. https://github.com/ytdl-org/youtube-dl/blob/master/README.md
2. https://ffmpeg.org/documentation.html
