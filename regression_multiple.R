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
x_moy=mean(var_explicative)
y_moy=mean(var_reponse)

Y_i_chapeau=Xm%*%beta_n_chapeau


sigma_n_carre=(1/n-rang_Xm)*sum((Y-Y_i_chapeau)^2)

R_carre= sum((Y_i_chapeau-y_moy)^2)/sum((var_reponse-y_moy)^2) #(norm(Y-Xm %*% beta_n_chapeau, type="F")) 

R_a_carre=1-((n-1)/(n-rang_Xm))*(1-R_carre)


#### test de significativité du modèle ####

F = ((norm(as.matrix(Y_i_chapeau - y_moy)))^2 / (rang_Xm - 1)) / ((norm(as.matrix(Y - y_moy)))^2 / (n - rang_Xm))
p_valeur = 1-pf(F,df1=rang_Xm-1, df2=n-rang_Xm)