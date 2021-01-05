# Convert Environmental Drivers & Do some rejiggering
# What's needed:
# --------------------------
# All scripts -- 
#   1. convert netcdf3 to netcdf-4
#   2. use CF-standard names for lat/lon/time
#   3. lat dimension south to north
#   4. add relevant CRS as global variable
# --------------------------
# Biome
#   1. 
# --------------------------



path.env <- "../original_submission/PalEON_Drivers_environmental_region/"

# --------------------------
# Biome
#   1. convert netcdf3 to netcdf-4
#   2. use CF-standard names for lat/lon/time
#   3. lat dimension south to north
#   4. add relevant CRS as global variable
# --------------------------
# Potential Veg
btype <- ncdf4::nc_open(file.path(path.env, "biome", "biome_potential_vegtype_biome.nc"))
btype
btype$var$biome

att.biome <- ncdf4::ncatt_get(btype, "biome")
att.biome.new <- list("")

var.lon
var.biome <- 
dat <- ncdf4::ncvar_get(btype, "biome")

# Creating a new 
# --------------------------
