####################################################################
#### modify biome_potential_vegtype_pft_fraction.nc
cd ~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission
cd PalEON_Drivers_environmental_region/biome

ncdump -h biome_potential_vegtype_pft_fraction.nc  # view the header

# change data type of pft variable and add attributes
ncap2 -h -s 'pft=byte(pft)' biome_potential_vegtype_pft_fraction.nc biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a grid_mapping,pft,c,c,"crs" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a flag_values,pft,c,b,'1,2,3,4,5,6,7,8,9,10' biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a flag_meanings,pft,c,c,"TreeBroadEvergreen TreeBroadDeciduous TreeNeedleEvergreen TreeNeedleDeciduous ShrubBroadEvergreen ShrubBroadDeciduous ShrubNeedleEvergreen ShrubNeedleDeciduous Grass Bare" biome_potential_vegtype_pft_fraction_modified.nc

ncdump -h biome_potential_vegtype_pft_fraction_modified.nc  # view the header of the new file

# add CRS variable and attributes
ncap2 -h -s 'crs=0.0' biome_potential_vegtype_pft_fraction_modified.nc  ## add CRS variable
ncatted -h -a long_name,crs,c,c,"coordinate reference system definition" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a grid_mapping_name,crs,c,c,"latitude_longitude" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a longitude_of_prime_meridian,crs,c,d,0.0 biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a semi_major_axis,crs,c,d,6378137.0 biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a inverse_flattening,crs,c,d,298.257223563 biome_potential_vegtype_pft_fraction_modified.nc

# rename dimensions and variables
ncrename -h -d longitude,lon -d latitude,lat biome_potential_vegtype_pft_fraction_modified.nc
ncrename -h -v longitude,lon -v latitude,lat biome_potential_vegtype_pft_fraction_modified.nc

# remove existing attributes
ncatted -h -a units,pft,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a missing_value,pft_frac,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a projection,pft_frac,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a projection_format,pft_frac,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a min,pft_frac,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a max,pft_frac,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a created_by,global,d,, biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a date,global,d,, biome_potential_vegtype_pft_fraction_modified.nc

# modify existing attributes
ncdump -v lat biome_potential_vegtype_pft_fraction_modified.nc  # lat values should go small to large (south to north)
ncpdq -O -h -a -lat biome_potential_vegtype_pft_fraction_modified.nc biome_potential_vegtype_pft_fraction_modified.nc  ## change order of lat values
ncatted -h -a long_name,lon,m,c,"longitude at center of pixel" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a long_name,lat,m,c,"latitude at center of pixel" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a long_name,pft,m,c,"Plant Functional Type" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a units,pft_frac,m,i,1 biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a _FillValue,pft_frac,m,f,-3.4e+38 biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a long_name,pft_frac,m,c,"Plant Functional Type Fractional Coverage" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a Conventions,global,m,c,"CF-1.8" biome_potential_vegtype_pft_fraction_modified.nc

# create attributes
ncatted -h -a standard_name,lon,c,c,"longitude" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a standard_name,lat,c,c,"latitude" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a grid_mapping,pft_frac,c,c,"crs" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a comment,pft_frac,c,c,"Relative area of a PFT within the grid cell" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a title,global,c,c,"Plant Functional Type (PFT) Classification | PalEON Regional Environmental Drivers" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a summary,global,c,c,"A one-time measurement of the fraction of plant functional types in each grid cell based on smoothing over a 5 deg x 5 deg area." biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a comment,global,c,c,"The PalEON biome driver is derived from SYNMAP (Jung et al. 2006) which is used by MsTMIP. Crosswalk between SYNMAP and PalEON generally followed previous for SiBCASA (Schaefer et al. 2015). SYNMAP-PFT crosswalk was modified from Poulter et al. 2015. In both cases, crops were equated with grassland and urban area ignored. Mosaic tree-shrub or tree-grass/crop were treated as the corresponding LCCS forest types (<15% forest cover) and treated shrub and grass as equivalent. The current product keeps the bare ground cover, and models that do not have bare ground should reallocate that proportion accordingly." biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a references,global,c,c,"Jung et al. 2006, https://doi.org/10.1016/j.rse.2006.01.020; Schaefer et al. 2014, https://doi.org/10.3334/ORNLDAAC/1220; Poulter et al. 2015, https://doi.org/10.5194/gmd-8-2315-2015" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a publisher_name,global,c,c,"Oak Ridge National Laboratory Distributed Active Archive Center (ORNL DAAC)" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a publisher_url,global,c,c,"https://daac.ornl.gov" biome_potential_vegtype_pft_fraction_modified.nc
ncatted -h -a publisher_email,global,c,c,"uso@daac.ornl.gov" biome_potential_vegtype_pft_fraction_modified.nc

ncdump -h biome_potential_vegtype_pft_fraction_modified.nc  # check your changes

# change version of file, make unlimited dim fixed, compress
ncdump -k biome_potential_vegtype_pft_fraction_modified.nc
nccopy -k 3 -d 4 -u biome_potential_vegtype_pft_fraction_modified.nc paleon_reg-env-dri_biome_pft.nc4
ncdump -k paleon_reg-env-dri_biome_pft.nc4  # final check of version

# Move to new folder
mv paleon_reg-env-dri_biome_pft.nc4 ../../../revised_submission/PalEON_Drivers_environmental_region/biome
