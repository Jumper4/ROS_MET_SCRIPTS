#!/bin/bash


maindir="/d1/wayandn/Grid_data/maurer12k"
tempdir="/d1/wayandn/Grid_data/tempfiles/"
outpdir="/d1/wayandn/Grid_data/CSSL_pt/"

# Clear
rm -f $outpdir"*"

# lat lon we want
t_lat = 39.313237
t_lon = -120.394202

# Find indices of t_lat and t_lon
# use other function:x

#Lat lon indices (zero based)
Ilat=113
Ilon=34

FL=$maindir"/MAU*"
#echo $FL

# for each file
for cf in $FL
do

#cf=$maindir"/MAURER12K_Forcing.1992-12.nc"
echo $cf

# Need to output time in a correct way
# ncdump -v var1,var2 foo.nc | sed -e '1,/data:/d' -e '$d' 
# check to remove black space

	ncdump -t -v time $cf | sed -e '1,/data:/d' -e '$d' > $tempdir"temp1"
	sed 's/time = //g' $tempdir"temp1" > $tempdir"temp2"
	sed 's/"//g'       $tempdir"temp2" > $tempdir"temp3"
	sed 's$, $\n$g'    $tempdir"temp3" > $tempdir"temp4" 
	sed '/^$/d'        $tempdir"temp4" > $tempdir"temp5" 	
	sed 's/    //g'    $tempdir"temp5" > $tempdir"temp6"
	sed 's/;//g'       $tempdir"temp6" > $tempdir"time"

	
	ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v ppt $cf > $tempdir"ppt"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v temp $cf > $tempdir"temp"
	ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v q $cf > $tempdir"q"
	ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v press $cf > $tempdir"press"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v sw $cf > $tempdir"sw"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v lw $cf > $tempdir"lw"
	ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v wnd $cf > $tempdir"wnd"

	cat $tempdir"time" >> $outpdir"time"
	head -n -1 $tempdir"ppt" >> $outpdir"ppt"
	head -n -1 $tempdir"temp" >> $outpdir"temp"
	head -n -1 $tempdir"q" >> $outpdir"q"
	head -n -1 $tempdir"press" >> $outpdir"press"
	head -n -1 $tempdir"sw" >> $outpdir"sw"
	head -n -1 $tempdir"lw" >> $outpdir"lw"
	head -n -1 $tempdir"wnd" >> $outpdir"wnd"
done


