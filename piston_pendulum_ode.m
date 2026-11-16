function dx = piston_pendulum_ode(t, x, p, force)
%PISTON_PENDULUM_ODE Reconstructed two-degree-of-freedom dynamics.
%   State: x = [y; v; theta; omega]. y is positive upward and theta is
%   measured from the downward vertical. force(t) acts upward on the piston.
%
%   The model is derived from the kinetic and potential energy expressions
%   printed in the project report, assuming a point-mass bob, a massless
%   rigid pendulum, a linear piston spring, and viscous friction. The original
%   instructor-supplied ODE source file was unavailable. This implementation
%   is a reconstruction and may differ from the model used in the reports.

y = x(1);
v = x(2);
theta = x(3);
omega = x(4);

if p.M <= 0 || p.m <= 0 || p.l <= 0 || p.k < 0 || p.bs < 0 || p.bp < 0
    error('Masses and length must be positive; stiffness and damping cannot be negative.');
end

% Mass matrix for the coupled generalized accelerations [y_ddot; theta_ddot].
A = [p.M + p.m,                p.m * p.l * sin(theta); ...
     p.m * p.l * sin(theta),  p.m * p.l^2];

% Piston force minus spring, gravity, damping and centrifugal terms;
% pendulum torque minus gravity and pivot damping.
b = [force(t) - p.bs*v - p.k*y - (p.M+p.m)*p.g ...
        - p.m*p.l*cos(theta)*omega^2; ...
     -p.bp*omega - p.m*p.g*p.l*sin(theta)];

acceleration = A \ b;
dx = [v; acceleration(1); omega; acceleration(2)];
end
