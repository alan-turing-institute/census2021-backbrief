General
------

1. What data will be available for the actual project?
    - Will the 2011 record matching data be available to the Turing researcher(s)
    - Is there any other data available? e.g. dummy data with "correct" record pairing decision labels for ambiguous matches
2. How can we measure how good our approaches were?
    - In 2011, the precision and sensitivity of the record linkage was determined by a re-matching procedure
    - We need to determine how this would this be done for the algorithmic record linkage; would it a sub-set of the record pairs still need to be looked at by humans to determine correctness?
    - Could we use 2011 data decision making for the ambiguous record pairs to train an automated evaluation method?

Technical
-------

1.  What metrics are used for field matching between the various fields present in the Census and CCS? Are these metrics also subject to improvement?
    - Should field mismatches that occur due to missing data be discounted? How likely is it that either the Census or CCS will have incomplete data fields, as oppose to just mistakes? Is this known?
2. Are constraints set for the online Census/CCS for d.o.b and other fields that check they fall within a certain range?
3. Which fields have standardised formats between the Census and CCS? Presumably d.o.b is standardised but address is not?
4. Are Census and CCS fields identical? (It looks like yes)
    - Are we to assume that the problem we have is only with **lexical heterogeneity**, as a result of citizens filling out fields of the survey and Census differently, and that the two datasets are **structurally homogenous** (i.e. equivalent fields), meaning data preparation/transformation is not required?
