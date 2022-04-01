##Load the microservice Dataset

microservicios <- read.csv("MicroserviceDatasetFeatureVector.csv")

##Load the two packages required to train classifiers

library(caret)
library(e1071)

##Split the data into data to train (80%) the classifiers and the data to test (20%) the classifiers

trainIndex <- createDataPartition(microservicios$Required.solution, p =.8, list = FALSE, times = 1)

microserviciosTrain <- microservicios[trainIndex,]

microserviciosTest <- microservicios[-trainIndex,]

##Configure the parameters for the cross-validation technique

fitControl <- trainControl(method = "cv", number = 10)
set.seed(1001)

##Train phase

##Decision Tree:

DTFit <- train (Required.solution ~., data =microserviciosTrain, method = "rpart2", trControl = fitControl)
DTFit

##KNN without pre-processing the data

DTFitknn <- train(Required.solution ~., data = microserviciosTrain, method = "knn", trControl = fitControl)
DTFitknn

##KNN pre-processing the data

DTFitknn2 <- train(Required.solution ~., data = microserviciosTrain, method = "knn", preProcess = c("center","scale"), trControl = fitControl)
DTFitknn2

##Test phase

##Test the Decision Tree classifier

microserviciosPrediccionTree <- predict(DTFit, microserviciosTest)

##Results of the Decision Tree classifier

confusionMatrix(microserviciosPrediccionTree,microserviciosTest$Required.solution)

##Test the KNN without pre-processing the data

microserviciosPrediccionKnn <- predict(DTFitknn, microserviciosTest)

##Results of the KNN without pre-processing the data

confusionMatrix(microserviciosPrediccionKnn,microserviciosTest$Required.solution)

##Test the KNN pre-processing the data

microserviciosPrediccionKnn2 <- predict(DTFitknn2, microserviciosTest)

##Results of the KNN pre-processing the data

confusionMatrix(microserviciosPrediccionKnn2,microserviciosTest$Required.solution)