#!/bin/bash


maindir="/d1/wayandn/Grid_data/maurer12k"
tempdir="/d1/wayandn/Grid_data/tempfiles/"
outpdir="/d1/wayandn/Grid_data/CSSL_pt/"

# Clear
rm -f $outpdir"*"

#Lat lon indices (zero based)
Ilat=100
Ilon=100

FL=$maindir"/MAU*"
echo $FL

# for each file
#for cf in $FL
#do

# Need to output time in a correct way
ncdump -v var1,var2 foo.nc | sed -e '1,/data:/d' -e '$d' 
# check to remove black space

	ncdump -t -v time $FL > $tempdir"time"
	ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v ppt $FL > $tempdir"ppt"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v temp $FL > $tempdir"temp"
	ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v q $FL > $tempdir"q"
	ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v press $FL > $tempdir"press"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v sw $FL > $tempdir"sw"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v lw $FL > $tempdir"lw"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v wnd $FL > $tempdir"wnd"

	cat $tempdir"time" >> $outpdir"time"
	cat $tempdir"ppt" >> $outpdir"ppt"
	cat $tempdir"temp" >> $outpdir"temp"
	cat $tempdir"q" >> $outpdir"q"
	cat $tempdir"press" >> $outpdir"press"
	cat $tempdir"sw" >> $outpdir"sw"
	cat $tempdir"lw" >> $outpdir"lw"
	cat $tempdir"wnd" >> $outpdir"wnd"
#done


