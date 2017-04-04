#Aponta para a pasta onde estão os arquivos do exercício.
setwd("C:/Users/gomes/Downloads/UCI HAR Dataset")

#*********************************************************************************
#*********************************************************************************

# Exercício 01 - "Merges the training and the test sets to create one data set."

# Tratamento das tabelas de treinamento ******************************************

# Lê a tabela subject_train da pasta train e carrega para a variável subject_train.
subject_train = read.table("train/subject_train.txt", col.names=c("subject_id"))
# Cria o campo ID na tabela subject_train
subject_train$ID <- as.numeric(rownames(subject_train))

# Lê a tabela X_train da pasta train e carrega para a variável X_train.
X_train = read.table("train/X_train.txt")
# Cria o campo ID na tabela X_train
X_train$ID <- as.numeric(rownames(X_train)) 
# Lê a tabela Y_train da pasta train e carrega para a variável Y_train.
y_train = read.table("train/y_train.txt", col.names=c("activity_id"))
# Cria o campo ID na tabela X_train
y_train$ID <- as.numeric(rownames(y_train))

# Faz o merge entre subject_train e y_train e carrega na tabela train
train <- merge(subject_train, y_train, all=TRUE)
# Faz o merge entre train e X_train
train <- merge(train, X_train, all=TRUE)


# Tratamento das tabelas de teste ************************************************

# Lê a tabela subject_test da pasta test e carrega para a variável subject_test.
subject_test = read.table("test/subject_test.txt", col.names=c("subject_id"))
# Cria o campo ID na tabela subject_test
subject_test$ID <- as.numeric(rownames(subject_test))

# Lê a tabela X_test da pasta test e carrega para a variável X_test.
X_test = read.table("test/X_test.txt")
# Cria o campo ID na tabela X_test
X_test$ID <- as.numeric(rownames(X_test)) 
# Lê a tabela Y_test da pasta test e carrega para a variável Y_test.
y_test = read.table("test/y_test.txt", col.names=c("activity_id"))
# Cria o campo ID na tabela X_test
y_test$ID <- as.numeric(rownames(y_test))

# Faz o merge entre subject_test e y_test e carrega na tabela test
test <- merge(subject_test, y_test, all=TRUE)
# Faz o merge entre test e X_test
test <- merge(test, X_test, all=TRUE)


# Une as tabelas train e test ****************************************************
dt1 <- rbind(train, test)


#*********************************************************************************
#*********************************************************************************

# Exercício 02 - "Extracts only the measurements on the mean and standard deviation for each measurement."

# Carrega a biblioteca data.table e cria a tabela features com os dados do arquivo features.txt.
library(data.table)
features = read.table("features.txt", col.names=c("feature_id", "feature_label"))

# Extrai os campos de média e desvio padrão de cada medida
selected_features <- features[grepl("mean\\(\\)", features$feature_label) | grepl("std\\(\\)", features$feature_label), ]
# Armazena os valores na variável dt2
dt2 <- dt1[, c(c(1, 2, 3), selected_features$feature_id + 3) ]


#*********************************************************************************
#*********************************************************************************

# Exercício 03 - "Uses descriptive activity names to name the activities in the data set."

# Carrega a biblioteca data.table e cria a tabela activity_labels com os dados do arquivo activity_labels.txt.
library(data.table)
activity_labels = read.table("activity_labels.txt", col.names=c("activity_id", "activity_label"))
# Faz o merge de dt2 com os campos de activity_labels.
dt3 = merge(dt2, activity_labels)


#*********************************************************************************
#*********************************************************************************

# Exercício 04 - "Appropriately labels the data set with descriptive variable names."

# Substitui os nomes dos campos pelos nomes que estão em selected_features$feature_label. Faz um loop para nomear todos os campos.
selected_features$feature_label = gsub("\\(\\)", "", selected_features$feature_label)
selected_features$feature_label = gsub("-", ".", selected_features$feature_label)
for (i in 1:length(selected_features$feature_label)) {
  colnames(dt3)[i + 3] <- selected_features$feature_label[i]
}
# Cria o dt4 com o conteúdo e formato do dt3
dt4 = dt3

#*********************************************************************************
#*********************************************************************************

# Exercício 05 - "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

# Cria uma variável com "ID" e "activity_label" para excluir na tabela dt5. (dt4 menos estes dois campos)
aux <- c("ID","activity_label")
dt5 <- dt4[,!(names(dt4) %in% aux)]

# Cria a tabela aggdt com as médias de cada atividade
aggdt <-aggregate(dt5, by=list(subject = dt5$subject_id, activity = dt5$activity_id), FUN=mean, na.rm=TRUE)

# Cria uma variável com "subject" e "activity" para excluir na tabela aggdt (aggdt menos estes dois campos)
aux <- c("subject","activity")
aggdt <- aggdt[,!(names(aggdt) %in% aux)]

# Faz o merge entre aggdt e activity_labels
aggdt = merge(aggdt, activity_labels)

write.table(file="Ex5_Getting_Cleaning_Data.txt",x=aggdt, row.names = FALSE)

#*********************************************************************************
#*********************************************************************************