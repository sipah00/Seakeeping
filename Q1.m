h = 100;
a = 1;
w = 2;
g = 9.81;
z = -h:0.1:0.0
f = @(k, h, z) sqrt(1 - (tanh(k .* (h + z))) .^ 2);

k = sqrt(w^2 ./ (g .* h));


plot(z, f(k,h,z))
xlabel("z")
ylabel("e")
title("Eccentricity vs Depth")
