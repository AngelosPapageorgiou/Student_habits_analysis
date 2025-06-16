data = read.csv("student_habits_performance.csv")
head(data)
str(data)

# fix classes 

data$gender = as.factor(data$gender)

data$part_time_job = as.factor(data$part_time_job)

data$diet_quality = as.factor(data$diet_quality)

data$parental_education_level = as.factor(data$parental_education_level)

data$internet_quality = as.factor(data$internet_quality)

data$extracurricular_participation = as.factor(data$extracurricular_participation)

str(data)

cor.test(data$study_hours_per_day, data$exam_score, method = "spearman")##
plot(data$study_hours_per_day, data$exam_score)

cor.test(data$age, data$exam_score, method = "spearman")

str(data)

cor.test(data$social_media_hours, data$exam_score, method = "spearman")##
plot(data$social_media_hours,data$exam_score)

cor.test(data$netflix_hours, data$exam_score, method = "spearman")##
plot(data$netflix_hours, data$exam_score)

cor.test(data$attendance_percentage, data$exam_score, method = "spearman")##
plot(data$attendance_percentage, data$exam_score)

cor.test(data$sleep_hours, data$exam_score, method = "spearman")##
plot(data$sleep_hours, data$exam_score)

data$result = ifelse(data$exam_score >= 50,"passed","failed")
data$result = as.factor(data$result)

str(data)


boxplot(data$exam_score~data$gender)
abline(h = mean(data$exam_score), col=2) 

boxplot(data$exam_score~data$part_time_job)
abline(h = mean(data$exam_score), col=2) 

boxplot(exam_score~diet_quality, data = data)
abline(h = mean(data$exam_score), col=2) 

data$exercise_frequency = as.factor(data$exercise_frequency)

boxplot(exam_score~exercise_frequency, data = data)

boxplot(exam_score~parental_education_level, data = data)

boxplot(exam_score~internet_quality, data = data)

boxplot(exam_score~extracurricular_participation, data = data)

t.test(exam_score~part_time_job, data = data)

t.test(exam_score~extracurricular_participation, data = data)

anova1 = aov(exam_score~gender, data = data) 
summary(anova1)

anova2 = aov(exam_score~diet_quality, data = data)
summary(anova2)

anova3 = aov(exam_score~exercise_frequency, data = data)
summary(anova3)

pairwise.t.test(data$exam_score,data$exercise_frequency)

TukeyHSD(anova3)

anova4 = aov(exam_score~parental_education_level, data = data)
summary(anova4)

anova5 = aov(exam_score~internet_quality, data = data)
summary(anova5)

model1 = lm(exam_score~study_hours_per_day + social_media_hours + netflix_hours + attendance_percentage + sleep_hours, data = data)
summary(model1)	

# assumptions

# normality
res1 = rstandard(model1)

shapiro.test(res1)

library(nortest)
lillie.test(res1)

qqnorm(res1)
qqline(res1,col=2)

# homoscedasticity
fit1 = fitted(model1)
qfit1 = cut(fit1,breaks = quantile(fit1), include.lowest = T)

library(car)
leveneTest(res1,qfit1)

plot(fit1,res1)
abline(h=c(-2,2),col=2,lty=2)

plot(fit1,sqrt(abs(res1)))
abline(h = sqrt(2),col=2,lty=2)

plot(fit1,res1^2)
abline(h=4,col=2,lty=2)

# linearity

plot(model1,which = 1)

AIC(model1)
stepwise = step(model1, direction = "both")

vif(model1)
par(mfrow = c(1,2))
plot(model1,which = 4)
plot(model1, which = 5)

data[568,]
data[4,]
data[713,]

# Observations are influential points and outliers
# we chekced them and their removal from the dataset didn't change p-values or estimates std badges 
# so we keep them in the dataset

# final model = model1


example = data.frame(
study_hours_per_day = c(1.5, 3, 2, 4.5, 0.5),
social_media_hours = c(4, 1, 2.5, 0.5, 6),
netflix_hours = c(2, 1, 1.5, 0, 3),
attendance_percentage = c(85, 95, 90, 98, 70),
sleep_hours = c(6, 7.5, 8, 6.5, 5)
)

predict(model1,newdata =example)



features = data[,c("study_hours_per_day","social_media_hours","netflix_hours","attendance_percentage","sleep_hours")]

features_scaled = scale(features)


library(factoextra)
library(cluster)
features = data[,c("study_hours_per_day","social_media_hours","netflix_hours","attendance_percentage","sleep_hours")]
features_scaled = scale(features)

fviz_nbclust(features_scaled, kmeans, method = "silhouette") +
labs(title = "Silhouette Method for Optimal k") +
theme_minimal()


k_means = kmeans(features_scaled, centers = 10)
str(features)
library(ggplot2)
ggplot(data,
aes(x = study_hours_per_day,
y = exam_score,
color = factor(k_means$cluster))) + 
geom_point(alpha = 0.6) + 
labs(title = "clustering study_hours - exam_score", color = "cluster") + 
theme_minimal()

































