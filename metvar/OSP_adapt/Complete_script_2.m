%complete study script from 10/11 in order to recapitulate all studies
clear all;
close all;
pkg load image
pkg load matgeom

%substrate reactions only%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%reference configuration
%e = full_study('ref_conf','ref');
if(e==1)
  disp('error')
  return
endif

%substrate starvation
e = full_study('starv','starv');
##
%substrate saving
%e = full_study('savy','savy');
##full_study('cellcyc','savy','savy');

##
%compensation
%e = full_study('compens','compens');
##full_study('cellcyc','compens','compens');
##
%compensation+prolif
%e = full_study('compens_prol','compens_prol');
%full_study('cellcyc','compens_prol','compens_prol');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

##%local hypoxia%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##full_study('loc_hypox_base','loc_hypox_base');
####
##full_study('loc_hypox_comp','loc_hypox_comp');
####
##full_study('loc_hypox_comp_prol','loc_hypox_comp_prol');
####
##full_study('loc_hypox_comp_arr','loc_hypox_comp_arr');


%OS models%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp('OS_fragile')
%full_study('OS_fragile','OS_fragile');
##
disp('OS_hypos_tol')
full_study('OS_hypos_tol','OS_hypos_tol');
##
%disp('OS_hypox_tol')
%full_study('OS_hypox_tol','OS_hypox_tol');
##
disp('OS_hypox_boost')
full_study('OS_hypox_boost','OS_hypox_boost');

%full_study('cellcyc','OS_hypox_boost_mig','OS_hypox_boost_mig');
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##
##%OSP models%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp('OS_fragile_P_lth')
%full_study('OS_fragile_P_lth','OS_fragile_P_lth');
##
disp('OS_fragile_P_doom')
full_study('OS_fragile_P_doom_lth','OS_fragile_P_doom_lth');
##
%disp('OS_fragile_P_resc')
%full_study('OS_fragile_P_resc_lth','OS_fragile_P_resc_lth');
##
full_study('OS_hypos_tol_P_lth','OS_hypos_tol_P_lth');
##
%full_study('OS_hypos_tol_P_doom_lth','OS_hypos_tol_P_doom_lth');
##
full_study('OS_hypos_tol_P_resc_lth','OS_hypos_tol_P_resc_lth');
##
%full_study('OS_hypos_tol_P_boost_lth','OS_hypos_tol_P_boost_lth');
##

full_study('OS_hypox_tol_P_lth','OS_hypos_tol_P_lth');
##
%full_study('OS_hypox_tol_P_doom_lth','OS_hypos_tol_P_doom_lth');
##
full_study('OS_hypox_tol_P_resc_lth','OS_hypos_tol_P_resc_lth');
##
%full_study('OS_hypox_tol_P_boost_lth','OS_hypos_tol_P_boost_lth');
##
full_study('OS_hypox_boost_P_lth','OS_hypos_boost_P_lth');
##
%full_study('OS_hypox_boost_P_doom_lth','OS_hypos_boost_P_doom_lth');
##
full_study('OS_hypox_boost_P_resc_lth','OS_hypos_boost_P_resc_lth');
##
%full_study('OS_hypox_boost_P_boost_lth','OS_hypos_boost_P_boost_lth');
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




