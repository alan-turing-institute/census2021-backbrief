Census 2021 record linkage project scoping
========

1. Provide an overview of the problem and specific challenges
    - Maximum automation of record pairing between Census and CCS (survey)
    - Simplification of clerical matching procedure with automated suggestions
    - Refine specific challenges after speaking to ONS
2. Provide a brief overview of the relevant background and literature
    - Briefly summarise the probabilistic approaches used in record linkage
    - The machine learning techniques others have applied to record linkage
3. Propose a specific question to focus on in the main project
    - Comparison of different cutting edge methods to maximise record pairing between Census and CCS, the best of which to actually be used by ONS
    - This could include a variety of record linkage algorithms (and perhaps also a variety of efficiency approaches like different blocking/indexing techniques, though these are less important since precision and sensitivity are more important than speed)
4. Propose a full project proposal and plan
    - Compare record linkage algorithms already implemented in [J535D165/recordlinkage](https://recordlinkage.readthedocs.io/en/latest/about.html) for record linkage between Census and CCS data or dummy data
    - Extend that Python package with other algorithms we find from literature and test them
    - Novel ML approaches to the question

Record linkage
-----

Record linkage is the process of matching records from multiple databases, or for de-duplication of matching records in a single database.

The simplest possible form of record linkage is deterministic record linkage i.e. rules based. The lower the data quality, the harder it gets to make sensible rules and the more edge cases. For many years the best alternative has been **probabilistic record linkage**, but nowadays **machine learning** approaches are being increasingly used.

To avoid comparing every record in one database with every one in the other (computationally demanding), **indexing/filtering techniques** are used to filter out extremely unlikely matches. There are many different techniques that vary in their performance and scalability. A common example is **Blocking** - All record pairs that disagree on a blocking key are discarded. This key can be a particular field or combination of multiple fields (e.g. last initial and post code).

Instead of simple relying on simple field agreement or disagreement, more complicated **features** can be used to improve the accuracy of record linkage.

There are also a variety of methods for speeding up the decision process of whether a given record pair is a match, which rely on classifying non-matches quickly based on specific fields or feature-subset comparisons.

How does probabilistic record linkage work?
----

The probability of a record match (*`M`*), or non-match (*`U`*), is the product of the set of probabilities of corresponding field matches (or non-matches) between the two records.

- Weights can be assigned to different record fields (e.g. using training data, see below)
- In the Census 2011 case, records pairs below the match threshold, but above the non-match threshold are subject to clerical resolution to make the final decision; this is an example of the **Felligi-Sunter** algorithm

### Field matching

There are a variety of methods for calculating the distance between two strings and the best one to use depends on the nature of the field data. Using one of these methods, a similarity score can be assigned to the values of two matching fields.

The values of *p(x<sub>i</sub>|M)* and *p(x<sub>i</sub>|U)* , where *x<sub>i</sub>* is the similarity score for each field string comparison depends on what algorithm/method is used.

When there is no training data available, an Expectation Maximisation algorithm can be use to compute these probabilities.

**Similarity score possibilities:**

- Binary (*x<sub>i</sub>* is 1 for match or 0 for non-match)
- Field mismatches caused by missing data (as oppose to mismatching strings) are discounted
- Implement different costs for wrongly classifying as *`M`* or *`U`*
- Probabilities computed with training data

### Training data in PRL:

`u` = probability of an field in 2 non-matching records (*`U`*) agreeing by chance e.g. 1/12 for a Month field

`m` = probability of a **field** in a matched **record pair** (*`M`*) being an exact match (or matched according to some distance metric/ similarity score)

The values of `u` and `m` for *`M`* and *`U`* records in training data can be used to compute the weight of the field.

What ONS want
------

ONS want to link records between the 2021 Census and the Census Coverage Survey (CCS) which is carried out six weeks after Census day. In 2011, CCS contained 6.2% of the postcodes from the Census.

In 2011, 19% of CCS/Census records required manual clerical review because there was no exact match and 1% could not even be matched.

Any algorithmic record linkage methodology they implement in 2021 as a result of collaboration with the Turing must match or exceed a precision of 99.90% and a sensitivity of 99.75% (from "difficult to match" CCS postcodes, elsewhere should be higher).

Where precision is `tp / tp + fp` and sensitivity is `tp / tp + fn`. The true positives etc were assessed as follows:

*After the matching work was completed, a sample of postcodes were selected for re-matching in order to assess the quality of the matching process and the decisions made, providing a measure of robustness for this element of the coverage assessment and adjustment methodology. The re-matching was performed by the more experienced matchers, most of whom were also more senior matchers. To ensure independence, no-one re-matched an area that they had worked on originally.*

*A comparison of the matching runs was made to identify where different decisions were made between the original matching process and the re-matching and to verify which of these decisions were correct. To assess validity of the decisions that were the same, the data from Manchester, one of the priority areas, was checked to confirm if both decisions were correct. For sets of decisions that were different, the sample data was checked to identify if the correct decision was made originally or at re-matching.*

### Do we have better suggestions than their their idea for automated record linkage?

ONS currently plan to use a probabilistic algorithm (Felligi-Sunter) together with an unsupervised iterative machine learning algorithm (Expectation Maximisation) to get the score for each record pair.

Can we suggest anything better? Ideally we could eliminate clerical resolution entirely.

### Can we reduce the effort required for clerical review of possible matches?

ONS would like a set of possible matches that the reviewer can then decide which, if any, is the correct one. They are currently considering using a rules-based approach and/or a probabilistic algorithm with very little/no blocking to generate these possible matches.

Is it feasible to use a machine learning algorithm to say, with very high confidence, that there is no match for a record?

Machine learning in record linkage
-----

- The problem with using only probabilistic record linkage is that it assumes independence of its features, which is typically not the case.

- ONS aren't sure whether 2011 data can/should be used as training data for machine learning methods. One key change is that collection this time, the Census will be primarily online. Do we think 2011 Census data could be used as training data for a machine learning method? Perhaps we should develop methods with and without the training data.

### ML record linkage methods

**Supervised learning** with training data; pre-labelled record pair examples. Problem in this context is that it will be very difficult to generate ambiguous (between threshold) record-pairs (dummy data) that would help create a highly accurate classifier, unless we have access to the 2011 Census/CCS data.

**Active learning** with small amounts of training data; the goal is to seek out from the unlabeled data pool those instances which, when labeled, will improve the accuracy of the classifier at the fastest possible rate.

**Distance based methods:**

These avoid need for training data
- **Treat the whole record as a single field** and do string matching
- **Foreign key co-occurence** - imagine surname "Smith" often co-occurs with "Flat 21 Blah St", so an entry with "Flat 12 Blah St" you want to match as an Flat no. typo because of the surname being "Smith" when others at that address are different
- **Rule based** - e.g. if field1 in x is similar to field 1 in y AND field2 in x is similar to field2 in y, then match (this is the kind of thing ONS are thinking of). But you could also generate matching rules from training data then fine tune

**Neural Networks:** Wilson (2011) reports that Neural Networks can improve upon PRL for record linkage, working best with complex features comparison.

### Python package

People in the real world appear to already be using ML methods for record linkage. [See this Python package](https://recordlinkage.readthedocs.io/en/latest/notebooks/classifiers.html) (the package is developed for research and the linking of small or medium sized files).

There are examples of unsupervised learning as ONS have considered as well as supervised learning with training data.

*Could part of the project be extending this open source project?*

Ideas
----

### Project aspect 1:

I’m thinking that the right approach to speeding up the manual clerical review process is this: As more manual record linkage decisions are made, these “match” labeled record pairs gets fed into the dataset (along with all the “non match” alternative pairs) used to train a ML algorithm, which for each new example spits out the top X (e.g. top 10) likely matches and the manual reviewer has to accept one of these, or reject all or carry out the existing manual process if they think they can find a match themselves when the algorithm can’t (which will be the case when the dataset is small). As the dataset grows, the suggestions should get better, reducing the possibility that a reviewer would choose to bother carrying out the manual process of record linkage and therefore speeding up the entire process.

### Project aspect 2:

Look at better approaches to the overall problem of Census/CCS record linkage that minimise the need for manual clerical review

### Evaluation of correctness

- When testing their algorithms on 2011 data, ONS use a "gold standard"
- With the 2021 data, there would be no evaluation possible

### After in-person meeting:

- Key thing that needs to be improved is the "Pre-search algorithm". Ideally we'd like to eliminate clerical searching altogether and just use clerical resolution (e.g. with list of 20 suggestions - see Rachel's doc), but that may not be possible as automating the kinds of decisions that clerical searching makes may be impossible
    - ONS need to assess how well what they're doing already performs. It's possible that it's so good that all decisions that would have been sent to clerical searching can just be considered non-matches and the precision/sensitivity thresholds are still reached. I should put in the report that we suggest doing this evaluation
    - We should suggest better approaches (like ML or deterministic on other parts of the census when the fields that are the CCS fields are scrambled, e.g. student indicates age)
- Could it be possible to prove certain Census or CCS records have no match
- Is it possible that clean (non-scrambled) records are more likely to definitely not have a match? (we don't know this but maybe ONS could check if this was the case in 2011 data?)
-

24th October revised report contents
========

1. Background
    - The Census Estimate
    - Record Linkage Between Census and CCS
    - Current Challenges
2. Current Work
    - Methods for Record Linkage
    - Application to Census/CCS in 2021
    - Potential uses of Machine Learning
3. Beyond Current Methods
    - Novel Machine Learning Applications
    - Feature Matching Improvements
4. Next Steps

Section 3, Beyond Current Methods Notes
========

- Use ML algorithms to speed up/reduce manual decisions of difficult-to-match records
- Use alternative ML algorithms that are better at automated record linkage than those ONS already researching
- Evaluation method
- Feature matching improvements

### Thoughts on ML

The following are (_FIXME_: inchoate) thoughts on what "more ML" could look
like. Note that the current plans for probabilistic matching could certainly be
thought of as machine learning.

- For analytical tractability, standard Fellegi-Sunter makes an assumption of
  probabilistic independence of the feature differences. It may be possible to
  relax this for certain combinations of features. For example, age and first
  name are presumably not independent.

- Likewise, perhaps we could do better when fields are missing by understanding
  the correlation with other fields, even fields not in the Survey. For example,
  if an age were missing from the Census record, but the individual were a
  student, we would more likely match this person with a student-age record in
  the survey than a retirement-age record.

- In 2021, could we initially run manual and automatic matching in parallel and determine, as we go along, the precision and recall of the automatic classifier? *NOTE: This doesn't help ONS plan how many manual reviewers to hire*

- Could we develop a more sophisticated model of feature mismatch? At present,
  we observe the ways in which the same individual's returns are different and
  create measures of difference that account for this. For example, we notice
  that transcription errors often introduce a transposition into names, and so
  we define a distance measure that counts as “close” names that differ only in
  a transposition of letters. We might imagine writing down a very general model
  of difference (with a high-dimensional parameter space) and then attempting to learn the specifics from data.

- For all the methods that require the learning of parameters, can we learn (or
    update) these parameters from 2021 data “as we go along”? Could we _choose_
    which individuals to send to clerical review to allow us to learn more
    quickly?
