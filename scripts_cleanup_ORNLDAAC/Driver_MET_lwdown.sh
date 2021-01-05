# File to convert longwave radiation drivers to CF standard, comply with ORNL etc
# NOTE: Files are in MONTHLY format

cd ~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission
cd PalEON_Drivers_meteorology_region/lwdown

# Step 0 Get list of compressed files
ftar=(*.tar.bz2)

# Step 1: Untar compressed files;
# NOTE: currently puts it in a pain in the ass file structure

# Step 2: Loop through each uncompressed file to do work

## START Loop
# - modify data & existing attributes
#   -- change things to bytes?
#   -- any conversion to CF standard_name
#   -- add CRS grid mapping variable
# - add CRS variable and attributes
# - rename dimensions and variables
#   -- latitude
#   -- longitude
# - remove existing attributes
#   -- units(?)
#   -- missing values
#   -- projection
#   -- projection format
#   -- min/semi_major_axis
#   -- created by
#   -- date
# - modify attributes
#   -- lat: min to max
#   -- lat/lon long names
#   -- units --> conform
# - create new global attributes
# - change version of file & compress
# - move final version to new folder

## END Loop

# Clean up  files:
# - remove uncompressed old files
# - Compress new files
