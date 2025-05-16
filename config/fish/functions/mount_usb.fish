#!/usr/bin/env fish

function mount_usb

    set DEVICE "$argv[1]"
    set PARTITION "$argv[2]"
    if lsblk | grep --quiet "sd$DEVICE"
        sudo mount "/dev/sd$DEVICE$PARTITION" "/home/$USER/Mounts/usb-$DEVICE"
        if test $status -eq 0
            echo "USB mounted at /home/$USER/Mounts/usb-$DEVICE"
        else
            echo Failed
        end
    end
end
