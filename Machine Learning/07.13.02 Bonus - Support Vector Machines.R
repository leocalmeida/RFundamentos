letterdata# Support Vector Machines 

# Estude o script e procure fazer correlacao com tudo que você estudou neste capitulo. 
# SVM's são temas bem avancados e aproveite esta chance para ter o primeiro contato com este algoritmo

# OCR - Optical Character Recognition
# Algumas etapas do script possuem levarao alguns segundos em processamento, dependendo da velocidade do seu computador

## Explorando e preparando os dados
letters <- read.csv("letterdata.csv")
str(letters)

# Criando dados de treino e dados de teste
letters_treino <- letters[1:16000, ]
letters_teste  <- letters[16001:20000, ]

## Treinando o Modelo
install.packages("kernlab")
library(kernlab)

# Criando o modelo com o kernel vanilladot
letter_classifier <- ksvm(letter ~ ., data = letters_treino, kernel = "vanilladot")

# Visualizando resultado do modelo
letter_classifier

# Avaliando a performance do modelo
letter_predictions <- predict(letter_classifier, letters_teste)
head(letter_predictions)
table(letter_predictions, letters_teste$letter)

# Criando um vetor de TRUE/FALSE indicando previsoes corretas/incorretas
agreement <- letter_predictions == letters_teste$letter
table(agreement)
prop.table(table(agreement))

## Otimizando o Modelo
set.seed(12345)

# Recriando o modelo com outro tipo de kernel
letter_classifier_rbf <- ksvm(letter ~ ., data = letters_treino, kernel = "rbfdot")

# Novas previsoes
letter_predictions_rbf <- predict(letter_classifier_rbf, letters_teste)

# Compare os resultados com a primeira versao do modelo
agreement_rbf <- letter_predictions_rbf == letters_teste$letter
table(agreement_rbf)
prop.table(table(agreement_rbf))