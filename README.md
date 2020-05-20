# 2020-AAS
Final Report of Advance Applied Statistics-2020

## Abstract
Recommendation systems, also called recommendation engines, are widely used in our daily life. Collaborative filtering systems, one of the recommendation systems, are used to predict future ratings of items by users based on their past ratings. GroupLens is one such collaborative filtering system. It uses the correlation between users for predictive purposes. However, the estimated correlation matrix sometimes has a serious defect: although the correaltion matrix is originally positive semidefinite, the estimated one may not be positive semidefinite when not all ratings are observed. To obtain a positive semidefinite correlation matrix, the nearest correlation matrix problem has been recently studied in the fields of numerical analysis and optimization. Since the optimization problem has a prescribed rank and bound constraints on the correlations, it can be converted into a orthogonal constrained optimization problem. In this project, we use a first-order feasible method to estimate the correlation matrix. We replace the original correlation matrix in the collaborative filtering system with our adjusted correlation matrix. We compare the efficieny between different recommendation algorithms.

## Data
GroupLens Research has collected and made available rating data sets from the MovieLens web site (http://movielens.org). The data sets were collected over various periods of time, depending on the size of the set. In this project, we use MovieLens 100K dataset which can be downloaded at https://grouplens.org/datasets/movielens/100k/

MovieLens data sets were collected by the GroupLens Research Project at the University of Minnesota. This data set consists of:

- 100,000 ratings (1-5) from 943 users on 1682 movies.

- Each user has rated at least 20 movies.

- Simple demographic info for the users (age, gender, occupation, zip)

The data was collected through the MovieLens web site (movielens.umn.edu) during the seven-month period from September 19th, 1997 through April 22nd, 1998. This data has been cleaned up - users who had less than 20 ratings or did not have complete demographic information were removed from this data set.

## Code

### Abstract
All of tha data analysis for this report were done in R. The corresponding code is provided to take exploratory data analysis on the raw data, conduct preprocessing steps and generate plots of the report. 

### Description
All of the R scripts used in the report are available in a public repository on GitHub https://github.com/zhengtianzhu1995/2020-AAS. The MIT license applies to all code, and no permissions are required to access the code.

### Optional Information
R version 3.6.1 (2019-07-05) -- "Action of the Toes" was used for the analyses in this report. The necessary R libraries for the code used for data processing and analysis are:
- ggplot 2 
- recommenderlab
 
The applications of shared codes are respectively:
- OptM.R is the solver of optimization problems with manifold constraints using feasible method.
- f and g.R is the loss function and corresponding gradient.

## Instructions for Use
All data preparation and analyses are reproduced, as well as all plots in the report.

The general steps are:

- Conduct data processing/preparation for the analyses.
- Take exploratory data analysis .
- Generate all plots in the report.































