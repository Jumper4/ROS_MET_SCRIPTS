import numpy as np
import netCDF4

t_lat = 39.313237
t_lon = -120.394202

print 'We want lat an lon values:',t_lat,t_lon

def naive_fast(latvar,lonvar,lat0,lon0):
    # Read latitude and longitude from file into numpy arrays
    latvals = latvar[:]
    lonvals = lonvar[:]
    ny,nx = latvals.shape
    dist_sq = (latvals-lat0)**2 + (lonvals-lon0)**2
    minindex_flattened = dist_sq.argmin()  # 1D index of min element
    iy_min,ix_min = np.unravel_index(minindex_flattened, latvals.shape)
    return iy_min,ix_min

filename = '/d1/wayandn/Grid_data/maurer12k/MAURER12K_Forcing.1994-01.nc'
ncfile = netCDF4.Dataset(filename, 'r')
latvar = ncfile.variables['lat']
lonvar = ncfile.variables['lon']
newlat = latvar * np.ones((len(lonvar),len(latvar)))
newlon = lonvar * np.ones((len(latvar),len(lonvar)))
newlat = newlat.T
newlon = (newlon - 180) * -1
iy,ix = naive_fast(newlat,newlon, t_lat, t_lon)
print 'Closest lat lon:', newlat[iy,ix], newlon[iy,ix]
print 'index values for lat and lon are:', iy, ix
ncfile.close()
