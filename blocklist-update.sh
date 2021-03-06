#!/bin/bash

echo "##################################################################"
echo "Moving To Centralized Location"
echo "##################################################################"

cd /tmp

echo "##################################################################"
echo "Commensing Download And Extraction Sequence Now"
echo "##################################################################"

wget "http://list.iblocklist.com/?list=gihxqmhyunbxhbmgqrla&fileformat=p2p&archiveformat=gz" -O peerblock1.gz
wget "http://list.iblocklist.com/?list=dufcxgnbjsdwmwctgfuj&fileformat=p2p&archiveformat=gz" -O peerblock2.gz
wget "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz" -O peerblock3.gz
wget "http://list.iblocklist.com/?list=gyisgnzbhppbvsphucsw&fileformat=p2p&archiveformat=gz" -O peerblock4.gz
wget "http://list.iblocklist.com/?list=uwnukjqktoggdknzrhgh&fileformat=p2p&archiveformat=gz" -O peerblock5.gz
wget "http://list.iblocklist.com/?list=plkehquoahljmyxjixpu&fileformat=p2p&archiveformat=gz" -O peerblock6.gz
wget "http://list.iblocklist.com/?list=cwworuawihqvocglcoss&fileformat=p2p&archiveformat=gz" -O peerblock7.gz
wget "http://list.iblocklist.com/?list=xpbqleszmajjesnzddhv&fileformat=p2p&archiveformat=gz" -O peerblock8.gz
wget "http://list.iblocklist.com/?list=llvtlsjyoyiczbkjsxpf&fileformat=p2p&archiveformat=gz" -O peerblock9.gz
wget "http://list.iblocklist.com/?list=ijfqtofzixtwayqovmxn&fileformat=p2p&archiveformat=gz" -O peerblock10.gz

echo "##################################################################"
echo "Extracting"
echo "##################################################################"

gunzip peerblock*.gz

echo "##################################################################"
echo "Merging lists"
echo "##################################################################"

cat peerblock* >> blocklist.bin

echo "##################################################################"
echo "Activating DeDuplication Algorithm"
echo "##################################################################"

awk '!dup[$0]++' blocklist.bin > blocklist.new && mv blocklist.new blocklist.bin

echo "##################################################################"
echo "Finalizing"
echo "##################################################################"

mv blocklist.bin ~/.config/transmission/blocklists/

echo "##################################################################"
echo "Cleaning Up"
echo "##################################################################"

rm peerblock*

echo "##################################################################"
echo "Process Complete"
echo "##################################################################"

exit
