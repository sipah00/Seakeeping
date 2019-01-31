sea_vel =[2, 4.5, 8, 13, 18.5, 24, 30, 36.5, 43.5, 51, 59, 67]

w = 0.1:0.001:1.0
g = 9.81

PMspectrum = @(w, u, g) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4)

plot(w, PMspectrum(w, sea_vel(1), g))
title("Sea Spectrum")
xlabel("w")
ylabel("freq spectrum")

for i = 2:length(sea_vel)
    hold on
    plot(w, PMspectrum(w, sea_vel(i), g))
end


M_0 = zeros(1,length(sea_vel)); M_2 = zeros(1,length(sea_vel)); M_4 = zeros(1,length(sea_vel))
Tz = zeros(1,length(sea_vel)); Tp = zeros(1,length(sea_vel))

for i = 1:length(sea_vel)
    M_0(i) = integral(@(w)PMspectrum(w, sea_vel(i), g), 0, Inf)
    M_2(i) = integral(@(w) (w.^2 .* PMspectrum(w, sea_vel(i), g)), 0, Inf)
    M_4(i) = integral(@(w) (w.^4 .* PMspectrum(w, sea_vel(i), g)), 0, Inf)
    Tz(i) = 2 * pi * sqrt(M_0(i)/M_2(i))
    Tp(i) = 2 * pi * sqrt(M_2(i)/M_4(i))
end

figure

ss = 1:12
scatter(ss, M_0)
title("M_0, M_2, M_4, Tz, Tp")
xlabel("sea state 1 to 12")
hold on
scatter(ss, M_2)
hold on
scatter(ss, M_4)
hold on
scatter(ss, Tp)
hold on
scatter(ss, Tz)
legend('M_0', 'M_2', 'M_4', 'Tz', 'Tp')