sample_size_solution <- function(sigma, E, confidence_level) {
  
  if (!is.numeric(sigma) || length(sigma) != 1 ||
      !is.finite(sigma) || sigma <= 0) {
    stop("sigma must be a positive number.")
  }
  
  if (!is.numeric(E) || length(E) != 1 ||
      !is.finite(E) || E <= 0) {
    stop("E (Error Bound) must be a positive number.")
  }
  
  if (!is.numeric(confidence_level) ||
      length(confidence_level) != 1 ||
      !is.finite(confidence_level)) {
    stop("Invalid confidence level.")
  }
  
  if (confidence_level <= 0 ||
      confidence_level >= 1) {
    stop("Confidence level must be between 0 and 1.")
  }
  
  CL <- confidence_level
  alpha <- 1 - CL
  alpha2 <- alpha / 2
  p <- 1 - alpha2
  
  zcrit <- qnorm(p)
  
  n_calc <- (zcrit * sigma / E)^2
  
  n_final <- ceiling(n_calc)
  
  f <- function(x) {
    round(x, 4)
  }
  
  steps <- list(
    
    # Title
    "Sample Size Calculation Solution",
    
    "Step 1:",
    
    expression(
      n == bgroup("(", frac(z[frac(alpha, 2)] ~ "\u00b7" ~ sigma, E), ")")^2
    ),
    
    "Step 2:",
    
    bquote(
      paste(
        1 - alpha == .(CL),
        ",   ",
        sigma == .(sigma),
        ",   ",
        E == .(E)
      )
    ),
    
    "Step 3:",
    
    bquote(
      "a.  " ~ 1 - alpha == .(CL)
    ),
    
    bquote(
      "b.  " ~ 1 - frac(alpha, 2) == frac(1 + .(CL), 2) ~ "=" ~ .(f(p))
    ),
    
    bquote(
      "c.  " ~ z[frac(alpha, 2)] == phi^-1 * bgroup("(", 1 - frac(alpha, 2), ")") ~ "=" ~ "qnorm(" * .(f(p)) * ")" ~ "=" ~ .(f(zcrit))
    ),
    
    "Step 4:",
    
    bquote(
      n == bgroup("(", frac(.(f(zcrit)) ~ "\u00b7" ~ .(sigma), .(E)), ")")^2
    ),
    
    bquote(
      n == .(f(n_calc))
    ),
    
    "Result: Always Round Up (Ceiling)",
    
    bquote(
      therefore ~ n == .(n_final)
    )
    
  )
  
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))
  
  par(
    mar = c(1, 1, 2, 1),
    family = "sans"
  )
  
  total <- length(steps)
  
  plot.new()
  
  plot.window(
    xlim = c(0, 1),
    ylim = c(0, total + 1)
  )
  
  y <- rev(seq_len(total))
  
  headings <- c(
    "Step 1:",
    "Step 2:",
    "Step 3:",
    "Step 4:",
    "Result: Always Round Up (Ceiling)"
  )
  
  for (i in seq_along(steps)) {
    
    item <- steps[[i]]
    
    if (i == 1) {
      
      text(
        x = 0.5,
        y = y[i],
        labels = item,
        cex = 1.15,
        font = 2
      )
      
    } else if (
      is.character(item) &&
      item %in% headings
    ) {
      
      text(
        x = 0.03,
        y = y[i],
        labels = item,
        adj = 0,
        cex = 0.85,
        font = 2,
        col = "#185ABC"
      )
      
    } else if (is.character(item)) {
      
      # Descriptive text
      text(
        x = 0.08,
        y = y[i],
        labels = item,
        adj = 0,
        cex = 0.75
      )
      
    } else {
      
      text(
        x = 0.08,
        y = y[i],
        labels = item,
        adj = 0,
        cex = 0.90
      )
      
    }
  }
  
  invisible(
    list(
      sigma = sigma,
      E = E,
      confidence_level = CL,
      alpha = alpha,
      alpha2 = alpha2,
      z_critical = zcrit,
      n_calculated = n_calc,
      n_rounded_up = n_final
    )
  )
}

# Example usage:
sample_size_solution(
  sigma = 2,
  E = 0.5,
  confidence_level = 0.99
)
