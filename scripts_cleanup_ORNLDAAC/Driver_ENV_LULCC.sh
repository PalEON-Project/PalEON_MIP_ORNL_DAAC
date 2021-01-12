# landuse land cover product
cd ~/Desktop/Research/PalEON_MIP_ORNL_DAAC/original_submission
cd PalEON_Drivers_environmental_region/lulcc
outbase=~/Desktop/Research/PalEON_MIP_ORNL_DAAC/revised_submission/PalEON_Drivers_environmental_region/lulcc

mkdir -p $outbase


fvar=(*.nc)
echo ${fvar[@]}
# i=1
for((i=0;i<${#fvar[@]};i++)); do
  # echo $i
  fnow=${fvar[i]}
  vnow=${fnow:13:5}
  fmod=${fnow:0:18}_modified.nc
  fnew=paleon_reg-env-dri_lulcc_${vnow}.nc4

  # echo $i
  # echo $fnow
  case ${vnow} in
    gcrop) # cropland; unit = fraction grid cell
      # Do stuff here
      ncv=prop_crop
      # vunit="faction"
      echo $ncv
      ;;
    gothr)
      ncv=prop_primary
      # vunit="faction"
      echo $ncv
      ;;
    gpast)
      ncv=prop_past
      # vunit="faction"
      echo $ncv
      ;;
    gsecd)
      ncv=prop_secd
      # vunit="faction"
      echo $ncv
      ;;
    gssma)
      ncv=age_secd
      # vunit="faction"
      echo $ncv
      ;;
    gssmb)
      ncv=biomass_secd
      # vunit="faction"
      echo $ncv
      ;;
    gfsh1)
      ncv=frac_harv_mature_secd
      # vunit="faction"
      echo $ncv
      ;;
    gfsh2)
      ncv=frac_harv_young_secd
      # vunit="faction"
      echo $ncv
      ;;
    gfsh3)
      ncv=frac_harv_nonforest_secd
      # vunit="faction"
      echo $ncv
      ;;
    gfvh1)
      ncv=frac_harv_mature_primary
      # vunit="faction"
      echo $ncv
      ;;
    gfvh2)
      ncv=frac_harv_young_primary
      # vunit="faction"
      echo $ncv
      ;;
    gsbh1)
      ncv=mature_biomass_harv_secd
      # vunit="faction"
      echo $ncv
      ;;
    gsbh2)
      ncv=young_biomass_harv_secd
      # vunit="faction"
      echo $ncv
      ;;
    gsbh3)
      ncv=nonforest_biomass_harv_secd
      # vunit="faction"
      echo $ncv
      ;;
    gvbh1)
      ncv=biomass_harv_prim
      # vunit="faction"
      echo $ncv
      ;;
    gvbh2)
      ncv=nonforest_biomass_harv_primary
      # vunit="faction"
      echo $ncv
      ;;
    gflcp)
      ncv=prop_cp_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflcs)
      ncv=prop_cs_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflpc)
      ncv=prop_pc_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflps)
      ncv=prop_ps_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflsc)
      ncv=prop_sc_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflsp)
      ncv=prop_sp_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflvc)
      ncv=prop_vc_transition
      # vunit="faction"
      echo $ncv
      ;;
    gflvp)
      ncv=prop_vp_transition
      # vunit="faction"
      echo $ncv
      ;;
  esac
done
