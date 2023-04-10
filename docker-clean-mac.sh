#!/bin/bash

rm -rf dexcom.patched.apk
rm -rf dexcom.patched-aligned-signed.apk
rm -rf dexcom.patched-aligned-signed.apk.idsig
colima delete --profile nativePatch
