Assuming `isync` is installed and `~/.mbsyncrc` file is configured [(wiki)](https://wiki.archlinux.org/index.php/Isync#Configuring).

Symlink those files to:

`$ ~/.config/systemd/user`

Then run this command:

```sh
systemctl --user enable mbsync.timer
systemctl --user start mbsync.timer
```
