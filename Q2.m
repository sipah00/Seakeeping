w = 10 .^ [-3:3]
b = 0:pi/6:pi
v = 10
g = 9.81
lam = 2*pi*g ./ (w.^2)

ew = zeros(length(b), length(w))
for i = 1:length(b)
	ew(i, :) = w - (((w .^ 2) .* v ./ g) .* cos(b(i)))
	elam = 2*pi*g ./ (ew(i, :).^2)
	figure(1)
	loglog(w, ew(i, :))
	hold on
	figure(2)
	loglog(lam, elam)
	hold on
end
figure(1)
xlabel("Wave Freq")
ylabel("Encounter Freq")
title("Encounter freq vs Wave freq")


% encounter wavelength vs wavelength
figure(2)
xlabel("Wave wavelength")
ylabel("Encounter wavelength")
title("Encounter wavelength vs Wave wavelength")

% when encounter freq == 0
% v = g/(w * cos(beta))

vs = zeros(length(b), length(w))
for i = 1:length(b)
	vs(i, :) = g ./ (w .* cos(b(i)))
end

disp("velocity ")
disp(vs)

% when encounter wavelength == 0
newEW = sqrt(2*pi*g/100)
newV = zeros(length(b), length(w))
for i = 1:length(b)
	newV(i, :) = (w - newEW) .* g / (cos(b(i) .* w.^2))
end

disp("velocity ")
disp(newV)