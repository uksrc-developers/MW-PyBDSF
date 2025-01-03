# MW-PyBDSF
---

This repository contains all the code relevant to running PyBDSF as part of the Multiwave Demonstrator Case.

## Introduction

This repository contains all the files needed to batch run PyBDSF ([PyBDSF Link](https://pybdsf.readthedocs.io/en/latest/index.html)) on a set of image mosaics as part of the MULTIWAVE Demonstrator Case. This version of PyBDSF is contained within the ddf-pipeline ([ddf-pipeline GitHub](https://github.com/mhardcastle/ddf-pipeline)) and will output a radio sources catalouge and Gaussian regions catalogue for each mosaic inputed into the code, as well as the final collated radio source and Gaussian region catalogue for further use in later steps of the MULTIWAVE pipeline.



## Hardware and Software

All the software required to run this is contained in the ddf-pipeline container. This container has the correct environment for running the required scripts, and contains the scripts. Instructions on how to build the container can be found at the ddf-pipeline GitHub (link in the intorduction and below).

The batching is currently run on a slurm cluster with the `SBATCH` code set to the minimum requirements of:
* 8 nodes
* 26 CPUs per node
* 40 GB RAM per node
* Storage will vary depending on the size of the mosaics. LoTSS DR2 minimum storage is 3.5 TB.


## Directory Structure



```bash

working_directory
├── PyBDSF
│   ├── ConcatCats/
│   ├── *mosaic_number*/
│   ├── *mosaic_number*/
│   ├── *mosaic_number*/
│   ... 

```


## Inputs and outputs




## Running MW-PyBDSF




## Future Work


These scripts focus on batching PyBDSF on Azimuth using a slurm cluster. There is the potential to adapt and/or generate scripts which allow for batching across different platforms.
There is opportunities for profiling and optimisation work to be carried.


## External links


*The relevant Jira tickets are as follows:*

* [TEAL-439: PyBDSF up and running on UH with test datasets](https://jira.skatelescope.org/browse/TEAL-439)
   * This ticket covers the exploratory works into PyBDSF
   * Corresponding confluence page:   [Running PyBDSF on UHHPC](https://confluence.skatelescope.org/display/SRCSC/Running+PyBDSF+on+UHHPC)
* [TEAL-440: PyBDSF work on Azimuth with test set and larger sample](https://jira.skatelescope.org/browse/TEAL-440)
   * This ticket covers the batching work
   * Corresponding confluence page:   [Batch Running PyBDSF on Azimuth](https://confluence.skatelescope.org/display/SRCSC/Batch+Running+PyBDSF+on+Azimuth)
* [TEAL-516: PyBDSF Demo](https://jira.skatelescope.org/browse/TEAL-516)
   * This ticket covers a demo of the work done on PyBDSF
   * The final comment includes the details to veiw this demo


*Details about PyBDSF can be obtained from:*

[PyBDSF: Read the Docs](https://pybdsf.readthedocs.io/en/latest/index.html)

Mohan N., Rafferty D., 2015, PyBDSF: Python Blob Detection and Source Finder, Astrophysics Source Code Library, record ascl:1502.007


*The details on how to obtain and build the ddf-pipeline conatiner are available at:*

[ddf-pipeline GitHub](https://github.com/mhardcastle/ddf-pipeline)


## List of developers and Collaborators

Barkus, B.

Hale, C.

Hardcastle, M. J.

Shimwell, T.
