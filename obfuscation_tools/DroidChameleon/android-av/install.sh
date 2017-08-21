#!/bin/bash

echo $1
adb -s emulator-5554 wait-for-device
adb -s emulator-5554 install $1
adb -s emulator-5556 install $1
adb -s emulator-5558 install $1
adb -s emulator-5560 install $1
adb -s emulator-5562 install $1
adb -s emulator-5564 install $1
#adb -s emulator-5566 install $1
