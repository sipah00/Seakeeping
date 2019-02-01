sea_vel =[2, 4.5, 8, 13, 18.5, 24, 30, 36.5, 43.5, 51, 59, 67] .* .5144
Hsig = [0.023, 0.15, 0.46, 1.1, 2, 3.3, 5.2, 7.6, 10.7, 14.7, 18.6, 22.7];


w = 0.1:0.001:1.0;
g = 9.81;
V = 10;

PMspectrum = @(w, u, g) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4);

plot(w, PMspectrum(w, sea_vel(1), g))
title("Sea Spectrum")
xlabel("w")
ylabel("freq spectrum")

for i = 2:length(sea_vel)
    hold on
    plot(w, PMspectrum(w, sea_vel(i), g));
end

N = [10 50 100 500 1000]
M_0 = zeros(1,length(sea_vel)); M_2 = zeros(1,length(sea_vel)); M_4 = zeros(1,length(sea_vel));
Tz = zeros(1,length(sea_vel)); Tp = zeros(1,length(sea_vel)); sig_h = zeros(1,length(sea_vel));
sig_v = zeros(1,length(sea_vel)); sig_a = zeros(1,length(sea_vel));
mph = zeros(length(sea_vel),length(N)); s = zeros(length(sea_vel),length(w));
hencounter_s = zeros(length(sea_vel),length(w)); fencounter_s = zeros(length(sea_vel),length(w));
freq = zeros(1, length(sea_vel));

for i = 1:length(sea_vel)
	s(i, :) = PMspectrum(w, sea_vel(i), g);
    M_0(i) = integral(@(w)PMspectrum(w, sea_vel(i), g), 0, Inf);
    M_2(i) = integral(@(w) (w.^2 .* PMspectrum(w, sea_vel(i), g)), 0, Inf);
    M_4(i) = integral(@(w) (w.^4 .* PMspectrum(w, sea_vel(i), g)), 0, Inf);
    Tz(i) = 2 * pi * sqrt(M_0(i)/M_2(i));
    Tp(i) = 2 * pi * sqrt(M_2(i)/M_4(i));
    sig_h(i) = 4 * sqrt(M_0(i));
    sig_v(i) = 2 * sqrt(M_2(i));
    sig_a(i) = 2 * sqrt(M_4(i));
    mph(i, :) = 2 * sqrt((M_0(i) .* log(N)));
	hencounter_s(i, :) = s(i, :) ./ (1 + (2 .* w .* V ./ g));  % head sea case
	fencounter_s(i, :) = s(i, :) ./ (1 - (2 .* w .* V ./ g));  % following sea case
	freq(i) = solve('')
end

figure

ss = 1:12;
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

disp("Verification");
disp("Beaufort scale");
disp(Hsig);
disp("Calculated Sig H");
disp(sig_h);
figure
scatter(Hsig, sig_h)
xlabel("Beaufort scale")
ylabel("Calculated Sig H")

disp("sig wave velocity amp and std deviation");
disp(sig_v);
disp(std(sig_v));
disp("sig wave acceleration amp and std deviation");
disp(sig_a);
disp(std(sig_a));

disp("most probable wave height for N encounters");
disp(mph);

