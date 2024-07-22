#!/bin/bash

# apply
curl https://raw.githubusercontent.com/hhd-dev/ko-test/master/patch.sh | sh

# sleep
echo `date '+%s' -d "+ 10 seconds"` | sudo tee /sys/class/rtc/rtc0/wakealarm; sudo systemctl suspend

# do both
curl https://raw.githubusercontent.com/hhd-dev/ko-test/master/patch.sh | sh && \
    echo `date '+%s' -d "+ 10 seconds"` | sudo tee /sys/class/rtc/rtc0/wakealarm; sudo systemctl suspend