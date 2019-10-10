

Context
======

- Briefly, what is the Census
- Briefly, what is the Census coverage survey and why is it carried out

The problem
=======

- Record linkage between Census 2021 and CCS
- Overview of the Census/CCS records and the likely issues that arise from their pairing
- Can we train based on manual decisions
- Harder to match Census/CCS records may be collected last

Project proposal
=======

- Use ML algorithms to speed up/reduce manual decisions of difficult-to-match records
- Use alternative ML algorithms that are better at automated record linkage than those ONS already researching
- Evaluation method

Timeline and plan
======

- Needs discussion with ONS

*FOR ONS:* Domain technical background
==========

Data collection processes
----

Technical background
========

This section contains a brief overview of the literature on record linkage and the variety of methods applied to this class of problem.

Record Linkage
------

There are many databases containing records that refer to real-world entities, such as people. There are also a variety of problems for which information on the same entity must be gathered from multiple databases. In order to combine or compare information on these entities from different databases, there must be a robust method for determining which records refer to the same entity.

The task of matching non-identical records from different databases that refer to the same entity is known as *record linkage*. In scientific literature it is also described by a variety of alternative names depending on the research community, including *instance identification*, *name matching*, *database hardening*, *merge-purge* and (when applied to a single database) *duplicate detection* (@elmagarmid_duplicate_2007).

- Briefly, the limitations of deterministic record linkage
- Briefly, explain that individual fields are matched with a similarity score
- Briefly, probabilistic record linkage and the Felligi-Sunter algorithm, based on weighted field matches
- The problem with using only probabilistic record linkage is that it assumes independence of its features, which is typically not the case. A variety of ML algorithms have also been applied to record linkage problems

Record Linkage Methods Used by ONS
------

- Felli-Sunter with Expectation Maximisation
- Other

Other Machine Learning Methods in Record linkage
-------

Glossary
=======

- Indexing
- Blocking

References
====
