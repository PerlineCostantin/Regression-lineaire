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
#les 4 et 6 sont des var qualitatives donc on ne les considère pas
X1= X[,2]
X2= X[,3]
X3= X[,5]
X4= X[,7]

n=length(var_reponse)

#### Estimateur Beta ####
#Créer X
u1=rep(c(1), n) #1 ère colonne avec que des 1
u2=c(X1) #2 ème colonne avec x1(1)........xn(1)
u3=c(X2)
u4=c(X3)
u5=c(X4)

Xm=cbind(u1,u2,u3,u4,u5) # concatener les vect
rang_Xm=qr(Xm)$rank

det=det(t(Xm)%*%Xm)
if(det!=0){ #vérifier si la matrice t(Xm)*Xm est inversible (on peut aussi faire avec le rang)
  beta_n_chapeau= solve(t(Xm) %*% Xm) %*% t(Xm)%*%Y # (X'X)⁻1X'Y
}else{
  print("t(Xm)*Xm non inversible")
}

#pour vérifier 
Xm2=cbind(u2,u3,u4,u5)
L = lm(var_reponse~Xm2)

#comparer les R² et enlever les plus petits pour voir l'influence 

#moyennes : x barre et y barre 
#x_moy=mean(var_explicative)
y_moy=mean(var_reponse)

Y_i_chapeau=Xm%*%beta_n_chapeau


sigma_n_carre=(1/(n-rang_Xm))*sum((Y-Y_i_chapeau)^2)

R_carre= sum((Y_i_chapeau-y_moy)^2)/sum((var_reponse-y_moy)^2) #(norm(Y-Xm %*% beta_n_chapeau, type="F")) 

R_a_carre=1-((n-1)/(n-rang_Xm))*(1-R_carre)

#### hypothèse gaussienne ####

H= Xm %*% solve(t(Xm) %*% Xm) %*% t(Xm) # H =X(X'X)⁻1X'
diagH=diag(H) 

epsilon_i_sd_chapeau = (Y-Y_i_chapeau)/sqrt(sigma_n_carre*(1-diagH)) #résidus standardisés

#vérif si les résidus standardisés suivent une loi normale standard
qqnorm(epsilon_i_sd_chapeau , main = "Normal QQ", xlab="", ylab="Standardized residuals")
#qqline(epsilon_i_sd_chapeau,xlab="", ylab="Standardized residuals")
#on a les résidus standardisés qui suivent approximativement une loi normale standard : cela valide l'hypothèse de Gaussianité



#résidus studentisés : 
residus_studentises=rstudent(L)

#Test de Kolmogorov (diapo 114)
ks.test(residus_studentises,"pnorm",mean=0, sd=1)
#la p_valeur est supérieur  à alpha donc on prefère H0 qui est : nos observations peuvent être modélisées par une loi de student
#comparaison des distances
# Crée une fonction F pour la fonction de répartition
F = ecdf(residus_studentises) 

# Points à tracer
val = sort(residus_studentises) #seq(min(residus_studentises)-1, max(residus_studentises)+1,length.out = 200)
x_vals= seq(min(val),max(val),0.01) 
#proba cum (appelle F sur les résidus)
proba_cumulees = F(x_vals)

# Loi de Student théorique
student = pt(x_vals, df=n-rang_Xm-1)

plot(x_vals,proba_cumulees,type="s",col="red")
lines(x_vals,student,type="l", col="blue")




#### test de significativité du modèle ####
alpha = 0.05

f = ((norm(as.matrix(Y_i_chapeau - y_moy),type="2")^2) / (rang_Xm - 1)) / ((norm(as.matrix(Y - Y_i_chapeau), type="2"))^2 / (n - rang_Xm))
p_valeur = 1-pf(f,df1=rang_Xm-1, df2=n-rang_Xm)

#règle de décision
if(p_valeur < alpha){
  print("décider H1 : les betas ne sont pas tous nuls ")
} else {
  print("on ne rejette pas H0 : il y a au moins un beta nul")
}

summary(lm(Y~Xm2))


#### Prédiction ####

#intervalle de confiance pour la première ligne : mettre des X1[1] dans le x_new
x_new = c(X1, X2, X3, X4)
#x_new=seq(min(Xm),max(Xm),0.01)

x_new1 = c(rep(c(1),n), x_new)
x_new1 = matrix(x_new1,nrow=n)

#y_chapeau_new=x_new1%*%beta_n_chapeau 

#y_pred = as.numeric(x_new_vect %*% beta_n_chapeau)


quantile=qt(1-alpha/2, df=n-rang_Xm)

borne_inf= x_new1%*%beta_n_chapeau -sqrt(sigma_n_carre*diag((x_new1)%*%solve(t(Xm) %*% Xm)%*%(t(x_new1))))*quantile
borne_sup= x_new1%*%beta_n_chapeau +sqrt(sigma_n_carre*diag((x_new1)%*%solve(t(Xm) %*% Xm)%*%(t(x_new1))))*quantile

