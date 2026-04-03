function phase4_intensity(img_gray)
%% ============================================================
%  PHASE 4 — Intensity Transformations  (Lab 04)
%  Requirements:
%    a. Negative transformation
%    b. Log transformation
%    c. Gamma correction (gamma = 0.5 and 1.5)
%  Analysis: Best method for Brightening & Highlighting details
%% ============================================================

fprintf('\n========================================\n');
fprintf('  PHASE 4 — INTENSITY TRANSFORMATIONS\n');
fprintf('========================================\n');

img_d = double(img_gray);   % work in double for math

%% ---- Apply each transformation ----

% (a) Negative
negative = uint8(255 - img_d);

% (b) Log Transform  s = c * log(1 + r)
c_log   = 255 / log(1 + max(img_d(:)));
log_img = uint8(c_log * log(1 + img_d));

% (c) Gamma correction  s = c * r^gamma
gamma_05  = uint8(255 * (img_d/255).^0.5);   % < 1 = brighter
gamma_15  = uint8(255 * (img_d/255).^1.5);   % > 1 = darker

%% ---- Display: 2x3 grid ----
figure('Name','Phase 4 — Intensity Transformations','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[50 50 1200 700]);

images = {img_gray, negative, log_img, gamma_05, gamma_15};
names  = {'Original','Negative','Log Transform',...
          'Gamma = 0.5  (Brighter)','Gamma = 1.5  (Darker)'};

for i = 1:5
    subplot(2,3,i);
    imshow(images{i});
    title(names{i},'Color','w','FontSize',10,'FontWeight','bold');
end

% Mean brightness comparison in last slot
subplot(2,3,6);
means = cellfun(@(x) mean(double(x(:))), images);
bar(means, 'FaceColor', [0.22 0.48 1], 'EdgeColor', 'none');
set(gca,'XTickLabel',{'Orig','Neg','Log','G0.5','G1.5'},...
    'Color',[0.12 0.13 0.17],'XColor','w','YColor','w','FontSize',9);
title('Mean Brightness Comparison','Color','w','FontSize',10,'FontWeight','bold');
ylabel('Mean Pixel Value','Color','w');

set(gcf,'Color',[0.08 0.08 0.10]);

%% ---- Analysis Report ----
fprintf('\n  INTENSITY ANALYSIS TABLE:\n');
fprintf('  %-20s %-12s %-30s\n','Transform','Mean Value','Best Use');
fprintf('  %s\n', repmat('-',1,65));
fprintf('  %-20s %-12.1f %-30s\n','Original',    mean(img_d(:)),       'Baseline');
fprintf('  %-20s %-12.1f %-30s\n','Negative',    mean(255-img_d(:)),   'Inverting brightness');
fprintf('  %-20s %-12.1f %-30s\n','Log Transform',mean(double(log_img(:))), 'BEST for detail highlight');
fprintf('  %-20s %-12.1f %-30s\n','Gamma = 0.5', mean(double(gamma_05(:))), 'BEST for brightening');
fprintf('  %-20s %-12.1f %-30s\n','Gamma = 1.5', mean(double(gamma_15(:))), 'Darkening / contrast');

fprintf('\n  CONCLUSION:\n');
fprintf('  >> Best for BRIGHTENING       : Gamma correction (gamma=0.5)\n');
fprintf('  >> Best for HIGHLIGHTING DETAILS: Log Transformation\n');

% Save outputs
imwrite(negative,  fullfile('..','images','output','phase4_negative.png'));
imwrite(log_img,   fullfile('..','images','output','phase4_log.png'));
imwrite(gamma_05,  fullfile('..','images','output','phase4_gamma05.png'));
imwrite(gamma_15,  fullfile('..','images','output','phase4_gamma15.png'));

fprintf('\n  [Phase 4 DONE]\n');
end
