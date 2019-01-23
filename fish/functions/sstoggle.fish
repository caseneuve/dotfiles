function sstoggle -d "Toggle screen saver (DPMS)"
    if test (xset -q | rg timeout | awk '{print $2}') -gt 0
        command xset s off
        echo Screen saver turned off.
    else
        command xset s on
        echo "Screen saver set to" (math (xset -q | rg timeout | awk '{print $2}') / 60) minutes.
    end
end
