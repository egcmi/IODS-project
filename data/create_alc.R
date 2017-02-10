# Emanuela Giovanna Calabi, 09/02/2017
#The result also provides the correlation between alcohol usage and the social, gender and study time attributes for each student.

student_mat <- read.csv("/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/student/student-mat.csv", header=TRUE, sep = ";")
student_por <- read.csv("/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/student/student-por.csv", header=TRUE, sep = ";")

str(student_mat)
dim(student_mat)

str(student_por)
dim(student_por)

library(dplyr)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")
mat_por <- inner_join(student_mat, student_por, by = join_by, suffix = c("mat", "por"))
alc <- select(mat_por, one_of(join_by))

str(alc)
dim(alc)

notjoined_columns <- colnames(student_mat)[!colnames(student_por) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)

write.table(alc, file="/home/emanuela/Desktop/UNI/Introduction to Open Data Science/IODS-project/data/alc.txt", sep="\t")
