# Piston–Pendulum Dynamics Simulation

## Project overview

This project studies a piston coupled to a pendulum under unforced and sinusoidally forced conditions. The three scenarios use the parameters and initial conditions stated in the published MATLAB reports from an Engineering Modeling and Analysis course.

**Model provenance:** The original course-provided MATLAB ODE model, driver file, and `.mat` data file were not supplied. The MATLAB files in this repository are a new reconstruction derived from the energy expression and scenario inputs shown in the reports. They are not the original source code, and their plots are not guaranteed to reproduce the published plots. See [MODEL_NOTES.md](MODEL_NOTES.md) for assumptions and equations.

## Objectives

- Explore a coupled piston–pendulum mechanical model.
- Compare unforced and sinusoidally forced responses from the same initial conditions.
- Plot displacement, pendulum angle, phase portraits, mechanical energy, and input force.
- Check equilibrium and the energy/work balance of the reconstructed model.

## Tools

- MATLAB and its built-in `ode45` solver.
- No additional toolbox or `.mat` parameter file is required by this reconstruction.
- The reports identify MATLAB R2023b. The reconstructed files have not yet been run in MATLAB and should be tested there.

## Scenario inputs

| Scenario | Piston mass M (kg) | Bob mass m (kg) | Length l (m) | Spring k (N/m) | Initial state [y, v, theta, omega] |
| --- | ---: | ---: | ---: | ---: | --- |
| 1 | 200 | 10 | 20 | 30 | [-10, 0, 0.1, 0] |
| 2 | 2 | 0.1 | 3.5 | 0.1 | [-10, 0, 5, 0] |
| 3 | 10 | 1 | 3 | 2 | [-15, 0, 1, 0] |

Each case runs for 40 seconds with gravity 9.8 m/s² and zero friction. The two runs use `F(t) = 0` and `F(t) = sin(t)` N. Displacement is in meters, velocity in meters per second, angle in radians, and angular velocity in radians per second.

## MATLAB files

| File | Purpose |
| --- | --- |
| `run_piston_pendulum.m` | Runs all three scenarios or one selected scenario and plots results. |
| `run_scenario_1.m` | Runs scenario 1. |
| `run_scenario_2.m` | Runs scenario 2. |
| `run_scenario_3.m` | Runs scenario 3. |
| `piston_pendulum_parameters.m` | Stores the three parameter sets and initial conditions. |
| `piston_pendulum_ode.m` | Implements the reconstructed coupled differential equations. |
| `piston_pendulum_energy.m` | Calculates mechanical energy. |
| `verify_piston_pendulum.m` | Checks equilibrium, unforced energy, and energy/work balance. |
| `MODEL_NOTES.md` | Documents the assumptions, equations, and verification limits. |

## How to run

1. Download all `.m` files into the same folder.
2. Open MATLAB and use its **Current Folder** panel to open that folder.
3. In the MATLAB Command Window, run all scenarios with:

   ```matlab
   run_piston_pendulum
   ```

   Or run one scenario with `run_scenario_1`, `run_scenario_2`, or `run_scenario_3`.

4. To run the included internal consistency checks, enter:

   ```matlab
   verify_piston_pendulum
   ```

## Reports

If the original published reports have been uploaded to the same repository, they can be viewed here:

- [Scenario 1 report](Scenario_1_Piston_Pendulum.pdf)
- [Scenario 2 report](Scenario_2_Piston_Pendulum.pdf)
- [Scenario 3 report](Scenario_3_Piston_Pendulum.pdf)

These reports are separate from the code package. Add them using the same file names if they have not already been uploaded.

## Verification and limitations

- The reconstructed equations are consistent with the report's stated energy expression under the assumptions in [MODEL_NOTES.md](MODEL_NOTES.md). A symbolic check and an independently implemented Python numerical model were used to check equilibrium and the energy/work relation. The MATLAB files themselves still require a direct MATLAB run.
- The model's energy expression and the original course ODE implementation may not have been consistent. Because the original ODE file is unavailable, the reason for the varying unforced energy in the PDF reports cannot be determined from those reports alone.
- Mechanical energy can change when external force performs work. Negative total energy is not automatically an error because the potential-energy reference is arbitrary.
- This is an educational model, not an experimentally validated or safety-qualified design.

## Attribution

The project reports refer to a course-provided piston–pendulum simulation. Confirm permission and give appropriate attribution before publicly sharing the course handout, original instructor files, or excerpts from course materials.
