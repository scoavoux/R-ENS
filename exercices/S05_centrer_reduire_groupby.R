load("data/ESS7e02_1.stata/ess7.RData")
source("data/ess7_recodage.R")

d <- group_by(d, cntry) %>% 
  mutate(qfimedu_cr = (qfimedu - mean(qfimedu, na.rm = TRUE))/sd(qfimedu, na.rm = TRUE))
