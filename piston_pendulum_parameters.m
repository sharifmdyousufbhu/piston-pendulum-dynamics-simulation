function p = piston_pendulum_parameters(scenario)
%PISTON_PENDULUM_PARAMETERS Inputs shown in the three supplied reports.
%   P = PISTON_PENDULUM_PARAMETERS(SCENARIO) returns physical parameters,
%   the initial state [y; ydot; theta; thetadot], and the time interval.
%   Values reproduce the reported inputs, not a verified physical machine.

if ~isnumeric(scenario) || ~isscalar(scenario) || ~isreal(scenario) || ...
        isnan(scenario) || isinf(scenario) || ...
        scenario ~= fix(scenario) || scenario < 1 || scenario > 3
    error('Scenario must be 1, 2, or 3.');
end

p.scenario = scenario;
p.g = 9.8;          % gravitational acceleration, m/s^2
p.bs = 0.0;         % piston viscous friction coefficient, N*s/m
p.bp = 0.0;         % pendulum pivot viscous friction, N*m*s/rad
p.tspan = [0, 40];  % seconds

switch scenario
    case 1
        p.M = 200.0;  % piston mass, kg
        p.m = 10.0;   % pendulum point mass, kg
        p.l = 20.0;   % pendulum length, m
        p.k = 30.0;   % piston spring constant, N/m
        p.x0 = [-10; 0; 0.1; 0];
    case 2
        p.M = 2.0;
        p.m = 0.1;
        p.l = 3.5;
        p.k = 0.1;
        p.x0 = [-10; 0; 5; 0];
    case 3
        p.M = 10.0;
        p.m = 1.0;
        p.l = 3.0;
        p.k = 2.0;
        p.x0 = [-15; 0; 1; 0];
end
end
