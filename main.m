%清除工作變數及畫面
clear all; clc;

tic
%讀取影像
im = imread("test_data\lena.bmp");
[im_row, im_col] = size(im);


% step 2: 先取出被LBP mask遮罩的值後,再與遮罩中心比較
im_mask_center = im(2:(end-1), 2:(end-1));
im_mask_center = repmat(im_mask_center, 1, 1, 8);
im_LBP_mask = zeros(im_row-2, im_col-2, 8);
im_LBP_mask(:,:,1) = im(1:end-2,    1:end-2);
im_LBP_mask(:,:,2) = im(2:(end-1),  1:end-2);
im_LBP_mask(:,:,3) = im(3:(end),    1:end-2);
im_LBP_mask(:,:,4) = im(3:(end),    2:(end-1));
im_LBP_mask(:,:,5) = im(3:(end),    3:end);
im_LBP_mask(:,:,6) = im(2:(end-1),  3:end);
im_LBP_mask(:,:,7) = im(1:(end-2),  3:end);
im_LBP_mask(:,:,8) = im(1:(end-2),  2:end-1);
im_LBP_mask = im_LBP_mask >= im_mask_center;
clear im_reg;
clear im_mask_center;

% step 3: 計算LBP碼
    %讀取LBP的遮罩權重
load 'parameter\LBP_weight.mat' %讀取參數
    %計算遮罩值
im_LBP_1 = sum(im_LBP_mask .* LBP_weight_1, 3);
im_LBP_2 = sum(im_LBP_mask .* LBP_weight_2, 3);
im_LBP_3 = sum(im_LBP_mask .* LBP_weight_3, 3);
im_LBP_4 = sum(im_LBP_mask .* LBP_weight_4, 3);
im_LBP_5 = sum(im_LBP_mask .* LBP_weight_5, 3);
im_LBP_6 = sum(im_LBP_mask .* LBP_weight_6, 3);
im_LBP_7 = sum(im_LBP_mask .* LBP_weight_7, 3);
im_LBP_8 = sum(im_LBP_mask .* LBP_weight_8, 3);
%{ 
im_reg = uint8(im_LBP_1);       imwrite(im_reg, 'result\LBP_code\LBP_1.jpg');
im_reg = uint8(im_LBP_2);       imwrite(im_reg, 'result\LBP_code\LBP_2.jpg');
im_reg = uint8(im_LBP_3);       imwrite(im_reg, 'result\LBP_code\LBP_3.jpg');
im_reg = uint8(im_LBP_4);       imwrite(im_reg, 'result\LBP_code\LBP_4.jpg');
im_reg = uint8(im_LBP_5);       imwrite(im_reg, 'result\LBP_code\LBP_5.jpg');
im_reg = uint8(im_LBP_6);       imwrite(im_reg, 'result\LBP_code\LBP_6.jpg');
im_reg = uint8(im_LBP_7);       imwrite(im_reg, 'result\LBP_code\LBP_7.jpg');
im_reg = uint8(im_LBP_8);       imwrite(im_reg, 'result\LBP_code\LBP_8.jpg');
%}
clear LBP_weight_*;

% step 4: 找出LBP的RI碼
im_LBPri = min( ...
                min( ...
                    min( im_LBP_1, im_LBP_2), ...
                    min( im_LBP_3, im_LBP_4)), ...
                min( ...
                    min( im_LBP_5, im_LBP_6), ...
                    min( im_LBP_7, im_LBP_8)...
                   )...
                );
clear im_LBP_*;
% step 5: 統計LBP的RI碼
im_LBPrid = zeros(1,10);
im_LBPrid(1) = length(find(im_LBPri == 0));
im_LBPrid(2) = length(find(im_LBPri == 1));
im_LBPrid(3) = length(find(im_LBPri == 3));
im_LBPrid(4) = length(find(im_LBPri == 7));
im_LBPrid(5) = length(find(im_LBPri == 15));
im_LBPrid(6) = length(find(im_LBPri == 31));
im_LBPrid(7) = length(find(im_LBPri == 63));
im_LBPrid(8) = length(find(im_LBPri == 127));
im_LBPrid(9) = length(find(im_LBPri == 255));
im_LBPrid(10) = (im_row-2)*(im_col-2) - sum(im_LBPrid(1:9));
toc
% step 6: 繪出統計結果(直方圖)並儲存
figure(1);
bar(1:10, im_LBPrid);
title('Histogram of LBP-RIU for Lena.bmp');
save result/im_LBP_rid im_LBPrid