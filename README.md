# Synthesis of Admissible Heuristics by Sum of Squares Programming
These scripts use the SOS module in YALMIP to compute admissible heuristics (i.e. lower bounds to the Hamilton Jacobi Bellman equation) for kinodynamic motion planning problems or related relaxations. This demo is intended to accompany the paper which is included in this directory  

Brian Paden, Valerio Varricchio, and Emilio Frazzoli. "Design of Admissible Heuristics for Kinodynamic Motion Planning via Sum of Squares Programming." Submitted.

## Contents
The two examples in the associated paper can be found in the directories /single_integrator_matlab and /double_integrator_matlab. YALMIP and SDPT3 are extermal libraries that make this technique extremely easy to implement. Further information on these computational tools can be found at  

1) Lofberg, Johan. "YALMIP: A toolbox for modeling and optimization in MATLAB." Computer Aided Control Systems Design, 2004 IEEE International Symposium on. IEEE, 2004.  
  
2) Toh, Kim-Chuan, Michael J. Todd, and Reha H. Tütüncü. "SDPT3—a MATLAB software package for semidefinite programming, version 1.3." Optimization methods and software 11.1-4 (1999): 545-581.  

## Usage
This script is MATLAB based. In MATLAB, execute startup.m. This will set the paths for the external libraries. To reproduce the plots in the paper illustrating polynomial heuristics run single_int_1D.m from the single_integrator_matlab directory. Similarly, run MAIN_double_int_1D.m from the double_integrator_matlab directory

