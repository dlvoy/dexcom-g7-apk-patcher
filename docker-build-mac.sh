#!/bin/bash

DEXCOM_MOD_APK="dexcom.patched.apk";
KEYSTORE_PATH="signing.keystore";
KEYSTORE_PASS="6dYlrOon6U1430fwj492dBjnYm8CN5zYcWdbVJ53GQIf7PExEV";
UBER_SIGNER="bin/uber-apk-signer-1.3.0.jar"

#rm -rf dexcom.patched.apk

colima stop
colima start --arch aarch64 --profile nativePatch
docker build --no-cache -t diakem-dexcom-g7-apk-patcher -f Dockerfile.mac .
docker run -it -v $(pwd):/output diakem-dexcom-g7-apk-patcher 


echo "----------------------";
echo "  ⏳ Signing new apk";
java -jar $UBER_SIGNER -a $DEXCOM_MOD_APK \
--ks $KEYSTORE_PATH \
--ksAlias cert \
--ksPass $KEYSTORE_PASS \
--ksKeyPass $KEYSTORE_PASS \
--zipAlignPath $ANDROID_HOME/build-tools/android-13 \
--verbose \
checkStatus $?
echo "----------------------";
echo "🎉🎉🎉 APK successfully signed 🎉🎉🎉 - install aligned signed APK on your 📲 now";

#rm -rf dexcom.patched.apk
#colima delete --profile nativePatch
