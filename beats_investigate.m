c = 2.99792e8;

wavelengths = [750e-9, 575e-9]; % AS 1, 5
omega = 2*pi*c*(wavelengths).^-1; % omega for AS 1, 5

omega_sfg = omega(1) + omega(2); % Never used.

wavelength_scan =  665e-9; % Scanned wavelength, AS 3.
omega_scan = 2*pi*c*(wavelength_scan).^-1; % Scanned omega, AS 3
omega_scan2 = 2*omega_scan; % Second harmonic of AS 3.

t_p = 50e-15; % Estimate based on XFROG
alpha = t_p^2; % Estimate based on XFROG
beta = alpha; % Estimate based on XFROG

delta_t = 0.1e-16; % About the same resolution the translation stage has.

t = -150e-15:delta_t:(150e-15-delta_t); % pulse time
tau = (-30e-15:delta_t:(30e-15-delta_t)); % delay time, (tau = 0 = 0 delay)
size_tau = size(tau); 
size_tau = size_tau(2); % needed later

gamma_r = alpha/(alpha^2 + beta^2); % chirp parameters
gamma_i = -beta/(alpha^2 + beta^2); % chirp parmaeters


pulse_scan_field = exp(1i*(t'-tau) .* 1*omega_scan);
pulse_scan_field_sh = exp(1i*(t'-tau) .* 1*omega_scan2);


Fs = 1/delta_t; % not used, might be needed for fft

time_d = size(t); % not used, might be needed for fft
time_d = time_d(1, 2); % not used, might be needed for fft

a_t_chirp = exp(-gamma_r * t.^2) .* exp(-1i * gamma_i * t.^2); % chirped a(t)
a_t_ftl = exp(-t.^2/t_p^2); % ftl a(t)

a_tau_chirp = exp(-gamma_r * (t'-tau).^2) .* exp(-1i * gamma_i * (t'-tau).^2); %
% chirped, delayed pulse by tau (tau = 0 = 0 delay)

y_array_chirp = a_t_chirp .* exp(1i*(omega' .* t)); % chirped sfg
y_array_ftl = a_t_ftl .* exp(1i*(omega' .* t)); % ftl sfg for comparison

A = sqrt(alpha^2 + beta^2)/alpha; % normalization correction for chirped pulses

sum_frequency_chirp = 1/A * real(y_array_chirp(1, :).* y_array_chirp(2, :))/2; % chirped SFG
sum_frequency_ftl = real(y_array_ftl(1, :).* y_array_ftl(2, :))/2; % ftl SFG for comparison
pulse_scan_sh = a_tau_chirp .* pulse_scan_field_sh; % chirped scanned pulse, envelope + field

gamma_a_tau = mean(a_t_chirp.^2 .* conj(a_tau_chirp)', 2); % taken out of wiener, pg. 89/90, included in github
gamma_a_zero = gamma_a_tau(size_tau/2); % gamma_a(0)
phi_tau = asin(imag(gamma_a_tau)./abs(gamma_a_tau)); % phase of gamma_a (tau)
 
g_1_tau = abs(gamma_a_tau)/(gamma_a_zero)' .* cos(omega_scan*tau + phi_tau'); % 1st order correlation
p_out = 1/2 * gamma_a_zero * (1 + g_1_tau); % time-averaged power seen by spectrometer, weiner, pg. 89