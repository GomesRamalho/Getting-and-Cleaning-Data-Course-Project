# Code Book for Getting and Cleaning Data Course Project

Abaixo há a descrição do que foi feito com os dados (fonte: site do Coursera)

1 - Merges the training and the test sets to create one data set.

2 - Extracts only the measurements on the mean and standard deviation for each measurement.

3 - Uses descriptive activity names to name the activities in the data set

4 - Appropriately labels the data set with descriptive variable names.

5 - From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject.

# Passo a passo do que foi feito:

Apontar para a pasta onde estão os arquivos do exercício.

# Exercício 01 - "Merges the training and the test sets to create one data set."

Tratamento das tabelas de treinamento 
Lê a tabela subject_train da pasta train e carrega para a variável subject_train.
Cria o campo ID na tabela subject_train
Lê a tabela X_train da pasta train e carrega para a variável X_train.
Cria o campo ID na tabela X_train
Lê a tabela Y_train da pasta train e carrega para a variável Y_train.
Cria o campo ID na tabela X_train
Faz o merge entre subject_train e y_train e carrega na tabela train
Faz o merge entre train e X_train

Tratamento das tabelas de teste 
Lê a tabela subject_test da pasta test e carrega para a variável subject_test.
Cria o campo ID na tabela subject_test
Lê a tabela X_test da pasta test e carrega para a variável X_test.
Cria o campo ID na tabela X_test
Lê a tabela Y_test da pasta test e carrega para a variável Y_test.
Cria o campo ID na tabela X_test

Faz o merge entre subject_test e y_test e carrega na tabela test
Faz o merge entre test e X_test
Une as tabelas train e test 

#*********************************************************************************

# Exercício 02 - "Extracts only the measurements on the mean and standard deviation for each measurement."

Carrega a biblioteca data.table e cria a tabela features com os dados do arquivo features.txt.
Extrai os campos de média e desvio padrão de cada medida
Armazena os valores na variável dt2

#*********************************************************************************

# Exercício 03 - "Uses descriptive activity names to name the activities in the data set."

Carrega a biblioteca data.table e cria a tabela activity_labels com os dados do arquivo activity_labels.txt.
Faz o merge de dt2 com os campos de activity_labels.

#*********************************************************************************

# Exercício 04 - "Appropriately labels the data set with descriptive variable names."

Substitui os nomes dos campos pelos nomes que estão em selected_features$feature_label. Faz um loop para nomear todos os campos.
Cria o dt4 com o conteúdo e formato do dt3

#*********************************************************************************

# Exercício 05 - "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

Cria uma variável com "ID" e "activity_label" para excluir na tabela dt5. (dt4 menos estes dois campos)
Cria a tabela aggdt com as médias de cada atividade
Cria uma variável com "subject" e "activity" para excluir na tabela aggdt (aggdt menos estes dois campos)
Faz o merge entre aggdt e activity_labels
Gerar o arquivo final .txt

#*********************************************************************************
