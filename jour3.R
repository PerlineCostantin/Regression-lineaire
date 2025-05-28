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
#remarque : avec X[,2], on trouve une mauvaise régression lin (R² sera proche de 0) 
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



# validité des hypothèses sur le bruit (diapo 108)

#résidus standardisés : 
#Créer X
u1=rep(c(1), n) #1 ère colonne avec que des 1
u2=c(var_explicative) #2 ème colonne avec x1........xn

X=cbind(u1,u2) # concatener les 2 vect

H= X %*% solve(t(X) %*% X) %*% t(X) # H =X(X'X)⁻1X'
diagH=diag(H) 

epsilon_i_sd_chapeau = (Y-Y_i_chapeau)/sqrt(sigma_n_carre*(1-diagH)) #résidus standardisés

#vérif si les résidus standardisés suivent une loi normale standard
qqnorm(epsilon_i_sd_chapeau , main = "Normal QQ", xlab="", ylab="Standardized residuals")
qqline(epsilon_i_sd_chapeau,xlab="", ylab="Standardized residuals")
#on a les résidus standardisés qui suivent approximativement une loi normale standard : cela valide l'hypothèse de Gaussianité


#résidus studentisés : 
residus_studentises=rstudent(LL)

#Test de Kolmogorov (diapo 114)
ks.test(residus_studentises,"pnorm",mean=0, sd=1)

#comparaison des distances
# Crée une fonction F pour la fonction de répartition
F = ecdf(residus_studentises) 

# Points à tracer
val = sort(residus_studentises) #seq(min(residus_studentises)-1, max(residus_studentises)+1,length.out = 200)
x_vals= seq(min(val),max(val),0.01) 
#proba cum (appelle F sur les résidus)
proba_cumulees = F(x_vals)

# Loi de Student théorique
student = pt(x_vals, df=n-3)

plot(x_vals,proba_cumulees,type="s",col="red")
lines(x_vals,student,type="l", col="blue")

#CONCLUSION : on a bien un résidu qui suit une loi de student donc le bruit vérifie l'hypothèse de la gaussienne
#pour la présentation, on peut montrer que une loi uniforme ne suit pas une loi student avec la distance entre les courbes
U=runif(1000,min(val),max(val))
sU=sort(U)
Ye=(1:1000)/1000
plot(sU,Ye,type="s",col="red",xlim=c(min(x_vals,min(val)),max(x_vals,max(val))),ylim=c(0,1))
lines(x_vals,student,type="l", col="blue")


#on peut donc tester le paramètre a (car bruit gaussien)
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
summary(LL)


#Prédiction ed y pour une nouvelle observation (diapo 102) 
x_new=seq(min(var_explicative),max(var_explicative),0.01)
#y_new_chapeau=an_chapeau*x_new+bn_chapeau
quantile=qt(1-alpha/2, df=n-2)
#intervalle de confiance pour y_new_chapeau
borne_inf= an_chapeau*x_new + bn_chapeau-sqrt(sigma_n_carre*(1+(1/n)+(x_new-x_moy)^2/sum((var_explicative-x_moy)^2)))*quantile
borne_sup= an_chapeau*x_new+ bn_chapeau+sqrt(sigma_n_carre*(1+(1/n)+(x_new-x_moy)^2/sum((var_explicative-x_moy)^2)))*quantile


plot(var_explicative,var_reponse,col='blue',ylim=c(min(borne_inf),max(borne_sup)))
lines(var_explicative,Y_i_chapeau,col='red', type='l')
lines(x_new,borne_inf,col='green')
lines(x_new,borne_sup,col='green')

#rajouter visualisation de un intervalle de confiance pour un point au hasard
x_new1=sample(x_new,1)
indice = which(x_new==x_new1)#pour récupérer indice de la valeur x_new1 dans le vecteur x_new
min_x_new1=borne_inf[indice]
max_x_new1=borne_sup[indice]
lines(c(x_new1,x_new1),c(min_x_new1,max_x_new1),col="black")
cat("Pour", x_new1, "l'intervalle de confiance de y est [",min_x_new1,";",max_x_new1,"]")
