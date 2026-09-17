# Statistical analysis of mtcars
# The analysis uses only base R functions.

options(stringsAsFactors = FALSE)

# Read the included CSV. It was exported from R's built-in mtcars dataset.
cars <- read.csv("data/mtcars.csv", stringsAsFactors = FALSE)
cars$transmission <- factor(cars$am,
  levels = c(0, 1),
  labels = c("Automatic", "Manual"))
cars$weight_1000lb <- cars$wt

analysis <- cars[, c("model", "mpg", "transmission", "weight_1000lb")]
analysis <- analysis[complete.cases(analysis), ]
analysis <- analysis[!duplicated(analysis), ]

# Main analysis uses all 32 available rows because the dataset is small.
# This is an optional reproducible 80 percent sampling check only.
set.seed(17)
sample_rows <- sample(seq_len(nrow(analysis)),
  size = floor(0.80 * nrow(analysis)))
sample_check <- analysis[sample_rows, ]

# Descriptive statistics and plots.
aggregate(mpg ~ transmission, data = analysis,
  FUN = function(x) c(n = length(x), mean = mean(x),
  sd = sd(x), median = median(x)))
boxplot(mpg ~ transmission, data = analysis,
  ylab = "Miles per gallon", xlab = "Transmission")
plot(analysis$weight_1000lb, analysis$mpg,
  xlab = "Weight (1000 lb)", ylab = "Miles per gallon")

# Assumption checks for the group comparison.
by(analysis$mpg, analysis$transmission, shapiro.test)
var.test(mpg ~ transmission, data = analysis)

# Welch two sample t test. This does not assume equal variances.
welch_test <- t.test(mpg ~ transmission, data = analysis,
  var.equal = FALSE, conf.level = 0.95)
welch_test

# Multiple linear regression controls for vehicle weight.
fit <- lm(mpg ~ weight_1000lb + transmission, data = analysis)
summary(fit)
confint(fit, level = 0.95)

# Regression diagnostics.
par(mfrow = c(2, 2))
plot(fit)
shapiro.test(residuals(fit))
