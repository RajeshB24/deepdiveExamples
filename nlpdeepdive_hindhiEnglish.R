
#devtools::install_github("RajeshB24/deepdive")
library("deepdive")
library("data.table")
library("stringr")

sen1 = "agar tum saath ho hindi"
sen2 = "mein tera hogaya hun hindi"
sen3 = "kasiey ye batavun thumhe hindi"
sen4 = "aalu peela ho gaya hindi"
sen5= "how are you buddy English"
sen6="May i know come English"
sen7="when the sun shines English"
sen8="just in the time English"





sentences= list(sen1,sen2,sen3,sen4,sen5,sen6,sen7,sen8)

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


testCase <- data.frame(X1="waise",
                      X2="ye",
                      X3="kya",
                      X4="hai")

#Predict fails if we pass 1 row hence lets duplicate
testCase<-rbind(testCase,testCase)

predTest<-  predict(deepnetMod,testCase)

predTest
