#!/bin/bash
if [ $1 = "old" ]; then
echo "Device is an iPhone 3GS old bootrom. Proceeding to script..."
fi
if [ $1 = "new" ]; then
echo "Device is an iPhone 3GS new bootrom. Proceeding to script..."
fi

if [ -e "iPhone2,1_3.0_7A341_Restore.ipsw" ]; then
sleep 1
else
echo "iOS 3.0 .ipsw not detected, downloading..."
wget http://appldnld.apple.com.edgesuite.net/content.info.apple.com/iPhone/061-6582.20090617.LlI87/iPhone2,1_3.0_7A341_Restore.ipsw
echo "iOS 3.0 .ipsw successfully downloaded!"
fi
bin/ipsw iPhone2,1_3.0_7A341_Restore.ipsw iPhone2,1_3.0_7A341_Custom_no24kpwn.ipsw
if [ -e "iPhone2,1_3.0_7A341_Custom_no24kpwn.ipsw" ]; then
echo "First custom .ipsw successfully made, adding exploit..."
else
echo "Failure making 1st custom .ipsw, aborting..."
exit
fi
mkdir addexploit
mkdir addexploit/custom3.0
unzip -d addexploit/custom3.0 iPhone2,1_3.0_7A341_Custom_no24kpwn.ipsw
rm -rf iPhone2,1_3.0_7A341_Custom_no24kpwn.ipsw
sudo mv addexploit/custom3.0/Firmware/all_flash/all_flash.n88ap.production/LLB.n88ap.RELEASE.img3 addexploit/..
bin/xpwntool LLB.n88ap.RELEASE.img3 llb.dec -iv fc4efef9fd245dc038ecb26f25f795c7 -k 783970ed70d151e65cdd0f52019f026cbc0ece5c604603117d677b6a85ea4d95
bin/xpwntool llb.dec addexploit/custom3.0/Firmware/all_flash/all_flash.n88ap.production/LLB.n88ap.RELEASE.img3 -xn8824k -t LLB.n88ap.RELEASE.img3 -iv fc4efef9fd245dc038ecb26f25f795c7 -k 783970ed70d151e65cdd0f52019f026cbc0ece5c604603117d677b6a85ea4d95
rm -rf LLB.n88ap.RELEASE.img3
rm -rf llb.dec
cd addexploit/custom3.0
zip ../../iPhone2,1_3.0_7A341_Custom_24kpwn.ipsw -r0 *
cd ../..
rm -rf addexploit
if [ -e "iPhone2,1_3.0_7A341_Custom_24kpwn.ipsw" ]; then
echo "Successfully made custom .ipsw!"
else
echo "Failed to make custom .ipsw, please try again."
if [ $1 = "new" ]; then
echo "Device is new bootrom, will require alloc8 to be applied after custom .ipsw installation.."
else "Device is old bootrom, will boot out of the box!"
exit
fi
