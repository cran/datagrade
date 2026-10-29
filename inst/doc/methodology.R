## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(datagrade)

## -----------------------------------------------------------------------------
report <- dg_assess(airquality, verbose = FALSE)
report$missing$columns
report$scores[["completeness"]]

## -----------------------------------------------------------------------------
df <- data.frame(constant = rep(5, 50), varying = c(rnorm(49), 100))
detect_outliers(df)$by_column

## -----------------------------------------------------------------------------
set.seed(11)
d <- data.frame(a = rnorm(500), b = rnorm(500))
d$c <- 0.6 * d$a + 0.3 * d$b + rnorm(500)

dg_vif(d)

vapply(names(d), function(col) {
  r2 <- summary(lm(d[[col]] ~ ., data = d[setdiff(names(d), col)]))$r.squared
  1 / (1 - r2)
}, numeric(1))

## -----------------------------------------------------------------------------
df <- data.frame(when = c("2024-01-15", "2024-02-20"), value = 1:2)
r <- dg_assess(df, verbose = FALSE, strip_punctuation = TRUE)
r$parsed_dates
r$dates

## -----------------------------------------------------------------------------
set.seed(42)
analyze_distribution(data.frame(normal = rnorm(20000), skewed = rexp(20000)))

## -----------------------------------------------------------------------------
text_only <- data.frame(a = c("x", "y", "z"), stringsAsFactors = FALSE)
r <- dg_assess(text_only, verbose = FALSE)
r$scores
r$overall

## -----------------------------------------------------------------------------
report <- dg_assess(iris, verbose = FALSE)
report$measures[, c("code", "characteristic", "value", "a", "b")]

## -----------------------------------------------------------------------------
d <- data.frame(ref = c(rep("AB-1234", 8), "1234-AB", "XX/99"),
                stringsAsFactors = FALSE)
m <- dg_assess(d, verbose = FALSE)$measures
m[m$code == "CONS_FORM", c("value", "a", "b")]

## -----------------------------------------------------------------------------
d <- data.frame(x = 1:4)
m <- dg_assess(d, spec = dg_spec(rules = list(fine = ~ x > 0,
                                              broken = ~ missing_col > 0)),
               verbose = FALSE)$measures
m[m$code == "CONS_SEMAN", c("value", "a", "b", "note")]

## -----------------------------------------------------------------------------
report$plausibility
report$scores[["accuracy"]]   # NA: no interval was declared

