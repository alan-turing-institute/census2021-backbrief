library(dplyr)

counts <- tribble(
    ~method,       ~tp,    ~fn, ~fp,   ~tn,
    "old_auto", 454961, 194983,   0, 59527,
    "det",      551613,  98331,   0, 59527,
    "all",      572966,  76978,   0, 59527,
    "all_hh",   585417,  64527,   0, 59527,
    "res",      633785,  16159,   0, 59527,
    "pre_top",  646025,   3919,   0, 59527,
    "pre_all",  647321,   2623,   0, 59527)

counts <- counts %>% mutate(precision = tp / (tp + fp), recall = tp / (tp + fn))

