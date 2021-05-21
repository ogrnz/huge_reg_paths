# Functions file

plot_reg_path <-
    function(estim, n_sample = FALSE, idx = NULL, par = TRUE, save = NULL, ...) {
        # Plot regularization paths of `huge` object
        # See https://github.com/ogrnz/huge_reg_paths for more details.
        #
        # Change the FIG_PATH constant.
        # `estim` is an object from the `huge` package.
        # If `n_sample` == FALSE: plot all paths.
        # If `n_sample` is numeric: plot `n_sample`*`n_edges` random paths.
        #   When using the above parameter, the ids of the plotted paths
        #   are returned and should be passed as the `idx` argument in order
        #   to get the same paths to be able to compare a second estimator.
        # If `par` == FALSE, do not overwrite the plot layout.
        # If `save` is defined, a list containing the following elements 
        #   must be passed: 
        #   c(str: "filename", int: dim_x, int: dim_y)
        #   A figure of dimensions dim_x*dim_y in cm in will be saved 
        #   under "figures/filename.png".
        
        FIG_PATH <- "./figures/"
        
        if (!is.null(save)) {
            filename <- save[1]
            dim_x <- as.numeric(save[2])
            dim_y <- as.numeric(save[3])
            
            png(paste0(FIG_PATH, filename, ".png"), res=800, pointsize=10, 
                width=dim_x, height=dim_y, units="cm", type = "cairo")
        }
        
        if (class(par) == "numeric") {
            par(mfrow = par)
        }
        else {
            if(par){
                par(mfrow = c(1, 1)) 
            }
        }
        
        icov <- estim$icov
        
        if (is.null(icov)) {
            stop("NULL precision matrix, did you use glasso method?")
        }
        
        n_feat <- dim(icov[[1]])[1]
        #n(n-1)/2 total edges
        n_edges <- n_feat * (n_feat - 1) / 2
        n_lambda <- length(estim$lambda)
        
        # Create empty matrix
        paths <- matrix(ncol = n_lambda, nrow = n_edges)
        
        # Take each element of the matrix and store
        # its evolution over each lambda
        for (l in seq(n_lambda)) {
            mat <- icov[[l]]
            uptri <- mat[upper.tri(mat)]
            paths[, l] <- uptri
        }
        
        # Plot the paths
        if (n_sample) {
            idx = sample(1:n_edges, n_sample * n_edges, replace = F)
        }
        else if (!is.null(idx)) {
            idx = idx
        }
        else{
            idx = seq(n_edges)
        }
        
        # Initialize empty plot
        plot(estim$lambda, rep(0, n_lambda), type = "l", ...)
        for (edge in idx) {
            lines(estim$lambda, paths[edge, ])
        }
        
        if (!is.null(save)) {
            dev.off()
        }
        
        # If `n_sample` is defined, return the plotted paths ids
        if (n_sample) {
            return(idx)
        }
        
    }
