#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <ota zip>"
    exit 1
fi

ZIP="$1"
FILENAME=$(basename $ZIP)
BUILDDIR=$(dirname $ZIP)
SCRIPTDIR=$(dirname $0)
REPODIR=$(dirname $SCRIPTDIR)
DEVICE=$(echo $FILENAME | cut -f5 -d '-' | cut -f1 -d '.')
DATE=$(echo $FILENAME | cut -f3 -d '-')
RECOVERY_NAME=$(echo $FILENAME | sed 's/UNOFFICIAL/recovery/g' | sed 's/\.zip/.img/g')
RELEASENAME="$DEVICE-$DATE"

# Devices that ship vbmeta.img alongside the OTA
case "$DEVICE" in
    b5q|dm1q|e3q|q5q) HAS_VBMETA=1 ;;
    *) HAS_VBMETA=0 ;;
esac

# Avoid colliding with an existing same-day release
if git -C $REPODIR ls-remote --exit-code --tags origin "refs/tags/$RELEASENAME" >/dev/null; then
    N=2
    while git -C $REPODIR ls-remote --exit-code --tags origin "refs/tags/$RELEASENAME-$N" >/dev/null; do
        N=$((N+1))
    done
    RELEASENAME="$RELEASENAME-$N"
fi

$SCRIPTDIR/otainfo.sh $ZIP $(hub -C $REPODIR browse -u) $RELEASENAME > $REPODIR/$DEVICE.json
cp $BUILDDIR/recovery.img $BUILDDIR/$RECOVERY_NAME
echo "$(sha256sum $ZIP | cut -f1 -d ' ') $FILENAME" > $REPODIR/$FILENAME.sha256
echo "$(sha256sum $BUILDDIR/$RECOVERY_NAME | cut -f1 -d ' ') $RECOVERY_NAME" > $REPODIR/$RECOVERY_NAME.sha256

if [ "$HAS_VBMETA" = 1 ]; then
    echo "$(sha256sum $BUILDDIR/vbmeta.img | cut -f1 -d ' ') vbmeta.img" > $REPODIR/vbmeta.img.sha256
fi

git -C $REPODIR add $DEVICE.json
git -C $REPODIR commit -m "OTA: $DEVICE: $DATE"
git -C $REPODIR tag "$RELEASENAME"
git -C $REPODIR push origin HEAD:staging --tags

if [ "$HAS_VBMETA" = 1 ]; then
    hub -C $REPODIR release create \
        -a $BUILDDIR/$RECOVERY_NAME \
        -a $REPODIR/$RECOVERY_NAME.sha256 \
        -a $ZIP \
        -a $REPODIR/$FILENAME.sha256 \
        -a $BUILDDIR/vbmeta.img \
        -a $REPODIR/vbmeta.img.sha256 \
        -m "$DEVICE: $DATE" \
        -t $(git -C $REPODIR rev-parse HEAD) \
        $RELEASENAME
else
    hub -C $REPODIR release create \
        -a $BUILDDIR/$RECOVERY_NAME \
        -a $REPODIR/$RECOVERY_NAME.sha256 \
        -a $ZIP \
        -a $REPODIR/$FILENAME.sha256 \
        -m "$DEVICE: $DATE" \
        -t $(git -C $REPODIR rev-parse HEAD) \
        $RELEASENAME
fi

git -C $REPODIR push origin HEAD:master --tags
git -C $REPODIR push origin --delete staging

rm $REPODIR/$FILENAME.sha256 $REPODIR/$RECOVERY_NAME.sha256 $BUILDDIR/$RECOVERY_NAME
if [ "$HAS_VBMETA" = 1 ]; then
    rm $REPODIR/vbmeta.img.sha256 $BUILDDIR/vbmeta.img
fi
