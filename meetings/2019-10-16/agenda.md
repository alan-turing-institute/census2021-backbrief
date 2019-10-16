% Proposed agenda for Turing site visit
% James Geddes & Ed Chalstrey (Turing)
% 16 October 2019

# Agenda

1. Show-and-tell from ONS

2. Make sure we understand past and current approach
   - Propose that this becomes the first half of the final report 

3. What is the question?

4. Ideas brainstorm

5. Next steps



# Things we'd like to understand

## Counts

### 2011


|                         | People      | HH           | Note |
|-------------------------+-------------+--------------+------|
| Census                  | ~60,000,000 | ?            |      |
|-------------------------+-------------+--------------+------|
| 1% Survey               | ~600,000    | ?            | [1]  |
| Matched algorithmically | ~70%        | ~60%         | [2]  |

[1] How is survey chosen? Sampling within postcodes?  
[2] Both deterministic and F-S probabilistic for people; deterministic only for
    households.


### 2021 (forecast)

|                         | People      | HH | Note |
|-------------------------+-------------+----+------|
| Census                  | ~60,000,000 |    |      |
|-------------------------+-------------+----+------|
| 1% Survey               | ~600,000    |    | [1]  |
| Matched algorithmically |             |     | [2]  |



## Features

### Original fields used in matching

- unique identifier (assigned how?)
- date of birth
- sex
- full name
- surname
- address

### Original fields, slightly different coding

- marital status
- country of birth

### Derived fields



# What is the question?

(1) To reduce the 55,000 not-yet-matches that have to be sent to clerical search
    (which is the time-consuming part)
    
(2) To know how good we are at this, on the 2021 data (which we don't have yet)
    which is likely to different from the 2011 data (because it's now online).

(3) Possibly, to get better at the 8% that go to clerical matching by learning
    as it goes through.
    
    
# Brainstorm
    
- Automatically reject anyone who isn't in the top-20 for pre-search
    
- Look for "clean" survey records, and try to prove no match (maybe with clean
  on the other side?).

# Next steps

## ONS
- Figure out the false negative rate if we reject everyone not in top-20


## Turing
- Write up

