%code for readouts of the different configurations
figure
hold on
for i=1:size(LD_r,3)
  i
  area(i) = length(find(LD_r(:,:,i)));
  live(i) = length(find(LD_r(:,:,i)==1));
  dead(i) = length(find(LD_r(:,:,i)==-1));
endfor
plot(area)
plot(live)
plot(dead)


figure
hold on
for i=1:size(S_r,3)
  i
  S_ctr(i) = S_r(round(sz/2),round(sz/2),i);
  O_ctr(i) = O_r(round(sz/2),round(sz/2),i);
endfor
plot(S_ctr)
plot(O_ctr)

figure
hold on
for i=1:size(state_mat_r,3)
  i
  well_fed_t(i) = length(find(state_mat_r(:,:,i)==5));
  hypox_t(i) = length(find(state_mat_r(:,:,i)==4));
  hypos_t(i) = length(find(state_mat_r(:,:,i)==3));
  hypox_hypos_t(i) = length(find(state_mat_r(:,:,i)==2));
  starv_t(i) = length(find(state_mat_r(:,:,i)==1));

endfor
plot(well_fed_t)
plot(hypox_t)
plot(hypos_t)
plot(hypox_hypos_t)
plot(starv_t)


figure
hold on
for i=1:size(kS_r,3)
  i
  kS_ctr(i) = kS_r(round(sz/2),round(sz/2),i);
  kO_ctr(i) = kO_r(round(sz/2),round(sz/2),i);

endfor
plot(kS_ctr)
plot(kO_ctr)
