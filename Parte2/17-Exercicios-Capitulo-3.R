library(dplyr)
# Exercício 1 - Crie uma função que receba e vetores como parâmetro, 
  # converta-os em um dataframe e imprima

vec2df <- function(...){
  df = data.frame(cbind(...))
}

Aluno <- c('Alan', 'Alice', 'Alana', 'Aline', 'ALex', 'Ajay')
Matematica <- c(90,80,85,87,56,79)

resultado <- vec2df(Aluno, Matematica)
resultado

# Exercício 2 - Crie uma matriz com 4 linhas e 4 colunas preenchida com números 
  # inteiros e calcule a media de cada linha

numeros <- c(1:16)

matriz <- matrix(numeros, ncol=4, byrow = TRUE)
matriz

media = apply(matriz, 1, mean)
media

# Exercício 3 - Considere o dataframe abaixo. Calcule a media por disciplina
Aluno <- c('Alan', 'Alice', 'Alana', 'Aline', 'ALex', 'Ajay')
Matematica <- c(90,80,85,87,56,79)
Geografia <- c(100, 78, 86, 90, 98, 67)
Quimica <- c(76, 56, 89, 90, 100, 87)

?data.frame()
df <- data.frame(Aluno, Matematica, Geografia, Quimica)
df

media_por_disciplica <- apply(df[,c(2,3,4)],2,mean)
media_por_disciplica

# Exercício 4 - Cria uma lista com 3 elementos, todos numéricos e calcule a soma de todos os
  # elementos da lista

lista <- list(c(1:3))
lista
class(lista)
?sapply()

sapply(lista, sum)


# Exercício 5 - Transforme a lista anterior um vetor
ex5 <- unlist(lista)
ex5
class(ex5)
typeof(ex5)


# Exercício 6 - Considere a string abaixo. Substitua a palavra textos por frases
str <- c('Expressoes','regulares', 'em linguagem R', 
         "permitem a busca de padroes", "e exploracao de textos",
         "podemos buscar padroes em digitos",
         "como por exemplo",
         "10992451280")

# é para encontrar determinado padrão
?grep()
grep('textos', str, ignore.case = FALSE, value = TRUE)

# é para substituir dado um determinado padrão
?gsub()
str02 <- gsub('textos', 'frases', str)
str02


# Exercício 7 - Usando o dataset mtcars, crie um gráfico com ggplot do tipo
  # scatter plot. Use as colunas disp e mpg nos eixos x e y respectivamente
detach(mtcars)
library(ggplot2)
?mtcars

?par()
par(mar=c(5,5,5,5))

plot(mtcars$disp, mtcars$mpg, ylab = 'Milhas/(US)gallon', 
     xlab = 'Cilindradas', main = 'Scatterplot')

# Exercício 8 - Usando o exemplo anterior, explore outros tipos de gráficos

boxplot(mtcars$disp, mtcars$mpg, ylab = 'Milhas/(US)gallon', xlab = 'Cilindradas')

hist(mtcars$disp)

# fatores
head(mtcars)

pie(mtcars$cyl)

barplot(mtcars$cyl)







