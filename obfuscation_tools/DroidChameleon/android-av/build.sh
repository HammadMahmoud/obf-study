#!/bin/bash

apktool b $1 1.apk

jarsigner -storepass helloworld 1.apk rv

zipalign -f 4 1.apk $2

rm -rf 1.apk
