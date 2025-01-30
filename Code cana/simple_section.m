function section = simple_section(N_circle, r, e)
section = zeros(2 * N_circle+2, 2);

% Outer circle
for i=1:N_circle
    theta = 2 * pi * i / N_circle;
    section(i, 1) = (r + e) * cos(theta);
    section(i, 2) = (r + e) * sin(theta);
end
section(N_circle + 1, :) = section(1, :);

% Inner circle
offset = pi / N_circle;
for i=1:N_circle
    theta = - 2 * pi * i / N_circle;
    section(N_circle + 1 + i, 1) = r * cos(theta + offset);
    section(N_circle + 1 + i, 2) = r * sin(theta + offset);
end
section(2 * N_circle + 2, :) = section(N_circle + 2, :);
end