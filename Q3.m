h = linspace(0.0, 15.0);
hrms = [0.5, 1.0, 2.0, 3.0];

plot(h, rpd(hrms(1), h));
title("Rayleigh Distribution");
xlabel("H");
ylabel("P(H)");

for i = 2:length(hrms)
    hold on;
    plot(h, rpd(hrms(i), h));
end

sgh = sqrt(log(3.0)) .* hrms;
disp("Significant Wave Heights");
disp(sgh);

% probability of wave height being greater than 3m
pthree = zeros(1, length(hrms));
for i = 1:length(hrms)
	pthree(i) = integral(@(h) rpd(hrms(i), h), 3.0, Inf);
end

disp("probability of wave height being greater than 3.0m");
disp(pthree);

% probability of wave height being less than 1.5m
pfive = zeros(1, length(hrms));
for i = 1:length(hrms)
	pfive(i) = integral(@(h) rpd(hrms(i), h), 0.0, 1.5);
end

disp("probability of wave height being less than 1.5m");
disp(pfive);

% means wave heights
meanH = zeros(1, length(hrms));
for i = 1:length(hrms)
	meanH(i) = integral(@(h) h .* rpd(hrms(i), h), 0, Inf);
end

disp("Mean Wave Heights");
disp(meanH);

disp("Modal Heights: ");
disp(hrms ./ sqrt(2));

% locus of modal wave heigh for changing sea states
g = 9.81
PMspectrum = @(w, u, g) ((0.0081 * g^2) ./ (w.^5))  .* exp(-0.74 .* (g ./(w .* u)).^4);
sea_vel =[2, 4.5, 8, 13, 18.5, 24, 30, 36.5, 43.5, 51, 59, 67];
M_H = zeros(1,length(sea_vel));

for i = 1:length(sea_vel)
    M_0 = integral(@(w)PMspectrum(w, sea_vel(i), g), 0, Inf);
    M_H(i) = 2 * sqrt(M_0)/sqrt(2);
end

figure
plot(1:12, M_H);
title("Locus of modal height");
xlabel("sea state");
ylabel("modal height");

%%%%%%%%%
function ph = rpd(hrms, h)
    ph = (2/(hrms^2)) .* h .* exp(-(h .^ 2)/(hrms^2));
end
