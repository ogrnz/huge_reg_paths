# Examples
library(huge)
source("reg_paths.R")

# Generate data
l1 <- huge.generator(n = 50, d = 12)

# Fit the data with classical glasso
l1.glasso <- huge(l1$data, method = "glasso")

# Fit the other with the nonparanormal method
npn <- huge.npn(l1$data)
l1.npn <- huge(npn, method = "glasso")

# 1. Basic
plot_reg_path(l1.glasso)

# 2. Style the plot as you wish 
plot_reg_path(l1.glasso, main="Regularization paths")

# 3. Save the plot
save_params <- c("glasso_reg_paths", 10, 10)
plot_reg_path(l1.glasso, save = save_params, 
              main = "Regularization paths", 
              xlab = expression(lambda), ylab = "Coefficient")

# 4. Compare paths with the two methods by overwriting par parameter
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
