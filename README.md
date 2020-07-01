---
title: "README"
output: html_document
---


## Code to simulate data and run models described in the manuscript "Integrated species distribution models; a comparison of approaches under different data quality scenarios"

This repository hosts functions to simulate structured and unstructured data and to run species distribution models on these to evaluate under which scenarios integrated perform better than individual dataset models. Three integrated models are tested - joint likelihood, covariate and correlation following Pacifici *et al* (2017)



Descriptions of each script are as follows:

### Data generation and sampling

All data generation and sampling functions can be run using [setParams.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/setParams.R) and [Functions to generate data and sample.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Functions%20to%20generate%20data%20and%20sample.R). This will generate a point process, thin it to take unstructured samples with ability to include some spatial bias and create a new realisation which is sampled in a non-biased stratified manner to create the structured data.

[setParams.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/setParams.R) : List of default parameters for data generation and sampling

Scripts sourced by [Functions to generate data and sample.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Functions%20to%20generate%20data%20and%20sample.R) : 

[genData.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/genData.R) : Simulate a log Cox Gaussian process using the rLCGP function from the spatstat package. This can be with or without an environmental covariate effect on the simulated intensity. The user can also specify the domain, the variance and shape parameters of the matern covariance and the mean of the intensity. Seed can be specified to make repeatable or left as NULL to be stochastic

[Generate strata levels Lam.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Generate%20strata%20levels%20Lam.R) : This function splits the domain specified in 'genData.R' into a number of strata, the number and pattern of which can be specified by the user. These strata are used to represent areas which may have different thinning probabilities and are used to ensure equal coverage in the structured data sampling

[addSpatialBias.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/addSpatialBias.R) : This function uses the strata created with 'Generate strata levels Lam.R' and assigns probabilities of sampling (thinning) used to generate the unstructured data. The user can specify these probabilites with a vector equal in length to the number of strata or they can be randomly generated

[make_truth_grid.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/make_truth_grid.R) : This function averages the true intensity within grid squares. The center of each grid square corresponds to a predicted point in prediction data.

[thinData.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/thinData.R) : This function uses the output of 'genData.R' with the output of 'addSpatialBias.R' to thin the point pattern to create the unstructured data

[sampleStructured.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/sampleStructured.R) : This function uses the output of 'genData.R' and the output of 'Generate strata levels Lam.R' to take stratified random points from the domain using the 'sampleStrata' function from 'Sample from strata.R' then creates structured presence/absence data by assessing overlap between the stratified random points (and the 5 by 5 neighbourhood around each point) and a new realisation from the point process generated with 'genData.R'.

[sampleStructured - subsetting.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/sampleStructured%20-%20subsetting.R) : Function to create PA data when PA data are spatially restricted

[Sample from strata.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Sample%20from%20strata.R) : Function to sample points from random field. Samples can either be taken equally from strata ("Stratified" type), or with probablity dependent on given strata sampling probabilities ("Unstructured" type), or with probability inversely related to the strata sampling probabilities ("Intelligent" type). "Stratified" sampling most closely resembles structured surveys whereas "Intelligent" sampling simulates the potential to take more samples from areas where unstructured samples are less likely to be taken (i.e. an adaptive sampling strategy)

[Sample from strata - subsetting.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/sampleStructured%20-%20subsetting.R) : Function to sample points when the PA data are spatially restricted

## Modelling

[Run models.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Run%20models.R) : This function runs an unstructured data only model in INLA. Data are modelled as point Poisson following the Simpson 2016 approach

[Run models unstructured bias covariate.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/Run%20models%20unstructured%20bias%20covariate.R) : This function runs a unstructured data only model in INLA including a covariate on the bias in the data. Data are modelled as point Poisson following the Simpson 2016 approach

[Run models structured.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Run%20models%20structured.R) : This function runs a structured data only SDM model in INLA. Data are assumed to come from a binomial distribution

[Run models joint.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Run%20models%20joint.R) : This function jointly models structured and unstructured data assuming structured data come from a binomial and unstructured data are Poisson distributed.

[Run models joint covariate for bias.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/Run%20models%20joint%20covariate%20for%20bias.R) : This model adds a covariate for the bias in the unstructured data to the joint model described above.

[Run correlation model - corrected.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/Run%20correlation%20model%20-%20corrected.R) : Function to implement the correlation model without bias covariate in INLA

[Run correlation-bias model - corrected.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/Run%20correlation-bias%20model%20-%20corrected.R) : Function to implement the correlation model with bias covariate in INLA

[Run cov model all eff prior.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/Run%20cov%20model%20all%20eff%20prior.R) : Function to implement the covariate model with or without bias covariate in INLA

[validation_function.R](https://github.com/NERC-CEH/IOFFsimwork/blob/master/validation_function.R) : This function runs our validation procedures on any fitted model. Outputs produced are: PLOT - of the truth inc data, predicted mean intensity, standard deviation of predicted intensity, and the relative differences between estimate and truth. SUMMARY_RESULTS - the beginnings of an output table. List includes MAE, model name, all differences, the worst performing grid squares, and the best (i.e. lowest relative difference).

[validation_function for correlation.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/validation_function%20for%20correlation.R) : Function above adapted for the correlation model

[Create prediction stack for correlation model.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/Create%20prediction%20stack%20for%20correlation%20model.R) : Function to create prediction stack for use in the correlation model

[Create prediction stack.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/Create%20prediction%20stack.R) : Create prediction stack for INLA model


## Scenarios

[simulation_study_newscenario.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_newscenario.R) : Code to run through PA coverage simulations

[simulation_study_newscenario_JASMIN](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_newscenario_JASMIN.R) : Code adapted to run on JASMIN HPC

[simulation_study_repeat.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_repeat.R) : Code to run through bias and large sample size simulations

[simulation_study_repeat_JASMIN.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_repeat_JASMIN.R) : Code to run large sample size scenario on JASMIN

[simulation_study_repeat_JASMIN_biased.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_repeat_JASMIN_biased.R) : Code to run biased scenario on JASMIN

[simulation_study_repeat_JASMIN_default.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_repeat_JASMIN_default.R) : Code to run default scenario on JASMIN

[simulation_study_repeat_JASMIN_unbiased.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/simulation_study_repeat_JASMIN_unbiased.R) : Code to run unbiased scenario on JASMIN

## Processing

[collate results JASMIN.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/collate%20results%20JASMIN.R) : Code to process results of first set of simulation runs on JASMIN

[collate new scenario results JASMIN.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/collate%20new%20scenario%20results%20JASMIN.R) : Code to process results of PA coverage simulation runs on JASMIN

[collate results for plots.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/collate%20results%20for%20plots.R) : Script to collate results from different scenarios for plots

[correlate MAE and rho.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/correlate%20MAE%20and%20rho.R) : Check whether rho and MAE are correlated in the correlation model

[covariate correlation plots.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/covariate%20correlation%20plots.R) : Replicate plots from Sarah's thesis


## Figures

[figure 2.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/figure%202.R) : Code to create figure 2

[figure 3.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/figure%202.R) : Code to create figure 3

[plot mid section results.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/plot%20mid%20section%20resutls.R) : code to create SI figures


## Shiny dashboards

[shinydashboard - NewScenario.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/shinydashboard%20-%20NewScenario.R) : Explore results of limited PA coverage simulations

[shinydashboard - simulation.R](https://github.com/NERC-CEH/IDM_comparisons/blob/master/shinydashboard%20-%20simulation.R) : Explore results of bias simulations


## Job files

Files ending .job give the run parameters for the LOTUS cluster on JASMIN


