## 2022-03-23
**NOTE: GOOGLE MAPS ARE BROKEN WITH THIS RELEASE. THIS IS AN ISSUE ON SAMSUNG'S SIDE, UNTIL WE FIX IT USE MAPS GO OR ANY OTHER ALTERNATIVE.**

**NOTE#2: IF FLASHING GOOGLE APPS, DO NOT SET UP NETWORK OR SECURITY OR ACCOUNT ON FIRST BOOT. SKIP EVERYTHING AND THEN SET UP THE ACCOUNT WHEN YOU GET PAST SETUP. THIS IS AS WELL NOT ISSUE ON OUR SIDE.**

**NOTE#3: IF YOU FLASHED ANY THIRD PARTY PACKAGES (GAPPS etc.) YOU NEED TO REFLASH THEM AGAIN, BECAUSE ADDON.D WILL NOT WORK! IF YOU STILL HAVE ISSUES, DO A CLEAN FLASH.)**

- Updated to lineage-19.1
- Updated stock blobs/kernel
- Started building AdvancedDisplay again
- Wired up mDNIe features
- Configured power hal
- Resolved battery issues from first release
- Enabled high refresh rate modes (96hz/120hz) - find it under display options
- Forced resolution to 2400x1080 - By default, that resolution is used on stock as well, couldnt make high refresh rate work otherwise
- Tons of other stuff, check github

## 2022-01-11
- Initial lineage-19 release

## 2021-11-19 (x1s fixup)
- Fixed x1s resolution issues/leftovers

## 2021-11-18
- Updated sources from latest samsung XXSCDUJ5 Release
- Added firmware assertion
- For firmware updates, check here: https://github.com/Linux4/firmware-update/releases

## 2021-10-23
**NOTE: This build needs to be flashed manually, OTA will work again starting from next release**
**NOTE #2: This will most probably be the last lineage-18.1 build. We will now focus work on lineage-19 instead**
- Fixed OTA
- Kanged autobrightness values from starlte + commonized them
- Dropped SamsungDoze, switched to AOSP implementation which uses pickup sensor, no more accidental touches
- removed unneded remove config_radio_access_family overlay

## 2021-10-16
- Updated blobs/kernel from latest samsung release
- WPA3 Fixed
- Updated init.exynos990.rc/ueventd.rc from XXSDUE4
- Cleaned up uneeded proprietary files
- Cleaned up device manifest
- Building Fastcharge HAL
- Allow fastbootd to flash super/userdata partition
- Sepolicy - addressed multiple denials
- Major device tree refactor, adapted to standard lineageos devicetree structure
- Updated Lineageos sources

Major thanks to Tim and Rob for these updates

## 2021-05-21

**NOTE:UPDATING THE RECOVERY AND FORMATTING DATA IS REQUIRED FOR THIS UPDATE, BECAUSE IT WILL NOT BOOT OTHERWISE.**
**ADDITIONAL DATA FORMATTING WILL NOT BE NEEDED, THIS IS BECAUSE OF SWITCHING FROM EXT4 TO F2FS.**

- Fixed USB tethering
- Fixed OMX issues
- Fixed audio issues
- Fixed camera issues/switched to snap api1
- Switched to F2FS, improved random write speed from 30 to 200 Mb/s
- Switched to opensource NFC stack
- Updated lineage sources
- Updated kernel source to latest samsung release
- Updated blobs and secpatch to latest samsung release
- Enabled MAC randomisation 
- Enabled Wi-Fi direct
- Disabled Wi-Fi Display
- Building libbt-vendor from source
- Commonized stock blobs
- Enabled haptic text cursor
- Enabled call recording
- Addressed some more sepolicy denials
- Added sepolicy for HDMI out
- Added support for freeform windows and PiP mode
- Enabled Multiuser
- Improved SQlite storage speed
- Adjusted powerhint
- Fixed charging speed reporting on lockscreen

