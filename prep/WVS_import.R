# Import World Values Survey Wave 7 data

# Haerpfer, C., Inglehart, R., Moreno, A., Welzel, C., Kizilova, K., 
# Diez-Medrano J., M. Lagos, P. Norris, E. Ponarin & B. Puranen et al. (eds.). 2020. 
# World Values Survey: Round Seven - Country-Pooled Datafile. Madrid, Spain & Vienna, 
# Austria: JD Systems Institute & WVSA Secretariat. doi.org/10.14281/18241.13

# Downloaded from https://www.worldvaluessurvey.org/WVSDocumentationWV7.jsp

pacman::p_load('tidyverse',
               'utils')


unzip(here::here("prep","F00011421-WVS_Cross-National_Wave_7_rds_v2_0.zip"),"WVS_Cross-National_Wave_7_R_v2_0.rds",exdir = here::here("prep"))

wvs_pvalue <- readRDS(here::here("prep","WVS_Cross-National_Wave_7_R_v2_0.rds")) %>%
  mutate(iso3c = B_COUNTRY_ALPHA,
         townsize = G_TOWNSIZE2,
         happiness = Q46,
         life_sat = Q49,
         fin_sat = Q50,
         imm_soc_conflict = Q129,
         god_importance = Q164,
         vote = Q222,
         female = ifelse(Q260 == 2, 1, ifelse(Q260 == 1, 0, NA)),
         age = Q262,
         immigrant = ifelse(Q263 == 2, 1, 0), # shortcut version of coding here (should include NA)
         educ_isced11 = Q275,
         educ_3 = Q275R,
         income = Q288R,
         income8 = Q288) %>%
  select(iso3c:income8)

write_rds(wvs_pvalue, file = here::here("data","wvs_pvalue.rds"))
