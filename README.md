# Regularization paths for huge package

Convenience function to plot the regularization paths of huge glasso estimated objects in R.

Please refer to the original package documentation on CRAN for additional information: https://cran.r-project.org/package=huge.

## Installation
This function only requires the `huge` package to work.
```R
#install.packages("huge")
library(huge)
```

You can then either manually download the source code located in `src/reg_paths.R` or clone it from GitHub and source it.
```R
source("path/to/reg_paths.R")
``` 

## Usage
If you plan on saving generated plots, do not forget to change the `FIG_PATH` constant of the desired folder at the beginning of the function.
When saving, you must pass a list of the following form: `save = c(str: "filename", int: dim_x, int: dim_y)`. See example `3`.

If there are too many paths, you can only take a proportion of `float: n_sample` of them as an argument. When doing so, a list of the randomly selected ids from the precision matrix elements is returned. You can pass it as the `list[numeric]: idx` argument to the next path function to plot only those elements for comparison. See example `5`. 


## Examples 
![Example regularization paths comparison](/src/figures/example.png)
See `src/examples.R` for examples.

```R
# 1. Basic
plot_reg_path(l1.glasso)

# 2. Style the plot as you wish 
plot_reg_path(l1.glasso, main="Regularization paths")

# 3. Save the plot
save_params <- c("glasso_reg_paths", 10, 10)
plot_reg_path(l1.glasso, save = save_params, 
              main = "Regularization paths", 
              xlab = expression(lambda), ylab = "Coefficient")

# 4. Compare paths with the two methods by overwriting `par` parameter
par(mfrow=c(1,2))
plot_reg_path(l1.glasso, par = FALSE,
              main = "Glasso", 
              xlab = expression(lambda), ylab = "Coefficient")
plot_reg_path(l1.npn, par = FALSE,
              main = "NPN", 
              xlab = expression(lambda), ylab = "Coefficient")

# 5. Only select a subsample of paths of proportion n_sample
par(mfrow=c(1,2))
idx_1 <- plot_reg_path(l1.glasso, par = FALSE,
              main = "Glasso", 
              n_sample = 0.5)
plot_reg_path(l1.npn, par = FALSE,
              main = "NPN", 
              idx = idx_1)
```

### Misc
* `type = cairo` is used for the png driver for smoother rendering when saving figures. Change that if it causes problem. 