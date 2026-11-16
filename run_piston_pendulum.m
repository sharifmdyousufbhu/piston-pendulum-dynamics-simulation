function run_piston_pendulum(scenario)
%RUN_PISTON_PENDULUM Run the reconstructed piston-pendulum simulations.
%   RUN_PISTON_PENDULUM runs all three parameter sets.
%   RUN_PISTON_PENDULUM(1), (2), or (3) runs one scenario.
%
%   This code reconstructs the missing original model from the energy
%   expression and inputs in the supplied PDFs. It is not the original
%   instructor-provided source and may produce different results.

if nargin < 1 || isempty(scenario)
    scenarios = 1:3;
else
    % Validate here before creating any figures.
    piston_pendulum_parameters(scenario);
    scenarios = scenario;
end

options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
no_force = @(t) 0;
sinusoidal_force = @(t) sin(t);

for number = scenarios
    p = piston_pendulum_parameters(number);
    [t_free, x_free] = ode45(@(t,x) piston_pendulum_ode(t,x,p,no_force), ...
        p.tspan, p.x0, options);
    [t_forced, x_forced] = ode45(@(t,x) piston_pendulum_ode(t,x,p,sinusoidal_force), ...
        p.tspan, p.x0, options);
    e_free = piston_pendulum_energy(x_free, p);
    e_forced = piston_pendulum_energy(x_forced, p);

    figure('Name', sprintf('Piston-Pendulum Scenario %d', number), ...
        'NumberTitle', 'off');

    subplot(3,2,1);
    plot(t_free, x_free(:,1), 'b-', t_forced, x_forced(:,1), 'r--');
    xlabel('Time (s)'); ylabel('Displacement y (m)');
    title('Piston displacement'); legend('Unforced', 'Forced', 'Location', 'best'); grid on;

    subplot(3,2,2);
    plot(t_free, x_free(:,3), 'b-', t_forced, x_forced(:,3), 'r--');
    xlabel('Time (s)'); ylabel('Angle theta (rad)');
    title('Pendulum angle'); legend('Unforced', 'Forced', 'Location', 'best'); grid on;

    subplot(3,2,3);
    plot(x_free(:,1), x_free(:,2), 'b-', x_forced(:,1), x_forced(:,2), 'r--');
    xlabel('y (m)'); ylabel('Velocity (m/s)');
    title('Piston phase portrait'); legend('Unforced', 'Forced', 'Location', 'best'); grid on;

    subplot(3,2,4);
    plot(x_free(:,3), x_free(:,4), 'b-', x_forced(:,3), x_forced(:,4), 'r--');
    xlabel('theta (rad)'); ylabel('Angular velocity (rad/s)');
    title('Pendulum phase portrait'); legend('Unforced', 'Forced', 'Location', 'best'); grid on;

    subplot(3,2,5);
    plot(t_free, e_free, 'b-', t_forced, e_forced, 'r--');
    xlabel('Time (s)'); ylabel('Mechanical energy (J)');
    title('Total mechanical energy'); legend('Unforced', 'Forced', 'Location', 'best'); grid on;

    subplot(3,2,6);
    plot(t_forced, sin(t_forced), 'r-');
    xlabel('Time (s)'); ylabel('Force (N)');
    title('Applied force: sin(t)'); grid on;

    energy_scale = max(1, max(abs(e_free)));
    scaled_drift = max(abs(e_free - e_free(1))) / energy_scale;
    fprintf('\nScenario %d: M=%g kg, m=%g kg, length=%g m, spring=%g N/m\n', ...
        number, p.M, p.m, p.l, p.k);
    fprintf('Initial state [y v theta omega] = [%g %g %g %g]\n', p.x0);
    fprintf('Largest unforced energy deviation / energy scale: %.3e\n', scaled_drift);
    fprintf('Results are for the reconstructed model, not the missing original source.\n');
end
end
