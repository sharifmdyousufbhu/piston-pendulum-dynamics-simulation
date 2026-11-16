# Piston–Pendulum Dynamics Simulation

## Project overview

This academic project examines the motion of a piston coupled to a pendulum using a course-provided MATLAB simulation. Three published simulation reports explore different parameter sets and initial conditions. Each report compares motion without an external piston force with motion under a sinusoidal force.

The work was prepared for an **Engineering Modeling and Analysis** course. The project instructions indicate that the underlying simulation files were supplied as course material. The reports document the selected scenarios, plots, and written interpretation.

## Objectives

- Explore the motion of a coupled piston–pendulum system.
- Compare unforced and sinusoidally forced cases using the same initial conditions within each scenario.
- Examine piston displacement and pendulum angle over time.
- Interpret phase portraits of position versus velocity.
- Examine the reported total-energy behavior for the unforced case.

## Methods and tools

- **Software:** MATLAB; the published reports identify MATLAB R2023b.
- **Numerical solver:** MATLAB `ode45`, as shown in the reports.
- **States:** piston displacement `y`, piston velocity `v1`, pendulum angle `theta`, and angular velocity `omega`.
- **Outputs:** time histories, phase portraits, and an unforced total-energy plot.
- **Forcing:** the reports compare `fp = 0` with `fp(t) = sin(t)`.

## Scenarios

| Scenario | Piston mass M (kg) | Pendulum mass m (kg) | Pendulum length l (m) | Spring constant k (N/m) | Initial state [y, v1, theta, omega] |
| --- | ---: | ---: | ---: | ---: | --- |
| 1 | 200 | 10 | 20 | 30 | [-10, 0, 0.1, 0] |
| 2 | 2 | 0.1 | 3.5 | 0.1 | [-10, 0, 5, 0] |
| 3 | 10 | 1 | 3 | 2 | [-15, 0, 1, 0] |

The reports state a 40-second simulation duration, gravitational acceleration of 9.8 m/s², and zero values for piston and pendulum friction coefficients in all three scenarios. The initial state uses meters, meters per second, radians, and radians per second, respectively. These values are the scenarios shown in the reports, not measurements of a specified physical machine.

## Project files

- [Scenario 1 report](Scenario_1_Piston_Pendulum.pdf)
- [Scenario 2 report](Scenario_2_Piston_Pendulum.pdf)
- [Scenario 3 report](Scenario_3_Piston_Pendulum.pdf)
- [Course project instructions](Course_Project_Instructions.pdf) — course-provided assignment handout; check permission before sharing it publicly.

The three reports contain the published driver-code excerpts and simulation plots. They are documentation of prior runs, not runnable MATLAB source files.

## Reproducing the simulations

The original standalone MATLAB driver (`piston_w_pend_driver.m`), the ODE model (`piston_w_pend.m`), and parameter data (`piston_w_pend.mat`) were not included in the supplied documents. The reports refer to these files, so the simulations cannot be reproduced from this repository as currently supplied. Add the original files if available and if you have permission to share them.

## Interpretation and limitations

- The reports show variation in the plotted unforced energy despite listing zero friction. The underlying model, energy expression, and numerical solution should be checked before claiming energy conservation or a validated result; the supplied PDFs alone do not establish the cause.
- With an external force, mechanical energy can change as work is added to or removed from the system. Negative potential or total energy is not automatically an error because the reference level for potential energy is arbitrary.
- The reports discuss possible resonance or complex motion. A definitive claim would require further analysis; the plotted responses alone do not establish resonance or chaos.

## Acknowledgment

The simulation and supporting course materials are attributed to the Engineering Modeling and Analysis course. Confirm permission and provide any required instructor attribution before publishing course-provided files or code.
