function phase3_geometric(img_gray)
%% ============================================================
%  PHASE 3 — Geometric Transformations  (Lab 03)
%  Requirements:
%    1. Rotation: 30, 45, 60, 90, 120, 150, 180 degrees
%    2. Translation
%    3. Shearing
%    Task: Inverse transformation to restore original
%% ============================================================

fprintf('\n========================================\n');
fprintf('  PHASE 3 — GEOMETRIC TRANSFORMATIONS\n');
fprintf('========================================\n');

[h, w] = size(img_gray);

%% ---- PART A: ROTATION ----
angles = [30, 45, 60, 90, 120, 150, 180];

figure('Name','Phase 3A — Rotations','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[30 30 1300 380]);

for i = 1:length(angles)
    rotated = imrotate(img_gray, angles(i), 'bilinear', 'crop');
    subplot(2,4,i);
    imshow(rotated);
    title(sprintf('%d°', angles(i)),'Color','w','FontSize',10,'FontWeight','bold');
end

% Show original in last slot
subplot(2,4,8);
imshow(img_gray);
title('Original','Color','w','FontSize',10,'FontWeight','bold');
set(gcf,'Color',[0.08 0.08 0.10]);

%% ---- PART B: TRANSLATION ----
% Shift right by 60px, down by 40px
tform_t = affine2d([1 0 0; 0 1 0; 60 40 1]);
translated = imwarp(img_gray, tform_t, 'OutputView', imref2d([h, w]));

%% ---- PART C: SHEARING ----
tform_s = affine2d([1 0.3 0; 0 1 0; 0 0 1]);
sheared = imwarp(img_gray, tform_s, 'OutputView', imref2d([h, w]));

figure('Name','Phase 3B — Translation & Shearing','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[30 450 900 360]);

subplot(1,3,1); imshow(img_gray);
title('Original','Color','w','FontSize',11,'FontWeight','bold');

subplot(1,3,2); imshow(translated);
title('Translated (+60px, +40px)','Color','w','FontSize',11,'FontWeight','bold');

subplot(1,3,3); imshow(sheared);
title('Sheared (k=0.3)','Color','w','FontSize',11,'FontWeight','bold');

set(gcf,'Color',[0.08 0.08 0.10]);

%% ---- PART D: INVERSE TRANSFORMATION (Restore) ----
demo_angle = 45;
rotated_45 = imrotate(img_gray, demo_angle, 'bilinear', 'loose');
restored   = imrotate(rotated_45, -demo_angle, 'bilinear', 'loose');

% Crop restored back to original size (centre crop)
[rh, rw] = size(restored);
r1 = max(1, floor((rh-h)/2)+1);  c1 = max(1, floor((rw-w)/2)+1);
r2 = min(rh, r1+h-1);            c2 = min(rw, c1+w-1);
restored_crop = restored(r1:r2, c1:c2);
restored_crop = imresize(restored_crop, [h, w]);

figure('Name','Phase 3C — Inverse Transform (Restore)','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[30 850 1100 360]);

subplot(1,3,1); imshow(img_gray);
title('Step 1: Original','Color','w','FontSize',11,'FontWeight','bold');

subplot(1,3,2); imshow(rotated_45);
title('Step 2: Rotated 45°','Color','w','FontSize',11,'FontWeight','bold');

subplot(1,3,3); imshow(restored_crop);
title('Step 3: Restored (Inverse -45°)','Color','w','FontSize',11,'FontWeight','bold');

set(gcf,'Color',[0.08 0.08 0.10]);

%% Print analysis
fprintf('  Rotation   : 7 angles applied (30 to 180)\n');
fprintf('  Translation: +60px right, +40px down\n');
fprintf('  Shearing   : horizontal shear k=0.3\n');
fprintf('  Inverse    : 45 degree rotation reversed successfully\n');
fprintf('  Note: Reversible transforms preserve spatial info\n');

% Save outputs
imwrite(imrotate(img_gray, 90, 'bilinear', 'crop'), ...
        fullfile('..','images','output','phase3_rotation90.png'));
imwrite(translated, fullfile('..','images','output','phase3_translated.png'));
imwrite(sheared,    fullfile('..','images','output','phase3_sheared.png'));
imwrite(restored_crop, fullfile('..','images','output','phase3_restored.png'));

fprintf('\n  [Phase 3 DONE]\n');
end
