%function [Grid,G,O,D,GD,T] = migrate2D_sphere_ctr(Grid,lG,cG,G,O,D,GD,T)
%function [Grid,kO,kG,DG,sycle] = migrate2D_sphere_ctr2(Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue)
function [Grid,kO,kS,kP,DSm,DOm,DPm,state]  = migrate2D_sphere_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue)
%encoding the migration of cells in a sphere in order to make the sphere round
% *Hypothesis: Cells are allowed to move a few steps every hour.
% They typically move in order to make the configuration more circular
% In that case it means they move towards the neighboring empty position where
% their distance to the center of the aggregate is minimal
% *The center of the aggregate can be fixed a the beginning or recalculated at each steps

 % only the perimeter cells can be moved
perim = im2double(bwperim(Grid));
idx_p = find(perim!=0);
sz = size(Grid,1);

[r c] = ind2sub([sz, sz],idx_p);
%pos_0 = [r c]

stable_bool=0;
while(stable_bool==0)

	perim = im2double(bwperim(Grid!=0));
	idx_p = find(perim!=0);
	[r c] = ind2sub([sz, sz],idx_p);
	pos_p = [r c];

	for i =1:length(idx_p)
		i;
		d_n = 0;

		pos_p(i,:);
		%kbhit
		ng(1,:) = [pos_p(i,1)-1 pos_p(i,2)-1];
		ng(2,:) = [pos_p(i,1) pos_p(i,2)-1];
		ng(3,:) = [pos_p(i,1)+1 pos_p(i,2)-1];
		ng(4,:) = [pos_p(i,1)-1 pos_p(i,2)];
		ng(5,:) = [pos_p(i,1)+1 pos_p(i,2)];
		ng(6,:) = [pos_p(i,1)-1 pos_p(i,2)+1];
		ng(7,:) = [pos_p(i,1) pos_p(i,2)+1];
		ng(8,:) = [pos_p(i,1)+1 pos_p(i,2)+1];

		d = sqrt((pos_p(i,1)-round(sz/2)).^2+(pos_p(i,2)-round(sz/2)).^2);
		ngh_vec = neighb(Grid,pos_p(i,:));
		[v,id_d] = find(ngh_vec==0);

		for j=1:length(id_d)
			d_n(j,2) = sqrt((ng(id_d(j),1)-round(sz/2)).^2 + (ng(id_d(j),2)-round(sz/2)).^2);
			d_n(j,1) = id_d(j);
		endfor

		min_d = find(d_n(:,2)==min(d_n(:,2)));
		if(min(d_n(:,2))<d)
			nb_can = length(min_d);

			%En choisi un aléatoirement
			rk = abs((1:nb_can)/nb_can-rand());
			id = find(rk==min(rk));

			min_d(id);
			d_n(min_d(id),1);
			Grid(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=Grid(idx_p(i));
			Grid(pos_p(i,1),pos_p(i,2))=0;
			kS(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=kS(idx_p(i));
			kS(pos_p(i,1),pos_p(i,2))=0;
			kP(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=kP(idx_p(i));
			kP(pos_p(i,1),pos_p(i,2))=0;
			kO(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=kO(idx_p(i));
			kO(pos_p(i,1),pos_p(i,2))=0;
			DSm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DSm(idx_p(i));
			DSm(pos_p(i,1),pos_p(i,2))=DS_tissue;
			DPm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DPm(idx_p(i));
			DPm(pos_p(i,1),pos_p(i,2))=DP_tissue;
			DOm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DOm(idx_p(i));
			DOm(pos_p(i,1),pos_p(i,2))=DOx_tissue;

			%mise à jour des cartes de diffusion intracellulaires

			%on ne remet pas  G et O à zéro car elles sont mis à jour à la prochaine étape de diffusion

			%mise à jour des cartes de diffusion intracellulaires

			%disp('switch')
			%imagesc(Grid!=0);
			break;%sort de la boucle si on change la config
		endif

		if(i==length(idx_p))
			stable_bool=1;
		endif

	endfor
endwhile

