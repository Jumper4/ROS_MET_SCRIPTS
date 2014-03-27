#!/bin/bash

# Script extracts one grid cell at a time by looping through a list of 

maindir="/d1/wayandn/Grid_data/"
datadir=$maindir"maurer12k/"
BASIN="Low"

# Clear all temp and output files
while read FN Ilat Ilon cLat cLon tlat tlon
do
	outpdir=$maindir"Basin_pts/"$BASIN"/"$FN"/"	
	cd $outpdir
	rm -v time ppt temp q press sw lw wnd
done < $I_lat_lon_list 
echo Done Clearing up previous files

#Lat lon indices (zero based)
#Ilat=113
#Ilon=34

FL=$datadir"/MAU*"
I_lat_lon_list=$maindir"Basin_pts/"$BASIN"/"$BASIN".txt"
echo $I_lat_lon_list

#echo $FL

for cf in $FL
do
	echo $cf

	while read FN Ilat Ilon cLat cLon tlat tlon
	do

		#echo $Ilat $Ilon $cLat $cLon $tlat $tlon
		tempdir=$maindir"Basin_pts/"$BASIN"/"$FN"/TEMP/"
		mkdir -p $tempdir

		outpdir=$maindir"Basin_pts/"$BASIN"/"$FN"/"

		/opt/netcdf4/bin/ncdump -t -v time $cf | sed -e '1,/data:/d' -e '$d' > $tempdir"temp1"
		sed 's/time = //g' $tempdir"temp1" > $tempdir"temp2"
		sed 's/"//g'       $tempdir"temp2" > $tempdir"temp3"
		sed 's$, $\n$g'    $tempdir"temp3" > $tempdir"temp4" 
		sed '/^$/d'        $tempdir"temp4" > $tempdir"temp5" 	
		sed 's/    //g'    $tempdir"temp5" > $tempdir"temp6"
		sed 's/;//g'       $tempdir"temp6" > $tempdir"time"
	
		#ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v ppt $cf > $tempdir"ppt"
		#ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v temp $cf > $tempdir"temp"
		#ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v q $cf > $tempdir"q"
		#ncks -s '%13.9f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v press $cf > $tempdir"press"
		#ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v sw $cf > $tempdir"sw"
		#ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v lw $cf > $tempdir"lw"
		#ncks -s '%13.3f\n' -C -H -d lat,$Ilat,$Ilat -d lon,$Ilon,$Ilon -v wnd $cf > $tempdir"wnd"

		cat $tempdir"time" >> $outpdir"time"
		#head -n -1 $tempdir"ppt" >> $outpdir"ppt"
		#head -n -1 $tempdir"temp" >> $outpdir"temp"
		#head -n -1 $tempdir"q" >> $outpdir"q"
		#head -n -1 $tempdir"press" >> $outpdir"press"
		#head -n -1 $tempdir"sw" >> $outpdir"sw"
		#head -n -1 $tempdir"lw" >> $outpdir"lw"
		#head -n -1 $tempdir"wnd" >> $outpdir"wnd"

	done < $I_lat_lon_list
done

# Merge files together
while read FN Ilat Ilon cLat cLon tlat tlon
do
	findir=$maindir"Basin_pts/"$BASIN"/"$FN"/OUT/"
	mkdir -p $findir

	outpdir=$maindir"Basin_pts/"$BASIN"/"$FN"/"	
	cd $outpdir

	#paste time ppt temp q press sw lw wnd > $findir"forcing_"$FN".txt"
	paste time > $findir"forcing_"$FN".txt"

done < $I_lat_lon_list






