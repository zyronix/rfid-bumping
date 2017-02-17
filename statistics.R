library(xtable)
options(xtable.floating=FALSE)
library(plyr)

# Reading Data file. --> Ignores lines with a #
df2 <- read.table('datasets/dataset2.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df5 <- read.table('datasets/dataset5.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df6 <- read.table('datasets/dataset6.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df7 <- read.table('datasets/dataset7.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df10 <- read.table('datasets/dataset10.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)

#df <- df[-(1),]
df2 <- droplevels(df2[complete.cases(df2$nested_stop),])
df5 <- droplevels(df5[complete.cases(df5$nested_stop),])
df6 <- droplevels(df6[complete.cases(df6$nested_stop),])
df7 <- droplevels(df7[complete.cases(df7$nested_stop),])
df10 <- droplevels(df10[complete.cases(df10$nested_stop),])

#total <- nrow(df)

#str(df)
#print(df)

#df$activate <- df$active_stop - df$activate_start
#df$default <- df$default_stop - df$default_start
df2$nested <- df2$nested_stop - df2$nested_start
df5$nested <- df5$nested_stop - df5$nested_start
df6$nested <- df6$nested_stop - df6$nested_start
df7$nested <- df7$nested_stop - df7$nested_start
df10$nested <- df10$nested_stop - df10$nested_start
#df$hard <- df$hard_stop - df$hard_start
#df$data <- df$data_stop - df$data_start

#dftimes <- subset(df, select = c('keys', 'activate', 'default', 'nested', 'hard', 'data'))

#print(dftimes)

pdf("stats/nested_time.pdf")
par(mfrow=c(3,2))
boxplot(df2$nested, horizontal = TRUE, xlab="Seconds", main="Nested Attack on one key")
boxplot(df5$nested, horizontal = TRUE, xlab="Seconds", main="Nested Attack on two keys")
boxplot(df6$nested, horizontal = TRUE, xlab="Seconds", main="Nested Attack on three keys")
boxplot(df7$nested, horizontal = TRUE, xlab="Seconds", main="Nested Attack on four keys")
boxplot(df10$nested, horizontal = TRUE, xlab="Seconds", main="Nested Attack on five keys")

garbage <- dev.off()

q()

cat('Number of valid entries:',total,'\n')

cat('\n Default Time Summary:\n')
summary(dftimes$default)


cat('\n Activation Time Summary:\n')
summary(dftimes$activate)

cat('\n Nested Time Summary:\n')
summary(dftimes$nested)
mean <- mean(dftimes$nested)
sd <- sd(dftimes$nested)

se <- (sd/sqrt(total))*1.64
cat('SE:',se,'\n')

cat('\n Hard Nested Time Summary:\n')
summary(dftimes$hard)

cat('\n Data Time Summary:\n')
summary(dftimes$data)


