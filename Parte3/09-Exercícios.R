# Exercicios Capitulo 4
getwd()
setwd("/home/leonardo/Documents/RFundamentos/Parte3")
# Exercicio 1 - Encontre e faça a correção do erro na instrução abaixo:
# Before
write.table(mtcars, file = 'mtcars.txt',sep='|', col.names = N, qmethod = 'double')
# After
write.table(mtcars, file = 'mtcars.txt',sep='|', col.names = NA, qmethod = 'double') 

# Exercicio 2 - Encontre e faça a correção do erro na instrução abaixo:
library(readr)
library(dplyr)
write_csv(iris, 'iris.csv')

# Before
df_iris <- read_csv('iris.csv',col_types = matrix(
  Sepal.Length = col_double(1),
  Sepal.Width = col_double(1),
  Petal.Length = col_double(1),
  Petal.Width = col_double(1),
  Species = col_factor(c('setosa','versicolor','virginica'))
))

#After
df_iris <- read_csv('iris.csv',col_types = list(
  Sepal.Length = col_double(),
  Sepal.Width = col_double(),
  Petal.Length = col_double(),
  Petal.Width = col_double(),
  Species = col_factor(c('setosa','versicolor','virginica'))
))

glimpse(df_iris)

# Exercicio 3 - Encontre e faça a correção do erro na instrução abaixo:
library(readxl)

#Before
df2 <- read.xlsx('UrbanPop.xlsx',sheetIndex=5)

#After
df2 <- read_excel('UrbanPop.xlsx')


# Exercicio 4 - Encontre e faça a correção do erro na instrução abaixo:
library(readr)

# Before
df_sono <- read_csv('sono.csv')
sleep_sono <- select(df_sono, nome, sono_total)
df_sono %>% 
  select(nome, cidade, sono_total) %>%
  arrange(cidade, sono_total) # faltou o %>%
  head

# After
df_sono <- read_csv('sono.csv')
sleep_sono <- select(df_sono, nome, sono_total)
df_sono %>% 
  select(nome, cidade, sono_total) %>%
  arrange(cidade, sono_total) %>%
  head


# Exercicio 5 - Encontre e faça a correção do erro na instrução abaixo:
library(ggplot2)

# Before
set.seed(1)
df3 <- data.frame(
  participante = c('p1','p2','p3','p4','p5','p6'),
  info = c('gim1','gim2','gim3','gim4','gim5','gim6'),
  day1score = rnorm(n=6, mean = 80, sd = 15),
  day2score = rnorm(n=6, mean = 80, sd = 8)
)

df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  separate(col = info, into = c("group", "gender"), sep = 2) %>%
  ggplot(aes(x = day, y = score)) #faltou +
  geom_point() +
  facet_wrap(~ group) +
  geom_smooth(method = "lm", aes(group = 1), se = F)


# After
df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  separate(col = info, into = c("group", "gender"), sep = 2) %>%
  ggplot(aes(x = day, y = score)) + 
  geom_point() + 
  facet_wrap(~ group) +
  geom_smooth(method = "lm", aes(group = 1), se = F)



