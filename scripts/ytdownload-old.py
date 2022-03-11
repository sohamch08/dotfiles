link = input()
app = "youtube-dl"
path = "-o '$HOME/Downloads/youtube-dl_songs/%(channel)s/%(title)s - %(channel)s.%(ext)s'"
title = "-o %(title)s - %(channel)s.%(ext)s"
audiodownload = "-f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 "
thumbnaildownload = "--write-thumbnail --skip-download"
filename = "--get-filename"
with open('command.bash','w') as f:
    f.write(f"{app} {title} {filename} {link} | python check.py\n")
    f.write(f"{app} {path} {audiodownload} {link}\n")
    f.write(f"{app} {path} {thumbnaildownload} {link}\n")
    f.write(f"{app} {title} {filename} {link}  >> yt-download_history.txt")
   