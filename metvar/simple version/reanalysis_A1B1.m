clear all;
close all;

Grids_Gl = load('hypoxia_A1B1/metvar2_Gl','Grid_r').Grid_r;
Grids_Ox = load('hypoxia_A1B1/metvar2_Ox','Grid_r').Grid_r;

S_Gl = load('hypoxia_A1B1/metvar2_Gl','S_r').S_r;
kS_Gl = load('hypoxia_A1B1/metvar2_Gl','kS_r').kS_r;
St_Gl = load('hypoxia_A1B1/metvar2_Gl','St_r').St_r;
O_Gl = load('hypoxia_A1B1/metvar2_Gl','O_r').O_r;
Ot = load('hypoxia_A1B1/metvar2_Gl','Ot_r').Ot_r;
kO_Gl = load('hypoxia_A1B1/metvar2_Gl','kO_r').kO_r;
S_Ox = load('hypoxia_A1B1/metvar2_Ox','S_r').S_r;
kS_Ox = load('hypoxia_A1B1/metvar2_Ox','kS_r').kS_r;
O_Ox = load('hypoxia_A1B1/metvar2_Ox','O_r').O_r;
kO_Ox = load('hypoxia_A1B1/metvar2_Ox','kO_r').kO_r;
dx = load('hypoxia_A1B1/metvar2_Gl','dx').dx;
sz = load('hypoxia_A1B1/metvar2_Gl','sz').sz;
S_prol = load('hypoxia_A1B1/metvar2_Gl','S_prol').S_prol;
S_maint = load('hypoxia_A1B1/metvar2_Gl','S_maint').S_maint;
O_norm = load('hypoxia_A1B1/metvar2_Gl','O_norm').O_norm;

%vérifs conditions
j=4
figure;
C5 = 5*and(S_Gl(:,:,j)>=S_prol,S_Gl(:,:,j)<1,O_Gl(:,:,j)>=O_norm);
C4 = 4*and(S_Gl(:,:,j)>=S_prol,S_Gl(:,:,j)<1,O_Gl(:,:,j)<O_norm);
C3 = 3*and(S_Gl(:,:,j)<S_prol,S_Gl(:,:,j)>=S_maint,S_Gl(:,:,j)<1,O_Gl(:,:,j)>=O_norm);
C2 = 2*and(S_Gl(:,:,j)<S_prol,S_Gl(:,:,j)>=S_maint,S_Gl(:,:,j)<1,O_Gl(:,:,j)<O_norm);
C1 = 1*and(S_Gl(:,:,j)<S_maint,S_Gl(:,:,j)<1);
map_Gl = C1+C2+C3+C4+C5;
imagesc(((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,map_Gl);colorbar

figure;
C5 = 5*and(S_Ox(:,:,j)>=S_prol,S_Ox(:,:,j)<1,O_Ox(:,:,j)>=O_norm);
C4 = 4*and(S_Ox(:,:,j)>=S_prol,S_Ox(:,:,j)<1,O_Ox(:,:,j)<O_norm);
C3 = 3*and(S_Ox(:,:,j)<S_prol,S_Ox(:,:,j)>=S_maint,S_Ox(:,:,j)<1,O_Gl(:,:,j)>=O_norm);
C2 = 2*and(S_Ox(:,:,j)<S_prol,S_Ox(:,:,j)>=S_maint,S_Ox(:,:,j)<1,O_Gl(:,:,j)<O_norm);
C1 = 1*and(S_Ox(:,:,j)<S_maint,S_Ox(:,:,j)<1);
map_Ox = C1+C2+C3+C4+C5;
imagesc(((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,map_Ox);colorbar

figure;
plot(St_Gl(200,:,j))

figure
plot(S_Gl(200,:,j))
hold on
plot(O_Gl(200,:,j))


figure
plot(S_Ox(200,:,j))
hold on
plot(O_Ox(200,:,j))

