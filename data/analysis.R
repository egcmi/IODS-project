learning2014 <- read.table("/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/learning2014.txt", header=TRUE)
str(learning2014)
dim(learning2014)

#
# describe dataset
#

# graphical overview of data and summary
library(ggplot2)
p1 <- ggplot(learning2014, aes(x = attitude, y = points, col = gender))
p2 <- p1 + geom_point()
p2+ ggtitle("Student's attitude versus exam points")
my_model <- lm(points ~ attitude, data = learning2014)
summary(my_model)

p3 <- p2 + geom_smooth(method = "lm")
p3
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4

my_model2 <- lm(points ~ attitude+stra+surf, data = learning2014)
plot(my_model2)
plot(my_model2, c(1, 2, 5))




