# Statistical analysis of vehicle fuel economy

This repository contains the reproducible files for the report about fuel
economy, transmission type, and vehicle weight.

## Files

- `data/mtcars.csv` is the cleaned analysis data.
- `scripts/analysis.R` is the full base R script.
- `outputs/` contains the analysis figures and saved results.

## Running the analysis

Open R or RStudio, set the working directory to this folder, and run:

```r
source("scripts/analysis.R")
```

The script uses the built-in R `mtcars` dataset and base R functions only.
The data file is included so the variables and cleaned structure are visible
in the repository.

## GitHub link

The GitHub repository for this analysis is:

https://github.com/Qwersel/mtcars-statistical-analysis

Source documentation for the built-in dataset:
https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html
