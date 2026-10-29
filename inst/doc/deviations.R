## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(datagrade)

## -----------------------------------------------------------------------------
report <- dg_assess(iris, verbose = FALSE)
m <- report$measures
m[m$code == "RIES_INCO", c("value", "a", "b")]

## -----------------------------------------------------------------------------
flag_redundant_columns(iris, 0.5)$columns
flag_redundant_columns(iris, 0.99)$columns

## -----------------------------------------------------------------------------
df <- data.frame(city = c(" Ağrı ", "Çorum"), email = c("a@b.com", "c@d.org"),
                 stringsAsFactors = FALSE)
clean_text_columns(df)
clean_text_columns(df, strip_punctuation = TRUE)

