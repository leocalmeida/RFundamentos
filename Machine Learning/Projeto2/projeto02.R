# Prevendo a Ocorrência de Câncer

## Etapa 1 - Coletando os Dados

# http://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29
# http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/ML/wisc_bc_data.csv

# Os dados do câncer da mama incluem 569 observações de biópsias de câncer, 
# cada um com 32 características (variáveis). Uma característica é um número de 
# identificação (ID), outro é o diagnóstico de câncer, e 30 são medidas laboratoriais 
# numéricas. O diagnóstico é codificado como "M" para indicar maligno ou "B" para 
# indicar benigno.
getwd()
setwd("/home/leonardo/Documents/RFundamentos/Machine Learning/Projeto2")

dados <- read.csv('breast_cancer_diag.csv')
str(dados)
summary(dados)
any(is.na(dados))

## Etapa 2 - Explorando os Dados

# Excluindo a coluna ID
# Independentemente do método de aprendizagem de máquina, deve sempre ser excluídas 
# variáveis de ID. Caso contrário, isso pode levar a resultados errados porque o ID 
# pode ser usado para unicamente "prever" cada exemplo. Por conseguinte, um modelo 
# que inclui um identificador pode sofrer de superajuste, e será muito difícil usá-lo para 
# generalizar outros dados.

#removendo a coluna ID
dados <- dados[-1]
head(dados)

# Muitos classificadores requerem que as variáveis sejam do tipo Fator
table(dados$diagnosis)
?factor
dados$diagnosis <- factor(dados$diagnosis, levels=c('M', 'B'), labels=c("Maligno", "Benigno"))

head(dados)
str(head(dados))

# Verificando a proporção
table(dados$diagnosis)
?prop.table
prop.table(table(dados$diagnosis))
prop.table(table(dados$diagnosis))*100
round(prop.table(table(dados$diagnosis))*100)

# Medidas de Tendência Cetral
# Detectamos aqui um problema de escala entre os dados, que então precisam ser normalizados
# O cálculo de distância feito pelo kNN é dependente das medidas de escala nos dados de entrada.
### Pegando os valores de 3 variáveis e aplicando um summary, dá para ver que 
  ###a proporçao de uma com a outra é muito descrepante, como o exemplo que segue
aux1 <- c(1,2,3,4,5,6)
aux2 <- c(10,20,30,40,50,60)
summary(aux1)
summary(aux2)


# Criando um função de normalização para que dados com valores muito distintos
  #sejam igualados.

normalizar <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}
## aplicando a funçao no exemplo acima
normalizar(aux1)
normalizar(aux2)
##após a normalizaçao os valores possuem a mesma proporçao.
##neste caso são identicos pois sao numeros iguais mas 10x maior queo outro.
##com uma amostra de numeros aleatórios, náo seriam iguais esses valores


# Normalizando os dados
dados_norm <- as.data.frame(lapply(dados[2:31], normalizar))

# Confirmando que a normalização funcionou
summary(dados[c("radius_mean", "area_mean", "smoothness_mean")])
summary(dados_norm[c("radius_mean", "area_mean", "smoothness_mean")])


## Etapa 3: Treinando o modelo

# Carregando o pacote library
install.packages("class")
library(class)
?knn

# Criando dados de treino e dados de teste
## criando manualmente
dados_norm_train <- dados_norm[1:469,]
dados_norm_test <- dados_norm[470:569,]

## criando pelo R
install.packages("caret", dependencies = TRUE)
library(caret)


# Criando os labels para os dados de treino e de teste

# Criando o modelo

# A função knn() retorna um objeto do tipo fator com as previsões para cada exemplo no dataset de teste


## Etapa 4: Avaliando e Interpretando o Modelo

# Carregando o gmodels

# Criando uma tabela cruzada dos dados previstos x dados atuais
# Usaremos amostra com 100 observações: length(dados_teste_labels)

# Interpretando os Resultados
# A tabela cruzada mostra 4 possíveis valores, que representam os falso/verdadeiro positivo e negativo
# A primeira coluna lista os labels originais nos dados observados
# As duas colunas do modelo (Benigno e Maligno) do modelo, mostram os resultados da previsão
# Temos:
# Cenário 1: Célula Benigno (label) x Benigno (Modelo) - 61 casos - true negative 
# Cenário 2: Célula Benigno (label) x Maligno (Modelo) - 00 casos - false positive 
# Cenário 3: Célula Maligno (label) x Benigno (Modelo) - 02 casos - false negative (o modelo errou)
# Cenário 4: Célula Maligno (label) x Maligno (Modelo) - 37 casos - true positive 

# Lendo a Confusion Matrix (Perspectva de ter ou não a doença):

# True Negative  = nosso modelo previu que a pessoa NÃO tinha a doença e os dados mostraram que realmente a pessoa NÃO tinha a doença
# False Positive = nosso modelo previu que a pessoa tinha a doença e os dados mostraram que NÃO, a pessoa tinha a doença
# False Negative = nosso modelo previu que a pessoa NÃO tinha a doença e os dados mostraram que SIM, a pessoa tinha a doença
# True Positive = nosso modelo previu que a pessoa tinha a doença e os dados mostraram que SIM, a pessoa tinha a doença

# Falso Positivo - Erro Tipo I
# Falso Negativo - Erro Tipo II

# Taxa de acerto do Modelo: 98% (acertou 98 em 100)

# Consulte a definição de confusion matrix em caso de dúvidas!!!


## Etapa 5: Otimizando a performance do modelo

# Usando a função scale() para padronizar o z-score 
?scale()

# Confirmando transformação realizada com sucesso

# Criando novos datasets de treino e de teste

# Reclassificando

# Criando uma tabela cruzada dos dados previstos x dados atuais

## Testando diferentes valores para k
# Criando dados de treino e dados de teste

# Criando os labels para os dados de treino e de teste

# Valores diferentes para k

## Calculando a taxa de erro
prev = NULL
taxa_erro = NULL

suppressWarnings(
  for(i in 1:20){
    set.seed(101)
    prev = knn(train = dados_treino, test = dados_teste, cl = dados_treino_labels, k = i)
    taxa_erro[i] = mean(dados$diagnosis != prev)
  })

# Obtendo os valores de k e das taxas de erro
library(ggplot2)
k.values <- 1:20
df_erro <- data.frame(taxa_erro, k.values)
df_erro

# À medida que aumentamos k, diminuímos a taxa de erro do modelo
ggplot(df_erro, aes(x = k.values, y = taxa_erro)) + geom_point()+ geom_line(lty = "dotted", color = 'red')






