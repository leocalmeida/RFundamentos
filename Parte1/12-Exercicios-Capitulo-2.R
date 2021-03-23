# Exercícios Capítulo 2

# Exercício 1 - Crie um vetor com 12 números inteiros
vetor <- seq(1:12)
vetor


# Exercício 2 - Crie uma matriz com 4 linhas e 4 colunas preenchida 
# com números inteiros
matriz <- matrix(seq(1:16),nc=4)
matriz

# Exercício 3 - Crie uma lista unindo o 
# vetor e matriz criados anteriormente
lista <- list(vetor,matriz)
lista

# Exercício 4 - Usando a função read.table() 
# leia o arquivo do link abaixo para uma dataframe
# http://data.princeton.edu/wws509/datasets/effort.dat
txt <- read.table("http://data.princeton.edu/wws509/datasets/effort.dat")
txt

# Exercício 5 - Transforme o dataframe anterior, 
# em um dataframe nomeado com os seguintes labels:
# c("config", "esfc", "chang")
names(txt) <- c('config','esfc','chang')
txt

# Exercício 6 - Imprima na tela o dataframe iris, 
# verifique quantas dimensões existem no dataframe iris, 
# imprima um resumo do dataset

head(iris)
dim(iris)
summary(iris)



# Exercício 7 - Crie um plot simples usando as duas primeiras colunas 
# do dataframe iris
plot(x=iris$Sepal.Length, y=iris$Sepal.Width)


# Exercício 8 - Usando s função subset, 
# crie um novo dataframe com o conjunto de dados do dataframe 
# iris em que Sepal.Length > 7
# Dica: consulte o help para aprender como usar a função subset()
help(subset)
iris_maiorq7 <- subset(iris, iris$Sepal.Length>7)
iris_maiorq7

# Exercícios 9 - Crie um dataframe que seja cópia do dataframe iris 
# e usando a função slice(), divida o dataframe em um subset de 15 linhas
# Dica 1: você vai ter que instalar e carregar o pacote dplyr
# Dica 2: Consulte o help para aprender como usar a função slice()
install.packages('dplyr')
# Carregar o pacote
library(dplyr)

iris_sliced <- slice(iris, 1:15)
iris_sliced


# Exercícios 10 - Use a função filter no seu novo dataframe 
# criado no item anterior e retorne apenas valores em que Sepal.Length > 6
# Dica: Use o RSiteSearch para aprender como usar a função filter
RSiteSearch("filter")
filter(iris_sliced, iris_sliced$Sepal.length>6)
# nao há um registro com Sepal Length maior q 6
ex10 <- subset(iris_sliced, iris_sliced$Sepal.Length>6)
ex10


