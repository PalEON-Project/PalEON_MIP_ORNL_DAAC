# File to convert longwave radiation drivers to CF standard, comply with ORNL etc
# NOTE: Files are in MONTHLY format

cd ~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission
cd PalEON_Drivers_meteorology_region/lwdown
outbase=~/Desktop/Research/PalEON_MIP_ORNL_DAAC/revised_submission/PalEON_Drivers_meterology_region/downwelling_longwave_flux_in_air

mkdir -p $outbase

# Step 0 Get list of compressed files
ftar=(*.tar.bz2)

# Loop through each compressed file to do work -- keeps memory manageable
for((i=1;i<${#ftar[@]};i++)); do
  ##  Step 1: Untar compressed files;
  # NOTE: currently puts it in a pain in the ass file structure, but I think
  # this actually works in our favor
  tar -jxvf ${ftar[i]}

  # Make a temporary place where we'll write out the dataqa
  dbase=${ftar[i]:0:(-8)}
  mkdir ${outbase}/${dbase}

  # This is the file structure from when I saved things on the BU server;
  # It's a pain in the butt, but leaving it alone will let is work with
  # smaller batches of uncompressed files
  pushd projectnb/dietzelab/paleon/met_regional/phase2_met_regional_v2/lwdown



  # Get list of all files to work through
  fvar=(*.nc)

  ## Step 2: START Loop
  for((j=1;j<${#fvar[@]};i++)); do
    # Make some placeholder names to keep things straight
    fnow=$fvar[j]
    fmod=${fnow:0:(-3)}_modified.nc
    fnew=paleon_reg-met-dri_${fnow:0:(-3)}.nc4

    # - modify data & existing attributes
    #   -- change things to bytes?
    #   -- any conversion to CF standard_name
    #   -- add CRS grid mapping variable
    ncap2 -h -s 'lwdown=lwdown' $fnow $fmod
    ncatted -h -a grid_mapping,lwdown,c,c,"crs" $fmod

    # - add CRS variable and attributes
    ncap2 -h -s 'crs=0.0' $fmod  ## add CRS variable
    ncatted -h -a long_name,crs,c,c,"coordinate reference system definition" $fmod
    ncatted -h -a grid_mapping_name,crs,c,c,"latitude_longitude" $fmod
    ncatted -h -a longitude_of_prime_meridian,crs,c,d,0.0 $fmod
    ncatted -h -a semi_major_axis,crs,c,d,6378137.0 $fmod
    ncatted -h -a inverse_flattening,crs,c,d,298.257223563 $fmod

    # - rename dimensions and variables
    #   -- latitude, longitude -- looks fine
    #   -- lwdown
    # ncrename -h -d longitude,lon -d latitude,lat $fmod # These were fine
    # ncrename -h -v longitude,lon -v latitude,lat $fmod
    ncrename -h -v lwdown,downwelling_longwave_flux_in_air $fmod

    # - remove existing attributes
    #   -- units(?)
    #   -- missing values
    #   -- projection
    #   -- projection format
    #   -- min/semi_major_axis
    #   -- created by
    #   -- date
    ncatted -h -a missing_value,downwelling_longwave_flux_in_air,d,, $fmod
    ncatted -h -a projection,downwelling_longwave_flux_in_air,d,, $fmod
    ncatted -h -a projection_format,downwelling_longwave_flux_in_air,d,, $fmod
    ncatted -h -a min,downwelling_longwave_flux_in_air,d,, $fmod
    ncatted -h -a max,downwelling_longwave_flux_in_air,d,, $fmod
    ncatted -h -a created_by,global,d,, $fmod
    ncatted -h -a date,global,d,, $fmod


    # - modify attributes
    #   -- lat: min to max --> looks fine
    #   -- lat/lon long names
    #   -- units --> conform
    # ncdump -v lat $fmod  # lat values should go small to large (south to north)
    # ncpdq -O -h -a -lat $fmod $fmod  ## change order of lat values
    ncatted -h -a long_name,lon,m,c,"longitude at center of pixel" $fmod
    ncatted -h -a long_name,lat,m,c,"latitude at center of pixel" $fmod
    ncatted -h -a _FillValue,downwelling_longwave_flux_in_air,m,d,-3.4e+38 $fmod
    ncatted -h -a Conventions,global,m,c,"CF-1.8" $fmod


    # - create new global attributes
    ncatted -h -a standard_name,lon,c,c,"longitude" $fmod
    ncatted -h -a standard_name,lat,c,c,"latitude" $fmod
    ncatted -h -a grid_mapping,downwelling_longwave_flux_in_air,c,c,"crs" $fmod
    # ncatted -h -a comment,downwelling_longwave_flux_in_air,c,c,"Relative area of a PFT within the grid cell" $fmod
    ncatted -h -a title,global,c,c,"Longwave Radation | PalEON Regional Meteorology Drivers" $fmod
    ncatted -h -a summary,global,c,c,"6-hourly downlwelling longwave radiation for each grid cell." $fmod
    ncatted -h -a comment,global,c,c,"All PalEON meteorology drivers are derived from spatially and temporally downscaling CCSM4 historical and last millenium CMIP5 experiments using a neural network approach trained on CRUNCEP data following Kumar et al (2012). Meteorology years from the following source: 850-1849 downscaled CCSM4 last millenium; 1850-1900 downscaled CCSM4 historical; 1901-2010 CRUNCEP.  CCSM4 based longwave radiation (850-1900) was adjusted to better match CRUNCEP using an average bias ration during the overlapp period of 1990-1961." $fmod
    ncatted -h -a references,global,c,c,"Kumar et al. 2012, https://doi.org/10.1016/j.procs.2012.04.095" $fmod
    ncatted -h -a publisher_name,global,c,c,"Oak Ridge National Laboratory Distributed Active Archive Center (ORNL DAAC)" $fmod
    ncatted -h -a publisher_url,global,c,c,"https://daac.ornl.gov" $fmod
    ncatted -h -a publisher_email,global,c,c,"uso@daac.ornl.gov" $fmod


    # - change version of file & compress
    nccopy -k 3 -d 4 -u $fmod $fnew

    # - move final version to new folder
    mv $fnew ${outbase}/${dbase}

  done ## END individual file Loop
  popd

  # Clean up  files:
  # - remove uncompressed old files
  # - Compress new files
  rm -rf projectnb

  pushd $outbase
  tar -jcvf ${dbase}.tar.bz2 $dbase
  rm -rf ${dbase}
  popd

done # End compressed file loop
