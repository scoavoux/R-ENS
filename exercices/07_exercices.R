load("data/ESS7e02_1.stata/ess7.RData")

recodage_trst <- function(var){
  # var est factor ; transformer en character
  var <- as.character(var)
  # recoder les valeurs extrêmes
  var[var == "No trust at all"] <- "0"
  var[var == "Complete trust"] <- "10"
  # transformer en numérique
  var <- as.numeric(var)
  return(var)
}

nom_trust <- c("trstprl", "trstlgl", "trstplc", "trstplt", "trstprt")
d[, nom_trust] <- lapply(X = d[, nom_trust], FUN = recodage_trst)

rm(nom_trust, recodage_trst)

## Exercice : adapter recodage_trst pour fonctionner
## sur **toutes** les likert scales de la basse
## de données ess7

## Question 2.

an_stat <- function(vec1, vec2, col.rm = TRUE){
  # Faire le tableau de contingence
  tab <- table(vec1, vec2)
  # calculer les effectifs en colonne
  if(col.rm){
    colpour <- prop.table(tab, margin = 2)
  } else {
    colpour <- NA
  }
  khi_t <- chisq.test(tab)
  
  # tester effectifs de tab
  if(any(khi_t$expected < 5)){
    khi_t <- fisher.test(tab)
    nom_test <- "Test de Fisher"
  } else {
    nom_test <- "Test de Khi-2"
  }
  resultat <- list(tableau1 = tab,
                   tableau2 = colpour,
                   p_value = khi_t$p.value,
                   nom_test = nom_test)
  
  return(resultat)
}


