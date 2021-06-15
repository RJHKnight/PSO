# library(tidyverse)
# library(plotly)
#
# res_wide <- res %>%
#   select(-best_position, -velocity ) %>%
#   pivot_wider(names_from = dimension, names_prefix = "dimension_", values_from = position) %>%
#   rowwise() %>%
#   mutate(z = goldstein_and_price(c(dimension_1, dimension_2))) %>%
#   ungroup()
#
#
# range <- seq(0,6000, by = 100)
# grid <- expand.grid(x = range, y = range)
# grid$z <- apply(grid, 1, goldstein_and_price)
# grid_z <- pivot_wider(grid, names_from = x, values_from = z) %>%
#   select(-y) %>%
#   as.matrix()
#
#
# num_it <- max(res_wide$iteration)
# grid_full <- do.call("rbind", replicate(num_it, grid, simplify = FALSE))
# grid_full$iteration <- rep(1:nrow(grid), each = num_it)
#
# fig <- res_wide %>%
#   plot_ly(x = ~dimension_1, y = ~dimension_2, frame = ~iteration,
#           type = 'scatter',
#           mode = 'markers',
#           showlegend = F) %>%
#   add_markers() %>%
#   add_contour(x = grid$x, y=grid$y, z=~grid_z, frame = 1)
#
# fig
