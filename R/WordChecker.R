read.csv(here("Data/Words5_On_SGB_Score.csv")) %>% filter(Word %in% c("board", "artsy")) %>% select(Word, Y, G, C) %>% kable("simple")

read.csv(here("Data/Words5_On_SGB_Score.csv")) %>% arrange(desc(Y)) %>% head(1) %>% select(Word, Y)


read.delim()