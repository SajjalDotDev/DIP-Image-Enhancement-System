%% ============================================================
%  Smart Image Enhancement & Analysis System
%  DIP Lab 06 | Mr. Ghulam Ali
%  main.m — Run this file to execute all phases
%% ============================================================
clc; clear; close all;

%% ---- Load Image ----
% Put your image inside:  images/input/your_image.jpg
img_path = fullfile('..', 'images', 'input', 'dip_img.jpeg');

if ~isfile(img_path)
    error('IMAGE NOT FOUND! Put your image at: images/input/your_image.jpg');
end

img_rgb  = imread(img_path);
img_gray = phase1_basics(img_rgb);          % Phase 1
phase2_sampling(img_gray);                  % Phase 2
phase3_geometric(img_gray);                 % Phase 3
phase4_intensity(img_gray);                 % Phase 4
phase5_histogram(img_gray);                 % Phase 5

% Phase 6 — Final Pipeline
enhanced = process_image(img_rgb);
figure('Name','Phase 6 — Final Pipeline','NumberTitle','off',...
       'Color',[0.08 0.08 0.10]);
subplot(1,3,1); imshow(img_gray);
title('Input Grayscale','Color','w','FontSize',13);
subplot(1,3,2); imshow(enhanced);
title('Enhanced Output','Color','w','FontSize',13);
subplot(1,3,3); imshow(imabsdiff(img_gray, enhanced),[]);
title('Difference Map','Color','w','FontSize',13);
colormap(gca, hot);
set(gcf,'Color',[0.08 0.08 0.10]);

% Save enhanced output
out_path = fullfile('..','images','output','enhanced_output.png');
imwrite(enhanced, out_path);
fprintf('\n[DONE] Enhanced image saved -> %s\n', out_path);
