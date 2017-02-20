# Script d'adaptation des données de l'ESS.
# Tous les recodages dans ce script sont en base-R


# Immigré et vie culturelle
d$imueclt <- as.character(d$imueclt)
d$imueclt[d$imueclt == "Cultural life undermined"] <- "0"
d$imueclt[d$imueclt == "Cultural life enriched"] <- "10"
d$imueclt <- as.numeric(d$imueclt)

# Bonheur
d$happy <- as.character(d$happy)
d$happy[d$happy == "Extremely unhappy"] <- "0"
d$happy[d$happy == "Extremely happy"] <- "10"
d$happy <- as.numeric(d$happy)

# Revenu
dic_revenu <- c(`J - 1st decile` = 1,
                `R - 2nd decile` = 2,
                `C - 3rd decile` = 3,
                `M - 4th decile` = 4,
                `F - 5th decile` = 5,
                `S - 6th decile` = 6,
                `K - 7th decile` = 7,
                `P - 8th decile` = 8,
                `D - 9th decile` = 9,
                `H - 10th decile` = 10,
                `Refusal` = NA,
                `Don't know` = NA,
                `No answer` = NA)
d$income_dec <- dic_revenu[d$hinctnta]

# Années d'éducation
d$eduyrs[d$eduyrs > 76] <- NA

# Fruits et légumes
dic_fruits <- c(`Three times or more a day` = 5, 
                `Twice a day` = 4, 
                `Once a day` = 3, 
                `Less than once a day but at least 4 times a week` = 2, 
                `Less than 4 times a week but at least once a week` = 1, 
                `Less than once a week` = 0, 
                `Never` = NA, 
                `Refusal` = NA, 
                `Don't know` = NA, 
                `No answer` = NA)
d$fruit <- dic_fruits[d$etfruit]
d$vegetables <- dic_fruits[d$eatveg]

d$gndr[d$gndr == "No answer"] <- NA
d$gndr <- factor(d$gndr)

d$cntry <- factor(d$cntry)

# QFI
d[, c("qfimedu", "qfimlng", "qfimchr", "qfimwht", "qfimwsk", "qfimcmt")] <-
  lapply(d[, c("qfimedu", "qfimlng", "qfimchr", "qfimwht", "qfimwsk", "qfimcmt")], 
         function(var){
           v <- as.character(var)
           v[v == "Extremely unimportant"] <- 0
           v[v == "Extremely important"] <- 10
           as.numeric(v)
           }
         )

# Trust
d[, c("trstprl", "trstlgl", "trstplc", "trstplt", "trstprt", "trstep", 
      "trstun")] <-
  lapply(d[, c("trstprl", "trstlgl", "trstplc", "trstplt", "trstprt", "trstep", 
               "trstun")], 
         function(var){
           v <- as.character(var)
           v[v == "Extremely unimportant"] <- 0
           v[v == "Extremely important"] <- 10
           cut(as.numeric(v), breaks = c(-1, 4, 6, 11), labels = c("Weak", "Average", "High"))
         }
  )

