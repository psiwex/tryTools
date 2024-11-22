% Create a tracking scenario
%varTry.mat

scene = trackingScenario('UpdateRate', 10);

% Create multiple time series datasets (trajectories)
numTrajectories = 5;
for i = 1:numTrajectories
    plat = platform(scene);
    waypoints = rand(10, 3) * 1000; % Random 3D waypoints
    times = linspace(0, 100, 10);
    velocities = rand(10, 3) * 10; % Random velocities
    plat.Trajectory = waypointTrajectory(waypoints, times, 'Velocities', velocities);
end

% Initialize tracker
tracker = trackerJPDA('MaxNumTracks', 20, 'MaxNumSensors', 1, 'AssignmentThreshold', 50);

% Initialize variables for storing trajectory information
trajectoryGroups = cell(1, numTrajectories);
timeSteps = [];

% Main simulation loop
while advance(scene)
    % Get current time
    currentTime = scene.SimulationTime;
    timeSteps = [timeSteps, currentTime];

    % Get platform poses
    poses = platformPoses(scene);

    % Create detections from poses
    detections = objectDetection.empty();
    for i = 1:numel(poses)
        det = objectDetection(currentTime, poses(i).Position, 'MeasurementParameters', {eye(3), zeros(3,1)});
        detections = [detections; det];
    end

    % Update tracker
    confirmedTracks = tracker(detections, currentTime);

    % Group trajectories
    for i = 1:numTrajectories
        trajectoryGroups{i} = [trajectoryGroups{i}, numel(confirmedTracks)];
    end
end

% Plot results
figure;
hold on;
for i = 1:numTrajectories
    plot(timeSteps, trajectoryGroups{i}, 'DisplayName', sprintf('Trajectory %d', i));
end
xlabel('Time');
ylabel('Number of Confirmed Tracks');
title('Trajectory Grouping Over Time');
legend('show');
hold off;