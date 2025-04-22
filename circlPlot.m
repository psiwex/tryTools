% 
% Define the parameters of the Gaussian function
mu = [0, 0]; % Mean
sigma = [14, 14]; % Standard deviation

% Create a grid of points
[x, y] = meshgrid(-35:1:35, -35:1:35);

% Evaluate the Gaussian function
z = (1 / (2 * pi * sigma(1) * sigma(2))) * exp(-((x - mu(1)).^2 / (2 * sigma(1)^2) + (y - mu(2)).^2 / (2 * sigma(2)^2)));
z=z/max(max(z));

% Plot the Gaussian function
c=figure(1);
surf(x, y, z);
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Normalized Intensity');
