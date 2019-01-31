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

V = 10
g = 9.81
w = 0.1:0.1:10
th = -pi/2:0.01:pi/2
% Pierson Moskowitz Spectrum
PMspectrum = @(w, u, g) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4)
[w, th] = meshgrid(w, th) 
tspec = 2/pi .* cos(th).^2 .* PMspectrum(w, u, g)
hencounter_s = tspec ./ (1 + (2 .* w .* V ./ g))  % head sea case
fencounter_s = tspec ./ (1 - (2 .* w .* V ./ g))  % following sea case


mesh(w,th,hencounter_s)
%surf(w,th,tspec)
%colormap hsv
figure
contour(w,th,hencounter_s)
figure

mesh(w,th,fencounter_s)
%surf(w,th,tspec)
%colormap hsv
figure
contour(w,th,fencounter_s)