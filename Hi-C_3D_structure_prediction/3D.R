library(igraph)
library(rARPACK)

inFile = "3D.txt"
outFile = paste("output-", inFile, sep = "", collapse = NULL)
#
# low counts cut-off, adujust based on your data
#
value = 6000
#

repmat = function(X,m,n){
  X <- as.matrix(X)
  mx = dim(X)[1]
  nx = dim(X)[2]
  matrix(t(matrix(X,mx,nx*n)),mx*m,nx*n,byrow=T)
}

M <- read.table(inFile, sep="\t",header=FALSE)
# M[is.na(M)] <- 0
flag <- rowSums(M) > value
N <- M[flag,]
O <- N[,flag]
dim(O)
M <- O
M <- 1 / M
n <- dim(M)[1]
colnames(M) <- rownames(M) <- seq(1, n)
M <- as.matrix(M)
g <- graph.adjacency(M, mode="undirected", weighted=TRUE, diag=FALSE)
M <- shortest.paths(g, algorithm = "dijkstra")
Data <- M
n <- dim(Data)[1]
center <- matrix(0,n,1)
for (i in 1:n){
  for (j in 1:n){
    center[i] <- center[i] + Data[i, j]^2 - 1/n*(Data[j,j:n]%*%Data[j:n,j])
  }
}
center[center<0] <- 0
center <- sqrt(center/n)
distmat=1/2*(repmat(center*center,1,n)+repmat(t(center*center),n,1)-Data*Data);
disteigen <- eigs(distmat, 4)
x <- as.double(disteigen$vectors[,1]*sqrt(disteigen$values[1]))
y <- as.double(disteigen$vectors[,2]*sqrt(disteigen$values[2]))
z <- as.double(disteigen$vectors[,3]*sqrt(disteigen$values[3]))
XYZ <- cbind(x, y, z)
scale <- 100/max(apply(XYZ, 2, max))
XYZ <- XYZ*scale
write.table(XYZ, file=outFile, row.names=FALSE, col.names=FALSE)
