---
layout: default
title: Install instructions - Samsung Galaxy Z Fold5
codename: q5q
---

# Install instructions for {{ page.title | replace: 'Install instructions - ', '' }} ({{ page.codename }})

{% assign ota_url = site.lineage_ota_base_url | append: page.codename | append: ".json" %}
{% fetch builds_raw ota_url %}
{% json builds builds_raw %}
{% assign build = builds.response[0] %}

{% if build %}
{% assign recovery_url = build.url | replace:'UNOFFICIAL','recovery' | replace:'.zip','.img' %}
{% assign vbmeta_url = build.url | replace: build.filename, 'vbmeta.img' %}

> Latest build: <a href="{{ build.url }}">{{ build.filename }}</a> — <a href="{{ build.url }}.sha256">sha256</a>
>
> Recovery: <a href="{{ recovery_url }}">recovery.img</a> — <a href="{{ recovery_url }}.sha256">sha256</a>
>
> vbmeta: <a href="{{ vbmeta_url }}">vbmeta.img</a> — <a href="{{ vbmeta_url }}.sha256">sha256</a> > {% endif %}

## Basic requirements

- Read through the instructions once before following them.
- Install `adb` on your computer.
- Windows: Install Samsung USB drivers and have Odin available. Linux/macOS: Use Heimdall.
- Ensure your model is supported and OEM unlock is available in Developer options.
- Boot stock OS once and verify functionality.

## Pre-Install instructions (unlock + vbmeta)

- Enable Developer options, then enable OEM unlock.
- Download `vbmeta.img` (link above). Create a TAR for flashing tools that require it:

```bash
tar --format=ustar -cvf vbmeta.tar vbmeta.img
```

- Reboot to Download mode: with USB plugged in, hold Volume Up + Volume Down and plug in the USB cable.
- Unlock the bootloader when prompted. The device will wipe data and reboot. Re-enable OEM unlock afterwards.

## Important information

Samsung devices use Download mode with Odin (Windows) or Heimdall (Linux/macOS).

## Installing Lineage Recovery (Odin on Windows)

1. Extract and run Odin.
2. In Options, uncheck “Auto Reboot”.
3. Prepare `recovery.tar` from `recovery.img`:

```bash
tar --format=ustar -cvf recovery.tar recovery.img
```

4. Put device in Download mode, connect USB. Odin should show a COM port.
5. Click AP and select `recovery.tar`.
6. Click Start and wait for the transfer to complete.
7. Without booting to system, force reboot then immediately boot to recovery (Plug in USB + Volume Up + Power).

## Installing Lineage Recovery (Heimdall on Linux/macOS)

1. Install Heimdall via your package manager.
2. Reboot to Download mode and connect USB.
3. Flash recovery:

```bash
heimdall flash --RECOVERY recovery.img --no-reboot
```

4. When flashing completes, manually boot to recovery (Plug in USB + Volume Up + Power).

## Installing vbmeta (to disable verification)

Flash `vbmeta.img` from Download mode using Odin/Heimdall:

- Odin (Windows): Pack as `vbmeta.tar`, load in AP, Start.
- Heimdall:

```bash
heimdall flash --VBMETA vbmeta.img --no-reboot
```

Then immediately boot to recovery (do not boot to system yet).

## Installing LineageOS from recovery

1. In recovery, Factory reset → Format data / factory reset.
2. Return to main menu → Apply update → Apply from ADB.
3. Sideload the build from your computer:

```bash
adb sideload <lineageos-zip-name.zip>
```

Tip: `adb` may show 47% and exit messages while still succeeding.

## Installing add-ons (optional)

If you plan to install Google Apps or other add-ons, sideload them before first boot using the same Apply from ADB flow.

## All set

Reboot system now. First boot can take up to 15 minutes.

## What next

- If you see a bootloader warning, it’s normal on unlocked devices.
