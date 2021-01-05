# Script to modify the environmental region data; lots of copy-paste from file from Jess
cd ~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission
cd PalEON_Drivers_environmental_region/biome

ncdump -h biome_potential_vegtype_biome.nc  # view the header

# change data type of biome variable and add attributes
ncap2 -h -s 'biome=byte(biome)' biome_potential_vegtype_biome.nc biome_potential_vegtype_biome_modified.nc
ncatted -h -a grid_mapping,biome,c,c,"crs" biome_potential_vegtype_biome_modified.nc
ncatted -h -a flag_values,biome,c,b,"1,2,3,4,5" biome_potential_vegtype_biome_modified.nc
ncatted -h -a flag_meanings,biome,c,c,"Broadleaf-Deciduous_Forest Mixed_Broadleaf-Deciduous_Needleleaf-Evergreen Needleleaf-Evergreen_Forest Savanna_Shrublands Grasslands" biome_potential_vegtype_biome_modified.nc

ncdump -h biome_potential_vegtype_biome_modified.nc  # view the header of the new file

# add CRS variable and attributes
ncap2 -h -s 'crs=0.0' biome_potential_vegtype_biome_modified.nc  ## add CRS variable
ncatted -h -a long_name,crs,c,c,"coordinate reference system definition" biome_potential_vegtype_biome_modified.nc
ncatted -h -a grid_mapping_name,crs,c,c,"latitude_longitude" biome_potential_vegtype_biome_modified.nc
ncatted -h -a longitude_of_prime_meridian,crs,c,d,0.0 biome_potential_vegtype_biome_modified.nc
ncatted -h -a semi_major_axis,crs,c,d,6378137.0 biome_potential_vegtype_biome_modified.nc
ncatted -h -a inverse_flattening,crs,c,d,298.257223563 biome_potential_vegtype_biome_modified.nc

# rename dimensions for CF standard
ncrename -h -d longitude,lon -d latitude,lat biome_potential_vegtype_biome_modified.nc
ncrename -h -v longitude,lon -v latitude,lat biome_potential_vegtype_biome_modified.nc

# remove existing attributes
ncatted -h -a units,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a _FillValue,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a missing_value,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a projection,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a projection_format,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a min,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a max,biome,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a created_by,global,d,, biome_potential_vegtype_biome_modified.nc
ncatted -h -a date,global,d,, biome_potential_vegtype_biome_modified.nc

# modify existing attributes
ncdump -v lat biome_potential_vegtype_biome_modified.nc  # lat values should go small to large (south to north)
ncpdq -O -h -a -lat biome_potential_vegtype_biome_modified.nc biome_potential_vegtype_biome_modified.nc  ## change order of lat values
ncatted -h -a long_name,lon,m,c,"longitude at center of pixel" biome_potential_vegtype_biome_modified.nc
ncatted -h -a long_name,lat,m,c,"latitude at center of pixel" biome_potential_vegtype_biome_modified.nc
ncatted -h -a Conventions,global,m,c,"CF-1.8" biome_potential_vegtype_biome_modified.nc

# create attributes
ncatted -h -a standard_name,lon,c,c,"longitude" biome_potential_vegtype_biome_modified.nc
ncatted -h -a standard_name,lat,c,c,"latitude" biome_potential_vegtype_biome_modified.nc
ncatted -h -a title,global,c,c,"Biome Classification | PalEON Regional Environmental Drivers" biome_potential_vegtype_biome_modified.nc
ncatted -h -a summary,global,c,c,"A one-time measurement of the dominant biome type in each grid cell. The original biome classification is from SYNMAP (MsTMIP biome driver)." biome_potential_vegtype_biome_modified.nc
ncatted -h -a comment,global,c,c,"The PalEON biome driver is derived from SYNMAP (Jung et al. 2006) which is used by MsTMIP. Crosswalk between SYNMAP and PalEON generally followed previous for SiBCASA (Schaefer et al. 2015). SYNMAP-PFT crosswalk was modified from Poulter et al. 2015. In both cases, crops were equated with grassland and urban area ignored. Mosaic tree-shrub or tree-grass/crop were treated as the corresponding LCCS forest types (<15% forest cover) and treated shrub and grass as equivalent. The current product keeps the bare ground cover, and models that do not have bare ground should reallocate that proportion accordingly." biome_potential_vegtype_biome_modified.nc
ncatted -h -a references,global,c,c,"Jung et al. 2006, https://doi.org/10.1016/j.rse.2006.01.020; Schaefer et al. 2014, https://doi.org/10.3334/ORNLDAAC/1220; Poulter et al. 2015, https://doi.org/10.5194/gmd-8-2315-2015" biome_potential_vegtype_biome_modified.nc
ncatted -h -a publisher_name,global,c,c,"Oak Ridge National Laboratory Distributed Active Archive Center (ORNL DAAC)" biome_potential_vegtype_biome_modified.nc
ncatted -h -a publisher_url,global,c,c,"https://daac.ornl.gov" biome_potential_vegtype_biome_modified.nc
ncatted -h -a publisher_email,global,c,c,"uso@daac.ornl.gov" biome_potential_vegtype_biome_modified.nc

ncdump -h biome_potential_vegtype_biome_modified.nc  # check your changes

# change version of file & compress
ncdump -k biome_potential_vegtype_biome_modified.nc
nccopy -k 3 -d 4 biome_potential_vegtype_biome_modified.nc paleon_reg-env-dri_biome_type.nc4
ncdump -k paleon_reg-env-dri_biome_type.nc4
ncdump -h paleon_reg-env-dri_biome_type.nc4  # final check of version

# Move to new folder
mv paleon_reg-env-dri_biome_type.nc4 ../../../revised_submission/PalEON_Drivers_environmental_region/biome
