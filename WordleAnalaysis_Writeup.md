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
(15577 words) of almost all 5 letter words in the English language. This
is *technically* the full breadth of possible words in Wordle, but it
includes words like “aalii” (a type of bush found in Hawaii) and “ganch”
(to execute via impaling) in the list. While these are possible to
enter, they are not particularly likely to show up. To account for this,
we also have a list of Wordle-allowed words (10640. We will use both the
full short word lists to judge our results.

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
*P*(1{*x* ∈ *W*}) for each unique letter in a word a form the expected
yellow results, *Y* as

$$Y=\\sum\_{j=1}^uP(1\\{x\_j\\in W\\})$$

where the subscript *j* denotes a specific letter and *u* is the number
of unique letters in that word. This gives us the expected number of
yellow results any one word should have; naturally, we simply want this
value to be the highest possible.

## Position Hunting

This is largely similiar to letter hunting, but instead of being
concerned with *P*(1{*x* ∈ *W*}) we now need to calculate the letter
being in the correct spot, which is given by

$$P(1\\{x\_j=W\_j\\}) = E\[(1\\{x\_j=W\_j\\})\] = \\frac{1}{n} \\sum\_{i=1}^n 1\\{x\_j \\in w\_{ij}\\}$$
We then calculate the expected number of green results, *G*, as

$$G=\\sum\_{j=1}^5 P(1\\{x\_j=w\_{ij}\\})$$
\#\# Combined Scoring & Vowel Omission

Once we have calculated a *Y* and *G* score for a word, we can combine
these two scores based on a given weight *t* to give us the combined
score *C*

*C* = *t**G* + (1 − *t*)*Y*

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
<td style="text-align: left;">aeros</td>
<td style="text-align: right;">1.883</td>
<td style="text-align: left;">aeros</td>
<td style="text-align: right;">1.943</td>
<td style="text-align: left;">aeros</td>
<td style="text-align: right;">1.943</td>
</tr>
<tr class="even">
<td style="text-align: left;">soare</td>
<td style="text-align: right;">1.883</td>
<td style="text-align: left;">soare</td>
<td style="text-align: right;">1.943</td>
<td style="text-align: left;">soare</td>
<td style="text-align: right;">1.943</td>
</tr>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.883</td>
<td style="text-align: left;">aesir</td>
<td style="text-align: right;">1.915</td>
<td style="text-align: left;">arose</td>
<td style="text-align: right;">1.943</td>
</tr>
<tr class="even">
<td style="text-align: left;">aesir</td>
<td style="text-align: right;">1.865</td>
<td style="text-align: left;">reais</td>
<td style="text-align: right;">1.915</td>
<td style="text-align: left;">aesir</td>
<td style="text-align: right;">1.915</td>
</tr>
<tr class="odd">
<td style="text-align: left;">reais</td>
<td style="text-align: right;">1.865</td>
<td style="text-align: left;">serai</td>
<td style="text-align: right;">1.915</td>
<td style="text-align: left;">reais</td>
<td style="text-align: right;">1.915</td>
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
<td style="text-align: left;">rynds</td>
<td style="text-align: right;">1.274</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: right;">1.329</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: right;">1.329</td>
</tr>
<tr class="even">
<td style="text-align: left;">tryps</td>
<td style="text-align: right;">1.260</td>
<td style="text-align: left;">tryps</td>
<td style="text-align: right;">1.305</td>
<td style="text-align: left;">tryps</td>
<td style="text-align: right;">1.305</td>
</tr>
<tr class="odd">
<td style="text-align: left;">byrls</td>
<td style="text-align: right;">1.243</td>
<td style="text-align: left;">byrls</td>
<td style="text-align: right;">1.287</td>
<td style="text-align: left;">byrls</td>
<td style="text-align: right;">1.287</td>
</tr>
<tr class="even">
<td style="text-align: left;">rotls</td>
<td style="text-align: right;">1.202</td>
<td style="text-align: left;">rotls</td>
<td style="text-align: right;">1.241</td>
<td style="text-align: left;">rotls</td>
<td style="text-align: right;">1.241</td>
</tr>
<tr class="odd">
<td style="text-align: left;">slart</td>
<td style="text-align: right;">1.202</td>
<td style="text-align: left;">slart</td>
<td style="text-align: right;">1.241</td>
<td style="text-align: left;">slart</td>
<td style="text-align: right;">1.241</td>
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
<td style="text-align: left;">sanes</td>
<td style="text-align: right;">0.799</td>
<td style="text-align: left;">sores</td>
<td style="text-align: right;">0.936</td>
<td style="text-align: left;">sores</td>
<td style="text-align: right;">0.936</td>
</tr>
<tr class="even">
<td style="text-align: left;">sores</td>
<td style="text-align: right;">0.797</td>
<td style="text-align: left;">sanes</td>
<td style="text-align: right;">0.930</td>
<td style="text-align: left;">sanes</td>
<td style="text-align: right;">0.930</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sales</td>
<td style="text-align: right;">0.789</td>
<td style="text-align: left;">sales</td>
<td style="text-align: right;">0.921</td>
<td style="text-align: left;">sales</td>
<td style="text-align: right;">0.921</td>
</tr>
<tr class="even">
<td style="text-align: left;">sones</td>
<td style="text-align: right;">0.776</td>
<td style="text-align: left;">sones</td>
<td style="text-align: right;">0.916</td>
<td style="text-align: left;">sones</td>
<td style="text-align: right;">0.916</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sates</td>
<td style="text-align: right;">0.772</td>
<td style="text-align: left;">soles</td>
<td style="text-align: right;">0.908</td>
<td style="text-align: left;">soles</td>
<td style="text-align: right;">0.908</td>
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
<td style="text-align: left;">sorts</td>
<td style="text-align: right;">0.542</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: right;">0.648</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: right;">0.648</td>
</tr>
<tr class="even">
<td style="text-align: left;">sorns</td>
<td style="text-align: right;">0.534</td>
<td style="text-align: left;">grrls</td>
<td style="text-align: right;">0.634</td>
<td style="text-align: left;">grrls</td>
<td style="text-align: right;">0.634</td>
</tr>
<tr class="odd">
<td style="text-align: left;">grrls</td>
<td style="text-align: right;">0.530</td>
<td style="text-align: left;">sorns</td>
<td style="text-align: right;">0.634</td>
<td style="text-align: left;">sorns</td>
<td style="text-align: right;">0.634</td>
</tr>
<tr class="even">
<td style="text-align: left;">serrs</td>
<td style="text-align: right;">0.530</td>
<td style="text-align: left;">serrs</td>
<td style="text-align: right;">0.630</td>
<td style="text-align: left;">serrs</td>
<td style="text-align: right;">0.630</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sants</td>
<td style="text-align: right;">0.521</td>
<td style="text-align: left;">sants</td>
<td style="text-align: right;">0.629</td>
<td style="text-align: left;">sants</td>
<td style="text-align: right;">0.629</td>
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
<td style="text-align: left;">aeros</td>
<td style="text-align: right;">0.919</td>
<td style="text-align: left;">aeros</td>
<td style="text-align: right;">1.014</td>
<td style="text-align: left;">aeros</td>
<td style="text-align: right;">1.014</td>
</tr>
<tr class="even">
<td style="text-align: left;">soare</td>
<td style="text-align: right;">0.880</td>
<td style="text-align: left;">soare</td>
<td style="text-align: right;">0.880</td>
<td style="text-align: left;">soare</td>
<td style="text-align: right;">0.880</td>
</tr>
<tr class="odd">
<td style="text-align: left;">arose</td>
<td style="text-align: right;">0.748</td>
<td style="text-align: left;">aesir</td>
<td style="text-align: right;">0.733</td>
<td style="text-align: left;">arose</td>
<td style="text-align: right;">0.729</td>
</tr>
<tr class="even">
<td style="text-align: left;">aesir</td>
<td style="text-align: right;">0.733</td>
<td style="text-align: left;">reais</td>
<td style="text-align: right;">1.005</td>
<td style="text-align: left;">aesir</td>
<td style="text-align: right;">0.733</td>
</tr>
<tr class="odd">
<td style="text-align: left;">reais</td>
<td style="text-align: right;">0.917</td>
<td style="text-align: left;">serai</td>
<td style="text-align: right;">0.816</td>
<td style="text-align: left;">reais</td>
<td style="text-align: right;">1.005</td>
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
<td style="text-align: left;">byrls</td>
<td style="text-align: right;">0.688</td>
<td style="text-align: left;">byrls</td>
<td style="text-align: right;">0.782</td>
<td style="text-align: left;">byrls</td>
<td style="text-align: right;">0.782</td>
</tr>
<tr class="even">
<td style="text-align: left;">grrls</td>
<td style="text-align: right;">0.668</td>
<td style="text-align: left;">grrls</td>
<td style="text-align: right;">0.760</td>
<td style="text-align: left;">grrls</td>
<td style="text-align: right;">0.760</td>
</tr>
<tr class="odd">
<td style="text-align: left;">tirls</td>
<td style="text-align: right;">0.659</td>
<td style="text-align: left;">tirls</td>
<td style="text-align: right;">0.749</td>
<td style="text-align: left;">tirls</td>
<td style="text-align: right;">0.749</td>
</tr>
<tr class="even">
<td style="text-align: left;">tarns</td>
<td style="text-align: right;">0.655</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: right;">0.749</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: right;">0.749</td>
</tr>
<tr class="odd">
<td style="text-align: left;">terns</td>
<td style="text-align: right;">0.655</td>
<td style="text-align: left;">tarns</td>
<td style="text-align: right;">0.743</td>
<td style="text-align: left;">tarns</td>
<td style="text-align: right;">0.743</td>
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
<td style="text-align: left;">aeros</td>
<td style="text-align: left;">sanes</td>
<td style="text-align: left;">tares</td>
</tr>
<tr class="even">
<td>… Consonants</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: left;">byrls</td>
</tr>
<tr class="odd">
<td>Short on Short</td>
<td style="text-align: left;">aeros</td>
<td style="text-align: left;">sores</td>
<td style="text-align: left;">tares</td>
</tr>
<tr class="even">
<td>… Consonants</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: left;">byrls</td>
</tr>
<tr class="odd">
<td>Full on Short</td>
<td style="text-align: left;">aeros</td>
<td style="text-align: left;">sores</td>
<td style="text-align: left;">tares</td>
</tr>
<tr class="even">
<td>… Consonants</td>
<td style="text-align: left;">rynds</td>
<td style="text-align: left;">sorts</td>
<td style="text-align: left;">byrls</td>
</tr>
</tbody>
</table>
