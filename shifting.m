Grid = [0 0 0 0 0 0; 0 0 1 2 0 0; 0 3 4 5 6 0; 0 7 8 9 10 0; 0 0 11 12 0 0; 0 0 0 0 0 0]

Grid_bool = Grid!=0;

pos = [5 3];
ngh_vec(1:3) = Grid_bool(pos(1)-1,pos(2)-1:pos(2)+1);
ngh_vec(6:8) = Grid_bool(pos(1)+1,pos(2)-1:pos(2)+1);
ngh_vec(4:5) = [Grid_bool(pos(1),pos(2)-1) Grid_bool(pos(1),pos(2)+1)];

opn_ngh = find(ngh_vec==0)
plr = opn_ngh(randi(length(opn_ngh)))

%%%% Shifting works

pos = [5 3];
shift_vec = [];

%intermediary position
int_pos = [pos(1)-1,pos(2)+1];

while(Grid(int_pos(1),int_pos(2))!=0)
  %vecteur des positions parcourues dans la direction choisies
  shift_vec = [shift_vec; int_pos];
  int_pos = [int_pos(1)-1 int_pos(2)+1];
endwhile

%on retourne le vecteur
shift_vec = flip(shift_vec,1);

for i=1:size(shift_vec,1)
  Grid(shift_vec(i,1)-1,shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
endfor


pos = [4 3];
shift_vec = [];

%intermediary position
int_pos = [pos(1)-1,pos(2)-1];

while(Grid(int_pos(1),int_pos(2))!=0)
  %vecteur des positions parcourues dans la direction choisies
  shift_vec = [shift_vec; int_pos];
  int_pos = [int_pos(1)-1 int_pos(2)-1];
endwhile

%on retourne le vecteur
shift_vec = flip(shift_vec,1);

for i=1:size(shift_vec,1)
  Grid(shift_vec(i,1)-1,shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
endfor

