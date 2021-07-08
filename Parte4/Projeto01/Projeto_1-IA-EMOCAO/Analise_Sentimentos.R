# Analise de sentimentos

# Pacote responsável pela conexão com o Twitter
install.packages('twitteR')

# Pacote responsável por ler o JSON de configuração
install.packages("rjson")

# Pacote responsável por limpar texto bruto
# Foi necessário executar o comando - sudo apt install libxml2-dev 
install.packages("tm")


# Carregando os pacotes
library(twitteR)
library(rjson)
library(tm)

