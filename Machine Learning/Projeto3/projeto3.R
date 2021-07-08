# Regressão Linear

# Configurando o diretório de trabalho
getwd()
setwd("/home/leonardo/Documents/RFundamentos/Machine Learning/Projeto3")

# Importando os dados
df <- read.csv('despesas.csv')

# Explorando os dados
head(df)
summary(df)
str(df)
any(is.na(df))

# Definindo factor para as variáveis de texto
# as quais são: sexo, fumantes e regiao

df$sexo <- factor(df$sexo, levels = c("mulher", "homem"), labels = c("mulher", "homem"))
str(df)

df$fumantes <- factor(df$fumantes, levels = c('sim', 'nao'), labels = c('sim', 'nao'))
str(df)

df$regiao <- factor(df$regiao, levels = c("sudeste", "sul", "norte", "nordeste"), 
                    labels = c("sudeste", "sul", "norte", "nordeste"))
str(df)

# Criando amostras de forma randomica
library(caTools)
amostra <- sample.split(df$gastos, SplitRatio = 0.70)

# Criando a base de treino com 70% dos casos
treino <- subset(df, amostra == TRUE)

# Criando a base de Teste com 30% dos casos
teste <- subset(df, amostra == FALSE)

# Gerando o modelo de regressao linear
# Modelo o qual tenta prever o gasto com um paciente dados as caracteristicas dele
modelo_v1 <- lm(gastos ~ .,treino)
modelo_v1
