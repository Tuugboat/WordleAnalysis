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

This is our Yellow-Maxing list, seperated by scope of the guesses and
scope of the possible words.

### Full List judged on Full List

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word</th>
<th style="text-align: right;">Y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.773</td>
</tr>
<tr class="even">
<td style="text-align: left;">orate</td>
<td style="text-align: right;">1.771</td>
</tr>
<tr class="odd">
<td style="text-align: left;">arise</td>
<td style="text-align: right;">1.769</td>
</tr>
<tr class="even">
<td style="text-align: left;">raise</td>
<td style="text-align: right;">1.769</td>
</tr>
<tr class="odd">
<td style="text-align: left;">serai</td>
<td style="text-align: right;">1.769</td>
</tr>
</tbody>
</table>

### Short List judge on Short List

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word</th>
<th style="text-align: right;">Y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.909</td>
</tr>
<tr class="even">
<td style="text-align: left;">raise</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="odd">
<td style="text-align: left;">arise</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="even">
<td style="text-align: left;">tears</td>
<td style="text-align: right;">1.871</td>
</tr>
<tr class="odd">
<td style="text-align: left;">rates</td>
<td style="text-align: right;">1.871</td>
</tr>
</tbody>
</table>

### Full List judged on Short List

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word</th>
<th style="text-align: right;">Y</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.909</td>
</tr>
<tr class="even">
<td style="text-align: left;">arise</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="odd">
<td style="text-align: left;">raise</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="even">
<td style="text-align: left;">serai</td>
<td style="text-align: right;">1.884</td>
</tr>
<tr class="odd">
<td style="text-align: left;">aster</td>
<td style="text-align: right;">1.871</td>
</tr>
</tbody>
</table>

## Position Seeking

Green-Maxing yields the following sets:

### Full List judged on Full List

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word</th>
<th style="text-align: right;">G</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">soree</td>
<td style="text-align: right;">0.651</td>
</tr>
<tr class="even">
<td style="text-align: left;">salay</td>
<td style="text-align: right;">0.607</td>
</tr>
<tr class="odd">
<td style="text-align: left;">boree</td>
<td style="text-align: right;">0.592</td>
</tr>
<tr class="even">
<td style="text-align: left;">sairy</td>
<td style="text-align: right;">0.586</td>
</tr>
<tr class="odd">
<td style="text-align: left;">saily</td>
<td style="text-align: right;">0.586</td>
</tr>
</tbody>
</table>

### Short List judge on Short List

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word</th>
<th style="text-align: right;">G</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">sores</td>
<td style="text-align: right;">0.886</td>
</tr>
<tr class="even">
<td style="text-align: left;">sales</td>
<td style="text-align: right;">0.874</td>
</tr>
<tr class="odd">
<td style="text-align: left;">soles</td>
<td style="text-align: right;">0.870</td>
</tr>
<tr class="even">
<td style="text-align: left;">sates</td>
<td style="text-align: right;">0.855</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sires</td>
<td style="text-align: right;">0.844</td>
</tr>
</tbody>
</table>

### Full List judged on Short List

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Word</th>
<th style="text-align: right;">G</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">soles</td>
<td style="text-align: right;">0.870</td>
</tr>
<tr class="even">
<td style="text-align: left;">cones</td>
<td style="text-align: right;">0.825</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sures</td>
<td style="text-align: right;">0.820</td>
</tr>
<tr class="even">
<td style="text-align: left;">tales</td>
<td style="text-align: right;">0.813</td>
</tr>
<tr class="odd">
<td style="text-align: left;">mores</td>
<td style="text-align: right;">0.812</td>
</tr>
</tbody>
</table>
