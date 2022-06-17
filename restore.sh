#!/bin/bash
echo "Saving and renaming .shsh blobs..."
decid="$((bin/idevicerestore -t iPhone2,1_3.0_7A341_Custom_24kpwn.ipsw) | sed -n -e 's/^.*Found ECID //p')"
cp -R shsh/.shsh shsh/.shsh1
mv shsh/.shsh1 shsh/$decid-iPhone2,1-3.0-7A341.shsh
cp shsh/$decid-iPhone2,1-3.0-7A341.shsh shsh/$decid-iPhone2,1-3.0.shsh
echo "Allowing 15 seconds for user to enter DFU mode on their iPhone 3GS..."
sleep 15
bin/iPwnder32 -p
bin/idevicerestore -e -w iPhone2,1_3.0_7A341_Custom_24kpwn.ipsw
echo "Script complete! If you have an iPhone 3GS with a new bootrom, please proceed to alloc8.sh. If you have an old bootrom iPhone 3GS, you are done and may start to use iOS 3.0 like normal."
