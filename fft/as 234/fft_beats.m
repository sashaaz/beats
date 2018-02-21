c = 2.99792e8;
as234_corr = importdata('as234_main_nobg.txt');

lambda_1 = 700e-9; % Original beams.
lambda_2 = 665e-9;
lambda_3 = 625e-9;

f_1 = c/lambda_1;
f_2 = c/lambda_2;
f_3 = c/lambda_3;

delta_t = 20e-9/c;

t = 0:delta_t:(7000*delta_t - delta_t); %% Making new t-axis as imported t axis is nonlinearish.
total_beats = as234_corr;

size_window = size(t);
size_window = size_window(2);

w_step = 1/(max(t) - min(t));
w = 0:w_step:(2^nextpow2(size_window) * w_step - w_step); % Define fft axis.

slice_beats = as234_corr(48, :) - 425; % Take just one frequency bin, subtact extra bg.

beats_fft = abs(fft(slice_beats, 2^(nextpow2(size_window))));
plot(w, beats_fft);
xlim([0 2e15])
ylim([0 10e4])
xlabel('Frequency (c/lambda)');
ylabel('Amplitude (arb. units)')
title('AS 2+4/SH of 3 FFT Spectrum');
set(gca, 'FontSize', 16);

