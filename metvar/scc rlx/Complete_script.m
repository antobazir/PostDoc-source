%complete study script from 10/11 in order to recapitulate all studies
clear all;
close all;
pkg load image

%substrate reactions only%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%reference configuration
e = full_study('ref_conf','ref');
if(e==1)
  disp('error')
  return
endif

%substrate starvation
e = full_study('starv','starv');
##
##%substrate saving
##full_study('cellcyc','savy','savy');
##
##%compensation
##full_study('cellcyc','compens','compens');
##
##%compensation+prolif
##full_study('cellcyc','compens_prol','compens_prol');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

##%local hypoxia%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##full_study('loc_hypox_base','loc_hypox_base');
##
##full_study('loc_hypox_comp','loc_hypox_comp');
##
##full_study('loc_hypox_comp_prol','loc_hypox_comp_prol');
##
##full_study('loc_hypox_comp_arr','loc_hypox_comp_arr');


##%OS models%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##full_study('cellcyc','OS_fragile','OS_fragile');
##
##full_study('cellcyc','OS_hypos_tol','OS_hypos_tol');
##
##full_study('cellcyc','OS_hypox_tol','OS_hypox_tol');
##
##full_study('cellcyc','OS_hypox_boost','OS_hypox_boost');

%full_study('cellcyc','OS_hypox_boost_mig','OS_hypox_boost_mig');
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##
##%OSP models%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##full_study('OS_fragile_P_detr','OS_fragile_P_detr');
##
##full_study('OS_hypox_boost_P_detr','OS_hypox_boost_P_detr');
##
##full_study('OS_fragile_P_boost','OS_fragile_P_boost');
##
##full_study('OS_hypox_boost_P_boost','OS_hypox_boost_P_boost');
##
##full_study('Prod_mediated_hypox_resp','Prod_mediated_hypox_resp');
##
##full_study('Prod_mediated_hypox_resp_mig','Prod_mediated_hypox_resp_mig');
##
##full_study('Prod_cons_in_hypos','Prod_cons_in_hypos');
##
##full_study('Prod_cons_in_hypos_hypox_resp','Prod_cons_in_hypos_hypox_resp');
##
##full_study('Prod_cons_in_hypos_hypox_resp_mig','Prod_cons_in_hypos_hypox_resp_mig');
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

##%OSK models%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##full_study('OS_fragile_K_detr','OS_fragile_K_detr');
##
##full_study('OS_hypox_boost_K_detr','OS_hypox_boost_K_detr');
##
##full_study('OS_fragile_K_boost','OS_fragile_K_boost');
##
##full_study('OS_hypox_boost_K_boost','OS_hypox_boost_K_boost');
##
##full_study('Kine_mediated_hypox_resp','Kine_mediated_hypox_resp');
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




