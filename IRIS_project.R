#R code with the selected model
#Load library
library(datasets)
library(tidyverse)
library(kableExtra)
library(gridExtra)
library(caret)

#Load data set
data(iris)

# Split the data
sample <- createDataPartition(iris$Species, p=0.80, list=FALSE)

# Create training data
iris_train <- iris[sample,]

# Create test data
iris_test <- iris[-sample,]

control <- trainControl(method='cv', number=10)
metric <- 'Accuracy'

# Linear Discriminant Analysis (LDA)
set.seed(101)
fit.lda <- train(Species~., data=iris_train, method='lda', 
                 trControl=control, metric=metric)

iris_prediction <- predict(fit.lda, iris_test)
confusionMatrix(iris_prediction, iris_test$Species)