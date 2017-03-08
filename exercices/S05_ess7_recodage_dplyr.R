# Script d'adaptation des données de l'ESS.
# Tous les recodages dans ce script sont en base-R

load("data/ESS7e02_1.stata/ess7.RData")
recodage_likert <- function(var, val_min, val_max, 
                            max = "10"){
  # var = variable à transformer
  # val_min = label de la valeur minimale de l'échelle
  # val_max = label de la valeur maximale de l'échelle
  # max = valeur numérique maximale
  # var est factor ; transformer en character
  var <- as.character(var)
  # recoder les valeurs extrêmes
  var[var == val_min] <- "0"
  var[var == val_max] <- max
  # transformer en numérique
  var <- as.numeric(var)
  return(var)
}
library(dplyr)

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


d <- mutate(d, 
            imueclt = recodage_likert(imueclt, 
                                    "Cultural life undermined", 
                                    "Cultural life enriched"),
            happy = recodage_likert(happy, 
                                      "Extremely unhappy", 
                                      "Extremely happy"),
            income_dec = dic_revenu[hinctnta],
            eduyrs = ifelse(eduyrs > 76, NA, eduyrs),
            fruit = dic_fruits[etfruit],
            vegetables = dic_fruits[eatveg],
            gndr = ifelse(gndr == "No answer", NA, gndr), 
            gndr = factor(gndr),
            cntry = factor(cntry)) %>% 
  filter(!is.na(gndr)) %>% 
  mutate_at(.cols = vars(starts_with("qfim"), starts_with("trst")),
            .funs = funs(recodage_likert(., 
                                         "Extremely unimportant",
                                         "Extremely important")))
