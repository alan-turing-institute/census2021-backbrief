Census 2021 Backbrief
=====

[Hut23 internal project issue](https://github.com/alan-turing-institute/Hut23/issues/431)

### Background

ONS want to link records between the 2021 Census and the Census Coverage Survey (CCS) which is carried out six weeks after Census day. In 2011, CCS contained 6.2% of the postcodes from the Census.

In 2011, record linkage between the CCS and Census required a lot of manual review, so the challenge is to automate the process to the highest degree possible whilst maintaining precision above 99.90% and sensitivity above 99.75% (from "difficult to match" CCS postcodes, elsewhere should be higher).

ONS currently plan to use a probabilistic algorithm (Felligi-Sunter) together with an unsupervised iterative machine learning algorithm (Expectation Maximisation) to get a score for each record pair. Two thresholds will be set; record pairs scoring above the top threshold will be accepted automatically as matches; record pairs scoring below the bottom threshold will be automatically rejected; record pairs scoring between the thresholds will be reviewed manually.

### Backbrief

Turing collaborators should suggest alternative machine learning approaches to this problem and suggest an optimal solution. The purpose of this backbrief is to determine how the collaboration should proceed by:

- Providing an overview of the problem and specific challenges
- Providing a brief overview of the relevant background and literature
- Proposing a specific question to focus on in the main project
- Proposing a full project proposal and plan
