![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)

# Student_habits_analysis

This repository contains a comprehensive data analysis of student lifestyle habits and how they relate to exam performance. The analysis is performed in R and includes correlation tests, visualizations, linear regression modeling, and clustering.

# Dataset Description

The file `student_habits_performance.csv` includes the following variables:

- gender: Student gender
- age: Age of the student
- study_hours_per_day: Daily study hours
- social_media_hours: Daily time spent on social media
- netflix_hours: Daily time spent watching Netflix
- sleep_hours: Daily sleep hours
- attendance_percentage: Class attendance rate
- part_time_job: Whether the student has a part-time job
- diet_quality: Quality of the student's diet
- exercise_frequency: Frequency of physical exercise
- parental_education_level: Parents' education level
- internet_quality: Quality of internet access
- extracurricular_participation: Participation in extracurricular activities
- exam_score: Final exam score



# Preprocessing

- Data cleaning and type conversion for categorical variables.
- Created binary `result` variable (passed/failed based on score ≥ 50).

# Correlations

Used Spearman correlations to explore monotonic relationships between exam scores and continuous variables (study hours, sleep, attendance, etc.).

# Statistical Tests

- t-tests & ANOVA to check for score differences across categorical variables.
- Tukey's HSD for post-hoc comparisons when needed.

# Linear Regression Model

The final model includes the following predictors:

- `study_hours_per_day` (positive effect)
- `social_media_hours` (negative effect)
- `netflix_hours` (negative effect)
- `attendance_percentage` (positive effect)
- `sleep_hours` (positive effect)

# Key Results

- R² = 0.76 → The model explains a large portion of score variability.
- All predictors are highly significant (p < 0.001).
- Residual diagnostics confirmed validity of model assumptions (normality, homoscedasticity, linearity).
- Influential observations were reviewed but retained since they didn’t affect model performance.

# Predictions

Predicted exam scores for new hypothetical students using the final regression model.

# Clustering (K-means)

- Scaled features used: study hours, social media hours, Netflix hours, attendance, sleep.
- Silhouette method used to select the optimal number of clusters.
- Cluster visualizations created using `ggplot2`.

# Required Packages
install.packages(c("car", "nortest", "factoextra", "cluster", "ggplot2"))
