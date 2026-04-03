function phase2_sampling(img_gray)
%% ============================================================
%  PHASE 2 — Sampling & Quantization Analysis  (Lab 02)
%  Requirements:
%    1. Up-sample and Down-sample: 0.25x, 0.5x, 1x, 1.5x, 2x
%    2. Reduce bit depth: 8-bit, 4-bit, 2-bit
%    3. Compare visual quality + comment on degradation
%% ============================================================

fprintf('\n========================================\n');
fprintf('  PHASE 2 — SAMPLING & QUANTIZATION\n');
fprintf('========================================\n');

[orig_h, orig_w] = size(img_gray);

%% ---- PART A: SAMPLING (Up & Down) ----
scales = [0.25, 0.5, 1.0, 1.5, 2.0];
scale_labels = {'0.25x (Down)', '0.5x (Down)', '1.0x (Original)', ...
                '1.5x (Up)', '2.0x (Up)'};

figure('Name','Phase 2A — Sampling Comparison','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[50 50 1200 380]);

fprintf('\n  SAMPLING TABLE:\n');
fprintf('  %-18s %-14s %-10s\n','Scale','Resolution','Quality');
fprintf('  %s\n', repmat('-',1,46));

for i = 1:length(scales)
    resampled = imresize(img_gray, scales(i));
    [rh, rw]  = size(resampled);

    % Quality note
    if scales(i) < 1
        quality = 'Degraded (blurry)';
    elseif scales(i) == 1
        quality = 'Original quality';
    else
        quality = 'Upscaled (smoother)';
    end

    fprintf('  %-18s %-14s %-20s\n', scale_labels{i}, ...
            sprintf('%dx%d', rw, rh), quality);

    subplot(1,5,i);
    imshow(resampled);
    title(sprintf('%s\n%dx%d', scale_labels{i}, rw, rh), ...
          'Color','w','FontSize',8,'FontWeight','bold');
end
set(gcf,'Color',[0.08 0.08 0.10]);

%% ---- PART B: QUANTIZATION (Bit Depth) ----
bits   = [8, 4, 2];
labels = {'8-bit (256 levels)','4-bit (16 levels)','2-bit (4 levels)'};

figure('Name','Phase 2B — Quantization (Bit Depth)','NumberTitle','off',...
       'Color',[0.08 0.08 0.10],'Position',[50 500 900 380]);

fprintf('\n  QUANTIZATION TABLE:\n');
fprintf('  %-22s %-12s %-8s %-20s\n','Bit Depth','Levels','PSNR','Observation');
fprintf('  %s\n', repmat('-',1,65));

for i = 1:length(bits)
    b       = bits(i);
    levels  = 2^b;
    quant   = uint8(round(double(img_gray)/255*(levels-1)) * (255/(levels-1)));

    % PSNR
    psnr_val = psnr(quant, img_gray);

    if b == 8
        obs = 'No visible loss';
    elseif b == 4
        obs = 'Slight banding visible';
    else
        obs = 'Heavy posterization';
    end

    fprintf('  %-22s %-12d %-8.1f %-20s\n', labels{i}, levels, psnr_val, obs);

    subplot(1,3,i);
    imshow(quant);
    title(sprintf('%s\nPSNR: %.1f dB', labels{i}, psnr_val), ...
          'Color','w','FontSize',9,'FontWeight','bold');
end
set(gcf,'Color',[0.08 0.08 0.10]);

% Save results
imwrite(imresize(img_gray, 0.5), ...
        fullfile('..','images','output','phase2_downsampled_05.png'));
imwrite(imresize(img_gray, 2.0), ...
        fullfile('..','images','output','phase2_upsampled_2x.png'));

bits2 = 2;
levels2 = 2^bits2;
quant2bit = uint8(round(double(img_gray)/255*(levels2-1)) * (255/(levels2-1)));
imwrite(quant2bit, fullfile('..','images','output','phase2_quantized_2bit.png'));

fprintf('\n  [Phase 2 DONE]\n');
end
