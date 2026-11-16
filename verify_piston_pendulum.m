function verify_piston_pendulum()
%VERIFY_PISTON_PENDULUM Check equilibrium and numerical energy balance.
%   This tests internal consistency of the reconstructed equations. It does
%   not validate the model against the missing original source or experiment.

options = odeset('RelTol', 1e-9, 'AbsTol', 1e-11);
zero_force = @(t) 0;
sinusoidal_force = @(t) sin(t);
threshold = 1e-6;

for number = 1:3
    p = piston_pendulum_parameters(number);
    equilibrium = [-(p.M+p.m)*p.g/p.k; 0; 0; 0];
    derivative = piston_pendulum_ode(0, equilibrium, p, zero_force);
    assert(norm(derivative) < 1e-9, 'Equilibrium check failed.');

    [~, state_free] = ode45(@(t,x) piston_pendulum_ode(t,x,p,zero_force), ...
        p.tspan, p.x0, options);
    energy_free = piston_pendulum_energy(state_free, p);
    free_scale = max(1, max(abs(energy_free)));
    free_error = max(abs(energy_free - energy_free(1))) / free_scale;
    assert(free_error < threshold, 'Unforced energy check failed.');

    % Integrate external work as an additional state rather than estimating
    % its integral with a coarse post-processing quadrature.
    initial_augmented = [p.x0; 0];
    [~, augmented] = ode45(@(t,z) dynamics_with_work(t,z,p,sinusoidal_force), ...
        p.tspan, initial_augmented, options);
    forced_energy = piston_pendulum_energy(augmented(:,1:4), p);
    work = augmented(:,5);
    residual = forced_energy - forced_energy(1) - (work - work(1));
    balance_scale = max([1; abs(forced_energy); abs(work)]);
    forced_error = max(abs(residual)) / balance_scale;
    assert(forced_error < threshold, 'Forced energy/work check failed.');

    fprintf('Scenario %d passed: equilibrium, unforced energy, and forced work balance.\n', number);
    fprintf('  Scaled unforced deviation: %.3e; forced balance residual: %.3e\n', ...
        free_error, forced_error);
end

% Also check the work balance with nonzero viscous damping.
p = piston_pendulum_parameters(3);
p.bs = 0.5;
p.bp = 0.2;
[~, augmented] = ode45(@(t,z) dynamics_with_work(t,z,p,sinusoidal_force), ...
    p.tspan, [p.x0; 0], options);
energy = piston_pendulum_energy(augmented(:,1:4), p);
work = augmented(:,5);
residual = energy - energy(1) - (work - work(1));
scale = max([1; abs(energy); abs(work)]);
assert(max(abs(residual))/scale < threshold, 'Damped energy/work check failed.');
disp('Damped energy/work balance passed.');
disp('All checks passed for the reconstructed model.');
end

function dz = dynamics_with_work(t, z, p, force)
x = z(1:4);
dx = piston_pendulum_ode(t, x, p, force);
power = force(t)*x(2) - p.bs*x(2)^2 - p.bp*x(4)^2;
dz = [dx; power];
end
