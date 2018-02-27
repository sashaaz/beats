t = -100:0.1:100;

w = [0.8 1 1.2];

dphi = [0:0.3:1] * pi;

figure; 
hold on;
for _dphi = dphi
    E = zeros(size(t));
    for i = 1:length(w)
        E = E + cos(w(i)*t + _dphi * w(i) );
    end;
    plot(E)
end
