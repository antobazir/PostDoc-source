Meadows.g_cons =
Meadows08.g_cons = 190e-15/3600
Meadows08.g_conc = 4.5/180
Meadows08.O_pp = 21
Meadows08.ga_conc = 4e-3
Meadows08.Pyr_conc = 1e-3
Meadows08.HEPES_conc = 15e-3
Meadows08.CO2_pp = 2
Meadows08.notes = 'glucose might be 5.5 g/L"
Meadows08.notes = 'glucose might be 5.5 g/L'
save('MCF7_glc_data')
Meadows08.Ser_perc = 5
save('MCF7_glc_data')
Mazurek.g_conc = 5e-3
MCF7_glc(1).g_cons = Meadows08.g_cons
MCF7_glc(1) = Meadows08
MCF7_glc( = Meadows08
MCF7_glc = Meadows08
MCF7_glc(2) = Meadows08
clear MCF7_glc
MCF7_glc = Meadows08
MCF7_glc.ref = 'Meadows2008'
MCF7_glc.PMID =  18307352
MCF7_glc.PMID
MCF7_glc.PMID =  '18307352'
save('MCF7_glc_data')
MCF_glc(2).ref = 'Mazurek1997'
MCF7_glc(2).ref = 'Mazurek1997'
MCF7_glc(2).PMID = '9030554'
MCF7_glc(2).g_conc = 5e-3
MCF7_glc(2)
MCF7_glc(2).g_cons = 1.26e-16
MCF7_glc(2).O_pp = 21
MCF7_glc(2)
MCF7_glc(2).Ser_perc = 10
MCF7_glc(2).Ser_perc = 20
MCF7_glc(2).Pyr_conc = 4e-3
MCF7_glc(2)
MCF7_glc(2).ga_conc = 2e-3
MCF7_glc(2).CO2_pp = 5
MCF7_glc(2)
save('MCF7_glc_data')
clear ('MCF_glc');
save('MCF7_glc_data')
MCF7_glc(3) = MCF7_glc(2)
MCF7_glc(3)
MCF7_glc(3).g_cons = 3.6e-17
MCF7_glc(3).g_conc = 0.5e-3
MCF7_glc(3)
save('MCF7_glc_data')
MCF7_glc(4).ref = 'Prado-Garcia2020'
MCF7_glc(4)
MCF7_glc(4).PMID = '32596143'
MCF7_glc(5:7) = MCF7_glc(4)
MCF7_glc(5)
MCF7_glc(4)
(351-[318 322 302 313])/106
Prado_gcs =
Prado_gcs = (351-[318 322 302 313])/106
Prado_gcs = (351-[318 322 302 313])/106*1e-6/3600
Prado_gcs = (351-[318 322 302 313])/106*1e-6/3600*1e-6
MCF7_glc(4)
MCF7_glc(4:7).g_conc = 10e-3
MCF7_glc(4).g_conc = 10e-3
MCF7_glc(5).g_conc = 10e-3
MCF7_glc(6).g_conc = 10e-3
MCF7_glc(7).g_conc = 10e-3
MCF7_glc(4)
MCF7_glc(4:)
MCF7_glc(4:5)
MCF7_glc(4:5).g_conc
MCF7_glc(4:5).g_conc = [0 0]
MCF7_glc.g_conc(4:5) = 0
setfield(MCF7_glc(4:5),g_conc,[0 0])
setfield(MCF7_glc(4:5),'g_conc',[0 0])
setfield(MCF7_glc,'g_conc',{4, 5},0)
MCF7_glc(4).g_conc
MCF7_glc(4)
setfield(MCF7_glc,{4, 5},'g_conc',0)
MCF7_glc(4)
MCF7_glc(5)
setfield(MCF7_glc,{4, 5},'g_conc',0)
setfield(MCF7_glc,'g_conc',{4:5},0)
clear ('ans');
setfield(MCF7_glc(4:7),'g_conc',0.01)
setfield(MCF7_glc2,'g_conc',0.01)
MCF7_glc2 = MCF7_glc
setfield(MCF7_glc2,'g_conc',0.01)
setfield(MCF7_glc2,g_conc,0.01)
setfield(MCF7_glc2(1),'g_conc',0.01)
setfield(MCF7_glc2,'g_conc',0.01)
clear ('MCF7_glc2');
MCF7_glc
MCF7_glc(4)
MCF7_glc(4).g_cons = Prado_gcs(1)
MCF7_glc(4)
MCF7_glc(4).O_pp = 21
MCF7_glc(4)
MCF7_glc(4).ga_conc = 0.3/146
MCF7_glc(4)
MCF7_glc(4).notes = 'Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc(5).notes = 'Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc(6).notes = 'Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc(7).notes = 'Glutamine is not specified but on sigma wbesite it is generally there at 0.3g/L'
MCF7_glc(4)
MCF7_glc(4).Ser_perc = 10
MCF7_glc(5).Ser_perc = 10
MCF7_glc(6).Ser_perc = 10
MCF7_glc(7).Ser_perc = 10
MCF7_glc(4)
MCF7_glc(4).CO2_pp =  5
MCF7_glc(5).CO2_pp =  5
MCF7_glc(6).CO2_pp =  5
MCF7_glc(7).CO2_pp =  5
MCF7_glc(4)
MCF7_glc(4).pH
MCF7_glc(4).pH = 7.2
MCF7_glc(4).lac_conc0 = 2e-3
MCF7_glc(5).lac_conc0 = 2e-3
MCF7_glc(6).lac_conc0 = 2e-3
MCF7_glc(7).lac_conc0 = 2e-3
MCF7_glc(4)
disp (Prado_gcs);
MCF7_glc(5).g_cons = 7.599e-17
MCF7_glc(5)
MCF7_glc(5).O_pp = 21; MCF7_glc(5).ga_conc = 2.0548e-03
MCF7_glc(6).O_pp = 2; MCF7_glc(6).ga_conc = 2.0548e-03
MCF7_glc(7).O_pp = 2; MCF7_glc(7).ga_conc = 2.0548e-03
MCF7_glc(5)
MCF7_glc(5).pH =  6.2
MCF7_glc(5)
MCF7_glc(6)
MCF7_glc(6).g_cons = Prado_gcs(3)
MCF7_glc(6)
MCF7_glc(6).pH = 7.2
MCF7_glc(6)
MCF7_glc(7).g_cons = Prado_gcs(4)
MCF7_glc(7)
MCF7_glc(7).pH = 6.2
MCF7_glc(7)
save('MCF7_glc_data')
MCF7_glc.g_conc
MCF7_glc.g_cons
(351-[318 322 302 313])/106
([7 3 9 8])/106
10e-3*180
save('MCF7_glc_data')
MCF7_glc(8).ref = 'Kaplan1990'
MCF7_glc(8).PMID = '2380179'
MCF7_glc(8)
MCF7_glc(8).g_conc = 11e-3
MCF7_glc(8)
5e-6/1440/60/1e6
MCF7_glc(8).g_cons = 5e-6/1440/60/1e6
MCF7_glc(8)
MCF7_glc(8).g_conc = 11e-3
MCF7_glc(8)
MCF7_glc(8).O_pp = 21
MCF7_glc(8)
MCF7_glc(8).CO2_pp = 5
MCF7_glc(8)
MCF7_glc(8).Ser_perc = 10
MCF7_glc(8)
MCF7_glc(8).Pyr_conc = 1e-3
MCF7_glc(8).notes = 'glutamine conc is taken from thermofischer formulation as they are not given in the study
MCF7_glc(8).notes = 'glutamine conc is taken from thermofischer formulation as they are not given in the study'
MCF7_glc(8)
MCF7_glc(8).ga_conc = 2e-3
MCF7_glc(8)
MCF7_glc(9).ref = 'Gardner2022'
MCF7_glc(9).PMID = '35876286'
MCF7_glc(9)
MCF7_glc(9).CO2_pp = 5
MCF7_glc(9)
MCF7_glc(9).O2_pp = 18
MCF7_glc(9)
rmfield
rmfield(MCF7_glc,O2_pp)
rmfield(MCF7_glc(9),O2_pp)
rmfield(MCF7_glc,'O2_pp')
MCF7_glc(9).O_pp = 18
MCF7_glc(9)
rmfield(MCF7_glc(9),'O2_pp')
MCF7_glc = rmfield(MCF7_glc,'O2_pp')
MCF7_glc(9)
MCF7_glc(9).g_conc = 5.8e-3
MCF7_glc(9)
MCF7_glc(9).Ser_perc =  2.5
MCF7_glc(9)
MCF7_glc(9).notes = 'Some info were retrieved in the ref 8 by Vander Voorde'
save('MCF7_glc_data')
MCF7_glc(9)
MCF7_glc(9).ga_conc = 650e-6
MCF7_glc(9).la_conc0 = 500e-6
MCF7_glc(9).Pyr_conc = 100e-6
MCF7_glc(9)
save('MCF7_glc_data')
MCF7_glc(9)
MCF7_glc(9).g_cons = 796e-15/3600
MCF7_glc(9)
MCF7_glc(9)
MCF7_glc(10)
MCF7_glc(10)=MCF7_glc(9)
MCF7_glc(10).O_pp = 5
MCF7_glc(10)
5.8e-3/180
5.8e-3*180
save('MCF7_glc_data')
MCF7_glc(10).lac_conc0 = 5e-4
MCF7_glc(9).lac_conc0 = 5e-4
MCF7_glc(10)
rmfield(MCF7_glc,'la_conc0')
MCF7_glc(10)
MCF7_glc = rmfield(MCF7_glc,'la_conc0')
MCF7_glc(10)
save('MCF7_glc_data')
MCF7_glc(11)
MCF7_glc(11).ref =  'Bayar2021'
MCF7_glc(11)
MCF7_glc(11).PMID = '33927477'
MCF7_glc(11)
MCF7_glc(11).ga_conc = 2e-3
MCF7_glc(11).Ser_perc = 10
MCF7_glc(11)
MCF7_glc(11).O_pp = 20
MCF7_glc(11)
MCF7_glc(11).CO2_pp = 5
MCF7_glc(11)
MCF7_glc(11).Pyr_conc = 1e-3
MCF7_glc(11).g_conc = 5.5e-3
MCF7_glc(11)
MCF7_glc(11)
5.5e-3*5e-3
5.5e-3*5e-3/2.5e-6
5.5e-3*5e-3/2.5e6
(0.26+1.11+0.67+2.29)
4.33e-3*5e-3/2.5e6
MCF7_glc(11)
MCF7_glc(11).notes = "consumption were calculated assuming a working volume of 5 mL and 2.5 M cells "
4.33e-3*5e-3/2.5e6/1440/60
MCF7_glc(11)
MCF7_glc(11).notes = "consumption were calculated assuming a working volume of 5 mL and 2.5 M cells Corning "
MCF7_glc(11)
4.33e-3*5e-3/2.5e6/1440/60
MCF7_glc(11).g_cons = 4.33e-3*5e-3/2.5e6/1440/60
MCF7_glc(11)
MCF7_glc(12) = MCF7_glc(11)
MCF7_glc(12)
MCF7_glc(12).g_conc = 15e-3
(0.46+0.57+2.92+4.52)
8.47e-3*5e-3/2.5e6/1440/60
MCF7_glc(11).g_cons = 8.47e-3*5e-3/2.5e6/1440/60
MCF7_glc(11).g_cons = 4.33e-3*5e-3/2.5e6/1440/60
MCF7_glc(12).g_cons = 8.47e-3*5e-3/2.5e6/1440/60
MCF7_glc(12)
MCF7_glc(13) = MCF7_glc(12)
MCF7_glc(13).g_conc =  55e-3
MCF7_glc(13)
(27.3+13.92+37.5+18.03)
MCF7_glc(13).g_cons = 96.750/1440/60/2.5e6
MCF7_glc(13)
MCF7_glc(13).g_cons = 96.750e-3/1440/60/2.5e6
MCF7_glc(13)
MCF7_glc(12).g_cons = 8.47e-3*5e-3/(2.5e6*1.25)/1440/60
MCF7_glc(12)
MCF7_glc(12).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient'
MCF7_glc(12).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient (1.25)'
95-52
43/100
43/50
11/0.86
MCF7_glc(12).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient (1.13)'
MCF7_glc(12).g_cons = 8.47e-3*5e-3/(2.5e6*1.13)/1440/60
MCF7_glc(12)
95-31
64/0.86
MCF7_glc(13).g_cons = 96.750e-3/1440/60/(2.5e6*1.74)
MCF7_glc(13)
MCF7_glc(13).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient (1.74)'
MCF7_glc(13)
save('MCF7_glc_data')
MCF7_glc(14) = MCF7_glc(11)
MCF7_glc(14)
MCF7_glc(14).O_pp = 1
4.33e-3*5e-3/2.5e6
(0.56+1.02+0.87+4.49)*1e-3*5e-3/2.5e6
(0.56+1.02+0.87+4.49)*1e-3*5e-3/2.5e6/1440/60
MCF7_glc(14).g_cons = (0.56+1.02+0.87+4.49)*1e-3*5e-3/2.5e6/1440/60
MCF7_glc(14)
MCF7_glc(15) = MCF7_glc(12)
save('MCF7_glc_data')
MCF7_glc(15)
MCF7_glc(15).O_pp = 1
MCF7_glc(15).g_cons = (0.59+2.16+2.25+5.53)*1e-3*5e-3/(2.5e6*1.13)/1440/60
MCF7_glc(15)
MCF7_glc(16) = MCF7_glc(13)
MCF7_glc(16).O_pp = 1
save('MCF7_glc_data')
MCF7_glc(16).g_cons = (26.62+24.11+30.19+36.89)*1e-3*5e-3/(2.5e6*1.74)/1440/60
MCF7_glc(16)
save('MCF7_glc_data')
MCF7_glc.g_cons
MCF7_glc(13).g_cons = (27.3+13.92+37.5+18.03)*1e-3*5e-3/(2.5e6*1.74)/1440/60
MCF7_glc.g_cons
206-175
206-175/50
(206-175)/50
206-156
(206-156)/0.62
MCF7_glc(14).g_cons = (0.56+1.02+0.87+4.49)*1e-3*5e-3/(2.5e6*1.80)/1440/60
MCF7_glc(14)
MCF7_glc(15).g_cons = (0.59+2.16+2.25+5.53)*1e-3*5e-3/(2.5e6*1.80)/1440/60
MCF7_glc(15)
MCF7_glc(15).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient (1.80)'
MCF7_glc(14).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient (1.80)'
(206-81)/0.62
MCF7_glc(16).g_cons = (26.62+24.11+30.19+36.89)*1e-3*5e-3/(2.5e6*1.74)/1440/60
MCF7_glc(16).g_cons = (26.62+24.11+30.19+36.89)*1e-3*5e-3/(2.5e6*3.0)/1440/60
save('MCF7_glc_data')
MCF7_glc.g_cons
MCF7_glc(16).notes ='consumption were calculated assuming aworking volume of 5 mL and 2.5 M cells (Corning) and adjusted with the viability coefficient (3.0)'
save('MCF7_glc_data')
5.5e-3*180
15e-3*180
55e-3*180
save('MCF7_glc_data')
MCF7_glc.g_cons
MCF7_glc(10)
MCF7_glc(11)
MCF7_glc(12)
MCF7_glc(13)
MCF7_glc(14)
MCF7_glc(15)
MCF7_glc(16)
(0.56+1.02+0.87+4.49)
(0.59+2.16+2.25+5.53)
15*5000
26.62+24.11+30.19+36.89
MCF7_glc(17).ref =  'SauloPenna2019'
MCF7_glc(17).PMID = '31819176'
MCF7_glc(17)
MCF7_glc(17).g_conc =  25e-3
MCF7_glc(17).CO2_pp =  5
MCF7_glc(17)
MCF7_glc(17).ga_conc =  5e-3
MCF7_glc(17).Ser_perc =  10
MCF7_glc(17)
25e-3*180
MCF7_glc(17).O_pp = 20
MCF7_glc(17)
0.61e-9/1e5/1440/60
800/1440/1
800/1440/100
0.61e-9/1e5/
0.61e-9/1e5
0.61e-9/1e5/60
0.61e-9/1e3/1440/60
MCF7_glc(17)
MCF7_glc(17).notes = 'The glucose to lactate ratio is good but the values are off by 3 orders of mangitude and no clear cause has been identified'
0.61e-6/1e5/1440/60
MCF7_glc(17).notes = 'The glucose to lactate ratio is good but the values are off by 3 orders of mangitude... most likely µmoles became nanomoles'
MCF7_glc(17).g_cons = 0.61e-6/1e5/1440/60
MCF7_glc(17)
save('MCF7_glc_data')
MCF7_glc(18)
MCF7_glc(18).ga_conc = 2.05e-3
MCF7_glc(18)
MCF7_glc(18).g_conc = 11e-3
MCF7_glc(18).g_conc = 11.1e-3
MCF7_glc(18).Pyr_conc = 0
MCF7_glc(18)
MCF7_glc(18).O_pp = 20
MCF7_glc(18).CO2_pp = 5
MCF7_glc(18)
MCF7_glc(18).Ser_perc = 10
MCF7_glc(18)
MCF7_glc(18).PMID = '35840963'
MCF7_glc(18)
MCF7_glc(18).lac_conc0 = 0
save('MCF7_glc_data')
MCF7_glc(19).ref = 'Hamadneh2020'
MCF7_glc(19).PMID = '33318536'
save('MCF7_glc_data')
MCF7_glc(19).g_conc = 2/180
MCF7_glc(19)
MCF7_glc(19).notes = 'I took the glutamine conc from the website because the 1% supplement is not clear"
MCF7_glc(19).notes = 'I took the glutamine conc from the website because the 1% supplement is not clear'
MCF7_glc(19).notes = 'I took the glutamine conc from the website because the 1% supplement is not clear'
MCF7_glc(19).ga_conc = 300e-3/146
MCF7_glc(19)
MCF7_glc(19).CO2_pp = 5
MCF7_glc(19).Ser_perc = 10
MCF7_glc(19)
MCF7_glc(19).O_pp = 20
MCF7_glc(19)
MCF7_glc(19).Pyr_conc = 0
MCF7_glc(19).lac_conc0 = 0
MCF7_glc(19)
2.5e-5*10*20e-3
2.5e-5*10*20e-3/1440/60
2.5e-5*10*1e-3/180*20e-3/1440/60
MCF7_glc(19).g_cons = 2.5e-5*10*1e-3/180*20e-3/1440/60
MCF7_glc.g_cons
MCF7_glc(19).ref = 'WonChoi2014'
MCF7_glc(19).ref = 'Hamadneh2020'
MCF7_glc(20).ref = 'WonChoi2014'
MCF7_glc(20)
MCF7_glc(20).PMID = '24480191'
MCF7_glc(20).g_cons = 25e-3
1e-3*200e-6
1e-3*200e-6/48
MCF7_glc.ref
MCF7_glc.PMID
[250 350]*2*2*2*2*2
24*5
[250 350]*2*2*2
[250 350]*2*2*2*2
5e-3*200e-6
2.5e-3*200e-6
2.5e-3*200e-6/5e3/2880/60
2.5e-3*200e-6/1e4/2880/60
2.5e-3*200e-6/5e4/(5*24*60)
2.5e-3*200e-6/5e4/(5*24*60*60)
MCF7_glc.ref
MCF7_glc(20).ref = 'Bartmann2018'
MCF7_glc(20).PMID = '29942509'
MCF7_glc(20).duration = 120
MCF7_glc(20).g_cons = 2.5e-3*200e-6/5e4/(5*24*60*60)
MCF7_glc(20)
2.5e-3*200e-6/5e4/(5*24*60*60)
2.5e-3*200e-6/5e3/(5*24*60*60)
2.5e-3*200e-6/1e4/(5*24*60*60)
MCF7_glc(20).g_cons = 2.5e-3*200e-6/1e4/(5*24*60*60)
MCF7_glc(20)
mCF7_glc(20).notes = '250c/ 200 µL 5mM glc -> 5 000 c /well after 5 days (doubling time  24h)
MCF7_glc(20).notes = '250c/ 200 µL 5mM glc -> 5 000 c /well after 5 days (doubling time  24h)'
MCF7_glc(20).notes = '250c/ 200 µL 5mM glc -> 10 000 c /well after 5 days (doubling time  24h) hypotheses needed'
MCF7_glc(20)
MCF7_glc(20).notes = '250c/ 200 µL 5mM glc -> 10 000 c /well after 5 days (doubling time  24h) hypotheses needed, glutamine not specified...'
MCF7_glc(20).Ser_perc =  10
MCF7_glc(20)
MCF7_glc(20).g_conc = 5e-3/180
MCF7_glc(20)
MCF7_glc(20).g_conc = 5e-3
MCF7_glc(20).g_conc = 21
MCF7_glc(20)
MCF7_glc(20).g_conc = 5e-3
MCF7_glc(20).O_pp = 21
MCF7_glc(20)
MCF7_glc(20).CO2_pp = 5
MCF7_glc(20)
MCF7_glc(21) = MCF7_glc(20)
MCF7_glc(21).g_cons = 2e-3*200e-6/5e4/(5*24*60*60)
MCF7_glc(20).notes = '250c/ 200 µL 5mM glc -> 10 000 c /well after 5 days (doubling time  24h) hypotheses needed, consumed sugar is obtained in absolute with the OD in supp, glutamine not specified...'
MCF7_glc(20).g_cons = 3e-3*2*200e-6/1e4/(5*24*60*60)
MCF7_glc(20)
MCF7_glc(21).g_cons = 2e-3*2*200e-6/1e4/(5*24*60*60)
MCF7_glc(21)
MCF7_glc(21).notes = '250c/ 200 µL 5mM glc -> 10 000 c /well after 5 days (doubling time  24h) hypotheses needed, consumed sugar is obtained in absolute with the OD in supp, glutamine not specified...'
MCF7_glc(21)
MCF7_glc(21).O_pp = 5
5e-3*180
MCF7_glc(20)
MCF7_glc(21)
300*2
300*1+(300*4/5)+(600*3/5)+(1200*2/5)+(2400*1/5)
300+300+600+1200+2400
300*1+(300*4/5)+(600*3/5)+(1200*2/5)+(2400*1/5)+(4800*0.5/5)
save('MCF7_glc_data')
5/37
269-193
76*0.1351
268-280
12*0.1351
16.4e-3*180
MCF7_glc(20)
MCF7_glc(21)
MCF7_glc(22).ref = 'Kämmerer2015'
MCF7_glc(22).PMID = '26187043'
MCF7_glc(22).notes = 'Initial conc reported as 16.4 mol/L when it's more likely 16.4 mmol/L'
MCF7_glc(22).notes = 'Initial conc reported as 16.4 mol/L when its more likely 16.4 mmol/L'
MCF7_glc(22)
MCF7_glc(22).g_conc = 16.4e-3
MCF7_glc(22).duration = 24
MCF7_glc(22)
MCF7_glc(22).O_pp = 21
MCF7_glc(22).CO2_pp = 5
MCF7_glc(22)
MCF7_glc(22).Ser_perc = 10
MCF7_glc(22)
MCF7_glc(22).notes = 'Initial conc reported as 16.4 mol/L when its more likely 16.4 mmol/L. Glutamine and HEPES not specified'
MCF7_glc(22).notes = 'Initial conc reported as 16.4 mol/L when its more likely 16.4 mmol/L. Glutamine and HEPES not specified, assumed working volume 0.3'
MCF7_glc(22).notes = 'Initial conc reported as 16.4 mol/L when its more likely 16.4 mmol/L. Glutamine and HEPES not specified, assumed working volume 0.3 mL'
MCF7_glc(22).g_cons = 10.3e-3*2e-3/10000/1440/60
MCF7_glc(22)
MCF7_glc(22).g_cons = 10.3e-3*0.3e-3/10000/1440/60
MCF7_glc(22)
MCF7_glc(22).medium = '1:1 DMEM/F12'
16*180
save('MCF7_glc_data')
MCF7_glc(23).ref = 'Patra2021'
MCF7_glc(23).PMID = '33420162'
MCF7_glc(23).medium = 'DMEM + GlutaMAX'
MCF7_glc(23).Ser_perc = 10
MCF7_glc(23)
MCF7_glc(23).HEPES_conc = 25e-3
MCF7_glc(23)
MCF7_glc(23).pH  = 7.7
MCF7_glc(23).duration =  48
MCF7_glc(23)
MCF7_glc(23).lac_conc0 = 1e-3
MCF7_glc(23).notes = 'monolayer results'
MCF7_glc(23)
MCF7_glc(23).CO2_pp = 5
MCF7_glc(23)
MCF7_glc(23).notes = 'monolayer results| Oxygen is not available due to the devices being sealed for NMR...'
MCF7_glc(23).notes = 'monolayer results| Oxygen is not available due to the devices being sealed'
MCF7_glc(23)
MCF7_glc(23).ga_conc =  2e-3
MCF7_glc(23).g_conc = 25e-3
MCF7_glc(23).notes = 'monolayer results| Oxygen is not available due to the devices being sealed | A value is given for each cell seeding density but the approximate median is given'
save('MCF7_glc_data')
MCF7_glc(23)
MCF7_glc(23).g_cons = 50e-15/3600
MCF7_glc(23)
MCF7_glc(23).g_cons = 250e-15/3600
MCF7_glc(23)
MCF7_glc(24) = MCF7_glc(23)
MCF7_glc(24).g_cons = 50e-15/3600
MCF7_glc(24).pH =  7.9
MCF7_glc(23)
MCF7_glc(24)
25e-3*180
save('MCF7_glc_data')
MCF7_glc.g_cons
hist(MCF7_glc.g_cons)
hist(MCF7_glc.g_cons,10)
a = MCF7_glc.g_cons
a = MCF7_glc.g_cons
MCF7_glc.g_cons
a = [MCF7_glc.g_conc; MCF7_glc.g_cons]'
hist(a(:,2))
hist(a(:,2),10)
hist(a(:,2),100)
scatter(a(:,1),a(:,2))
b = [MCF7_glc.O_pp; MCF7_glc.g_cons]'
MCF7_glc.g_cons
MCF7_glc(1)
MCF7_glc(2)
MCF7_glc(3)
MCF7_glc(4
MCF7_glc(4)
MCF7_glc(21)
MCF7_glc(22)
MCF7_glc(23)
MCF7_glc(23).O_pp = 5
MCF7_glc(24).O_pp = 5
