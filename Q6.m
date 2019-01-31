w = 0.01:0.1:10;
V = 10;
u = 3;
g = 9.81;
% encounter freq
% for following sea, beta = 0deg
few = w - (w .^ 2 .* V ./ g);
% for head sea, beta = 180deg
hew = w + (w .^ 2 .* V ./ g);

% Pierson Moskowitz Spectrum
PMspectrum = @(w, u, g) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4);
% encounter spectrum
%for following sea, beta = 0deg
fes = PMspectrum(w, u, g) ./ (1 - (2 .* w .* V ./ g));

%for head sea, beta = 180deg
hes = PMspectrum(w, u, g) ./ (1 + (2 .* w .* V ./ g));

subplot(2,1,1)
plot(few, fes)
title("Following Sea")
xlabel("Encounter freq.")
ylabel("Encounter spec.")

subplot(2,1,2)
plot(hew, hes)
title("Head Sea")
xlabel("Encounter freq.")
ylabel("Encounter spec.")
