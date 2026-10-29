## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 8,
                      fig.height = 4.5, dpi = 120)
library(datagrade)

## -----------------------------------------------------------------------------
report <- dg_assess(iris, verbose = FALSE)
report

## -----------------------------------------------------------------------------
report$scores
report$measures[, c("code", "characteristic", "value", "a", "b")]
report$outliers$by_column
report$redundancy$pairs

## -----------------------------------------------------------------------------
spec <- dg_spec(
  required = c("Sepal.Length", "Species"),
  ranges   = list(Sepal.Length = c(4, 8), Petal.Width = c(0, 3)),
  domains  = list(Species = levels(iris$Species)),
  rules    = list(petal_smaller = ~ Petal.Length < Sepal.Length)
)
spec

## -----------------------------------------------------------------------------
scored <- dg_assess(iris, spec = spec, verbose = FALSE)
scored$scores
scored$measures[scored$measures$applicable,
                c("code", "value", "a", "b")]

## -----------------------------------------------------------------------------
waiting <- scored$measures[!scored$measures$applicable, c("code", "note")]
waiting

## -----------------------------------------------------------------------------
report$plausibility
report$scores[["accuracy"]]   # NA: nothing was declared

## -----------------------------------------------------------------------------
summary(report)$columns

## -----------------------------------------------------------------------------
datasets <- list(iris = iris, mtcars = mtcars, airquality = airquality)
sweep <- do.call(rbind, lapply(names(datasets), function(nm) {
  row <- as.data.frame(dg_assess(datasets[[nm]], verbose = FALSE))
  row$source <- nm
  row
}))
sweep[, c("source", "rows", "completeness", "consistency", "overall",
          "plausibility")]

## -----------------------------------------------------------------------------
figures <- dg_plots(report)
names(figures)
figures$scores

## -----------------------------------------------------------------------------
figures$correlation

## ----fig.height = 5.5---------------------------------------------------------
figures$distribution

## -----------------------------------------------------------------------------
path <- tempfile(fileext = ".csv")
write.csv(mtcars, path, row.names = FALSE)
dg_assess(path = path, verbose = FALSE)$scores
unlink(path)

## -----------------------------------------------------------------------------
detect_data_types(data.frame(id = c("a", "b", "c"), n = c(1.5, 2.5, 3.5)))
dg_vif(iris)
analyze_distribution(iris)

