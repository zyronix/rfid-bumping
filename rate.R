library(xtable)
options(xtable.floating=FALSE)
library(plyr)

# Reading Data file. --> Ignores lines with a #
df2 <- read.table('datasets/dataset2_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df5 <- read.table('datasets/dataset5_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df6 <- read.table('datasets/dataset6_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df7 <- read.table('datasets/dataset7_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df8 <- read.table('datasets/dataset8_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df9 <- read.table('datasets/dataset9_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)
df10 <- read.table('datasets/dataset10_rate.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)

#df <- df[-(1),]
#df <- droplevels(df[complete.cases(df$nested_stop),])

#total <- nrow(df)

#str(df)
#print(df)

#df$activate <- df$active_stop - df$activate_start
#df$default <- df$default_stop - df$default_start
#df$nested <- df$nested_stop - df$nested_start
#df$hard <- df$hard_stop - df$hard_start
#df$data <- df$data_stop - df$data_start

#dftimes <- subset(df, select = c('keys', 'activate', 'default', 'nested', 'hard', 'data'))

df = rbind(df2, df5, df6,df7,df8,df9,df10)

#print(df)
print(sum(df$got_keys) / sum(df$changed_keys))
print(sum(df$changed_keys))
print(sum(df$got_keys))


q()

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


