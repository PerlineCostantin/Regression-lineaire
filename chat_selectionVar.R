library(combinat)

# Variables explicatives initiales
X_full = cbind(X1, X2, X3, X4)
colnames(X_full) = c("X1", "X2", "X3", "X4")

n = length(Y)
r2a_values = c()
model_names = c()
models_list = list()

# On teste tous les sous-modèles possibles (1 à 4 variables)
for (k in 1:4) {
  combs = combn(1:4, k)
  for (j in 1:ncol(combs)) {
    idx = combs[,j]
    X_subset = X_full[,idx]
    model = lm(Y ~ X_subset)
    
    r2a = summary(model)$adj.r.squared
    r2a_values = c(r2a_values, r2a)
    
    name = paste(colnames(X_full)[idx], collapse = "+")
    model_names = c(model_names, name)
    models_list[[name]] = model
  }
}

# Afficher les R² ajustés pour chaque sous-modèle
results = data.frame(Modèle = model_names, R2_ajusté = r2a_values)
print(results[order(-results$R2_ajusté), ])

# Identifier le meilleur modèle
best_idx = which.max(r2a_values)
best_model_name = model_names[best_idx]
cat("\n✅ Meilleur modèle selon R² ajusté :", best_model_name, "\n")
best_model = models_list[[best_model_name]]
summary(best_model)
