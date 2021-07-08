# Conexão com o Twitter

# Pacote responsável pela conexão
install.packages('rtweet')

# Pacote responsável por ler o JSON de configuração
install.packages("rjson")

# Pacote responsável por limpar texto bruto
# Foi necessário executar o comando - sudo apt install libxml2-dev 
install.packages("tm")

# Carregando os pacotes
library(rtweet)
library(rjson)
library(tm)
library(RColorBrewer)
library(wordcloud)


# lendo o arquivo de configuração
twitterKeys <- fromJSON(file="/home/leonardo/Documents/DSA-R-IA-EMOCAO/twitter_keys.json", 
                        simplify = TRUE)

# Atribuindo as variaveis
consumerKey <- twitterKeys$consumerKey
consumerKeySecret <- twitterKeys$secretKey
accessKey <- twitterKeys$accessToken
accessKeySecret <- twitterKeys$accessTokenSecret

# Criando o token de acesso
token <- create_token(
  app = "DSA-R-IA-Emocao",
  consumer_key = consumerKey,
  consumer_secret = consumerKeySecret,
  access_token = accessKey,
  access_secret = accessKeySecret)


data <- rtweet::search_tweets('bbb', n=1e4, include_rts = FALSE)

head(data$text)

# Corpus
mydata <- Corpus(VectorSource(data$text))

# Convert to lower case
mydata <- tm_map(mydata, content_transformer(tolower))

# remove emojis e afins
mydata <- tm_map(mydata, content_transformer(gsub),
                 pattern="\\W",replace=" ")

# remove URLS
removeURL <- function(x) gsub("http[^[:space:]]*","", x)
mydata <- tm_map(mydata, content_transformer(removeURL))


# remove todos os acentos
remove_acentos <- function(x) iconv(x, to = "ASCII//TRANSLIT")
mydata <- tm_map(mydata, content_transformer(remove_acentos))


# remove stopwords
stopwords <- readLines("stopword_list.txt")
mydata <- tm_map(mydata, removeWords, stopwords)

# remove extra whitespace
mydata <- tm_map(mydata, stripWhitespace)

# remove number
mydata <- tm_map(mydata, removeNumbers)

# remove punctuation
mydata <- tm_map(mydata, removePunctuation)


# fazer o stemming de palavras
mydata <- tm_map(mydata, stemDocument)


# Gerando uma nuvem palavras
par(mar = rep(0,4))
dev.new(width = 1000, height = 1000, unit = "px")
pal2 <- brewer.pal(8,"Dark2")
wordcloud(mydata,
          min.freq = 4,
          scale = c(5,1),
          max.word = 100,
          random.order = F,
          colors = pal2)


mydataMatrix <- TermDocumentMatrix(mydata)
palavras <- findFreqTerms(mydataMatrix, lowfreq = 11)
palavras[1:5]








