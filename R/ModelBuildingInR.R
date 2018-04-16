library(tidyverse)
library(ggplot2)
library(gridExtra)
library(ModelMetrics)
library(rpart)
library(randomForest)
library(xgboost)

CB <- read_csv("https://github.com/JackStat/PracticalDataScience/blob/master/data/CollegeBasketball.csv?raw=true")


g1 <- ggplot(CB, aes(x = Offense, fill = factor(Win))) +
  geom_density(alpha = .5) +
  theme(legend.position = 'none')

g2 <- ggplot(CB, aes(x = Defense, fill = factor(Win))) +
  geom_density(alpha = .5) +
  theme(legend.position = 'none')

g3 <- ggplot(CB, aes(x = Margin, fill = factor(Win))) +
  geom_density(alpha = .5) +
  theme(legend.position = 'none')


grid.arrange(g1,g2,g3)

### GLM
####################
gg <- glm(factor(Win) ~ Offense + Defense + OppOffense + OppDefense
          , family = "binomial"
          , data = CB
          )

GLMpreds <- predict(gg, type = 'response')

### Decision Tree
####################
rr <- rpart(factor(Win) ~ Offense + Defense + OppOffense + OppDefense
            , data = CB
            )


# plot(rr,compress = TRUE)
# text(rr, use.n = TRUE)

DTreepreds <- predict(rr)[,2]
# [,2] means all entries in the second column
# [,1] would mean all entries in the first column
# throws the rest away

### Random Forest
####################

rf <- randomForest(factor(Win) ~ Offense + Defense + OppOffense + OppDefense
             , data = CB
             , ntree = 1000
             )

RFpreds <- predict(rf, type = "prob")[,2]


# gradient boosting is like randomForest on steroids





messageMetrics <- function(preds, modelName = "GLM"){
  AUC = auc(CB$Win, preds)
  LL = logLoss(CB$Win, preds)
  message(paste(modelName, ": AUC =", AUC, "logLoss =", LL))
} # make a function



# this is made into a function above
# message(paste0("GLM: AUC ="
#                , auc(CB$Win, preds)
#                , "logloss ="
#                , logLoss(CB$Win, preds
#                          )
#                )
#         )



message("Decision Tree")
auc(CB$Win, preds)
logLoss(CB$Win, preds)

## xgboost
####

y = CB$Win

x = CB[, c("Offense", "Defense", "OppOffense", "OppDefense")]
var.names <- names(x)
x <- as.matrix(x)

params <- list(
  objective = "reg:logistic"
  ,eval_metric = "logloss"
  ,max_depth = 3
  ,colsample_bytree = .6
  ,eta = .05
)

bst.cv <- xgb.cv(params, data = x, label = y, nfold = 5, nrounds = 250
       , missing = NA
       , prediction = TRUE
       )

  # which(bst.cv$evaluation_log$test_logloss_mean ==
  #         min(bst.cv$evaluation_log$test_logloss_mean)
  # )
nround = which.min(bst.cv$evaluation_log$test_logloss_mean)



XGB <- xgboost(params = params
               , data = x
               , label = y
               , nrounds = nround
               , missing = NA
        )

xgb.importance(var.names, model = XGB)

# xgb.plot.tree(var.names, model = XGB, n_first_tree = 1)

xgbPred <- predict(XGB, newdata = x)


# use that function twice
messageMetrics(GLMpreds)
messageMetrics(DTreepreds, "Decision Tree")
messageMetrics(RFpreds, "Random Forest")
messageMetrics(xgbPred, "xgboost")


table(CB$Win, GLMpreds < .5)
table(CB$Win, GLMpreds > .5)











