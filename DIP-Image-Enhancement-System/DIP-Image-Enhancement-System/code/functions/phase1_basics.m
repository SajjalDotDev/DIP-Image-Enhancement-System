function img_gray = phase1_basics(img_rgb)
%% ============================================================
%  PHASE 1 — Image Acquisition & Understanding  (Lab 01)
%  Requirements:
%    1. Load image (RGB / Grayscale)
%    2. Convert RGB to Grayscale
%    3. Display: image matrix, resolution, data type
%% ============================================================

fprintf('\n========================================\n');
fprintf('  PHASE 1 — IMAGE ACQUISITION REPORT\n');
fprintf('========================================\n');

%% Step 1: Handle RGB or already-grayscale input
if size(img_rgb, 3) == 3
    img_gray = rgb2gray(img_rgb);
    fprintf('  Color Mode   : RGB (converted to Grayscale)\n');
else
    img_gray = img_rgb;
    fprintf('  Color Mode   : Already Grayscale\n');
end

%% Step 2: Print image info
[h, w, c] = size(img_rgb);
fprintf('  Resolution   : %d x %d pixels\n', w, h);
fprintf('  Data Type    : %s\n', class(img_gray));
fprintf('  Channels     : %d\n', c);
fprintf('  Min Value    : %d\n', min(img_gray(:)));
fprintf('  Max Value    : %d\n', max(img_gray(:)));
fprintf('  Mean Value   : %.2f\n', mean(double(img_gray(:))));

%% Step 3: Display partial pixel matrix (top-left 8x8)
fprintf('\n  Pixel Matrix (top-left 8x8 block):\n');
disp(img_gray(1:8, 1:8));

%% Step 4: Display figures
figure('Name','Phase 1 — Image Basics','NumberTitle','off',...
       'Color',[0.08 0.08 0.10], 'Position',[50 100 900 420]);

subplot(1,2,1);
imshow(img_rgb);
title('Original RGB Image','Color','w','FontSize',12,'FontWeight','bold');

subplot(1,2,2);
imshow(img_gray);
title('Grayscale Image','Color','w','FontSize',12,'FontWeight','bold');

set(gcf,'Color',[0.08 0.08 0.10]);

% Save results
imwrite(img_gray, fullfile('..','images','output','phase1_grayscale.png'));
fprintf('\n  [Phase 1 DONE] Grayscale saved.\n');
end
