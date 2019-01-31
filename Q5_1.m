sea_s = input("Enter Sea State: ")

if sea_s == 2
    u = (4 + 6)/2
elseif sea_s == 5
    u = (17 + 21)/2
elseif sea_s == 8
    u = (34 + 40)/2
elseif sea_s == 11
    u = (56 + 63)/2
end

g = 9.81

% Pierson Moskowitz Spectrum
PMspectrum = @(w, u, g) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4)
[w, th] = meshgrid(0.1:0.1:10, -pi/2:0.01:pi/2) 
tspec = 2/pi .* cos(th).^2 .* PMspectrum(w, u, g)

mesh(w,th,tspec)
%surf(w,th,tspec)
%colormap hsv
figure
contour(w,th,tspec)