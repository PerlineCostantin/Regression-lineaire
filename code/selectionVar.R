##### Sélection de variables ####

### Méthode 1 : Avec R^2 et Ra^2 ###
# on va utiliser leaps pour sélectionner les meilleurs sous-ensembles de variables explicatives pour prédire la variable réponse

#package
library(leaps)

#mettre toutes les données dans un tableau 
donnees=data.frame(Y=Y, X1=X1, X2=X2, X3=X3, X4=X4)

#teste toutes les combinaisons possibles de X1, X2, X3, X4 (de 1 à 4 variables)
test = regsubsets(Y ~ ., data = donnees, nvmax = 4)

resume = summary(test) #résumés pour tous les modèles testés

#dans le tableau, on voit quelles variables retenir pour chauqe taille de modèle. Par exemple, pour un modèle à deux variables, les plus pertinentes seront X1 et X3

#récuperer le R^2 et Ra^2
names(resume) #pour savoir les éléments de resume

Ra_2= resume$adjr2
R_2= resume$rsq 

#tracer l'évolution de R^2 et Ra^2 en fonction du nombre de variables explicatives
plot(1:4, R_2, type = "l", col = "blue", xlab = "Nombre de variables", ylab = "Valeur",ylim = c(min(R_2, Ra_2), 1),main = "Évolution de R² et R² ajusté")

lines(1:4, Ra_2, type = "l", col = "red")

legend("topright", legend = c("R²", "R² ajusté"), col = c("blue", "red"), lty = 1)                  
