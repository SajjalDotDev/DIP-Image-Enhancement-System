function phase5_histogram(img_gray)
%% ============================================================
%  PHASE 5 — Histogram Processing  (Lab 05)
%  Requirements:
%    1. Plot histogram of original image
%    2. Analyze contrast distribution
%    3. Apply Histogram Equalization
%  Output: Before / After histogram comparison
%% ============================================================

fprintf('\n========================================\n');
fprintf('  PHASE 5 — HISTOGRAM PROCESSING\n');
fprintf('========================================\n');

%% Apply histogram equalization
img_eq = histeq(img_gray);

%% ---- Figure: 2x2 layout ----
figure('Name','Phase 5 — Histogram Processing','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[50 50 1100 700]);

% Original image
subplot(2,2,1);
imshow(img_gray);
title('Original Image','Color','w','FontSize',11,'FontWeight','bold');

% Original histogram
subplot(2,2,2);
imhist(img_gray, 256);
title('Original Histogram','Color','w','FontSize',11,'FontWeight','bold');
set(gca,'Color',[0.12 0.13 0.17],'XColor',[0.7 0.7 0.7],'YColor',[0.7 0.7 0.7]);
xlabel('Pixel Intensity (0-255)','Color','w');
ylabel('Frequency','Color','w');

% Equalized image
subplot(2,2,3);
imshow(img_eq);
title('Histogram Equalized Image','Color','w','FontSize',11,'FontWeight','bold');

% Equalized histogram
subplot(2,2,4);
imhist(img_eq, 256);
title('Equalized Histogram','Color','w','FontSize',11,'FontWeight','bold');
set(gca,'Color',[0.12 0.13 0.17],'XColor',[0.7 0.7 0.7],'YColor',[0.7 0.7 0.7]);
xlabel('Pixel Intensity (0-255)','Color','w');
ylabel('Frequency','Color','w');

set(gcf,'Color',[0.08 0.08 0.10]);

%% ---- Contrast Analysis ----
orig_std  = std(double(img_gray(:)));
eq_std    = std(double(img_eq(:)));
orig_mean = mean(double(img_gray(:)));
eq_mean   = mean(double(img_eq(:)));

fprintf('\n  CONTRAST ANALYSIS:\n');
fprintf('  %-25s %-15s %-15s\n','Metric','Original','Equalized');
fprintf('  %s\n', repmat('-',1,57));
fprintf('  %-25s %-15.2f %-15.2f\n','Mean Pixel Value', orig_mean, eq_mean);
fprintf('  %-25s %-15.2f %-15.2f\n','Std Dev (Contrast)', orig_std, eq_std);
fprintf('  %-25s %-15d %-15s\n','Min Value', min(img_gray(:)), num2str(min(img_eq(:))));
fprintf('  %-25s %-15d %-15s\n','Max Value', max(img_gray(:)), num2str(max(img_eq(:))));

if eq_std > orig_std
    fprintf('\n  >> Histogram equalization IMPROVED contrast.\n');
    fprintf('     Std dev increased from %.1f to %.1f\n', orig_std, eq_std);
else
    fprintf('\n  >> Contrast was already well distributed.\n');
end

% Save
imwrite(img_eq, fullfile('..','images','output','phase5_equalized.png'));
fprintf('\n  [Phase 5 DONE]\n');
end
