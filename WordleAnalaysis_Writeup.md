# Introduction

The first guess for a WordleWord is an interesting microcosm of
arbitrary, hyper-optimizable strategy decisions. One of the interesting
catches of Wordle as a whole is trying to work through the results that
you obtain throughout your guesses. The first word is unique: much like
a chess opening, the game hasn’t shaped up. Here, we will attempt to
provide a small selection of “best first words” for a number of
different strategies:

-   Letter Hunting
-   Position Hunting
-   Letter & Position Combo
-   Vowel Minimization

This provides you with the choice: do you want to get as many yellow
letters or green letters as possible. We can weight and combine these
scores to get a ranking that compromises between yellow and green
results as well. Since vowels are fairly trivial to include on later
guesses, we may be more interested in maximizing our correctly-guessed
consonants and ignoring the contribution of vowels to our score.

# On Judgement

In order to do this, we are going to use two different sets of words to
treat as our “potential guesses” for the game. We have a large list
(8497 words) of all 5 letter words in the English language. This is
*technically* the full breadth of possible words in Wordle, but it
includes words like “aalii” (a type of bush found in Hawaii) and “ganch”
(to execute via impaling) in the list. While these are possible, they
are not particularly likely to show up. To account for this, we also
have a list of commonly used words (5757. We will use both the full
short word lists to judge our results.

This will yield a set of results for each strategy: results when our
scope is *all* words and results when our scope is *likely* words. This
is four combinations of possible results:

-   All words judged on all words
-   All words judged on likely words
-   Likely words judged on likely words
-   Likely words judged on all words

We are only concerned with the first three. The last of these is
useless, after all, there is no world in which you only want to *guess*
a common word, but a possible result is *any* word.

## Letter Hunting

We make the simple observation that

$$P(1\\{x \\in W\\}) = E\[1\\{x \\in W\\}\] = \\frac{1}{n} \\sum\_{i=1}^n 1\\{x \\in w\_i\\}$$
Where *x* is a given letter, *W* is a random word and *w*<sub>*i*</sub>
is a specific word within our target sample. We then calculate
*P*(1{*x*∈*W*}) for each unique letter in a word a form the expected
yellow results, *Y* as

$$Y=\\sum\_{j=1}^uP(1\\{x\_j\\in W\\})$$

where the subscript *j* denotes a specific letter and *u* is the number
of unique letters in that word. This gives us the expected number of
yellow results any one word should have; naturally, we simply want this
value to be the highest possible.

## Position Hunting

This is largely similiar to letter hunting, but instead of being
concerned with *P*(1{*x*∈*W*}) we now need to calculate the letter being
in the correct spot, which is given by

$$P(1\\{x\_j=W\_j\\}) = E\[(1\\{x\_j=W\_j\\})\] = \\frac{1}{n} \\sum\_{i=1}^n 1\\{x\_j \\in w\_{ij}\\}$$
We then calculate the expected number of green results, *G*, as

$$G=\\sum\_{j=1}^5 P(1\\{x\_j=w\_{ij}\\})$$
## Combined Scoring & Vowel Omission

Once we have calculated a *Y* and *G* score for a word, we can combine
these two scores based on a given weight *t* to give us the combined
score *C*

*C* = *t**G* + (1−*t*)*Y*

Of note with the C score is to remember that we do discredit green
results when searching for yellow results. A yellow letter and a green
letter will both count for our purposes as a “yellow outcome”, but only
a green letter will count as a “green outcome”. When we look at our full
score, it’s important to remember that the trade-off is between having
results hit in general and having a specifically green result result
instead. Each of yellow letters has *P*(*G**r**e**e**n*) = 0.2, so there
is a *very* strong relationship between them. This becomes consequential
when we are choosing our weighting factor *t*, since at low values of
*t* we would expect remarkable ranking similarity between different
choices.

Finally, we can reconsider the *Y*, *G*, and *C* values but ignore the
vowels when calculating each score in order to get a separate
vowel-omitted score.

# Results

The fun stuff!

## Letter-Seeking

This is our Yellow-Maxing list, separated by scope of the guesses and
scope of the possible words. The first set is our full list, judged on
it’s ability to guess the words in the full list. The second set of
three is the words in the short list, predicting the short list. The
last set of three values is for the words in the full list, predicting
words in the short list.

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word (FoF)</th>
<th style="text-align: right;">Y</th>
<th style="text-align: left;">Word (SoS)</th>
<th style="text-align: right;">Y</th>
<th style="text-align: left;">Word (FoS)</th>
<th style="text-align: right;">Y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.773</td>
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.909</td>
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.909</td>
</tr>
<tr class="even">
<td style="text-align: left;">orate</td>
<td style="text-align: right;">1.771</td>
<td style="text-align: left;">raise</td>
<td style="text-align: right;">1.884</td>
<td style="text-align: left;">arise</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="odd">
<td style="text-align: left;">arise</td>
<td style="text-align: right;">1.769</td>
<td style="text-align: left;">arise</td>
<td style="text-align: right;">1.884</td>
<td style="text-align: left;">raise</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="even">
<td style="text-align: left;">raise</td>
<td style="text-align: right;">1.769</td>
<td style="text-align: left;">tears</td>
<td style="text-align: right;">1.871</td>
<td style="text-align: left;">serai</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="odd">
<td style="text-align: left;">serai</td>
<td style="text-align: right;">1.769</td>
<td style="text-align: left;">rates</td>
<td style="text-align: right;">1.871</td>
<td style="text-align: left;">aster</td>
<td style="text-align: right;">1.871</td>
</tr>
</tbody>
</table>

### Consonants

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word (FoF)</th>
<th style="text-align: right;">Y</th>
<th style="text-align: left;">Word (SoS)</th>
<th style="text-align: right;">Y</th>
<th style="text-align: left;">Word (FoS)</th>
<th style="text-align: right;">Y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">slart</td>
<td style="text-align: right;">1.112</td>
<td style="text-align: left;">turns</td>
<td style="text-align: right;">1.242</td>
<td style="text-align: left;">slart</td>
<td style="text-align: right;">1.280</td>
</tr>
<tr class="even">
<td style="text-align: left;">slirt</td>
<td style="text-align: right;">1.112</td>
<td style="text-align: left;">stern</td>
<td style="text-align: right;">1.242</td>
<td style="text-align: left;">slirt</td>
<td style="text-align: right;">1.280</td>
</tr>
<tr class="odd">
<td style="text-align: left;">snirt</td>
<td style="text-align: right;">1.097</td>
<td style="text-align: left;">rents</td>
<td style="text-align: right;">1.242</td>
<td style="text-align: left;">snirt</td>
<td style="text-align: right;">1.242</td>
</tr>
<tr class="even">
<td style="text-align: left;">snort</td>
<td style="text-align: right;">1.097</td>
<td style="text-align: left;">snort</td>
<td style="text-align: right;">1.242</td>
<td style="text-align: left;">snort</td>
<td style="text-align: right;">1.242</td>
</tr>
<tr class="odd">
<td style="text-align: left;">snurt</td>
<td style="text-align: right;">1.097</td>
<td style="text-align: left;">runts</td>
<td style="text-align: right;">1.242</td>
<td style="text-align: left;">snurt</td>
<td style="text-align: right;">1.242</td>
</tr>
</tbody>
</table>

## Position-Seeking

This table follows the same logic, 3 triplets based on their scoring
method.

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word (FoF)</th>
<th style="text-align: right;">G</th>
<th style="text-align: left;">Word (SoS)</th>
<th style="text-align: right;">G</th>
<th style="text-align: left;">Word (FoS)</th>
<th style="text-align: right;">G</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">soree</td>
<td style="text-align: right;">0.651</td>
<td style="text-align: left;">sores</td>
<td style="text-align: right;">0.886</td>
<td style="text-align: left;">soles</td>
<td style="text-align: right;">0.870</td>
</tr>
<tr class="even">
<td style="text-align: left;">salay</td>
<td style="text-align: right;">0.607</td>
<td style="text-align: left;">sales</td>
<td style="text-align: right;">0.874</td>
<td style="text-align: left;">cones</td>
<td style="text-align: right;">0.825</td>
</tr>
<tr class="odd">
<td style="text-align: left;">boree</td>
<td style="text-align: right;">0.592</td>
<td style="text-align: left;">soles</td>
<td style="text-align: right;">0.870</td>
<td style="text-align: left;">sures</td>
<td style="text-align: right;">0.820</td>
</tr>
<tr class="even">
<td style="text-align: left;">sairy</td>
<td style="text-align: right;">0.586</td>
<td style="text-align: left;">sates</td>
<td style="text-align: right;">0.855</td>
<td style="text-align: left;">tales</td>
<td style="text-align: right;">0.813</td>
</tr>
<tr class="odd">
<td style="text-align: left;">saily</td>
<td style="text-align: right;">0.586</td>
<td style="text-align: left;">sires</td>
<td style="text-align: right;">0.844</td>
<td style="text-align: left;">mores</td>
<td style="text-align: right;">0.812</td>
</tr>
</tbody>
</table>

### Consonants

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word (FoF)</th>
<th style="text-align: right;">G</th>
<th style="text-align: left;">Word (SoS)</th>
<th style="text-align: right;">G</th>
<th style="text-align: left;">Word (FoS)</th>
<th style="text-align: right;">G</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">serry</td>
<td style="text-align: right;">0.433</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: right;">0.592</td>
<td style="text-align: left;">carls</td>
<td style="text-align: right;">0.528</td>
</tr>
<tr class="even">
<td style="text-align: left;">sorry</td>
<td style="text-align: right;">0.433</td>
<td style="text-align: left;">salts</td>
<td style="text-align: right;">0.577</td>
<td style="text-align: left;">slops</td>
<td style="text-align: right;">0.528</td>
</tr>
<tr class="odd">
<td style="text-align: left;">surly</td>
<td style="text-align: right;">0.433</td>
<td style="text-align: left;">silts</td>
<td style="text-align: right;">0.577</td>
<td style="text-align: left;">pants</td>
<td style="text-align: right;">0.522</td>
</tr>
<tr class="even">
<td style="text-align: left;">sorty</td>
<td style="text-align: right;">0.429</td>
<td style="text-align: left;">slits</td>
<td style="text-align: right;">0.572</td>
<td style="text-align: left;">turns</td>
<td style="text-align: right;">0.521</td>
</tr>
<tr class="odd">
<td style="text-align: left;">slyly</td>
<td style="text-align: right;">0.411</td>
<td style="text-align: left;">slots</td>
<td style="text-align: right;">0.572</td>
<td style="text-align: left;">darts</td>
<td style="text-align: right;">0.520</td>
</tr>
</tbody>
</table>

## Combined Weighting

Here is the combined values for *t* = 0.75.

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word (FoF)</th>
<th style="text-align: right;">C</th>
<th style="text-align: left;">Word (SoS)</th>
<th style="text-align: right;">C</th>
<th style="text-align: left;">Word (FoS)</th>
<th style="text-align: right;">C</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">0.774</td>
<td style="text-align: left;">arose</td>
<td style="text-align: right;">0.749</td>
<td style="text-align: left;">arose</td>
<td style="text-align: right;">0.749</td>
</tr>
<tr class="even">
<td style="text-align: left;">orate</td>
<td style="text-align: right;">0.748</td>
<td style="text-align: left;">raise</td>
<td style="text-align: right;">0.805</td>
<td style="text-align: left;">arise</td>
<td style="text-align: right;">0.747</td>
</tr>
<tr class="odd">
<td style="text-align: left;">arise</td>
<td style="text-align: right;">0.773</td>
<td style="text-align: left;">arise</td>
<td style="text-align: right;">0.747</td>
<td style="text-align: left;">raise</td>
<td style="text-align: right;">0.805</td>
</tr>
<tr class="even">
<td style="text-align: left;">raise</td>
<td style="text-align: right;">0.815</td>
<td style="text-align: left;">tears</td>
<td style="text-align: right;">0.951</td>
<td style="text-align: left;">serai</td>
<td style="text-align: right;">0.763</td>
</tr>
<tr class="odd">
<td style="text-align: left;">serai</td>
<td style="text-align: right;">0.799</td>
<td style="text-align: left;">rates</td>
<td style="text-align: right;">1.050</td>
<td style="text-align: left;">aster</td>
<td style="text-align: right;">0.760</td>
</tr>
</tbody>
</table>

### Consonants

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word (FoF)</th>
<th style="text-align: right;">C</th>
<th style="text-align: left;">Word (SoS)</th>
<th style="text-align: right;">C</th>
<th style="text-align: left;">Word (FoS)</th>
<th style="text-align: right;">C</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">surly</td>
<td style="text-align: right;">0.584</td>
<td style="text-align: left;">carts</td>
<td style="text-align: right;">0.704</td>
<td style="text-align: left;">turns</td>
<td style="text-align: right;">0.701</td>
</tr>
<tr class="even">
<td style="text-align: left;">sorty</td>
<td style="text-align: right;">0.582</td>
<td style="text-align: left;">crits</td>
<td style="text-align: right;">0.702</td>
<td style="text-align: left;">darts</td>
<td style="text-align: right;">0.695</td>
</tr>
<tr class="odd">
<td style="text-align: left;">stray</td>
<td style="text-align: right;">0.560</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: right;">0.701</td>
<td style="text-align: left;">dorts</td>
<td style="text-align: right;">0.695</td>
</tr>
<tr class="even">
<td style="text-align: left;">strey</td>
<td style="text-align: right;">0.560</td>
<td style="text-align: left;">turns</td>
<td style="text-align: right;">0.701</td>
<td style="text-align: left;">carls</td>
<td style="text-align: right;">0.692</td>
</tr>
<tr class="odd">
<td style="text-align: left;">stroy</td>
<td style="text-align: right;">0.560</td>
<td style="text-align: left;">terns</td>
<td style="text-align: right;">0.701</td>
<td style="text-align: left;">grits</td>
<td style="text-align: right;">0.669</td>
</tr>
</tbody>
</table>

# Conclusion

So, depending on your and desired strategy, one of the words from the
following table is certainly the best option. Based purely on
estimation, it is likely that the consonant-filtered long-on-short
combined score is the most efficient word to pick, but doing this hinges
on a balanced strategy and considering words that are not commonly used
which minimizes your chances of having a *correct* first guess. By
picking the combined-score short-on-short word, you alternatively
maximize your chance of having a correct first guess.

<table>
<thead>
<tr class="header">
<th></th>
<th style="text-align: left;">Y</th>
<th style="text-align: left;">G</th>
<th style="text-align: left;">C</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Full on Full</td>
<td style="text-align: left;">arose</td>
<td style="text-align: left;">soree</td>
<td style="text-align: left;">tarie</td>
</tr>
<tr class="even">
<td>… Consonants</td>
<td style="text-align: left;">slart</td>
<td style="text-align: left;">serry</td>
<td style="text-align: left;">surly</td>
</tr>
<tr class="odd">
<td>Short on Short</td>
<td style="text-align: left;">arose</td>
<td style="text-align: left;">sores</td>
<td style="text-align: left;">tares</td>
</tr>
<tr class="even">
<td>… Consonants</td>
<td style="text-align: left;">turns</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: left;">carts</td>
</tr>
<tr class="odd">
<td>Full on Short</td>
<td style="text-align: left;">arose</td>
<td style="text-align: left;">soles</td>
<td style="text-align: left;">tales</td>
</tr>
<tr class="even">
<td>… Consonants</td>
<td style="text-align: left;">slart</td>
<td style="text-align: left;">carls</td>
<td style="text-align: left;">turns</td>
</tr>
</tbody>
</table>
