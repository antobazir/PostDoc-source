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
MCF7_glc_lac(1).g_cons = 190e-15/3600
MCF7_glc_lac(1).lac_prod = 370e-15/3600
MCF7_glc_lac(1).ratio_lg = 370e-15/190e-15
MCF7_glc_lac(1).notes = 'lol'
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
MCF7_glc_lac(2).g_cons = 1.26e-16
MCF7_glc_lac(2).lac_prod = 109.9e-9/100000/3600
MCF7_glc_lac(2).ratio_lg = 109.9/43.8
MCF7_glc_lac(2).notes = ' 5 mM glucose'
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
MCF7_glc_lac(3).g_cons = 13.0e-9/100000/3600
MCF7_glc_lac(3).lac_prod = 20.4e-9/100000/3600
MCF7_glc_lac(3).ratio_lg = 20.4/13.0
MCF7_glc_lac(3).notes = '0.5 mM glucose'
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
MCF7_glc_lac(4).g_cons = 10.0e-9/100000/3600
MCF7_glc_lac(4).lac_prod = 95.6e-9/100000/3600
MCF7_glc_lac(4).ratio_lg = 95.6/10.0
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
MCF7_glc_lac(5).g_cons = 0.29e-6/1e6/3600
MCF7_glc_lac(5).lac_prod = 0.5e-6/1e6/3600
MCF7_glc_lac(5).ratio_lg = 0.5/0.3
MCF7_glc_lac(5).notes = 'pH 7.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L| pyruvte 0 according to thermofishcer on similar product'
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
MCF7_glc_lac(6).g_cons = 0.26e-6/1e6/3600
MCF7_glc_lac(6).lac_prod = 0.44e-6/1e6/3600
MCF7_glc_lac(6).ratio_lg = 0.44/0.26
MCF7_glc_lac(6).notes = 'pH 6.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
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
MCF7_glc_lac(7).g_cons = 0.47e-6/1e6/3600
MCF7_glc_lac(7).lac_prod = 0.89e-6/1e6/3600
MCF7_glc_lac(7).ratio_lg = 0.89/0.47
MCF7_glc_lac(7).notes = 'pH 7.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
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
MCF7_glc_lac(8).g_cons = 0.35e-6/1e6/3600
MCF7_glc_lac(8).lac_prod = 0.81e-6/1e6/3600
MCF7_glc_lac(8).ratio_lg = 0.81/0.35
MCF7_glc_lac(8).notes = 'pH 6.2 | Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
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
MCF7_glc_lac(9).g_cons = '0'
MCF7_glc_lac(9).lac_prod = '1.5 pm 0.5'
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
MCF7_glc_lac(10).g_cons = '0'
MCF7_glc_lac(10).lac_prod = '2 pm 0.2'
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
MCF7_glc_lac(11).g_cons = '2.3 pm 1'
MCF7_glc_lac(11).lac_prod = '8 pm 1.5'
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
MCF7_glc_lac(12).g_cons = '4 pm 1'
MCF7_glc_lac(12).lac_prod = '10 pm 2'
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
MCF7_glc_lac(13).g_cons = '4.5 pm 1'
MCF7_glc_lac(13).lac_prod = '6 pm 0'
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
MCF7_glc_lac(14).g_cons = '5.5 pm 1'
MCF7_glc_lac(14).lac_prod = '6 pm 2'
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
MCF7_glc_lac(15).g_cons = '18 pm 5'
MCF7_glc_lac(15).lac_prod = '9 pm 2'
MCF7_glc_lac(15).ratio_lg = 9/18
MCF7_glc_lac(15).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(15).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(15).med = 3 %'DMEM F12'
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
MCF7_glc_lac(16).g_cons = '36.9  pm 3'
MCF7_glc_lac(16).lac_prod = '10 pm 4'
MCF7_glc_lac(16).ratio_lg = 10/36.9
MCF7_glc_lac(16).notes = 'values are the 24hr values from fig 5'
MCF7_glc_lac(16).medium = ' (DMEM; Sigma, D6421) supplemented with 10% heat in-activated fetal bovine serum (FBS, Sigma, F0804). All media were supplemented with 10 U/ml of penicillin and 10 µg/mL streptomycin (Gibco), 1 mM sodium pyruvate (Sigma, P5280) and 2 mM l-Glutamine (Gibco).'
MCF7_glc_lac(16).med =  3 %'DMEM F12'
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
MCF7_glc_lac(17).g_cons = '0.6 nmol/10⁵ cells'
MCF7_glc_lac(17).lac_prod = '0.95 nmol/10⁵ cells'
MCF7_glc_lac(17).ratio_lg = 1.62
MCF7_glc_lac(17).notes = 'Only control value given but the compound makes it decrease'
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
MCF7_glc_lac(18).notes = 'Glutamine value taken from the seahorse exp'
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
MCF7_glc_lac(19).notes = 'Glutamine value taken from the seahorse exp'
MCF7_glc_lac(19).medium = '(DMEM)/Hams F12 (1:1) medium (Gibco, ThermoFisher Scientific, Darmstadt, Germany) supplemented with 10% fetal calf serum (FCS; Biochrom, Berlin, Germany) and 50 ng/ml Gentamycin'
MCF7_glc_lac(19).med = 3%'DMEM F12'
MCF7_glc_lac(19).dens0_surf = 300/0.32 %cells/cm²



MCF7_glc_lac(20).ref =  'Russell2020'
MCF7_glc_lac(20).PMID = '35840963'
MCF7_glc_lac(20).g_conc = 11.1e-3
MCF7_glc_lac(20).ga_conc = 2.05e-3
MCF7_glc_lac(20).O_pp = 20;
MCF7_glc_lac(20).CO2_pp = 5;
MCF7_glc_lac(20).Pyr_conc = 0
MCF7_glc_lac(20).Ser_conc = 10
MCF7_glc_lac(20).lac_conc0 = 0
MCF7_glc_lac(20).g_cons = '1.8 pm 0.2 pmol/cell'
MCF7_glc_lac(20).lac_prod = '0.6 pm 0.2 pmol/cell'
MCF7_glc_lac(20).ratio_lg = 0.6/1.8
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
MCF7_glc_lac(21).g_cons = '10 pm 3 pmol/cell'
MCF7_glc_lac(21).lac_prod = '1.28 pm 0.3 mmol/L/10000c/24hr'
MCF7_glc_lac(21).ratio_lg = 1.28/10
MCF7_glc_lac(21).notes = 'Nomroxic exp conditions assumed'
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
MCF7_glc_lac(23).notes = ' (she speaks about lactic acid) Results fro 2500 cells monolayer results| Oxygen is not available due to the devices being sealed | A value is given for each cell seeding density but the approximate median is given'
MCF7_glc_lac(23).medium = 'DMEM + GlutaMAX with 10% Fetal Bovine Serum (Gibco) and 1% Amphotericin B (Sigma-Aldrich, UK)'
MCF7_glc_lac(23).med = 4% 'DMEM + GlutaMAX'
MCF7_glc_lac(23).dens0_surf= -1 %cells/cm²
save('MCF7_glc_lac_data')

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
scatter3(MCF7_g_conc,MCF7_O,MCF7_g_ratio)

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
