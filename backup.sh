exclude="/tmp/rsync-excludes.rc"

excludes=(
    '.adobe'
    'alltunes'
    '.cache'
    '.cmus'
    '.config'
    '.dbus'
    'Desktop'
    'Documents'
    'Downloads'
    '.dropbox'
    '.dropbox-dist'
    '.e'
    '.fontconfig'
    '.gconf'
    '.gconfd'
    '.gstreamer-0.10'
    '.gvfs'
    '.lesshst'
    '.local'
    '.macromedia'
    '.mozilla'
    '.msf3'
    'network'
    'nzbget'
    '.pki'
    '.pulse'
    '.purple'
    'Software'
    '.subversion'
    '.veetle_vlc'
    '.VirtualBox'
    'VirtualBox VMs'
    '.wine'
)

if [ $UID -ne 0 ]; then
    echo Please run as root.
else
    echo > /tmp/rsync-excludes.rc
    for file in ${excludes[@]}; do
        echo "$file" >> "$exclude"
    done

    rsync -varusP --delete /etc /home/james/Dropbox/backup
    rsync -varusP --delete --delete-excluded --exclude-from="/home/james/backup/exclude.srv.list" /srv /home/james/Dropbox/backup
    rsync -varusP --delete --delete-excluded --exclude-from="/home/james/backup/exclude.list" /home/james /home/james/Dropbox/backup

    pacman -Qqe | grep -v "$(pacman -Qmq)" > "/home/james/Dropbox/backup/pacman.list"
    pacman -Qmq > "/home/james/Dropbox/backup/yaourt.list"
    chown -R james:users /home/james/Dropbox/backup
fi
