# ORNL Formatted
path.env <- "~/Downloads/paleon_reg_env_dri/paleon_reg-env-dri/"
dir(path.env)

lulcc <- ncdf4::nc_open(file.path(path.env, "paleon_reg-env-dri_lulcc.nc4"))
summary(lulcc$var)
harvmat2nd <- ncdf4::ncvar_get(lulcc, "frac_harv_mature_secd")
dim(harvmat2nd)
summary(harvmat2nd)
max(harvmat2nd, na.rm=T)
summary(harvmat2nd[harvmat2nd>0 & !is.na(harvmat2nd)])
# summary(lulcc$var$prop_cp_transition)


path.met <- "~/Downloads/paleon_reg-met-dri_sample/"
dir(path.met)

lwdown <- ncdf4::nc_open(file.path(path.met, "paleon_reg-met-dri_lwdown_0850-0899.nc4"))
lwdown$dim$time
lwdat <- ncdf4::ncvar_get(lwdown, "lwdown")
summary(lwdat)
dim(lwdat)
# pft <- 
  
  
# Paleon Raw
path.paleon <- "~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission/"
dir(path.paleon)
gfsh1 <- ncdf4::nc_open(file.path(path.paleon,"PalEON_Drivers_environmental_region/lulcc/", "paleon_lulcc_gfsh1.nc"))
summary(gfsh1$var)
                        
harvPaleon <- ncdf4::ncvar_get(gfsh1, "frac_harv_mature_secd")
summary(harvPaleon)
max(harvPaleon, na.rm=T)
summary(harvPaleon[harvPaleon>0 & !is.na(harvPaleon)])


lwdownPaleon <- ncdf