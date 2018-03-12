t = -100:0.1:100;

w = [0.9 1 1.1];


% Want phi_1 =/= phi_2 =/= phi_3, but 2phi_2 = phi_1 + phi_3
%dE = [0.1 0.6 1.1; 0.3 0.8 1.3; 0.2 0.7 1.2]*pi; % final matrix for 2phi_2 -phi_1 - phi_3 const.

%dE = [0 -1/2 -1; 0 1 2; 0 -1/2 -1]*pi; % final matrix for phi_1 + phi_2 + phi_3 const.

dE = [0 0.1 0.2; 0 0 0; 0 -0.1 -0.2]*pi; % matrix for phi_1 - phi_3 not constant, adding linear time delay.
% the values that are here now are not exactly right, but they are close to
% right. Give nearly nondistorted time delay.
% figure; 
% hold on;
phi0 = 0.74;
dphi = 0;
w0 = 1;
Omega = 0.1;
delta = [0:0.1:0.2];
w = [w0 - Omega, w0, w0 + Omega]


E = zeros(length(delta), size(t, 2));
figure
hold on
for j=1:length(delta)
    phi_minus = phi0 + (w0 - Omega)*delta(j)/Omega
    phi = phi0 + dphi + w0 * delta(j) / Omega
    phi_plus = phi0 + (w0 + Omega)*delta(j)/Omega

    phi = [phi_minus, phi, phi_plus]
    for i = 1:length(w)
        E(j, :) = E(j, :) + cos(w(i)*t + phi(i));
    end
end
legends = {}
for j=1:length(delta)
    plot(t, 1/3 * E(j, :))
    legends{j} = ['0.5(\phi_- - \phi_+) = ',  num2str(delta(j))]
end

legend(legends, 'Interpreter', 'latex');
set(gca, 'fontsize', 26)
xlabel('Time (t)');
ylabel('Amplitude');

% Peter code not used
% for dphi = dphi
%     E = zeros(size(t));
%     for i = 1:length(w)
%         E = E + cos(w(i)*t + dphi);
%     end
%     plot(E)
% end
