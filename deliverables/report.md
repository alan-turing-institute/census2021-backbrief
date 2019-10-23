% ONS Census Coverage Scoping Project
% November 2019

This document presents the results of a short, joint, scoping exercise carried out in October 2019 by a small team from the Alan Turing Institute and the Office for National Statistics (ONS).

It is intended that this document will provide the foundation for a longer project to explore the application of machine learning to record linkage between the 2021 UK census and the Census Coverage Survey (CCS), which assesses under-coverage in the census.

Our main aim below is to specify the challenges faced by ONS with regards to this task and outline a project plan, providing sufficient background for any project team quickly to start work.

The next section contains a brief summary of the context in which the research project will be carried out and the necessary information the team will need on the UK census and CCS.

# Context

In the UK, the national census is carried out every 10 years, in order to measure the population size and demographics. Unlike in other countries where the census count itself is published, the UK aims to provide a census estimate, adjusted for overcount and undercount. In 2011, the census questions were asked on paper forms, but in 2021, a combination of online forms and paper forms will be used.

To calculate the census estimates, the CCS, an independent enumeration of a sample of 1% of postcodes, is carried out after the census. This involves in-person interviews carried out at the selected addresses, to obtain data from the occupants for a small selection of the core census form fields: first name, surname, date of birth, sex, marital status, address and occupation.

As a simple explanation of the logic used to deduce the undercount estimate, consider the scenario of a fisherman wishing to estimate the number of fish in a lake. Suppose the fisherman catches 100 fish on a particular day and tags them all. He then returns to fish another day, catching 50, of which 25 have a tag. Since half the fish caught on the second day had a tag, the fisherman could estimate that the total number of fish in the lake is double the number of tagged fish (200).

When sampling humans rather than fish, the considerations are of course more complex. However, for the purposes of this document and the project being scoped, the task of importance is not the calculation of the population estimate, but the challenges associated with precisely linking each CCS record to a census record from the same person.

The 2011 UK Census estimated that in the UK there are about 65 million people
($63.2\,\text{m}$) and 25 million households ($26.4\,\text{m}), with the CCS sampling $1\,\%$ of postcodes, counting about $600\,000$ people and $340\,000$ households.

In the postcodes sampled by the Survey, about $95\,000$ individuals counted by
the Census were not matched in the Survey; likewise, there were about $55\,000$
individuals counted by the Survey who were not matched in the Census, even when
the search was broadened to include postcodes not in the Survey sample. These
figures are higher than the final estimates of under-enumeration because the
sample postcodes were weighted towards areas where high under-enumeration was
expected.

_FIXME: Is it true that the search was broadened?_.

The Problem
=======

Records in the CCS need to be paired with matching census records that correspond to the same person, even when there is missing/incomplete information in one of the records or differences due to spelling mistakes, scanning errors and other mistakes. As such, this problem can be considered a record linkage problem. See the *Technical Background* section of this report for a longer summary of the record linkage problem and the algorithms used to tackle it.

In 2011, 70% of the people matches were made automatically using a mixture of deterministic matching and standard *Fellegi-Sunter* probabilistic matching. This left 30% for clerical resolution (deciding if a given pair of records are a match) and clerical searching (searching for a match when no possible matches are initially presented). For households, a deterministic method was used that was able to match 60% of households automatically.

The clerical matching procedure took the equivalent of 30 full-time staff all working for 30 weeks in 2011, but in 2021, the deadline for completing the census matching is only 8 weeks from when all the census and CCS returns are in.

The primary objective of the collaboration project between ONS and the Alan Turing Institute should be: to minimise (to the greatest degree possible) the need for clerical searching as part of the 2021 matching methodology, or to speed up this process. The slowness of this procedure in 2011 owes to the fact that in order for a CCS record for which their is suspected to be a match to be ruled out and considered a non-match (or matched), it must first be checked against every single census record for which there is currently no match (and vice versa).

Even after improvements ONS have already made to their automated matching methods (detailed later in this report), they are still left with 9% of people records to match manually (5% for household records) when testing these methods on 2011 data. They predict that of these people matches, a further 8% will be found by clerical resolution, leaving 1% of matches still to make. This 1% (~5,300 matches) could be included anywhere amongst the unmatched CCS records (55,000 in 2011) and unmatched census records from CCS areas (95,000 in 2011). Any method used to replace clerical searching for these very difficult matches also needs to be able to declare when records definitely do not have a match.

Alternative methods to speed up clerical resolution procedure that make use of the Turing researcher's expertise in Machine Learning (ML) algorithms, should be proposed and tested. In particular, this should include methods to generate a list of possible matches for CCS/census records that could not be automatically labeled as a definite match (or definite non-match), in order to aid the clerical decision making. One challenge here is that if any method requires training data, there will not be any available in advance of it being deployed on the matching days, due to appropriate 2021 census/CCS example records not yet existing. To complicate things further, there is no guarantee that the kinds of difficult-to-match record pairs that a learning algorithm might find useful are likely to arise early in the matching procedure.

As a secondary objective, Turing researchers should propose and explore potential ML methods that could out-perform those already being researched by ONS, at the overall task of automated census-CCS record linkage.

Any improvements to the matching methodology made as a result of this project will be subject to strict precision and recall criteria; recall of at least $99.75\,\%$ and
precision of at least $99.9\,\%$. In 2011, approximately $550\,000$ individuals were
matched. If the numbers in 2021 were identical (they of course won't be), this allows no more than $1\,300$ true matches to be missed and nor more than $550$ pairs of different individuals incorrectly identified as being the same. **TODO:** *Update these stats as per Rachel's recent email*

_FIXME: Can we get equivalent figures for households?_

The technical background section of this document will explain the improvements to the 2011 census-CCS matching methodology already made by ONS, after summarising the relevant background literature on record linkage algorithms.

Technical Background
========

The first part of this section contains a brief overview of the literature on record linkage and the variety of methods used for this class of problem. The second section details the specific methods being researched by ONS.

Record Linkage
------

There are many databases containing records that refer to real-world entities, such as people. There are also a variety of problems for which information on the same entity must be gathered from multiple databases. In order to combine or compare information on these entities from different databases, there must be a robust method for determining which records refer to the same entity. In cases like that of the census and CCS, the challenge is complicated by the reality of missing or inaccurate data in records that should be matched (those that refer to the same person).

The task of matching non-identical records from different databases that refer to the same entity is known as *record linkage*. In scientific literature it is also described by a variety of alternative names depending on the research community, including *instance identification*, *name matching*, *database hardening*, *merge-purge* and (when applied to a single database) *duplicate detection* [@Elmagarmid2007].

Record linkage problems deal with records that reference complex real world entities like people, with multiple data fields. The challenge is therefore greater than simply matching a single field, where commonly used string distance metrics such as the Levenshtein edit distance or Jaro-Winkler are suitable. Such metrics can however be used to compute a distance metric for the equivalent fields of two records, which has shown to be useful in matching census names with typographical errors [@WilliamE.Yancey2005].

To avoid comparing every record in one database with every one in the other, there are a variety of different methods used to filter out extremely unlikely matches that vary in their performance and scalability. A common example is *blocking*, where all record pairs that disagree on a blocking key are initially discarded. This key can be a particular field or combination of multiple fields [@Christen2012].

The methods used for the problem of record linkage fall into the three general categories; deterministic, probabilistic and learning based methods. All of these methods work on the general premise of categorising record pairs as matches, as non-matches and in some cases as indeterminate.

Deterministic methods use a set of rules based on the constituent fields of each record pair to classify matches, with pairs that don't match according to those rules classified as non-match. The specified rules can be considered a "Matchkey". A simple example of a Matchkey for a pairing of records that have two equivalent fields could be: Field1 must be an exact match and Field2 must have an edit distance < 3.

Probabilistic methods (most commonly the Felligi-Sunter algorithm) use a Bayesian approach to calculate the probability of each record pair being a match or non-match, based on the product of the set of probabilities of corresponding fields being matches or non-matches between the two records. Pairs falling below a match threshold and above a lower non-match threshold are classified as indeterminate and sent out for clerical review. Each field used in the calculation is assigned a weight, computed either by an Expectation Maximisation algorithm or from the probabilities in training data [@Murray2018].

One key problem with probabilistic record linkage is that it assumes independence of the fields, which is typically not the case. For example, in record linkage between the census and CCS, fields such as first name and date of birth cannot be considered conditionally independent.

Application of Machine Learning to Record Linkage
-------

As an alternative to the probabilistic and deterministic methods already discussed, a variety of ML algorithms have been applied to record linkage problems. Broadly, these methods can be classified into supervised learning, unsupervised learning and active learning.

A common example of unsupervised learning in record linkage has already been discussed in this report; the use of the Expectation Maximisation algorithm to estimate the match and non-match class probabilities from the set of probabilities of corresponding fields being matches or non-matches between the two records. This is considered to be of particular use in scenarios when the record fields cannot be considered conditionally independent, especially when the data contain a relatively large percentage of matches (more than 5 percent) [@Elmagarmid2007]. Another example of unsupervised learning involves the use clustering algorithms to group together similar comparison vectors (which contain information about the differences between fields in a pair of records), with the idea being that similar comparison vectors correspond to the same class (i.e. match, non-match or possible match) [@Elmagarmid2007].

Supervised learning relies on the existence of suitable training data, which in the case of record linkage, comes in the form of record pairs that are labeled as matches and non-matches. There are a variety of classification algorithms that have been applied to record linkage that fall into the supervised learning category, including support vector machine classification and decision trees, but @Christen2012 notes that none of these methods have consistently outperformed probabilistic methods, especially for applications with tens of millions of records. By contrast, methods that rely on neural networks such as single layer perceptrons have been reported to outperform traditional probabilistic methods in some cases [@Wilson2011].

A key difficulty with these supervised learning methods is that in order for a classifier to become highly accurate, the training data would need to include many examples of matches and non-matches and crucially, examples of both that are ambiguous; the kinds that would be classed as indeterminate by a probabilistic method and sent for clerical review. In response to this problem, active learning methods have been developed that require far less training data, initially only using labeled record pairs from ambiguous cases (where the uncertainty of match/non-match classification was high). The classifier will initially work for only some un-labeled instances, but can be used to find record pairs in the un-labeled data pool which, when labeled, will improve the accuracy of the classifier at the fastest possible rate [@Elmagarmid2007]. Those pairs can then be manually labeled, adding to the training data and progressively improving the classifier.


Improvements in Census to CCS Record Linkage
=========

Already, the research team at ONS have begun to improve upon the methods used for record linkage between the 2011 census and CCS. Based on their improvements so far, they predict that in 2021, 91% of people records, and 95% of household records can be matched automatically (compared with 70% and 60% respectively in 2011). In this section of the report, the key improvements to the methodology that resulted in this performance increase will be detailed.

Automated Matching
------

In order to improve upon determinstic matching of people, a set of matchkeys have been developed using the 2011 Census data as test data. These include more derived field variables, accounting common errors in name fields such as those caused by scanning (of paper forms), spelling errors or transposition errors. For example, by rearranging the letters of names into alphabetical order to deal with transposition errors (Alphaname) and and by using the Jaro-Winkler edit distance or a phonetic algorithm based on English pronunciation similarity (Soundex) to deal with phonetic and spelling errors. Comparison with the 2011 Gold Standard (record pairing decisions made by all methods including manual clerical review in 2011) shows that the matchkeys find 85% of the matches made in 2011. It should however be noted that this Gold Standard is not perfect, with duplicates being a recurring issue with using it to verify new methods. **TODO: should we inlcude this table:** *See appendix A for variables used for matching and matchkeys.*

A new set of matchkeys have also been developed for household record pairing, using both household information (tenure, type of property, number of usual residents etc) together with the people sets. This method has enabled ONS to make 95% of the matches on the 2011 households Gold Standard.

ONS researchers have also looked into making improvements to the match rate their Fellegi-Sunter probabilistic algorithm. Rather than use the Expectation Maximisation algorithm, they plan to calculate the values for the weights of record fields manually (initially using the 2011 data) and then iteratively improving this using the matching (both automatic and clerical) carried out in 2021. In addition, changes have been made to the blocking carried out before matching. Using a single blocking pass, bringing together record pairs that share the same postcode; all other CCS fields are available for use in the actual matching. Testing this approach with 2011 data gave a pairs completeness of 97.8%. An alternative blocking pass on date of birth has also been attempted in order to capture the remaining 2.2%, but no extra matches were made using this.

Some steps have already been taken to speed up the clerical review process via a proposed associative people matching method, which also increases the number of automatic matches. Unmatched people in households where the household record has already been matched are given a score using Fellegi-Sunter. Any candidate people record pairs who score above a threshold are accepted automatically (note that this threshold can be lower than that set for the initial people matching algorithm). Matched households that still contain unmatched people are then sent to clerical review, giving the reviewer a household view that clearly shows those people matches already made within the household. **TODO: would be nice to refer to figure here**.

Reducing the Clerical Matching Requirement
-------

In starting to address the key objective of speeding up the clerical matching procedure, ONS have developed what they call a *Pre-search* algorithm, which is applied to the ambiguous records assigned for clerical review by the prior automated matching methods before laborious clerical searching is attempted. Their current approach finds potential candidates for pairing using very loose blocking, ranks them using Fellegi-Sunter scoring, and then presents them to the clerical reviewer who gets to make the final decision as to whether there is a match. The ultimate goal would be to be able to say with confidence that if the matching record is not amongst the top candidates presented to the reviewer, then there is no match for that record.

ONS report that this method is already working well; when there is a match (as evaluated by the 2011 Gold Standard), it appears as the first record on the list 98% of the time. There however no way to know for sure that methods that work well for 2011 data will work as well on 2021 data and ONS are keen to consider alternative ML methods for improving the *Pre-search* algorithm in collaboration with the Turing.

The next section of this report will outline some of the proposed methods not already being explored by ONS for improving both the *Pre-search* algorithm and the overall record linkage methodology.

Project Proposal
=======

- Use ML algorithms to speed up/reduce manual decisions of difficult-to-match records
- Use alternative ML algorithms that are better at automated record linkage than those ONS already researching
- Evaluation method

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




Timeline and Plan
======

- Needs discussion with ONS

Glossary
=======

- Indexing
- Blocking

References
====
