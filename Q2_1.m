w = 10 .^ [-3:3]
b = 0:30:180
v = 10
g = 9.81

ew = zeros(length(w), length(b))
for i = 1:length(w)
	ew(i,:) = w(i) - (((w(i) ^ 2) * v / g) .* cos(b))
end

loglog(w, ew)
title("Encounter freq vs Wave freq")
