t = -100:0.1:100;

w = [0.9 1 1.1];


% Want phi_1 =/= phi_2 =/= phi_3, but 2phi_2 = phi_1 + phi_3
%dE = [0.1 0.6 1.1; 0.3 0.8 1.3; 0.2 0.7 1.2]*pi; % final matrix for 2phi_2 -phi_1 - phi_3 const.

dE = [0 -1/2 -1; 0 1 2; 0 -1/2 -1]*pi; % final matrix for phi_1 + phi_2 + phi_3 const.

w0 = 1;
Omega = 0.1;

phi0 = [0 0.5 1]*pi;
dphi = 0; % which == Phi
delta = 0;

w = [w0 - Omega, w0, w0 + Omega];


E = zeros(length(phi0), size(t, 2));
figure
hold on
for j=1:length(phi0)
    phi_minus = phi0(j) + (w0 - Omega)*delta/Omega;
    phi = phi0(j) + dphi + w0 * delta / Omega;
    phi_plus = phi0(j) + (w0 + Omega)*delta/Omega;

    phi = [phi_minus, phi, phi_plus];
    for i = 1:length(w)
        E(j, :) = E(j, :) + cos(w(i)*t + phi(i));
    end
end
legends = {};
for j=1:length(phi0)
    plot(t, 1/3 * E(j, :))
    legends{j} = ['$\phi_0 =$ ',  num2str(phi0(j)/pi), '$\pi$'];
end

legend(legends, 'Interpreter', 'latex');
set(gca, 'fontsize', 26)
xlabel('Time (t)');
ylabel('Amplitude');
