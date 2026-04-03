function enhanced = process_image(input_image)
%% ============================================================
%  PHASE 6 — Final Integrated Pipeline Function
%  enhanced_image = process_image(input_image)
%
%  Pipeline:
%    Step 1 → Grayscale conversion
%    Step 2 → Histogram Equalization  (fix contrast)
%    Step 3 → Gamma Correction γ=0.6  (brighten)
%    Step 4 → Log Transformation      (highlight details)
%% ============================================================

fprintf('\n========================================\n');
fprintf('  PHASE 6 — FINAL INTEGRATED PIPELINE\n');
fprintf('========================================\n');

%% Step 1: Grayscale
if size(input_image, 3) == 3
    img = rgb2gray(input_image);
    fprintf('  Step 1: RGB -> Grayscale ... DONE\n');
else
    img = input_image;
    fprintf('  Step 1: Already grayscale ... DONE\n');
end

%% Step 2: Histogram Equalization
img = histeq(img);
fprintf('  Step 2: Histogram Equalization ... DONE\n');

%% Step 3: Gamma Correction (brighten slightly)
img = uint8(255 * (double(img)/255).^0.6);
fprintf('  Step 3: Gamma Correction (γ=0.6) ... DONE\n');

%% Step 4: Log Transformation (enhance details)
c_log   = 255 / log(1 + double(max(img(:))));
img     = uint8(c_log * log(1 + double(img)));
fprintf('  Step 4: Log Transformation ... DONE\n');

enhanced = img;

fprintf('\n  Pipeline complete! Output: %dx%d uint8\n', ...
        size(enhanced,2), size(enhanced,1));
fprintf('========================================\n');
end
