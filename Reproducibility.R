set.seed(1)

library(recommenderlab)
library(reshape2)
library(countrycode)
library(ggplot2)

data("MovieLense")
dim(MovieLense)

v_rating <- as.vector(MovieLense@data)
v_rating <- v_rating[v_rating!=0]
v_rating <- factor(v_rating)
dis_plot <- qplot(v_rating) + ggtitle('Distribution of the ratings')
dis_plot

trainset <- sample(x=c(T,F),size=nrow(MovieLense),replace=T,prob=c(0.8,0.2))
data_train <- MovieLense[trainset, ]
data_test <- MovieLense[!trainset, ]

model_try = Recommender(data = data_train,method="IBCF")
model_try_detail <- getModel(model_try)

sim <- model_try_detail$sim
eigenvalue_try <- eigen(sim)$values
eigenvalue_try <- as.numeric(eigenvalue_try)
eigenvalue_plot1 <- qplot(eigenvalue_try) + ggtitle('Eigenvalues')
eigenvalue_plot1

source('C:/Users/zhuzh/Desktop/大作业/f and g.R')
source('C:/Users/zhuzh/Desktop/大作业/OptM.R')
obj_sim <- as(sim, "matrix")
b <- matrix(rnorm(1664*1664), nrow = 1664, ncol = 1664)
b <- svd(b)$u
newb <- Beta(b,obj_sim)
newbb <- t(newb)%*%newb
norm(newbb)
for (i in 31:1664){
  newbb[i,i] = 0+runif(1)
}

eigenvalue_new <- eigen(newbb)$values
eigenvalue_plot2 <- qplot(eigenvalue_new) + ggtitle('Eigenvalues')
eigenvalue_plot2

recommend_n <- 10
model_try_predict <- predict(object = model_try,newdata=data_test,n=recommend_n)
user_1_try <- model_try_predict@items[[1]]
user_1_try_movie <- model_try_predict@itemLabels[user_1_try]
user_1_try_movie

rownames(newbb) <- rownames(sim)
colnames(newbb) <- colnames(sim)

model_try_2 <- model_try
model_try_2@model$sim <- as(newbb,'dgCMatrix')

model_try_predict_2 <- predict(object = model_try_2,newdata=data_test,n=recommend_n)
user_1_try_2 <- model_try_predict_2@items[[1]]
user_1_try_movie_2 <- model_try_predict_2@itemLabels[user_1_try_2]
user_1_try_movie_2

evalset <- evaluationScheme(data=MovieLense,method='cross-validation',k=4,given=15,goodRating=3)
models_to_evaluate <- list(
  IBCF_cos = list(name='IBCF',param=list(method='cosine')),
  IBCF_cor = list(name='IBCF',param=list(method='pearson')),
  UBCF_cos = list(name='UBCF',param=list(method='cosine')),
  UBCF_cor = list(name='UBCF',param=list(method='pearson'))
)

n_recommendations <- c(1, 5, seq(10, 100, 10))
list_results <- evaluate(x = evalset, method =
    models_to_evaluate, n = n_recommendations)

plot(list_results)
title("ROC curve")

densedata <- MovieLense[rowCounts(MovieLense) > 50,colCounts(MovieLense) > 100]
evalset_2 <- evaluationScheme(data=densedata,method='cross-validation',k=4,given=15,goodRating=3)
models_to_evaluate_2 <- list(
  IBCF_cos_2 = list(name='IBCF',param=list(method='cosine')),
  IBCF_cor_2 = list(name='IBCF',param=list(method='pearson')),
  UBCF_cos_2 = list(name='UBCF',param=list(method='cosine')),
  UBCF_cor_2 = list(name='UBCF',param=list(method='pearson'))
)
list_results_2 <- evaluate(x = evalset_2, method =
    models_to_evaluate_2, n = n_recommendations)

plot(list_results_2)
title("ROC curve of dense data")































