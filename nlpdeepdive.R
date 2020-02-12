
#devtools::install_github("RajeshB24/deepdive")
library("deepdive")
library("data.table")
library("stringr")

sen1 = "jhuk bhuk jing bingo"
sen2 = "jhuk bhuk jung bingo"
sen3 = "thak luk jing lungo"

#Guess !!
sen4 = "thak luk jung ?"


sentences= list(sen1,sen2,sen3)

unique_words<- as.factor(unique(unlist(str_split(sentences," "))))

unique_levels<- as.integer(unique_words)


names(unique_words)<-unique_levels
names(unique_levels)<-unique_words

SentenceDf<-data.frame(t(data.frame( str_split(sentences," "))))


n_words_to_wait=ncol(SentenceDf)-1
n_levels=max(unique_levels)

XSentenceDf=SentenceDf[,-ncol(SentenceDf)]
YSentencedf<-data.frame( as.character(SentenceDf[,ncol(SentenceDf)]))


head(XSentenceDf)
head(YSentencedf)
names(YSentencedf)<-"y"

#Build ANN with 1 input layer and multi class output layer
deepnetMod<- deepnet(XSentenceDf,YSentencedf,hiddenLayerUnits = c(1),
                     activation = c("sin"),
                     modelType = c("multiClass"),
                     iterations = 500,
                     eta = 10^-2,
                     stopError = 0.01)





predout<-  predict(deepnetMod,XSentenceDf)
predout


testCase <- data.frame(X1="thuk",
                      X2="luk",
                      X3="jung")

#Predict fails if we pass 1 row hence lets duplicate
testCase<-rbind(testCase,testCase)

predTest<-  predict(deepnetMod,testCase)

predTest
