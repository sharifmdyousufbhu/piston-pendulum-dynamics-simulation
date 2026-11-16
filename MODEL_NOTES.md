# Model notes and source limitations

## What was reconstructed

The published reports include an energy expression, parameters, initial states, forcing choices, and MATLAB driver excerpts. They refer to `piston_w_pend.m` and `piston_w_pend.mat`, but those original standalone files were not supplied. Therefore, this project implements a **new model** that is consistent with the printed energy expression under the assumptions below. It must not be described as a recovered copy of the original governing-equation file.

## Coordinates and assumptions

- `y` is the piston's vertical displacement, positive upward.
- `theta` is the pendulum angle measured from the downward vertical.
- The bob is a point mass `m` on a massless rigid rod of length `l`.
- The piston has mass `M`; a linear spring with stiffness `k` acts on it.
- `bs` and `bp` are nonnegative viscous-friction coefficients for piston and pivot.
- `F(t)` acts upward on the piston. Frictionless report cases use `F(t) = 0` and `F(t) = sin(t)`.

## Energy expression

For `v = dy/dt` and `omega = dtheta/dt`, the reports use:

```text
T = 1/2 M v^2 + 1/2 m (v^2 + 2 l v omega sin(theta) + l^2 omega^2)
V = 1/2 k y^2 + m g (l + y - l cos(theta)) + M g y
E = T + V
```

The constant in gravitational potential energy sets a reference; negative values of `E` can be physically meaningful.

## Reconstructed equations of motion

Applying Lagrange's equations to the above expressions with the stated forces yields:

```text
[(M + m)          m l sin(theta)] [y_ddot    ]
[m l sin(theta)   m l^2         ] [theta_ddot]

= [F(t) - bs v - k y - (M+m)g - m l cos(theta) omega^2]
  [-bp omega - m g l sin(theta)                           ]
```

The matrix is solved numerically at each solver step. For positive `M`, `m`, and `l`, its determinant is `m*l^2*(M + m*cos(theta)^2)`, which is positive.

For this reconstructed model the instantaneous energy balance is:

```text
dE/dt = F(t) v - bs v^2 - bp omega^2
```

Thus, an unforced, frictionless run should conserve energy apart from numerical error. An externally forced run can gain or lose energy through work.

## Verification completed and outstanding

- The reconstructed equations and energy identity were checked symbolically.
- A separately implemented Python numerical model was checked for all three unforced and forced scenarios, plus a damped case; equilibrium and scaled energy/work residuals passed a `1e-6` threshold.
- MATLAB/Octave was not available in the authoring environment, so the `.m` files have not been executed there. Run `verify_piston_pendulum` in MATLAB to check this implementation directly.
- Internal energy consistency does not establish agreement with the missing original ODE model or validate the model experimentally.
