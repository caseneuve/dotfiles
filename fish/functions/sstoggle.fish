function sstoggle -d "Toggle screen saver (DPMS)"
    if test (xset -q | rg timeout | awk '{print $2}') -gt 0 \
        || test (string match -r "Enabled" (xset -q | rg " DPMS" | awk '{print $3}'))
        command xset s off -dpms
        echo "Screen saver turned off and DPMS has been disabled."
    else
        command xset s on +dpms
        echo "Screen saver set to" (math (xset -q | rg timeout | awk '{print $2}') / 60) "minutes and DPMS has been enabled."
    end
end
