function [Grid,G,O,D,GD,T] = migrate2D_sphere_ctr(Grid,lG,cG,G,O,D,GD,T)
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

		d = sqrt((pos_p(i,1)-lG).^2+(pos_p(i,2)-cG).^2);
		ngh_vec = neighb(Grid,pos_p(i,:));
		[v,id_d] = find(ngh_vec==0);

		for j=1:length(id_d)
			d_n(j,2) = sqrt((ng(id_d(j),1)-lG).^2 + (ng(id_d(j),2)-cG).^2);
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

			%mise à jour des cartes de diffusion intracellulaires
			G(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=G(idx_p(i));
			O(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=O(idx_p(i));
			%on ne remet pas  G et O à zéro car elles sont mis à jour à la prochaine étape de diffusion

			%mise à jour des cartes de diffusion intracellulaires
			GD(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=GD(idx_p(i));
			GD(pos_p(i,1),pos_p(i,2))=0;
			D(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=D(idx_p(i));
			D(pos_p(i,1),pos_p(i,2))=0;
			T(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=T(idx_p(i));
			T(pos_p(i,1),pos_p(i,2))=0;
			disp('switch')
			%imagesc(Grid!=0);
			break;%sort de la boucle si on change la config
		endif

		if(i==length(idx_p))
			stable_bool=1;
		endif

	endfor
endwhile

