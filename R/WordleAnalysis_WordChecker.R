read.csv(here("Data/Long_On_Allowed_Score.csv")) %>% filter(Word %in% c("arose", "aeros")) %>% select(Word, Y, G, C) %>% kable("simple")



