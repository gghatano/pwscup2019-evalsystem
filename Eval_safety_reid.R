
library(dplyr)
library(stringr)

dat_ptable = readr::read_csv("ptable_all.csv") %>% 
 mutate(team = str_extract(team, "[0-9]+")) %>% 
 filter(data == "IDP")
dat_etable = readr::read_csv("etable_all_result.csv") %>% 
 mutate(user_id = user_id + 2000) %>% 
 rename(user_id_anon = user_id)

dat_ptable %>% head
dat_etable %>% head


dat_etable %>% 
 inner_join(dat_ptable, by = c("target" = "team", "user_id_anon" = "user_id_anon")) %>% 
 select(-data) %>% 
 mutate(HIT_FLG = (user_id_estimated == user_id_raw)) %>%
 pull(HIT_FLG) 
