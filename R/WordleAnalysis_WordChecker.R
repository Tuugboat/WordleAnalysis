read.csv(here("Data/Long_On_Allowed_Score.csv")) %>% filter(Word %in% c("arose", "sores", "tares", "board", "cream")) %>% select(Word, Y, G, C) %>% kable("pipe")



