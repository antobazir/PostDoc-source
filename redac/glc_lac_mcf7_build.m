%Meadows2008
MCF7_glc_lac(1).ref = 'Meadows2008'
MCF7_glc_lac(1).PMID = '18307352'
MCF7_glc_lac(1).O_pp = 21
MCF7_glc_lac(1).CO2_pp = '5'
MCF7_glc_lac(1).g_conc = 4.5/180
MCF7_glc_lac(1).ga_conc = 4e-3
MCF7_glc_lac(1).Pyr_conc = 1e-3
MCF7_glc_lac(1).Ser_conc = 5
MCF7_glc_lac(1).lac_conc0 = 0
MCF7_glc_lac(1).g_cons = '190 pm 30 fmol/cell/h'
MCF7_glc_lac(1).lac_prod = '370 pm 40 fmol/cell/h'
MCF7_glc_lac(1).ratio_lg = 370e-15/190e-15
MCF7_glc_lac(1).g_cons_val = 190e-15/60
MCF7_glc_lac(1).notes = 'consumption experiments with bioanalyzer'
MCF7_glc_lac(1).medium = 'DMEM base (Sigma), supplemented with 10 nM estradiol, 4 mM glutamine, 110 mg/L sodium pyruvate, 15 mM HEPES, 2.1 g/L sodium bicarbonate, 5% charcoal-dextran treated FBS, and 1 g/L d-glucose'
MCF7_glc_lac(1).med = 1 %'DMEM'
MCF7_glc_lac(1).dens0_surf = 18000 %cells/cm²
%From Falcon website he probably used 353025 (others are too small for the volume he used)


%Mazurek1997
MCF7_glc_lac(2).ref = 'Mazurek1997'
MCF7_glc_lac(2).PMID = '9030554'
MCF7_glc_lac(2).g_conc = 5e-3
MCF7_glc_lac(2).O_pp = 21
MCF7_glc_lac(2).ga_conc = 2e-3
MCF7_glc_lac(2).Pyr_conc = 4e-3
MCF7_glc_lac(2).Ser_conc = 20
MCF7_glc_lac(2).lac_conc0 = 0
MCF7_glc_lac(2).g_cons = '43.8 pm 0.5 nmol/h/0.1Mcell'
MCF7_glc_lac(2).lac_prod = '109.9 pm 0.9 nmol/h/0.1Mcell'
MCF7_glc_lac(2).ratio_lg = 109.9/43.8
MCF7_glc_lac(2).g_cons_val = 43.8e-9/60/100000
MCF7_glc_lac(2).notes = ' consumption experiments/ 5 mM glucose'
MCF7_glc_lac(2).medium = 'DMEM supplemented with 100 units of penicillin/ml, 100 mg of streptomycin/ml, 2mM glutamine, and 4 mM pyruvate (all from Biochrom, Berlin, Germany)'
MCF7_glc_lac(2).med = 1 %'DMEM'
MCF7_glc_lac(2).dens0_surf = 15e6/(4*pi*4) %cells/cm²

MCF7_glc_lac(3).ref = 'Mazurek1997'
MCF7_glc_lac(3).PMID = '9030554'
MCF7_glc_lac(3).g_conc = 0.5e-3
MCF7_glc_lac(3).O_pp = 21
MCF7_glc_lac(3).ga_conc = 2e-3
MCF7_glc_lac(3).Pyr_conc = 4e-3
MCF7_glc_lac(3).Ser_conc = 20
MCF7_glc_lac(3).lac_conc0 = 0
MCF7_glc_lac(3).g_cons = "13.0 pm 3.3 nmol/100000 cells/hr"
MCF7_glc_lac(3).lac_prod = "20.4 pm 6.4 nmol/100000 cells/hr"
MCF7_glc_lac(3).ratio_lg = 20.4/13.0
MCF7_glc_lac(3).g_cons_val = 13.0e-9/60/1e5
MCF7_glc_lac(3).notes = 'consumption experiments/0.5 mM glucose'
MCF7_glc_lac(3).medium = 'DMEM supplemented with 100 units of penicillin/ml, 100 mg of streptomycin/ml, 2mM glutamine, and 4 mM pyruvate (all from Biochrom, Berlin, Germany)'
MCF7_glc_lac(3).med = 1%'DMEM'
MCF7_glc_lac(3).dens0_surf = 15e6/(4*pi*4) %cells/cm²

MCF7_glc_lac(4).ref = 'Mazurek1997'
MCF7_glc_lac(4).PMID = '9030554'
MCF7_glc_lac(4).g_conc = 5e-3
MCF7_glc_lac(4).O_pp = 21
MCF7_glc_lac(4).ga_conc = 2e-3
MCF7_glc_lac(4).Pyr_conc = 4e-3
MCF7_glc_lac(4).Ser_conc = 20
MCF7_glc_lac(4).lac_conc0 = 0
MCF7_glc_lac(4).g_cons = '10.9 pm 0.5 nmol/100000/hr'
MCF7_glc_lac(4).lac_prod = '95.6 pm nmol/100000/hr'
MCF7_glc_lac(4).ratio_lg = 95.6/10.9
MCF7_glc_lac(4).g_cons_val = 10.9e-9/1e5/60
MCF7_glc_lac(4).notes = '5 mM glucose + AMP'
MCF7_glc_lac(4).medium = 'DMEM supplemented with 100 units of penicillin/ml, 100 mg of streptomycin/ml, 2mM glutamine, and 4 mM pyruvate (all from Biochrom, Berlin, Germany)'
MCF7_glc_lac(4).med = 1 %'DMEM'
MCF7_glc_lac(4).dens0_surf = 15e6/(4*pi*4) %cells/cm²

save('MCF7_glc_lac_data')

%Prado-Garcia
%glc 1 µmoles : 291
%glc 0 µmoles : 398
% 107 px/u
%lac 1 µmoles : 307
%lac 0 µmoles : 389
%82 px/u

%glc 1: 366+355 | 2: 370+368 | 3:349+341 | 4: 361+352
%lac 1: 348+339 | 2: 353 | 3:316+304 | 4: 323+310

%glc 1: 0.299 | 2: 0.262 | 3: 0.467 | 4: 0.346
%lac 1: 0.5 | 2: 0.439 | 3: 0.890 | 4: 0.805

MCF7_glc_lac(5).ref = 'Prado-Garcia2020'
MCF7_glc_lac(5).PMID = '32596143'
MCF7_glc_lac(5).g_conc = 10e-3
MCF7_glc_lac(5).ga_conc = 0.3/146
MCF7_glc_lac(5).Pyr_conc = 0
MCF7_glc_lac(5).Ser_conc = 10
MCF7_glc_lac(5).O_pp = 21;
MCF7_glc_lac(5).CO2_pp = 5;
MCF7_glc_lac(5).lac_conc0 = 2e-3
MCF7_glc_lac(5).g_cons = "0.3 pm 0.1 µmol/Mcells/hr"
MCF7_glc_lac(5).lac_prod = "0.5e pm 0.12 µmol/MCells/hr"
MCF7_glc_lac(5).ratio_lg = 0.5/0.3
MCF7_glc_lac(5).g_cons_val = 0.3e-6/1e6/60 '
MCF7_glc_lac(5).notes = 'supernatant/pH 7.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L| pyruvte 0 according to thermofishcer on similar product'
MCF7_glc_lac(5).medium = 'complete RPMI-1640 medium (Sigma-Aldrich, St. Louis, MO, USA) that contained 2 mM lactate and 10 mM glucose, it was supplemented with 10% heat-inactivated FCS (fetal calf serum, Hyclone, Logan, Utah, USA), 100 U/mL of penicillin and 100 μg/mL of streptomycin. '
MCF7_glc_lac(5).med = 2 %'RPMI 1640'
MCF7_glc_lac(5).dens0_surf = 1e5/1.9 %cells/cm²
%10⁵ c/mL + working volume 0.5-1 mL (vendor) + 1.9 cm² surf

MCF7_glc_lac(6).ref = 'Prado-Garcia2020'
MCF7_glc_lac(6).PMID = '32596143'
MCF7_glc_lac(6).g_conc = 10e-3
MCF7_glc_lac(6).ga_conc = 0.3/146
MCF7_glc_lac(6).Pyr_conc = 0
MCF7_glc_lac(6).Ser_conc = 10
MCF7_glc_lac(6).O_pp = 21;
MCF7_glc_lac(6).CO2_pp = 5;
MCF7_glc_lac(6).lac_conc0 = 2e-3
MCF7_glc_lac(6).g_cons = "0.26 pm 0.03 µmol/MCell/hr"
MCF7_glc_lac(6).lac_prod = "0.43 pm 0.04 µmol/Mcells/hr"
MCF7_glc_lac(6).ratio_lg = 0.44/0.26
MCF7_glc_lac(6).g_cons_val = 0.26e-6/1e6/60
MCF7_glc_lac(6).notes = 'supernatant/pH 6.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc_lac(6).medium = 'complete RPMI-1640 medium (Sigma-Aldrich, St. Louis, MO, USA) that contained 2 mM lactate and 10 mM glucose, it was supplemented with 10% heat-inactivated FCS (fetal calf serum, Hyclone, Logan, Utah, USA), 100 U/mL of penicillin and 100 μg/mL of streptomycin. '
MCF7_glc_lac(6).med = 2 %'RPMI 1640'
MCF7_glc_lac(6).dens0_surf = 1e5/1.9 %cells/cm²

MCF7_glc_lac(7).ref = 'Prado-Garcia2020'
MCF7_glc_lac(7).PMID = '32596143'
MCF7_glc_lac(7).g_conc = 10e-3
MCF7_glc_lac(7).ga_conc = 0.3/146
MCF7_glc_lac(7).Pyr_conc = 0
MCF7_glc_lac(7).Ser_conc = 10
MCF7_glc_lac(7).O_pp = 2;
MCF7_glc_lac(7).CO2_pp = 5;
MCF7_glc_lac(7).lac_conc0 = 2e-3
MCF7_glc_lac(7).g_cons = "0.45 pm 0.11 µmol/Mcells/hr"
MCF7_glc_lac(7).lac_prod = "0.92 pm 0.14 µmol/MCells/hr"
MCF7_glc_lac(7).ratio_lg = 0.89/0.47
MCF7_glc_lac(7).g_cons_val = 0.45e-6/1e6/60
MCF7_glc_lac(7).notes = 'supernatant/pH 7.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc_lac(7).medium = 'complete RPMI-1640 medium (Sigma-Aldrich, St. Louis, MO, USA) that contained 2 mM lactate and 10 mM glucose, it was supplemented with 10% heat-inactivated FCS (fetal calf serum, Hyclone, Logan, Utah, USA), 100 U/mL of penicillin and 100 μg/mL of streptomycin. '
MCF7_glc_lac(7).med =2 %'RPMI 1640'
MCF7_glc_lac(7).dens0_surf = 1e5/1.9 %cells/cm²

MCF7_glc_lac(8).ref = 'Prado-Garcia2020'
MCF7_glc_lac(8).PMID = '32596143'
MCF7_glc_lac(8).g_conc = 10e-3
MCF7_glc_lac(8).ga_conc = 0.3/146
MCF7_glc_lac(8).Pyr_conc = 0
MCF7_glc_lac(8).Ser_conc = 10
MCF7_glc_lac(8).O_pp = 2;
MCF7_glc_lac(8).CO2_pp = 5;
MCF7_glc_lac(8).lac_conc0 = 2e-3
MCF7_glc_lac(8).g_cons = "0.35 pm 0.1 µmol/MCells/hr"
MCF7_glc_lac(8).lac_prod = "0.83 pm  0.15 µmol/Mcells/hr"
MCF7_glc_lac(8).ratio_lg = 0.81/0.35
MCF7_glc_lac(8).g_cons_val = 0.35e-6/1e6/60
MCF7_glc_lac(8).notes = 'supernatant/pH 6.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc_lac(8).medium = 'complete RPMI-1640 medium (Sigma-Aldrich, St. Louis, MO, USA) that contained 2 mM lactate and 10 mM glucose, it was supplemented with 10% heat-inactivated FCS (fetal calf serum, Hyclone, Logan, Utah, USA), 100 U/mL of penicillin and 100 μg/mL of streptomycin. '
MCF7_glc_lac(8).med = 2% 'RPMI 1640'
MCF7_glc_lac(8).dens0_surf = 1e5/1.9 %cells/cm²

save('MCF7_glc_lac_data')
MCF7_glc_lac(9).ref =  'Bayar2021'
MCF7_glc_lac(9).PMID = '33927477'
MCF7_glc_lac(9).ga_conc = 2e-3
MCF7_glc_lac(9).g_conc = 0e-3
MCF7_glc_lac(9).O_pp = 21;
MCF7_glc_lac(9).CO2_pp = 5;
MCF7_glc_lac(9).lac_conc0 = 0
MCF7_glc_lac(9).Pyr_conc = 1e-3
MCF7_glc_lac(9).Ser_conc = 10
MCF7_glc_lac(9).g_cons = '0 mM'
MCF7_glc_lac(9).lac_prod = '1.6 pm 0.25 mM/24hr/6100*336pm200*4e-3pm1e-3'
MCF7_glc_lac(9).ratio_lg = 0
MCF7_glc_lac(9).notes = 'values are the 24hr values from fig 5|D6421 is DMEM F12 on sigmal website...'
MCF7_glc_lac(9).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(9).med = 3% 'DMEM F12'
MCF7_glc_lac(9).dens0_surf = 70000 %cells/cm²
%densité à 60% confluence 6.7e4 cells/cm² chez thermofischer

MCF7_glc_lac(10).ref =  'Bayar2021'
MCF7_glc_lac(10).PMID = '33927477'
MCF7_glc_lac(10).ga_conc = 2e-3
MCF7_glc_lac(10).g_conc = 0e-3
MCF7_glc_lac(10).O_pp = 1;
MCF7_glc_lac(10).CO2_pp = 5;
MCF7_glc_lac(10).lac_conc0 = 0
MCF7_glc_lac(10).Pyr_conc = 1e-3
MCF7_glc_lac(10).Ser_conc = 10
MCF7_glc_lac(10).g_cons = '0 mM'
MCF7_glc_lac(10).lac_prod = '1.95 pm 0.2 mM/24Hr/9600*336pm200*4e-3pm1e-3'
MCF7_glc_lac(10).ratio_lg = 0
MCF7_glc_lac(10).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(10).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(10).med = 3% 'DMEM F12'
MCF7_glc_lac(10).dens0_surf = 70000 %cells/cm²


MCF7_glc_lac(11).ref =  'Bayar2021'
MCF7_glc_lac(11).PMID = '33927477'
MCF7_glc_lac(11).ga_conc = 2e-3
MCF7_glc_lac(11).g_conc = 5.5e-3
MCF7_glc_lac(11).O_pp = 21;
MCF7_glc_lac(11).CO2_pp = 5;
MCF7_glc_lac(11).lac_conc0 = 0
MCF7_glc_lac(11).Pyr_conc = 1e-3
MCF7_glc_lac(11).Ser_conc = 10
MCF7_glc_lac(11).g_cons = '2.3 pm 0.9 mM/24hr/4400*336pm250*4e-3pm1e-3'
MCF7_glc_lac(11).lac_prod = '8 pm 1.5 mM/24hr/4400*336pm250*4e-3pm1e-3'
MCF7_glc_lac(11).ratio_lg = 8/2.3
MCF7_glc_lac(11).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(11).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(11).med = 3%'DMEM F12'
MCF7_glc_lac(11).dens0_surf = 70000 %cells/cm²



MCF7_glc_lac(12).ref =  'Bayar2021'
MCF7_glc_lac(12).PMID = '33927477'
MCF7_glc_lac(12).ga_conc = 2e-3
MCF7_glc_lac(12).g_conc = 5.5e-3
MCF7_glc_lac(12).O_pp = 1;
MCF7_glc_lac(12).CO2_pp = 5;
MCF7_glc_lac(12).lac_conc0 = 0
MCF7_glc_lac(12).Pyr_conc = 1e-3
MCF7_glc_lac(12).Ser_conc = 10
MCF7_glc_lac(12).g_cons = '4 pm 1 mM/24hr/8900*336pm450*4e-3pm1e-3'
MCF7_glc_lac(12).lac_prod = '10 pm 2 mM/24hr/8900*336pm450*4e-3pm1e-3'
MCF7_glc_lac(12).ratio_lg = 10/4
MCF7_glc_lac(12).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(12).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(12).med = 3% 'DMEM F12'
MCF7_glc_lac(12).dens0_surf = 70000 %cells/cm²



MCF7_glc_lac(13).ref =  'Bayar2021'
MCF7_glc_lac(13).PMID = '33927477'
MCF7_glc_lac(13).ga_conc = 2e-3
MCF7_glc_lac(13).g_conc = 15e-3
MCF7_glc_lac(13).O_pp = 21;
MCF7_glc_lac(13).CO2_pp = 5;
MCF7_glc_lac(13).lac_conc0 = 0
MCF7_glc_lac(13).Pyr_conc = 1e-3
MCF7_glc_lac(13).Ser_conc = 10
MCF7_glc_lac(13).g_cons = '4.5 pm 1 mM/24hr/5600*336pm300*4e-3pm1e-3'
MCF7_glc_lac(13).lac_prod = '6 pm 0 mM/24hr/5600*336pm300*4e-3pm1e-3'
MCF7_glc_lac(13).ratio_lg = 6/4.5
MCF7_glc_lac(13).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(13).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(13).med = 3%'DMEM F12'
MCF7_glc_lac(13).dens0_surf = 70000 %cells/cm²



MCF7_glc_lac(14).ref =  'Bayar2021'
MCF7_glc_lac(14).PMID = '33927477'
MCF7_glc_lac(14).ga_conc = 2e-3
MCF7_glc_lac(14).g_conc = 15e-3
MCF7_glc_lac(14).O_pp = 1;
MCF7_glc_lac(14).CO2_pp = 5;
MCF7_glc_lac(14).lac_conc0 = 0
MCF7_glc_lac(14).Pyr_conc = 1e-3
MCF7_glc_lac(14).Ser_conc = 10
MCF7_glc_lac(14).g_cons = '5.5 pm 1 mM/24hr/8800*336pm460*4e-3pm1e-3'
MCF7_glc_lac(14).lac_prod = '6 pm 2 mM/24hr/8800*336pm460*4e-3pm1e-3'
MCF7_glc_lac(14).ratio_lg = 6/5.5
MCF7_glc_lac(14).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(14).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(14).med = 3% 'DMEM F12'
MCF7_glc_lac(14).dens0_surf = 70000 %cells/cm²


MCF7_glc_lac(15).ref =  'Bayar2021'
MCF7_glc_lac(15).PMID = '33927477'
MCF7_glc_lac(15).ga_conc = 2e-3
MCF7_glc_lac(15).g_conc = 55e-3
MCF7_glc_lac(15).O_pp = 21;
MCF7_glc_lac(15).CO2_pp = 5;
MCF7_glc_lac(15).lac_conc0 = 0
MCF7_glc_lac(15).Pyr_conc = 1e-3
MCF7_glc_lac(15).Ser_conc = 10
MCF7_glc_lac(15).g_cons = '18 pm 5 mM/24hr/8600*336pm450*4e-3pm1e-3'
MCF7_glc_lac(15).lac_prod = '9 pm 2 mM/24hr/8600*336pm450*4e-3pm1e-3'
MCF7_glc_lac(15).ratio_lg = 9/18
MCF7_glc_lac(15).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(15).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(15).med = 1 %'DMEM'
MCF7_glc_lac(15).dens0_surf = 70000 %cells/cm²


MCF7_glc_lac(16).ref =  'Bayar2021'
MCF7_glc_lac(16).PMID = '33927477'
MCF7_glc_lac(16).ga_conc = 2e-3
MCF7_glc_lac(16).g_conc = 55e-3
MCF7_glc_lac(16).O_pp = 1;
MCF7_glc_lac(16).CO2_pp = 5;
MCF7_glc_lac(16).lac_conc0 = 0
MCF7_glc_lac(16).Pyr_conc = 1e-3
MCF7_glc_lac(16).Ser_conc = 10
MCF7_glc_lac(16).g_cons = '36.9 pm 3 mM/24hr/14800*336pm750*4e-3pm1e-3'
MCF7_glc_lac(16).lac_prod = '10 pm 4 mM/24hr/14800*336pm750*4e-3pm1e-3'
MCF7_glc_lac(16).ratio_lg = 10/36.9
MCF7_glc_lac(16).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(16).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(16).med =  1 %'DMEM '
MCF7_glc_lac(16).dens0_surf = 70000 %cells/cm²


MCF7_glc_lac(17).ref =  'SolaPenna2019'
MCF7_glc_lac(17).PMID = '31819176'
MCF7_glc_lac(17).ga_conc = 5e-3
MCF7_glc_lac(17).g_conc = 25e-3
MCF7_glc_lac(17).O_pp = 20;
MCF7_glc_lac(17).CO2_pp = 5;
MCF7_glc_lac(17).lac_conc0 = 0
MCF7_glc_lac(17).Pyr_conc = 0
MCF7_glc_lac(17).Ser_conc = 10
MCF7_glc_lac(17).g_cons = '0.6 nmol/10⁵ cells/24hr'
MCF7_glc_lac(17).lac_prod = '0.95 nmol/10⁵ cells/24hr'
MCF7_glc_lac(17).ratio_lg = 1.62
MCF7_glc_lac(17).g_cons_val = 0.6e-9/1e5/1440
MCF7_glc_lac(17).notes = 'uptake/ Only control value given but the compound makes it decrease'
MCF7_glc_lac(17).medium = 'Dulbecco’s Modified Eagle’s Medium (DMEM) with 25 mM glucose supplemented with 10% (vol/vol) heat-inactivated foetal bovine serum (FBS) and 5 mM L-glutamine (Invitrogen, São Paulo, SP, Brazil).'
MCF7_glc_lac(17).med = 1%'DMEM'
MCF7_glc_lac(17).dens0_surf = 0.7*8000/0.32 %cells/cm²


MCF7_glc_lac(18).ref =  'Bartmann2018'
MCF7_glc_lac(18).PMID = '29942509'
MCF7_glc_lac(18).g_conc = 5e-3
MCF7_glc_lac(18).ga_conc = 2.5e-3
MCF7_glc_lac(18).O_pp = 21;
MCF7_glc_lac(18).CO2_pp = 5;
MCF7_glc_lac(18).Pyr_conc = 5e-4
MCF7_glc_lac(18).Ser_conc = 10
MCF7_glc_lac(18).lac_conc0 = 0
MCF7_glc_lac(18).g_cons = '2 pm 1 mmol/L/OD'
MCF7_glc_lac(18).lac_prod = '7 pm 2 mmol/L/OD'
MCF7_glc_lac(18).ratio_lg = 7/2
MCF7_glc_lac(18).g_cons_val = 2e-3*0.15e-3/(5*1440)/0.04e-6
MCF7_glc_lac(18).notes = 'confluency after 5 days (0.04e6)/Glutamine value taken from the seahorse exp'
MCF7_glc_lac(18).medium = '(DMEM)/Hams F12 (1:1) medium (Gibco, ThermoFisher Scientific, Darmstadt, Germany) supplemented with 10% fetal calf serum (FCS; Biochrom, Berlin, Germany) and 50 ng/ml Gentamycin'
MCF7_glc_lac(18).med = 3%'DMEM F12'
MCF7_glc_lac(18).dens0_surf = 300/0.32 %cells/cm²


MCF7_glc_lac(19).ref =  'Bartmann2018'
MCF7_glc_lac(19).PMID = '29942509'
MCF7_glc_lac(19).g_conc = 5e-3
MCF7_glc_lac(19).ga_conc = 2.5e-3
MCF7_glc_lac(19).O_pp = 5;
MCF7_glc_lac(19).CO2_pp = 5;
MCF7_glc_lac(19).Pyr_conc = 5e-4
MCF7_glc_lac(19).lac_conc0 = 0
MCF7_glc_lac(19).g_cons = '0.8 pm 1 mmol/L/OD'
MCF7_glc_lac(19).lac_prod = '6 pm 2 mmol/L/OD'
MCF7_glc_lac(19).ratio_lg = 6/0.8
MCF7_glc_lac(19).g_cons_val = 0.8e-3*0.15e-3/(5*1440)/0.04e-6
MCF7_glc_lac(19).notes = 'density of 96-well plates taken Glutamine value taken from the seahorse exp'
MCF7_glc_lac(19).medium = '(DMEM)/Hams F12 (1:1) medium (Gibco, ThermoFisher Scientific, Darmstadt, Germany) supplemented with 10% fetal calf serum (FCS; Biochrom, Berlin, Germany) and 50 ng/ml Gentamycin'
MCF7_glc_lac(19).med = 3%'DMEM F12'
MCF7_glc_lac(19).dens0_surf = 300/0.32 %cells/cm²



MCF7_glc_lac(20).ref =  'Russell2022'
MCF7_glc_lac(20).PMID = '35840963'
MCF7_glc_lac(20).g_conc = 11.1e-3
MCF7_glc_lac(20).ga_conc = 2.05e-3
MCF7_glc_lac(20).O_pp = 21;
MCF7_glc_lac(20).CO2_pp = 5;
MCF7_glc_lac(20).Pyr_conc = 0
MCF7_glc_lac(20).Ser_conc = 10
MCF7_glc_lac(20).lac_conc0 = 0
MCF7_glc_lac(20).g_cons = '1.8 pm 0.2 pmol/cell/24h'
MCF7_glc_lac(20).lac_prod = '0.6 pm 0.2 pmol/cell/24h'
MCF7_glc_lac(20).ratio_lg = 0.6/1.8
MCF7_glc_lac(20).g_cons_val = 1.8e-12/1440
MCF7_glc_lac(20).notes = 'Nomroxic exp conditions assumed'
MCF7_glc_lac(20).medium = 'RPMI media 1640 (Life Technologies Gibco®, 11,875–093) supplemented with 10% FBS (Hyclone Laboratories, UT) under standard cell culture conditions. '
MCF7_glc_lac(20).med = 2%'RPMI 1640'
MCF7_glc_lac(20).dens0_surf = 0.9*4e4/0.32 %cells/cm²


MCF7_glc_lac(21).ref =  'Kammerer2015'
MCF7_glc_lac(21).PMID = '26187043'
MCF7_glc_lac(21).g_conc = 16.4e-3
MCF7_glc_lac(21).ga_conc = 2.5e-3
MCF7_glc_lac(21).O_pp = 21;
MCF7_glc_lac(21).CO2_pp = 5;
MCF7_glc_lac(21).Pyr_conc = 5e-4
MCF7_glc_lac(21).Ser_conc = 10
MCF7_glc_lac(21).lac_conc0 = 0
MCF7_glc_lac(21).g_cons = '10 pm 2 mmol/L/10000c/24hr'
MCF7_glc_lac(21).lac_prod = '1.28 pm 0.3 mmol/L/10000c/24hr'
MCF7_glc_lac(21).ratio_lg = 1.28/10
MCF7_glc_lac(21).g_cons_val = 10e-3*0.3e-3/1e5/1440
MCF7_glc_lac(21).notes = 'supernatant analysis/1e5 in supp material and 1e4 in paper/Nomroxic exp conditions assumed'
MCF7_glc_lac(21).medium = '1:1 mixture of DMEM/Ham"s F-12 supplemented with 10% (v/v) fetal calf serum (FCS) and 10 ng/ml gentamycine'
MCF7_glc_lac(21).med = 3%'DMEM F12'
MCF7_glc_lac(21).dens0_surf= 1e5*0.3/1.1 %cells/cm²


MCF7_glc_lac(22).ref =  'Patra2021'
MCF7_glc_lac(22).PMID = '33420162'
MCF7_glc_lac(22).g_conc = 25e-3
MCF7_glc_lac(22).ga_conc = 2e-3
MCF7_glc_lac(22).lac_conc0 = 1e-3
MCF7_glc_lac(22).Pyr_conc = 0
MCF7_glc_lac(22).O_pp = 5;
MCF7_glc_lac(22).CO2_pp = 5;
MCF7_glc_lac(22).g_cons = '80 pm 10 fmol/cell/h'
MCF7_glc_lac(22).lac_prod = '200 pm 30 fmol/cell/h'
MCF7_glc_lac(22).ratio_lg = 200/80
MCF7_glc_lac(22).g_cons_val = 80e-15/60
MCF7_glc_lac(22).notes = ' Pyr is assumed to be zero since no ref given| (she speaks about lactic acid) Results fro 2500 cells spheroid results| Oxygen is not available due to the devices being sealed | A value is given for each cell seeding density but the approximate median is given'
MCF7_glc_lac(22).medium = 'DMEM + GlutaMAX with 10% Fetal Bovine Serum (Gibco) and 1% Amphotericin B (Sigma-Aldrich, UK)'
MCF7_glc_lac(22).med = 4% 'DMEM + GlutaMAX'
MCF7_glc_lac(22).dens0_surf= -1 %cells/cm²
% 1000*2.5

MCF7_glc_lac(23).ref =  'Patra2021'
MCF7_glc_lac(23).PMID = '33420162'
MCF7_glc_lac(23).g_conc = 25e-3
MCF7_glc_lac(23).ga_conc = 2e-3
MCF7_glc_lac(23).lac_conc0 = 1e-3
MCF7_glc_lac(23).Pyr_conc = 0
MCF7_glc_lac(23).O_pp = 5;
MCF7_glc_lac(23).CO2_pp = 5;
MCF7_glc_lac(23).g_cons = '250 pm 20 fmol/cell/h'
MCF7_glc_lac(23).lac_prod = '700 pm 100 fmol/cell/h'
MCF7_glc_lac(23).ratio_lg = 700/250
MCF7_glc_lac(23).g_cons_val = 250e-15/60 
MCF7_glc_lac(23).notes = ' (she speaks about lactic acid) Results fro 2500 cells monolayer results| Oxygen is not available due to the devices being sealed | A value is given for each cell seeding density but the approximate median is given'
MCF7_glc_lac(23).medium = 'DMEM + GlutaMAX with 10% Fetal Bovine Serum (Gibco) and 1% Amphotericin B (Sigma-Aldrich, UK)'
MCF7_glc_lac(23).med = 4% 'DMEM + GlutaMAX'
MCF7_glc_lac(23).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(24).ref =  'Carta2024'
MCF7_glc_lac(24).PMID = '39082337'
MCF7_glc_lac(24).g_conc = 25e-3
MCF7_glc_lac(24).ga_conc = 2e-3
MCF7_glc_lac(24).lac_conc0 = 0
MCF7_glc_lac(24).Pyr_conc = 0
MCF7_glc_lac(24).O_pp = 21;
MCF7_glc_lac(24).CO2_pp = 5;
MCF7_glc_lac(24).g_cons = '9 pm 1 nmol/Mcell/min'
MCF7_glc_lac(24).lac_prod = 'nope'
MCF7_glc_lac(24).ratio_lg = 0
MCF7_glc_lac(24).g_cons_val = 9e-9/1e6
MCF7_glc_lac(24).notes = 'glucose consumtpion direct estimation'
MCF7_glc_lac(24).medium = 'MCF-7 cells were cultured in Dulbecco’s Modified Eagle Medium (DMEM) (#01-057-1A, Sartorius, AG, Göt-tingen, Germany) supplemented with 10% fetal bovine serum (10270-106, Thermo Fisher Scientific , Waltham, MA, USA), 25 mM glucose, 2 mM glutamine, 1 mM pyruvate,'
MCF7_glc_lac(24).med = 4% 'DMEM + GlutaMAX'
MCF7_glc_lac(24).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(25).ref =  'Carta2024'
MCF7_glc_lac(25).PMID = '39082337'
MCF7_glc_lac(25).g_conc = 2.5e-3
MCF7_glc_lac(25).ga_conc = 0.5e-3
MCF7_glc_lac(25).lac_conc0 = 0
MCF7_glc_lac(25).Pyr_conc = 0
MCF7_glc_lac(25).O_pp = 21;
MCF7_glc_lac(25).CO2_pp = 5;
MCF7_glc_lac(25).g_cons = '10 pm 0.2 nmol/Mcell/min'
MCF7_glc_lac(25).lac_prod = 'nope'
MCF7_glc_lac(25).ratio_lg = 0
MCF7_glc_lac(25).g_cons_val = 10e-9/1e6
MCF7_glc_lac(25).notes = 'glucose consumtpion FDG estimation'
MCF7_glc_lac(25).medium = 'idem but 2.5 mM glucose and 0.5 mM glutamine'
MCF7_glc_lac(25).med = 1% 'DMEM + GlutaMAX'
MCF7_glc_lac(25).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(26).ref =  'Carta2024'
MCF7_glc_lac(26).PMID = '39082337'
MCF7_glc_lac(26).g_conc = 25e-3
MCF7_glc_lac(26).ga_conc = 2e-3
MCF7_glc_lac(26).lac_conc0 = 0
MCF7_glc_lac(26).Pyr_conc = 0
MCF7_glc_lac(26).O_pp = 21;
MCF7_glc_lac(26).CO2_pp = 5;
MCF7_glc_lac(26).g_cons = '5 pm 2.5 nmol/Mcell/min'
MCF7_glc_lac(26).lac_prod = 'nope'
MCF7_glc_lac(26).ratio_lg = 0
MCF7_glc_lac(26).g_cons_val= 5e-9/1e6
MCF7_glc_lac(26).notes = 'glucose consumtpion direct estimation'
MCF7_glc_lac(26).medium = 'MCF-7 cells were cultured in Dulbecco’s Modified Eagle Medium (DMEM) (#01-057-1A, Sartorius, AG, Göt-tingen, Germany) supplemented with 10% fetal bovine serum (10270-106, Thermo Fisher Scientific , Waltham, MA, USA), 25 mM glucose, 2 mM glutamine, 1 mM pyruvate,'
MCF7_glc_lac(26).med = 1% 'DMEM + GlutaMAX'
MCF7_glc_lac(26).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(27).ref =  'Carta2024'
MCF7_glc_lac(27).PMID = '39082337'
MCF7_glc_lac(27).g_conc = 2.5e-3
MCF7_glc_lac(27).ga_conc = 0.5e-3
MCF7_glc_lac(27).lac_conc0 = 0
MCF7_glc_lac(27).Pyr_conc = 0
MCF7_glc_lac(27).O_pp = 21;
MCF7_glc_lac(27).CO2_pp = 5;
MCF7_glc_lac(27).g_cons = '2.5 pm 0 nmol/Mcell/min'
MCF7_glc_lac(27).lac_prod = 'nope'
MCF7_glc_lac(27).ratio_lg = 0
MCF7_glc_lac(27).g_cons_val = 2.5e-9/1e6
MCF7_glc_lac(27).notes = 'glucose consumtpion FDG estimation'
MCF7_glc_lac(27).medium = 'idem but 2.5 mM glucose and 0.5 mM glutamine'
MCF7_glc_lac(27).med = 1% 'DMEM + GlutaMAX'
MCF7_glc_lac(27).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')


MCF7_glc_lac(28).ref =  'Hamadneh2020'
MCF7_glc_lac(28).PMID = '33318536'
MCF7_glc_lac(28).g_conc = 11e-3
MCF7_glc_lac(28).ga_conc = 2.05e-3
MCF7_glc_lac(28).lac_conc0 = 0
MCF7_glc_lac(28).Pyr_conc = 0
MCF7_glc_lac(28).O_pp = 21;
MCF7_glc_lac(28).CO2_pp = 5;
MCF7_glc_lac(28).g_cons = '2.5 mg/dL/cell/24hr <-> 0.1389 mmol/L/cell/24hr'
MCF7_glc_lac(28).lac_prod = -1
MCF7_glc_lac(28).ratio_lg = -1
MCF7_glc_lac(28).g_cons_val =  0.1389e-3*11.5e-3/1440*1e-5
MCF7_glc_lac(28).notes = 'concentration based but glucose concentration is unclear'
MCF7_glc_lac(28).medium = ' RPMI 1640 (EuroClone S.p.A., Italy) media supplemented with 10% fetal bovine serum (FBS)'
MCF7_glc_lac(28).med = 2% 'RPMI'
MCF7_glc_lac(28).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')


MCF7_glc_lac(29).ref =  'Kakuturu2023'
MCF7_glc_lac(29).PMID = '37736248'
MCF7_glc_lac(29).g_conc = 25e-3
MCF7_glc_lac(29).ga_conc = 4e-3
MCF7_glc_lac(29).lac_conc0 = 0
MCF7_glc_lac(29).Pyr_conc = 0
MCF7_glc_lac(29).O_pp = 21;
MCF7_glc_lac(29).CO2_pp = 5;
MCF7_glc_lac(29).g_cons = '150 pm 45 mg/dL/7.5MCells/48hr <-> 8.33e-3 mmol/mL*30mL/7.5Mcell/48hr'
MCF7_glc_lac(29).lac_prod = -1
MCF7_glc_lac(29).ratio_lg = -1
MCF7_glc_lac(29).g_cons_val = 1.5/180*30*1e-3/(4*7.5e6)/2880
MCF7_glc_lac(29).notes = 'define range for pop/supernatant + gluco meter 0% oxygen reported but weird concentration based but glucose concentration is unclear'
MCF7_glc_lac(29).medium = ' Millipore Sigma, DMEM-high glucose, catalog # D6429'
MCF7_glc_lac(29).med = 1% 'DMEM'
MCF7_glc_lac(29).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(30).ref =  'Wang2023'
MCF7_glc_lac(30).PMID = '37108300'
MCF7_glc_lac(30).g_conc = 25e-3
MCF7_glc_lac(30).ga_conc = 2e-3
MCF7_glc_lac(30).lac_conc0 = 0
MCF7_glc_lac(30).Pyr_conc = 0
MCF7_glc_lac(30).O_pp = 21;
MCF7_glc_lac(30).CO2_pp = 5;
MCF7_glc_lac(30).g_cons = '9 pm 0.3 mmol/L/Mcell/24hr'
MCF7_glc_lac(30).lac_prod = '30+45 µg/L/100 000 Cell/24hr'
MCF7_glc_lac(30).g_cons_val = 9e-3*2e-3/1e6/1440
MCF7_glc_lac(30).ratio_lg = -1
MCF7_glc_lac(30).notes = 'uptake value'
MCF7_glc_lac(30).medium = 'DMEM supplemented with or without a high concentration of D-glucose (4500 mg/L) containing 10% FBS, 2 mM glutamine, and 100 units/mL penicillin/streptomycin (Gibco, New York, NY, USA).'
MCF7_glc_lac(30).med = 1% 'DMEM'
MCF7_glc_lac(30).dens0_surf= 1e6/9.6 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(31).ref =  'Guppy2002'
MCF7_glc_lac(31).PMID = '11988105'
MCF7_glc_lac(31).g_conc = 6e-3
MCF7_glc_lac(31).ga_conc = 1.5e-3
MCF7_glc_lac(31).lac_conc0 = 0
MCF7_glc_lac(31).Pyr_conc = 0
MCF7_glc_lac(31).O_pp = 21;
MCF7_glc_lac(31).CO2_pp = 5;
MCF7_glc_lac(31).g_cons = '0.075 µmol/10Mcell/hr'
MCF7_glc_lac(31).lac_prod = '5.39 pm 0.95 µmol/10Mcell/hr'
MCF7_glc_lac(31).ratio_lg = -1
MCF7_glc_lac(31).g_cons_val = 0.075e-6/1e7/60 
MCF7_glc_lac(31).notes = 'rates of fuel oxidation'
MCF7_glc_lac(31).medium = 'Dulbecco’s modified Eagle’s medium with the following additions : 6 mM glucose, 1.5 mM glutamine,Phenol Red (15 mg}l), Penstrep (10 ml}l) and 5 % FBS. 0.09 mM palmitate, 0.05 mM oleate,'
MCF7_glc_lac(31).med = 1% 'DMEM'
MCF7_glc_lac(31).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(32).ref =  'Marini2022'
MCF7_glc_lac(32).PMID = '36670904'
MCF7_glc_lac(32).g_conc = 25e-3
MCF7_glc_lac(32).ga_conc = 2e-3
MCF7_glc_lac(32).lac_conc0 = 0
MCF7_glc_lac(32).Pyr_conc = 1e-3
MCF7_glc_lac(32).O_pp = 21;
MCF7_glc_lac(32).CO2_pp = 5;
MCF7_glc_lac(32).g_cons = '13.5 pm 3 nmol/1 Mcell/min'
MCF7_glc_lac(32).lac_prod = 'N.A'
MCF7_glc_lac(32).ratio_lg = -1
MCF7_glc_lac(32).g_cons_val = 13.5e9/1e6
MCF7_glc_lac(32).notes = 'normal conditions/uptake'
MCF7_glc_lac(32).medium = 'Dulbecco’s Modified Eagle Medium (DMEM, Gibco, Los Angeles, CA, USA) supplemented with 10% fetal bovine serum, 25 mM glucose, 2 mM glutamine, 1 mM pyruvate, 1% penicillin-streptomycin (Gibco, Grand Island, NY, USA) at 37 °C with 5% CO2.'
MCF7_glc_lac(32).med = 1% 'DMEM'
MCF7_glc_lac(32).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(33).ref =  'Marini2022'
MCF7_glc_lac(33).PMID = '36670904'
MCF7_glc_lac(33).g_conc = 25e-3
MCF7_glc_lac(33).ga_conc = 0.5e-3
MCF7_glc_lac(33).lac_conc0 = 0
MCF7_glc_lac(33).Pyr_conc = 1e-3
MCF7_glc_lac(33).O_pp = 21;
MCF7_glc_lac(33).CO2_pp = 5;
MCF7_glc_lac(33).g_cons = '10.3 pm 2.5 nmol/1 Mcell/min'
MCF7_glc_lac(33).lac_prod = 'N.A'
MCF7_glc_lac(33).ratio_lg = -1
MCF7_glc_lac(33).g_cons_val = 10.3e-9/1e6
MCF7_glc_lac(33).notes = 'low glutamine/uptake'
MCF7_glc_lac(33).medium = 'Dulbecco’s Modified Eagle Medium (DMEM, Gibco, Los Angeles, CA, USA) supplemented with 10% fetal bovine serum, 25 mM glucose, 2 mM glutamine, 1 mM pyruvate, 1% penicillin-streptomycin (Gibco, Grand Island, NY, USA) at 37 °C with 5% CO2.'
MCF7_glc_lac(33).med = 1% 'DMEM'
MCF7_glc_lac(33).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(34).ref =  'Kaplan1990'
MCF7_glc_lac(34).PMID = ' 2380179'
MCF7_glc_lac(34).g_conc = 11e-3
MCF7_glc_lac(34).ga_conc = 2e-3
MCF7_glc_lac(34).lac_conc0 = 0
MCF7_glc_lac(34).Pyr_conc = 1e-3
MCF7_glc_lac(34).O_pp = 21;
MCF7_glc_lac(34).CO2_pp = 5;
MCF7_glc_lac(34).g_cons = '5 pm 0.45 µmol/1 Mcell/24hrs'
MCF7_glc_lac(34).lac_prod = 'N.A'
MCF7_glc_lac(34).ratio_lg = -1
MCF7_glc_lac(34).g_cons_val = 5e-6/1e6/1440
MCF7_glc_lac(34).notes = ''
MCF7_glc_lac(34).medium = 'Dulbecco’s Modified Eagle Medium (DMEM, Gibco, Los Angeles, CA, USA) supplemented with 10% fetal bovine serum, 25 mM glucose, 2 mM glutamine, 1 mM pyruvate, 1% penicillin-streptomycin (Gibco, Grand Island, NY, USA) at 37 °C with 5% CO2.'
MCF7_glc_lac(34).med = 1% 'DMEM'
MCF7_glc_lac(34).dens0_surf= 250000/25 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(35).ref =  'Moreira2013'
MCF7_glc_lac(35).PMID = '23664836'
MCF7_glc_lac(35).g_conc = 55e-3
MCF7_glc_lac(35).ga_conc = 0e-3
MCF7_glc_lac(35).lac_conc0 = 0
MCF7_glc_lac(35).Pyr_conc = 0e-3
MCF7_glc_lac(35).O_pp = 21;
MCF7_glc_lac(35).CO2_pp = 5;
MCF7_glc_lac(35).g_cons = '13.5 pm 4.8 µmol/mg prot/6 min 310pg/cell'
MCF7_glc_lac(35).lac_prod = 'N.A'
MCF7_glc_lac(35).ratio_lg = -1
MCF7_glc_lac(35).g_cons_val = '13.5 pm 4.8 µmol/mg prot/6 min'
MCF7_glc_lac(35).notes = 'glucose uptake/lots of sugar...but it 10X on the site so it 5.5 ?'
MCF7_glc_lac(35).medium = 'grown in minimum essential medium supplemented with 10% heat-inactivated fetal bovine serum and 1% antibiotic/antimycotic solution '
MCF7_glc_lac(35).med = 5% 'MEM'
MCF7_glc_lac(35).dens0_surf= 250000/25 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(36).ref =  'Wang2023'
MCF7_glc_lac(36).PMID = '37108360'
MCF7_glc_lac(36).g_conc = 25e-3
MCF7_glc_lac(36).ga_conc = 2e-3
MCF7_glc_lac(36).lac_conc0 = 0
MCF7_glc_lac(36).Pyr_conc = 0
MCF7_glc_lac(36).O_pp = 21;
MCF7_glc_lac(36).CO2_pp = 5;
MCF7_glc_lac(36).g_cons = '7.7 pm 1.1 mmol/L/Mcell/24hr'
MCF7_glc_lac(36).lac_prod = '36+45 µg/L/100 000 Cell/24hr'
MCF7_glc_lac(36).ratio_lg = -1
MCF7_glc_lac(36).g_cons_val =  7.7e-3*2e-3/1e6/1440
MCF7_glc_lac(36).notes = 'consumption value/ assumed volume 2mL'
MCF7_glc_lac(36).medium = 'DMEM supplemented with or without a high concentration of D-glucose (4500 mg/L) containing 10% FBS, 2 mM glutamine, and 100 units/mL penicillin/streptomycin (Gibco, New York, NY, USA).'
MCF7_glc_lac(36).med = 1% 'DMEM'
MCF7_glc_lac(36).dens0_surf= 1e6/9.6 %cells/cm²
save('MCF7_glc_lac_data')

MCF7_glc_lac(37).ref =  'Marini2022'
MCF7_glc_lac(37).PMID = '36670904'
MCF7_glc_lac(37).g_conc = 25e-3
MCF7_glc_lac(37).ga_conc = 2.5e-3
MCF7_glc_lac(37).lac_conc0 = 0
MCF7_glc_lac(37).Pyr_conc = 1e-3
MCF7_glc_lac(37).O_pp = 21;
MCF7_glc_lac(37).CO2_pp = 5;
MCF7_glc_lac(37).g_cons = '13.7 pm 2.6 nmol/1 Mcell/min'
MCF7_glc_lac(37).lac_prod = 'N.A'
MCF7_glc_lac(37).ratio_lg = -1
MCF7_glc_lac(37).g_cons_val = 13.7e-9/1e6
MCF7_glc_lac(37).notes = 'consumption'
MCF7_glc_lac(37).medium = 'Dulbecco’s Modified Eagle Medium (DMEM, Gibco, Los Angeles, CA, USA) supplemented with 10% fetal bovine serum, 25 mM glucose, 2 mM glutamine, 1 mM pyruvate, 1% penicillin-streptomycin (Gibco, Grand Island, NY, USA) at 37 °C with 5% CO2.'
MCF7_glc_lac(37).med = 1% 'DMEM'
MCF7_glc_lac(37).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')


%MCF7_glc_lac(29).ref =  'Karim2024'
%MCF7_glc_lac(29).PMID = '38686050'
%MCF7_glc_lac(29).g_conc = 30e-3
%MCF7_glc_lac(29).ga_conc = 2.05e-3
%MCF7_glc_lac(29).lac_conc0 = 0
%MCF7_glc_lac(29).Pyr_conc = 0
%MCF7_glc_lac(29).O_pp = 21;
%MCF7_glc_lac(29).CO2_pp = 5;
%MCF7_glc_lac(29).g_cons = '1.75 pm 0.25 pmol/cell'
%MCF7_glc_lac(29).lac_prod = '0.5 pm 0.2 pmol/cell'
%MCF7_glc_lac(29).ratio_lg = 0.5/1.75
%MCF7_glc_lac(29).notes = 'concentration based but glucose concentration is unclear'
%MCF7_glc_lac(29).medium = '(DMEM) containing 10% fetal bovine serum (FBS) and 1% penicillin–streptomycin'
%MCF7_glc_lac(29).med = 1% 'DMEM + GlutaMAX'
%MCF7_glc_lac(29).dens0_surf= -1 %cells/cm²
%save('MCF7_glc_lac_data')


https://pmc.ncbi.nlm.nih.gov/articles/PMC10509689/

%MCF7_glc_lac(25).ref =  'Romero-Garcia2019'
%MCF7_glc_lac(25).PMID = '31681589'
%MCF7_glc_lac(24).g_conc = 25e-3
%MCF7_glc_lac(24).ga_conc = 2e-3
%MCF7_glc_lac(24).lac_conc0 = 1e-3
%MCF7_glc_lac(24).Pyr_conc = 0
%MCF7_glc_lac(24).O_pp = 5;
%MCF7_glc_lac(24).CO2_pp = 5;
%MCF7_glc_lac(24).g_cons = '250 pm 20 fmol/cell/h'
%MCF7_glc_lac(24).lac_prod = '700 pm 100 fmol/cell/h'
%MCF7_glc_lac(24).ratio_lg = 700/250
%MCF7_glc_lac(24).notes = ' (she speaks about lactic acid) Results fro 2500 cells monolayer results| Oxygen is not available due to the devices being sealed | A value is given for each cell seeding density but the approximate median is given'
%MCF7_glc_lac(24).medium = 'DMEM + GlutaMAX with 10% Fetal Bovine Serum (Gibco) and 1% Amphotericin B (Sigma-Aldrich, UK)'
%MCF7_glc_lac(24).med = 4% 'DMEM + GlutaMAX'
%MCF7_glc_lac(24).dens0_surf= -1 %cells/cm²
%save('MCF7_glc_lac_data')

%Analysis___________________
for i = 1:length(MCF7_glc_lac)

	MCF7_g_conc(i) = MCF7_glc_lac(i).g_conc
	MCF7_g_ratio(i) = MCF7_glc_lac(i).ratio_lg
	MCF7_ga_conc(i) = MCF7_glc_lac(i).ga_conc
	MCF7_Pyr_conc(i) = MCF7_glc_lac(i).Pyr_conc
	MCF7_lac_conc0(i) = MCF7_glc_lac(i).lac_conc0
	MCF7_med(i) = MCF7_glc_lac(i).med
	MCF7_O(i) = MCF7_glc_lac(i).O_pp
	MCF7_lac(i) = MCF7_glc_lac(i).lac_conc0

endfor

figure
scatter(MCF7_g_conc,MCF7_g_ratio)

figure
scatter(MCF7_ga_conc,MCF7_g_ratio)

figure
scatter(MCF7_Pyr_conc,MCF7_g_ratio)

figure
scatter(MCF7_O,MCF7_g_ratio)

figure
scatter(MCF7_med,MCF7_g_ratio)

figure
scatter(MCF7_lac,MCF7_g_ratio)

figure
scatter3(MCF7_Pyr_conc,MCF7_ga_conc,MCF7_g_ratio)

figure
scatter3(MCF7_g_conc*1e3,MCF7_O,MCF7_g_ratio,'x')
xlabel("Glucose concentration (mM)")
ylabel("Oxygen partial pressure (%)")
zlabel("Lactate/glucose ratio")

G_vs_O_ratio = [MCF7_g_conc; MCF7_O ;MCF7_g_ratio]'

% a peu près 3 donc là ça va
G_vs_O_ratio([2 11 18],:)

% là non la manip de Russel
G_vs_O_ratio([5 6 20],:)

G_vs_O_ratio([1 17],:)

G_vs_O_ratio([13 21],:)

G_O_P_L_med_ratio = [MCF7_g_conc; MCF7_O;MCF7_Pyr_conc; MCF7_lac_conc0 ;MCF7_med ;MCF7_g_ratio]'

G_O_P_L_med_ratio([2 11 18],:)

G_O_P_L_med_ratio([5 6 20],:)

G_O_P_L_med_ratio([13 21],:)

G_O_P_L_med_ratio([1 17],:)

G_O_P_L_med_ratio([19 7 8 14],:)
