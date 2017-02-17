library(xtable)
options(xtable.floating=FALSE)
library(plyr)

# Reading Data file. --> Ignores lines with a #
df <- read.table('datasets/dataset11.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
dfnonce <- read.table('datasets/dataset11_compl.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)

df$activate <- df$active_stop - df$activate_start
df$default <- df$default_stop - df$default_start
df$nested <- df$nested_stop - df$nested_start
df$hard <- df$hard_stop - df$hard_start
df$data <- df$data_stop - df$data_start

dftimes <- subset(df, select = c('file', 'hard'))

#dfnonce$nonces <- dfnonce$nonces1 + dfnonce$nonces2 

dfnonce <- subset(dfnonce, select = c('file', 'nonces'))

dftotal = subset(merge(dftimes, dfnonce, by='file'), select = c('hard', 'nonces'))


pdf("stats/noncesperseconden.pdf")
plot(dftotal, xlab="Time (Seconds)", ylab="Number of nonces" , main="Nonces per second")

coef(lm(dftotal$nonce ~ dftotal$hard))

grid(NULL, col="black")

garbage <- dev.off()

q()

