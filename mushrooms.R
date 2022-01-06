#Read data
install.packages("ggplot2")
library(ggplot2)
library(gridExtra)
install.packages("party")
load(party)
install.packages("lattice")
library(caret)
library(tidyverse)
library(naniar)
install.packages("randomForest")
library(randomForest)
library(party)
library(rpart)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

mushroom_dataset <- read.csv("mushrooms.csv", stringsAsFactors = TRUE, header = TRUE)
mushrooms <- read.csv("mushrooms.csv", stringsAsFactors = TRUE, header = TRUE)

names(mushroom_dataset)
str(mushroom_dataset)
view(mushroom_dataset)

vis_miss(mushroom_dataset)

#Checking missing values
map_dbl(mushroom_dataset, function(.x) {sum(is.na(.x))})

#Data Transformation
summary(mushroom_dataset)
# Rename the variables
colnames(mushroom_dataset) <- c("cap_shape", "cap_surface",
                        "cap_color", "bruises", "odor",
                        "gill_attachement", "gill_spacing", "gill_size",
                        "gill_color", "stalk_shape", "stalk_root",
                        "stalk_surface_above_ring", "stalk_surface_below_ring", "stalk_color_above_ring",
                        "stalk_color_below_ring", "veil_type", "veil_color",
                        "ring_number", "ring_type", "spore_print_color",
                        "population", "habitat","class")
names(mushroom_dataset)
str(mushroom_dataset)


## We redefine each of the category for each of the variables
levels(mushroom_dataset$class) <- c("edible", "poisonous")
levels(mushroom_dataset$cap_shape) <- c("bell", "conical", "flat", "knobbed", "sunken", "convex")
levels(mushroom_dataset$cap_color) <- c("buff", "cinnamon", "red", "gray", "brown", "pink",
                                "green", "purple", "white", "yellow")
levels(mushroom_dataset$cap_surface) <- c("fibrous", "grooves", "scaly", "smooth")
levels(mushroom_dataset$bruises) <- c("no", "yes")
levels(mushroom_dataset$odor) <- c("almond", "creosote", "foul", "anise", "musty", "none", "pungent", "spicy", "fishy")
levels(mushroom_dataset$gill_attachement) <- c("attached", "free")
levels(mushroom_dataset$gill_spacing) <- c("close", "crowded")
levels(mushroom_dataset$gill_size) <- c("broad", "narrow")
levels(mushroom_dataset$gill_color) <- c("buff", "red", "gray", "chocolate", "black", "brown", "orange",
                                 "pink", "green", "purple", "white", "yellow")
levels(mushroom_dataset$stalk_shape) <- c("enlarging", "tapering")
levels(mushroom_dataset$stalk_root) <- c("missing", "bulbous", "club", "equal", "rooted")
levels(mushroom_dataset$stalk_surface_above_ring) <- c("fibrous", "silky", "smooth", "scaly")
levels(mushroom_dataset$stalk_surface_below_ring) <- c("fibrous", "silky", "smooth", "scaly")
levels(mushroom_dataset$stalk_color_above_ring) <- c("buff", "cinnamon", "red", "gray", "brown", "pink",
                                             "green", "purple", "white", "yellow")
levels(mushroom_dataset$stalk_color_below_ring) <- c("buff", "cinnamon", "red", "gray", "brown", "pink",
                                             "green", "purple", "white", "yellow")
levels(mushroom_dataset$veil_type) <- "partial"
levels(mushroom_dataset$veil_color) <- c("brown", "orange", "white", "yellow")
levels(mushroom_dataset$ring_number) <- c("none", "one", "two")
levels(mushroom_dataset$ring_type) <- c("evanescent", "flaring", "large", "none", "pendant")
levels(mushroom_dataset$spore_print_color) <- c("buff", "chocolate", "black", "brown", "orange",
                                        "green", "purple", "white", "yellow")
levels(mushroom_dataset$population) <- c("abundant", "clustered", "numerous", "scattered", "several", "solitary")
levels(mushroom_dataset$habitat) <- c("wood", "grasses", "leaves", "meadows", "paths", "urban", "waste")
glimpse(mushroom_dataset)
view(mushroom_dataset)




#Data Exploration
#Check classes each variable
table(mushroom_dataset$class)
plot(mushroom_dataset$class)

#number of rows, number of levels
number_class <- function(x){
  x <- length(levels(x))
}

x <- mushroom_dataset %>% map_dbl(function(.x) number_class(.x)) %>% as_tibble() %>%
  rownames_to_column() %>% arrange(desc(value))
colnames(x) <- c("Attribute Number", "No. of levels")
View(x)


#number of rows, number of levels
number_class <- function(x){
  x <- length(levels(x))
}
#drop factor variable with only one level
mushroom_dataset <- mushroom_dataset %>% select(- veil_type)
View(mushroom_dataset)

# Draw the histogram
h0 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = cap_shape, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Cap Shape")

h1 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = cap_surface, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Cap Surface")

hc2 <- ggplot(data = mushroom_dataset) + 
    geom_histogram(stat = "count", 
    mapping = aes(x = cap_color, 
    fill = factor(class))) + 
    facet_wrap(~class) + xlab("Cap Color")
  
grid.arrange(h0, h1, hc2, ncol = 1)

h2 <- ggplot(data = mushroom_dataset) + 
    geom_histogram(stat = "count", 
    mapping = aes(x = bruises, 
    fill = factor(class))) + 
    facet_wrap(~class) + xlab("Bruises")

h3 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = odor, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Odor")
  
  grid.arrange(h2, h3, ncol = 1)

h4 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = gill_attachement, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Gill Attachement")

h5 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = gill_spacing, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Gill spacing")

h6 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = gill_size, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Gill Size")

grid.arrange(h4, h5, h6, ncol = 2)

h7 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = stalk_shape, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Stalk Shape")

h8 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = stalk_root, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Stalk Root")

h9 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = stalk_surface_below_ring, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Stalk Surface Below Ring")

h10 <- ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = stalk_surface_above_ring, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Stalk Surface Above Ring")

grid.arrange(h7, h8, h9, h10, ncol = 2)

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = stalk_color_below_ring, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Stalk Color Below Ring")

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = stalk_color_above_ring, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Stalk Color Above Ring")

grid.arrange(h11, h12, ncol = 2)

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = veil_color, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Veil Color")

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = ring_number, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Ring Number")

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = spore_print_color, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Spore Print Color")

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = population, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Population")

ggplot(data = mushroom_dataset) + 
  geom_histogram(stat = "count", 
  mapping = aes(x = habitat, 
  fill = factor(class))) + 
  facet_wrap(~class) + xlab("Habitat")

chart.Correlation(mushrooms, histogram = TRUE)

#Chi-squared test
library(MASS)
ch1 <- table(mushroom_dataset$class, mushroom_dataset$cap_shape)
chisq.test(ch1)

#Multivariate Analysis
ggplot(mushroom_dataset, aes(odor, spore_print_color, class)) +
  geom_point(aes(shape = factor(class), color = factor(class)), size = 3.5) +
  scale_shape_manual(values = c('e', 'x')) +scale_colour_manual(values = c("blue", "red"))
+ggtitle("Spore Print Color vs Odor") +labs(x = "Odor", y = "Spore Print Color")

ggplot(mushroom_dataset, aes(ring_type, gill_color, class)) +
  geom_point(aes(shape = factor(class), color = factor(class)), size = 3.5) +scale_shape_manual(values = c('e', 'x')) +scale_colour_manual(values = c("blue", "red"))+ggtitle("Ring Type vs Gill Color") +labs(x = "Ring Type", y = "Gill Color")

ggplot(mushroom_dataset, aes(stalk_surface_above_ring, stalk_surface_below_ring, class)) +
  geom_point(aes(shape = factor(class), color = factor(class)), size = 3.5) +scale_shape_manual(values = c('e', 'x')) +scale_colour_manual(values = c("blue", "red"))+ggtitle("Stalk Surface") +labs(x = "Stalk surface above ring", y = "Stalk surface below ring")

ggplot(mushroom_dataset, aes(gill_size, stalk_color_above_ring, class)) +
  geom_point(aes(shape = factor(class), color = factor(class)), size = 3.5) +scale_shape_manual(values = c('e', 'x')) +scale_colour_manual(values = c("blue", "red"))+ggtitle("Gill size vs Stalk color above ring") +labs(x = "Gill size", y = "Stalk color above ring")

ggplot(mushroom_dataset, aes(bruises, stalk_color_below_ring,class)) +geom_point(aes(shape = factor(class), color = factor(class)), size = 3.5) +scale_shape_manual(values = c('e', 'x')) +scale_colour_manual(values = c("blue", "red")) +ggtitle("Stalk Color above ring vs Bruises") +labs(x = "Bruises", y = "Stalk Color below Ring")

#visualize data
library(ggplot2)
ggplot(mushroom_dataset, aes(x = cap_surface, y = cap_color, col = class)) +
  geom_jitter(alpha = 0.5) +
  scale_color_manual(breaks = c("edible", "poisonous"),
                     values = c("green", "red"))

ggplot(mushroom, aes(x = cap_shape, y = cap_color, col = class)) +
  geom_jitter(alpha = 0.5) +
  scale_color_manual(breaks = c("edible", "poisonous"),
                     values = c("green", "red"))
ggplot(mushroom, aes(x = gill_color, y = cap_color, col = class)) +
  geom_jitter(alpha = 0.5) +
  scale_color_manual(breaks = c("edible", "poisonous"),
                     values = c("green", "red"))
ggplot(mushroom, aes(x = class, y = odor, col = class)) +
  geom_jitter(alpha = 0.5) +
  scale_color_manual(breaks = c("edible", "poisonous"),
                     values = c("green", "red"))

ggplot(mushroom, aes(x = gill_color, y = cap_color, col = class)) +
  geom_jitter(alpha = 0.5) +
  scale_color_manual(breaks = c("edible", "poisonous"),
                     values = c("green", "red"))

ggplot(mushroom, aes(x = class, y = odor, col = class)) +
  geom_jitter(alpha = 0.5) +
  scale_color_manual(breaks = c("edible", "poisonous"),
                     values = c("green", "red"))



#split the data into a training and testing set

set.seed(1234)
mushroom_dataset[,"train"] <- ifelse(runif(nrow(mushroom_dataset))<0.8, 1, 0)

trainset <- mushroom_dataset[mushroom_dataset$train == "1",]
testset <- mushroom_dataset[mushroom_dataset$train == "0",]

view(mushroom_dataset[23])
trainset <- trainset[-23]
testset <- testset[-23]


#use of SVM
install.packages("e1071")
library(e1071)
model_svm <- svm(class ~. , data=trainset, cost = 1000, gamma = 0.01)


#Check the prediction
test_svm <- predict(model_svm, newdata = testset %>% na.omit())
yo <- testset %>% na.omit()
table(test_svm, yo$class)

install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

#Decision Tree
model_tree <- rpart(class ~ ., data = trainset, method = "class")
model_tree
rpart.plot(model_tree, extra = 106)
library(caret)
caret::confusionMatrix(data=predict(model_tree, type = "class"),
                       reference = trainset$class,
                       positive="edible")

#Check the prediction

test_nb <- predict(model_tree, newdata = testset, type = "class")

table(predicted = test_nb, actual = testset$class)

mean(test_nb==testset$class)


# Use of Random Forest
mushroom_rf <- randomForest(class ~ ., ntree = 100, data = trainset, importance = TRUE)
plot(mushroom_rf)
print(mushroom_rf)

varImpPlot(mushroom_rf,  
           sort = T,
           main = "Variable Importance")
caret::confusionMatrix(data = mushroom_rf$predicted, reference = trainset$class ,
                       positive = "edible")

test_rf <- predict(mushroom_rf, newdata = testset, type = "class")
table(predicted= test_rf, actual = testset$class)
library(caret)
print(  
  confusionMatrix(data = test_rf,  
                  reference = testset$class,
                  positive = 'edible'))

TN <- 851
FN <- 0
FP <- 0
TP <- 764
Acc <- (TP + TN) / (TP + TN + FP + FN)
Acc

precision <- TP / (TP + FP)
precision
recall <- TP / (TP + FN)
recall

F1 <- 2* ((precision * recall) / (precision + recall))  
F1
