A=mtcars 
F1=as.factor(A[,8])
A[,8]=F1
set.seed(9)
set.seed(9*floor(100*runif(1,0,3)))
set1=sample(1:32,1)
B=A[-set1,]
Y=B[,1]
u=1:11
v=u[-c(1,8,9)]
set2=c(8,sample(v,6,replace=FALSE))
X=B[,set2]


var_reponse = Y
var_explicative= X[,5]

#A$cyl = as.factor(A$cyl)
cyl = as.factor(X[,4])

res_aov2 = aov(var_explicative ~ cyl, data = X)
summary(res_aov2)

boxplot(var_explicative ~ cyl, data = X,
        main = "poids de la voiture selon le nombre de cylindres",
        xlab = "Nombre de cylindres",
        ylab = "Poids",
        col = c("orange", "lightblue", "lightgreen"))

# Ton code de base
boxplot(var_explicative ~ cyl, data = X,
        main = "Poids de la voiture selon le nombre de cylindres",
        xlab = "Nombre de cylindres",
        ylab = "Poids (en milliers de livres)",
        col = c("orange", "lightblue", "lightgreen"))

# Calcul des moyennes par groupe
moyennes = tapply(var_explicative, cyl, mean)

# Ajout des points rouges pour la moyenne
points(x = 1:length(moyennes), y = moyennes, col = "red", pch = 19)

# Optionnel : ajouter une légende
legend("topright", legend = "Moyenne", col = "red", pch = 19, bty = "n")

