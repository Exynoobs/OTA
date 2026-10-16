---
layout: default
title: Upgrade instructions - Samsung Galaxy Z Fold5
codename: q5q
---

# Upgrade instructions for {{ page.title | replace: 'Upgrade instructions - ', '' }} ({{ page.codename }})

{% assign ota_url = site.lineage_ota_base_url | append: page.codename | append: ".json" %}
{% fetch builds_raw ota_url %}
{% json builds builds_raw %}
{% assign build = builds.response[0] %}

{% if build %}
{% assign recovery_url = build.url | replace:'UNOFFICIAL','recovery' | replace:'.zip','.img' %}

> Latest build: <a href="{{ build.url }}">{{ build.filename }}</a> — <a href="{{ build.url }}.sha256">sha256</a>
>
> Recovery: <a href="{{ recovery_url }}">recovery.img</a> — <a href="{{ recovery_url }}.sha256">sha256</a>
{% endif %}

## Tips for Z fold5

- Use recovery on the outer screen, while device is folded.
- While booting, boot it unfolded.

## Basic requirements

1. Read through the instructions at least once before actually following them, so as to avoid any problems due to any missed steps!
2. You actually want to upgrade your device to the newest version - if you wish to downgrade to an earlier version of LineageOS, follow your device's [install instructions]({{ "/devices/" | append: page.codename | append: "-install.html" | relative_url }}) for installing LineageOS the first time.
3. STOCK F946BXXS5EYI1 OR equivalent firmware for your device model is required. If your device is using a newer or older firmware, up- or downgrade to the required version before proceeding.

## Manually upgrading LineageOS

> Following these instructions will **not** wipe your data. It is, however, recommended to save important data before doing so, anyway!

The updater app does not support upgrades from one version of LineageOS to another, and will block installation to any update for a different version. Upgrading manually requires similar steps to installing LineageOS for the first time.

1. Verify your device is using the latest Lineage Recovery (link above). Follow your device's [install instructions]({{ "/devices/" | append: page.codename | append: "-install.html" | relative_url }}) to see how you can update your recovery image.
   - These instructions may not work if you choose to use a different recovery!
2. Download the LineageOS zip file (link above).
3. If you are currently using (or now want to use) an application package add-on such as [Google Apps](https://wiki.lineageos.org/gapps), you have the following options:
   - keep using them: Download the appropriate version [now](https://wiki.lineageos.org/gapps) (use the `arm64` architecture)
   - remove them: You can only do so by performing a factory reset, which will also remove all your data.
   - start using them: You can only do so by performing a factory reset, which will also remove all your data. Download the appropriate version [now](https://wiki.lineageos.org/gapps) (use the `arm64` architecture)
4. Make sure your computer has working `adb`.
5. Enable USB debugging on your device.
6. Run:

```bash
adb -d reboot sideload
```

- The device may reboot to a blank black screen, fear not, this is a known bug on some recoveries, proceed with the instructions.

7. Run (inserting the path to your LineageOS package):

```bash
adb -d sideload /path/to/zip
```

Tip: Normally, `adb` reports `Total xfer: 1.00x`, but in some cases, even if the process succeeds, the output may stop at 47% and show `adb: failed to read command: Success`. It might also display `adb: failed to read command: No error` or `adb: failed to read command: Undefined error: 0` which is also fine.

8. _(Optionally)_: If you want to install any add-ons, click `Apply update`, then `Apply from ADB`, then run for each of those packages in sequence:

```bash
adb -d sideload /path/to/zip
```

- If you previously had any Google Apps add-on package installed on your device, you must install an updated package **before** the first boot of Android! If you did not have Google Apps installed, you must wipe the **Data** partition (or perform a factory reset) to install them.
- Add-ons aren't signed with LineageOS's official key, and therefore when they are sideloaded, Lineage Recovery will present a screen that says `Signature verification failed`, this is expected, please click `Continue`.

9. Once you have installed everything successfully, click the back arrow in the top left of the screen, then "Reboot system now".
