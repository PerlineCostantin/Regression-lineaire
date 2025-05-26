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
#remarque : avec X[,4], on trouve une mauvaise régression lin (R² sera proche de à) 
#A FAIRE : Comparer les R²

#moyennes : x barre et y barre 
x_moy=mean(var_explicative)
y_moy=mean(var_reponse)

an_chapeau= sum((var_explicative-x_moy)*(var_reponse-y_moy))/sum((var_explicative-x_moy)^2)
bn_chapeau= y_moy-an_chapeau*x_moy
#pour vérif : on a an_chapeau = -5.355465 et bn_chapeau = 37.35029
#si on fait lm(var_reponse~var_explicative) on a les memes val

Y_i_chapeau=an_chapeau*var_explicative+bn_chapeau

plot(var_explicative,var_reponse,col='blue')
lines(var_explicative,Y_i_chapeau,col='red', type='l')

#pour vérifier 
LL=lm(var_reponse~var_explicative)
abline(LL,col='green',lty=2)

#Evaluer la validité de la régression linéaire avec R²

epsilon_i_chapeau=Y-Y_i_chapeau

R_carre=sum((Y_i_chapeau-y_moy)^2)/sum((var_reponse-y_moy)^2)
#avec X[,5], on a R² = 0.7534246
#avec X[,3], on a R² = 0.1786671
R_carre
