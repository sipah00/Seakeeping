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

PMspectrum = @(w) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4)

E = integral(PMspectrum, 0, Inf)

disp(E)