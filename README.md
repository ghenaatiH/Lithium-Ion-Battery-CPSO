# Lithium-Ion-Battery-CPSO
# Constraint-Aware Capacity Loss Modeling of Lithium-Ion Batteries via Coevolutionary Particle Swarm Optimization

This repository contains the MATLAB implementation and supporting files for the paper:

**"Constraint-Aware Capacity Loss Modeling of Lithium-Ion Batteries via Coevolutionary Particle Swarm Optimization"**

The provided codes reproduce the numerical experiments, parameter identification procedures, and comparison results reported in the manuscript.

---

## Overview

This work presents a constrained parameter identification framework for lithium-ion battery capacity loss modeling using a Coevolutionary Particle Swarm Optimization (CPSO) algorithm.

The proposed framework identifies the parameters of a semi-empirical degradation model while considering predefined error-bound constraints during the optimization process.

The repository includes the implementation of:

- Proposed capacity loss model
- Benchmark degradation models
- CPSO optimization framework
- Constraint-handling mechanism
- Experimental evaluation procedures

---

# Repository Structure

## 1. Problem_1_Zarei_Model_Benchmark

This folder contains the implementation of the first experimental case study.

In this case, the proposed model is compared with the degradation model reported by Hu et al (12) and Zarei et al (5).

The CPSO and PSO algorithms are used for parameter identification of both proposed and Hu_Model.

The results obtained from this folder correspond to:

- Table 2 in the manuscript
- Figure 2 in the manuscript

---

## 2. Problem_2_Hu_Model_Benchmark

This folder contains the implementation of the second experimental case study.

The proposed model is compared with the degradation model reported by Hu et al (12) and Zarei et al (5).

The CPSO is used for parameter identification of proposed model while GA is used for and Zarei_Model.

The parameter identification is performed under six operating conditions:

- Three temperature levels
- Two charge/discharge current conditions

A single parameter set is obtained to represent all investigated conditions.

The results correspond to:

- Table 3 in the manuscript
- Figure 3 in the manuscript


---
## Naming Conventions

To clarify the naming of some variables in the MATLAB code, note that:

- `JREE` refers to the **Zarei model** [5].
- `F11` refers to the **Hu model** [12].

The main references are as follows:

[5] Zarei-Jelyani, M., et al., Development of lifetime prediction model of lithium-ion battery based on minimizing prediction errors of cycling and operational time degradation using genetic algorithm. Journal of Renewable Energy and Environment, 2018. 5(3): p. 60-63.

[12] Hu, M., et al., Study on cycle-life prediction model of lithium-ion battery for electric vehicles. International Journal of Electrochemical Science, 2016. 11(1): p. 577-589.

---

# Requirements

The code was developed and tested using:

- MATLAB R20XX or later

Required MATLAB toolboxes:

- Optimization Toolbox (if applicable)

---

## Running the Code

For each problem and each method, navigate to the corresponding folder and run the solver script. Precomputed results are already provided in the `results` directory, so running the code is only necessary if you want to reproduce the results. If you only want to inspect the results, you do not need to run the code; the precomputed outputs are already available in the `results` folder.
