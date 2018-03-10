t = -100:0.1:100;

w = [0.8 1 1.2];


% Want phi_1 =/= phi_2 =/= phi_3, but 2phi_2 = phi_1 + phi_3
%dE = [0.1 0.6 1.1; 0.3 0.8 1.3; 0.2 0.7 1.2]*pi; % final matrix for 2phi_2 -phi_1 - phi_3 const.

%dE = [0 -1/2 -1; 0 1 2; 0 -1/2 -1]*pi; % final matrix for phi_1 + phi_2 + phi_3 const.

dE = [0 1.1 3.25; 0 0 -0.75; 0 -1.5 -4.5]; % matrix for phi_1 - phi_3 not constant, adding linear time delay.
% the values that are here now are not exactly right, but they are close to
% right. Give nearly nondistorted time delay.
% figure; 
% hold on;

E = zeros(3, size(t, 2));
figure
hold on
for i = 1:length(w)
    for j=1:length(w)
        E(j, :) = E(j, :) + cos(w(i)*t + dE(i, j));
    end
end
for j=1:length(w)
    plot(t, 1/3 * E(j, :))
end
legend({'$\frac{1}{2} (\phi_1 - \phi_3) = 0$', '$\frac{1}{2} (\phi_1 - \phi_3) = ?$',...
'$\frac{1}{2} (\phi_1 - \phi_3) = \pi?$'}, 'Interpreter','latex');
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
