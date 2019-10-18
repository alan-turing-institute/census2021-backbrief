This document presents the results of a short, joint, scoping exercise carried out
in October 2019 by a small team from the Alan Turing Institute and the Office for National Statistics (ONS).

It is intended that this document will provide the foundation for a longer project
to explore the application of machine learning to record linkage between the 2021 UK census and the Census Coverage Survey (CCS), which assesses under-coverage in the census.

Our main aim below is to specify the challenges faced by ONS with regards to this task and outline a project plan, providing sufficient background for any project team quickly to start work.

The next section contains a brief summary of the context in which the research project will be carried out and the necessary information the team will need on the UK census and CCS.

Context
======

In the UK, the national census is carried out every 10 years, in order to measure the population size and demographics. Unlike in other countries where the census count itself is published, the UK aims to provide a census estimate, adjusted for overcount and undercount. In 2011, the census questions were asked on paper forms, but in 2021, a combination of online forms and paper forms will be used.

To calculate the census estimates, the CCS, an independent enumeration of a sample of 1% of postcodes, is carried out after the census. This involves in-person interviews carried out at the selected addresses, to obtain data from the occupants for a small selection of the core census form fields: first name, surname, date of birth, sex, marital status, address and occupation.

As a simple explanation of the logic used to deduce the undercount estimate, consider the scenario of a fisherman wishing to estimate the number of fish in a lake. Suppose the fisherman catches 100 fish on a particular day and tags them all. He then returns to fish another day, catching 50, of which 25 have a tag. Since half the fish caught on the second day had a tag, the fisherman could estimate that the total number of fish in the lake is double the number of tagged fish (200).

When sampling humans rather than fish, the considerations are of course more complex. However, for the purposes of this document and the project being scoped, the task of importance is not the calculation of the population estimate, but the challenges associated with precisely linking each CCS record to a census record from the same person.

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
