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

