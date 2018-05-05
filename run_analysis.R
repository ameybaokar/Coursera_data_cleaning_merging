
#################setting the working directory###############################
setwd("C:/Users/abaokar/DataScience/Getting and Cleaning Data - Course 3/Week 4/Project/Data/UCI HAR Dataset/")



########################loading all the required datasets#################################
subject_train <- rio::import("train/subject_train.txt")
subject_test <- rio::import("test/subject_test.txt")
activity_labels <- rio::import("activity_labels.txt")

#Loading the training dataset
data_train <- rio::import("train/X_train.txt")
train_activity_class <- rio::import("train/Y_train.txt")
#Loading the test dataset
data_test <- rio::import("test/X_test.txt")
test_activity_class <- rio::import("test/Y_test.txt")
#loading the features dataset, which tells about the column names
features <- rio::import("features.txt")
#Adding column names to test and train datasets
names(data_test) <- c(features$V2)
names(data_train) <- c(features$V2)
names(train_activity_class) <- c("activity_class")
names(test_activity_class) <- c("activity_class")
names(subject_test) <- c("subject")
names(subject_train) <- c("subject")
data_test <- cbind(data_test, test_activity_class, subject_test)
data_train <- cbind(data_train, train_activity_class, subject_train)


########################performing operations required for the assignment#####################
#1. Merging training and test datasets

one_data <- rbind(data_train, data_test)

#2. Extracting only the measurements on the mean and std.deviation for each measurement
all_names <- features$V2
selected_names <- all_names[grepl("mean|std", all_names)]
selected_data <- one_data[, c(selected_names, "activity_class", "subject")]

#3.Using descriptive activity names to name the activities in the dataset

#adding the activity description to the activity class variable

names(activity_labels) <- c("activity_class", "activity_desc")


#Adding activity description and class to the whole dataset
selected_data <- selected_data %>% left_join(activity_labels, "activity_class") %>% select(-activity_class)


#4. making the columns descriptive

#getting the descriptive names of the columns
col_desc <- rio::import("col_desc.csv")
#making column names free of mean or std
col_names <- tibble(col_name = c(names(selected_data)))
col_names <- col_names %>% mutate(small_form = sub("-.*", "", col_name), 
                                  second_name =str_replace(col_name, "-", "/")) %>%
            mutate(second_name = sub(".*/", "", second_name)) %>% left_join(col_desc, by = "small_form") %>%
            mutate(desc_name = ifelse(second_name == "subject" | second_name == "activity_desc", second_name,  paste0(col_desc,"-", second_name)))
desc_names <- col_names$desc_name
names(selected_data) <- c(desc_names)


#5. calculating mean by per subject per activity
smmarized_data <- selected_data %>% group_by(subject, activity_desc) %>% summarise_all(funs(mean))

##exporting the summarized data
write.table(smmarized_data, "output.txt", row.names = FALSE)
