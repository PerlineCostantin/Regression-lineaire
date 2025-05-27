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
#remarque : avec X[,2], on trouve une mauvaise régression lin (R² sera proche de à) 
#A FAIRE : Comparer les R²

n=length(var_reponse )

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
#avec X[,2], on a R² = 0.2301823 car cette variable doit être considérée comme une variable qualitative donc cela ne sert à rien de les afficher, il vaut mieux faire l'étude de la variance par exemple 
R_carre

#test du paramètre a : 
sigma_n_carre=sum(((Y-Y_i_chapeau)^2)/(n-2))
Ta=an_chapeau/sqrt(sigma_n_carre/sum((var_explicative-x_moy)^2))
err_standard=sqrt(sigma_n_carre/sum((var_explicative-x_moy)^2))
alpha=0.05
#seuil=qt(1-(alpha/2), df=n-2)
p_val= 1- pt(abs(Ta), df =n-2)
#on a p_val = 1.277153e-10< alpha donc on choisit H1

#règle de décision
if(p_val < alpha){
  print("décider H1 : a non nul ")
} else {
  print("on ne rejette pas H0 : on ne peut pas être sûr que a est non nul")
}


#tableau : 


#Prédiction (diapo 102)
x_new=
y_new_chapeau=an_chapeau*x_new+bn_chapeau

# validité des hypothèses sur le bruit (diapo 108)

#résidus standardisés : 
#Créer X
u1=rep(c(1), n) #1 ère colonne avec que des 1
u2=c(var_explicative) #2 ème colonne avec x1........xn
  
X=cbind(u1,u2) # concatener les 2 vect

H= X %*% solve(t(X) %*% X) %*% t(X) # H =X(X'X)⁻1X'
diagH=diag(H) 

epsilon_i_sd_chapeau = Y-Y_i_chapeau/sqrt(sigma_n_carre*(1-diagH)) #résidus standardisés

#vérif si les résidus standardisés suivent une loi normale standard
qqnorm(epsilon_i_sd_chapeau , main = "Normal QQ", xlab="", ylab="Standardized residuals")
#qqline(epsilon_i_sd_chapeau,xlab="", ylab="Standardized residuals")
#on a les résidus standardisés qui suivent approximativement une loi normale standard : cela valide l'hypothèse de Gaussianité

