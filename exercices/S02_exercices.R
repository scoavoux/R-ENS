######## IMPORT #########

## Importer les fichiers import1 à import3
# import1.csv est en réalité un fichier au format
# fixed-width
ex1 <- read.fwf("./data/import1.csv", 
                widths = c(2, 3, 12, 6),
                dec = ";",
                stringsAsFactors = FALSE)
names(ex1) <- c("id", "age", "dipl", "var1")
str(ex1)

ex2 <- read.csv("./data/import2.txt",
                dec = ",",
                stringsAsFactors = FALSE)
str(ex2)

ex3 <- read.csv2("./data/import3.txt",
                 stringsAsFactors = FALSE)
str(ex3)

####### Indexation #######

## extraire les variables de pratiques
# uniquement pour les cadres

str(hdv2003)
# il s'agit des variables hard.rock à sport
names(hdv2003)

hdv2003[hdv2003$qualif == "Cadre" & !is.na(hdv2003$qualif), c("hard.rock", "lecture.bd", "peche.chasse", "cuisine", "bricol", "cinema", "sport")]

## extraire toutes les variables des 15 derniers enquêtés
hdv2003[seq(nrow(hdv2003) - 14, nrow(hdv2003)), ]

## extraire l'âge des personnes qui ne sont pas retraitées.
hdv2003$age[hdv2003$qualif != "Retraite"]

####### Recodage #######
## Renommez les modalités de la variable catégorie socioprofessionnelle (1 chiffre).
eec$csp <- factor(eec$CSER, 
                  levels = as.character(c(1:6, 8)),
                  labels=c("Agriculteurs exploitants",
                           "Artisans, commerçants et chefs d'entreprise",
                           "Cadres et professions intellectuelles supérieures",
                           "Professions intermédiaires",
                           "Employés",
                           "Ouvriers",
                           "Chômeurs n'ayant jamais travaillé"))
table(eec$csp)

## **À partir de la variable `NAFG088UN`**, créez une variable de secteur économique prenant pour modalités "primaire", "secondaire" et "tertiaire".
eec$secteur <- cut(as.numeric(eec$NAFG088UN), 
                   breaks=c(0.5, 9.5, 44, 100),
                   labels = c("Primaire", "Secondaire", "Tertiaire"))
eec$secteur

unique(eec$MRC)
# Une solution
eec$MRA_n[eec$MRA == "2" | is.na(eec$MRA)] <- 0
eec$MRA_n[eec$MRA == "1"] <- 1

# Une autre solution plus courte
eec$MRA_n <- ifelse(eec$MRA == "1" & !is.na(eec$MRA), 1, 0)
eec$MRB_n <- ifelse(eec$MRB == "1" & !is.na(eec$MRB), 1, 0)
eec$MRC_n <- ifelse(eec$MRC == "1" & !is.na(eec$MRC), 1, 0)
eec$nb_mode <- eec$MRA_n + eec$MRB_n + eec$MRC_n
str(eec$nb_mode)

eec$heures_travail_jour <- eec$HHCE / eec$JOURTR
str(eec$heures_travail_jour)
