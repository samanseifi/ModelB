# Electroporation Model

This is a phase-field code implemented in FORTRAN 90. This code models the diffuse interface model of electroporation. Allen-Cahn type equation are utilized along with electric field equations under leaky dielectric assumption. The file `manager.f90` is the highest level of control, co-ordinating, so to speak, the sequence to calls solvers, initializations, etc. The module solver_mod.f90 contains the  solver routines. The module util_mod.f90 contains functions called upon to do various i/o.

Input variables are given in input file.

Note 1: For initfile the variable takes either `"yes"` or `"no"`. If it's `"yes"` the initname would be the name of the file contains the initial profile of order parameter. Otherwise, the code will do the random mixture of order parameter with `ave=0.5`.

To build and compile the codes into an executable, run the following commands:

```sh
cmake -B build
cmake --build build
```

the executable then is created in `build` with name `electroporation`.

Run the program, specifying the data directory like:

```sh
build/electroporation ./inputs
```
