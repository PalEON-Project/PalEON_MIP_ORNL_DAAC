cd ~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission
cd PalEON_Drivers_environmental_region/co2

outbase=~/Desktop/Research/PalEON_MIP_ORNL_DAAC/revised_submission/PalEON_Drivers_environmental_region/co2
mkdir -p $outbase

####################################################################
#### modify annual CO2 driver
####################################################################
fnow=paleon_annual_co2.nc
fmod=paleon_annual_co2_modified.nc
fnew=paleon_reg-env-dri_co2_annual.nc

ncdump -h $fnow  # view the header

# Copy variable over to new file
ncap2 -h -s 'co2=co2' $fnow $fmod
# Note: standard value for whole region, so no CRS info needed

# - rename dimensions and variables
ncrename -h -v co2,mole_fraction_of_carbon_dioxide_in_air $fmod

# - remove existing attributes
ncatted -h -a units,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a missing_value,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a projection,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a projection_format,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a min,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a max,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a created_by,global,d,, $fmod
ncatted -h -a date,global,d,, $fmod

# - modify attributes
ncatted -h -a units,mole_fraction_of_carbon_dioxide_in_air,m,c,"umol/mol (ppm)" $fmod
ncatted -h -a long_name,mole_fraction_of_carbon_dioxide_in_air,m,c,"Annual average atmospheric CO2 concentration in parts per million" $fmod
ncatted -h -a _FillValue,mole_fraction_of_carbon_dioxide_in_air,m,d,1e+30 $fmod
ncatted -h -a Conventions,global,m,c,"CF-1.8" $fmod

# create attributes
ncatted -h -a title,global,c,c,"CO2 concentration in atmosphere (Annual) | PalEON Regional Environmental Drivers" $fmod
ncatted -h -a summary,global,c,c,"Annual average atmospheric CO2 across the study domain" $fmod
ncatted -h -a comment,global,c,c,"The PalEON CO2 driver is a spliced combination of PMIP-3 records and observations from NOAA Mona Loa Observatory." $fmod
# ncatted -h -a references,global,c,c,"Huntzinger et al. 2013, https://doi.org/10.5194/gmd-6-2121-2013" $fmod
ncatted -h -a publisher_name,global,c,c,"Oak Ridge National Laboratory Distributed Active Archive Center (ORNL DAAC)" $fmod
ncatted -h -a publisher_url,global,c,c,"https://daac.ornl.gov" $fmod
ncatted -h -a publisher_email,global,c,c,"uso@daac.ornl.gov" $fmod

# change version of file, make unlimited dim fixed, compress
# ncdump -k $fmod
nccopy -k 3 -d 4 -u $fmod $fnew
# ncdump -k $fnew  # final check of version

# Move to new folder
mv $fnew $outbase
rm $fmod

####################################################################
#### modify monthly CO2 driver
####################################################################

fnow=paleon_monthly_co2.nc
fmod=paleon_monthly_co2_modified.nc
fnew=paleon_reg-env-dri_co2_monthly.nc

ncdump -h $fnow  # view the header

# Copy variable over to new file
ncap2 -h -s 'co2=co2' $fnow $fmod
# Note: standard value for whole region, so no CRS info needed

# - rename dimensions and variables
ncrename -h -v co2,mole_fraction_of_carbon_dioxide_in_air $fmod

# - remove existing attributes
ncatted -h -a units,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a missing_value,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a projection,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a projection_format,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a min,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a max,mole_fraction_of_carbon_dioxide_in_air,d,, $fmod
ncatted -h -a created_by,global,d,, $fmod
ncatted -h -a date,global,d,, $fmod

# - modify attributes
ncatted -h -a units,mole_fraction_of_carbon_dioxide_in_air,m,c,"umol/mol (ppm)" $fmod
ncatted -h -a long_name,mole_fraction_of_carbon_dioxide_in_air,m,c,"Monthly average atmospheric CO2 concentration in parts per million" $fmod
ncatted -h -a _FillValue,mole_fraction_of_carbon_dioxide_in_air,m,d,1e+30 $fmod
ncatted -h -a Conventions,global,m,c,"CF-1.8" $fmod

# create attributes
ncatted -h -a title,global,c,c,"CO2 concentration in atmosphere (Monthly) | PalEON Regional Environmental Drivers" $fmod
ncatted -h -a summary,global,c,c,"Annual average atmospheric CO2 across the study domain" $fmod
ncatted -h -a comment,global,c,c,"The PalEON CO2 driver is a spliced combination of PMIP-3 records and observations from NOAA Mona Loa Observatory. Monthly driver has seasonal cycles from MsTMIP variation added in (Wei et al. 2014) " $fmod
ncatted -h -a references,global,c,c,"Wei et al. 2014, http://dx.doi.org/10.3334/ORNLDAAC/1220" $fmod
ncatted -h -a publisher_name,global,c,c,"Oak Ridge National Laboratory Distributed Active Archive Center (ORNL DAAC)" $fmod
ncatted -h -a publisher_url,global,c,c,"https://daac.ornl.gov" $fmod
ncatted -h -a publisher_email,global,c,c,"uso@daac.ornl.gov" $fmod

# change version of file, make unlimited dim fixed, compress
# ncdump -k $fmod
nccopy -k 3 -d 4 -u $fmod $fnew
# ncdump -k $fnew  # final check of version

# Move to new folder
mv $fnew $outbase
