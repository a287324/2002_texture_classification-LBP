clear all; clc;
LBP_weight_1 = reshape([1,128,64,32,16,8,4,2],1,1,8); %LBP½XªºÅv­«­È
LBP_weight_2 = reshape([2,1,128,64,32,16,8,4],1,1,8);
LBP_weight_3 = reshape([4,2,1,128,64,32,16,8],1,1,8);
LBP_weight_4 = reshape([8,4,2,1,128,64,32,16],1,1,8);
LBP_weight_5 = reshape([16,8,4,2,1,128,64,32],1,1,8);
LBP_weight_6 = reshape([32,16,8,4,2,1,128,64],1,1,8);
LBP_weight_7 = reshape([64,32,16,8,4,2,1,128],1,1,8);
LBP_weight_8 = reshape([128,64,32,16,8,4,2,1],1,1,8);

save('LBP_weight.mat', 'LBP_weight_*');