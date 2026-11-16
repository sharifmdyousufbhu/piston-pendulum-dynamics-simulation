function energy = piston_pendulum_energy(x, p)
%PISTON_PENDULUM_ENERGY Total mechanical energy from the report.
%   X contains one state per row: [y, v, theta, omega]. A single 4-element
%   column state is also accepted. Energy is in joules.
%
%   The potential-energy zero is arbitrary, so negative total energy is not
%   inherently an error. Compare energy changes rather than absolute sign.

if isvector(x) && numel(x) == 4
    x = reshape(x, 1, 4);
end
if size(x, 2) ~= 4
    error('Expected a state matrix with four columns.');
end

y = x(:,1);
v = x(:,2);
theta = x(:,3);
omega = x(:,4);

kinetic = 0.5*p.M*v.^2 + 0.5*p.m*(v.^2 ...
    + 2*p.l*v.*omega.*sin(theta) + p.l^2*omega.^2);
potential = 0.5*p.k*y.^2 + p.m*p.g*(p.l + y - p.l*cos(theta)) ...
    + p.M*p.g*y;
energy = kinetic + potential;
end
