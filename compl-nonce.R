library(xtable)
options(xtable.floating=FALSE)
library(plyr)

# Reading Data file. --> Ignores lines with a #
df <- read.table('datasets/dataset11_compl.txt', header=TRUE, sep=";", fill=TRUE, flush=TRUE)

#print(df)

df <- droplevels(df[c("complex_log", "nonces")])
#df <- df[which(df$nonces<10000),]
df <- df[c(2,1)]

#print(df)
pdf("stats/hard_complexity.pdf")
plot(df, xlab="Nonces", ylab=expression(Keyspace~2^x) , main="Complexity")
garbage <- dev.off()

pdf("stats/hard_complexity_box.pdf")
boxplot(df$complex_log, horizontal = TRUE, xlab="Number of possible keys", main="Leftover keyspace", frame.plot=FALSE, axes=FALSE)
axis(side = 1, at = c(25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43), labels=c(as.expression(bquote(2^25)),as.expression(bquote(2^26)),as.expression(bquote(2^27)),as.expression(bquote(2^28)),as.expression(bquote(2^29)),as.expression(bquote(2^30)),as.expression(bquote(2^31)),as.expression(bquote(2^32)),as.expression(bquote(2^33)),as.expression(bquote(2^34)),as.expression(bquote(2^35)),as.expression(bquote(2^36)),as.expression(bquote(2^37)),as.expression(bquote(2^38)),as.expression(bquote(2^39)),as.expression(bquote(2^40)),as.expression(bquote(2^41)),as.expression(bquote(2^42)),as.expression(bquote(2^43))))
garbage <- dev.off()

print(nrow(df))

df <- read.table('datasets/nestedtime.csv', header=TRUE, sep=";", fill=TRUE, flush=TRUE)

pdf("stats/correlation_time_keys.pdf")
plot(df$mean ~ df$key, xlim=c(1, 11), ylim=c(0,300), xlab="Number of keys", ylab="Time in seconds", main="Time per key")
abline(lm(df$mean ~ df$keys), lwd=2)

axis(side = 1, at = c(1,3,5,7,9,11))
axis(side = 2, at = c(100,300,500,700,900))

grid(NULL, col="black")

garbage <- dev.off()

coef(lm(df$mean ~ df$keys))


q()

#>>> (31 - 0.72282090)/0.03282373
#922.4173821805139
#>>> 922.4 / 60
#15.373333333333333
