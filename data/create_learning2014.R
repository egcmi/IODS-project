# first row contains variable names, whitespace is separator
learning2014 <- read.table("/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/JYTOPKYS3-data.txt", header=TRUE)

str(learning2014)
# structure has 183 observations, 60 variables
# for each variable shows datatype and sample of data

dim(learning2014)
# the dimension is 183 observations * 60 variables in the dataset

library(dplyr)
lrn14 <- read.table("/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/JYTOPKYS3-data.txt", header=TRUE)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose columns to keep and create new dataset
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# change column names to lowercase for convenience
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"

# exclude observations where points variable is 0
learning2014 <- filter(learning2014, points > 0)

# checking correctness of dataset
str(learning2014)
head(learning2014)
dim(learning2014)

# save analysis dataset
write.table(learning2014, file="/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/learning2014.txt", sep="\t")
