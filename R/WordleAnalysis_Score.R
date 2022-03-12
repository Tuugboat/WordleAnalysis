##########################################################
#Author: Robert Petit
#Project: WordleAnalysis
#Desc: Generating "scoring" tables for words that could be used.
##########################################################
library(tictoc)

Gen_Scores <- function(WordIn, LetterIn, LLength) {
  WordSet = WordIn
  LetterInfo = LetterIn
  WordNum = LLength #The number of words, ignoring the one we are going to calculate
  #t is the weight of G in C. t must be in [0,1]
  t=0.75
  #Calculate Y
  
  Cons = ("bcdfghjklmnpqrstvwxyz") %>% strsplit("") %>% unlist
  
  WordSet %<>%
    rowwise(Word) %>% #We're going to go row by row and aggregate match values for each of the unique letters
    mutate(
      #First the Y values--------------------
      MatchNum = UniqueLetters %>% #From here on, we are piping the letters, not any dataframe values
      strsplit("") %>%
      unlist %>% #at this point we have a vector with each unqiue letter as an entry
      foreach(Letter=., .combine="+") %do% {
        #This loops *sums* the following
          LetterInfo %>%
          filter(L==Letter) %>% #Pulls the apprpriate row
          summarize(Match-1) %>% #gets the Match-1 value. -1 is to omit the same-word match that is baked into the data
          
          pull(1) #we need the raw number
          },
      Y=MatchNum/WordNum,
      
      #Then Y ignoring vowels-----------------
      MatchNum_Cons = UniqueLetters %>% #Second verse same as the first
        strsplit("") %>%
        unlist %>%
        .[(. %in% Cons)] %>% #This line grabs only the values of the list that are in the generated consonant list
          foreach(Letter=., .combine="+") %do% {
            #This loops *sums* the following
            LetterInfo %>%
              filter(L==Letter) %>% #Pulls the apprpriate row
              summarize(Match-1) %>% #gets the Match-1 value. -1 is to omit the same-word match that is baked into the data
  
              pull(1) #we need the raw number
            
          },
      Y_Cons=MatchNum_Cons/WordNum,

      
      
      #Then the G values--------------------
      Green_1_Total = filter(LetterInfo, LetterInfo$L==Letter_1) %>% #Get the value of each Letter_1's PlaceMatch_1
        summarize(PM_1-1) %>% #-1 here is to avoid the baked-in same word match
        pull(1),
      Green_2_Total = filter(LetterInfo, LetterInfo$L==Letter_2) %>% #same thing but for _2, etc.
        summarize(PM_2-1) %>%
        pull(1),
      Green_3_Total = filter(LetterInfo, LetterInfo$L==Letter_3) %>%
        summarize(PM_3-1) %>%
        pull(1),
      Green_4_Total = filter(LetterInfo, LetterInfo$L==Letter_4) %>%
        summarize(PM_4-1) %>%
        pull(1),
      Green_5_Total = filter(LetterInfo, LetterInfo$L==Letter_5) %>%
        summarize(PM_5-1) %>%
        pull(1),
      #After we calculate each individually, we sum them all together and divide by the total number.
      G = ((Green_1_Total+Green_2_Total+Green_3_Total+Green_4_Total+Green_5_Total)/WordNum),
      
      #Then G ignoring vowels-----------------
      Green_1_Total_Cons = ifelse(Letter_1 %in% Cons,
                                  filter(LetterInfo, LetterInfo$L==Letter_1) %>% #Get the value of each Letter_1's PlaceMatch_1
                                    summarize(PM_1-1) %>% #-1 here is to avoid the baked-in same word match
                                    pull(1),
        0),
      Green_2_Total_Cons = ifelse(Letter_2 %in% Cons,
                             filter(LetterInfo, LetterInfo$L==Letter_2) %>% #same thing but for _2, etc.
                               summarize(PM_2-1) %>%
                               pull(1),
        0),
      Green_3_Total_Cons = ifelse(Letter_3 %in% Cons,
                             filter(LetterInfo, LetterInfo$L==Letter_3) %>%
                                summarize(PM_3-1) %>%
                                pull(1),
        0),
      Green_4_Total_Cons = ifelse(Letter_4 %in% Cons,
                             filter(LetterInfo, LetterInfo$L==Letter_4) %>%
                                summarize(PM_4-1) %>%
                                pull(1),
        0),
      Green_5_Total_Cons = ifelse(Letter_5 %in% Cons,
                             filter(LetterInfo, LetterInfo$L==Letter_5) %>%
                                summarize(PM_5-1) %>%
                                pull(1),
        0),
      #After we calculate each individually, we sum them all together and divide by the total number.
      G_Cons = ((Green_1_Total_Cons+Green_2_Total_Cons+Green_3_Total_Cons+Green_4_Total_Cons+Green_5_Total_Cons)/WordNum),
      
      #Then we combine
      C=(t*G + (1-t)*Y),
      
      #And Cons Only
      C_Cons=(t*G_Cons + (1-t)*Y_Cons)
  )
return(WordSet)
}

tic("Read")
Full_WordSet = read.csv(here("Data/Combo_Long_WordSet.csv"))
Short_WordSet = read.csv(here("Data/Allowed_WordSet.csv"))

Full_LetterInfo = read.csv(here("Data/Combo_Long_LetterInfo.csv"))
Short_LetterInfo = read.csv(here("Data/Allowed_LetterInfo.csv"))
toc()

tic("Full")
Full_on_Full_Score = Gen_Scores(Full_WordSet, Full_LetterInfo, nrow(Full_WordSet)-1)
toc()

tic("Short")
Short_on_Short_Score = Gen_Scores(Short_WordSet, Short_LetterInfo, nrow(Short_WordSet)-1)
toc()

tic("Full on Short")
Full_on_Short_Score = Gen_Scores(Full_WordSet, Short_LetterInfo, nrow(Short_WordSet)-1)
toc()

tic("Write")

write.csv(Full_on_Full_Score, here("Data/Combo_Long_Score.csv"), row.names=FALSE)
write.csv(Short_on_Short_Score, here("Data/Allow_Score.csv"), row.names=FALSE)
write.csv(Full_on_Short_Score, here("Data/Long_On_Allow_Score.csv"), row.names=FALSE)

toc()
