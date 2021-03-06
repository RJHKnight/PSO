# Only for 2d optimization.
#' @import ggplot2
#' @export
plot_pso <- function(value_function, min_value, max_value, full_results)
{

  range <- seq(min_value, max_value, by  = (max_value - min_value) / 200)
  value_function_base = expand.grid(x = range, y = range)
  value_function_base <- value_function_base %>%
    rowwise %>%
    dplyr::mutate(value = value_function(c(x, y))) %>%
    dplyr::ungroup()

  points <- res %>%
    dplyr::select(particle_id, position, dimension, iteration) %>%
    tidyr::pivot_wider(names_from = dimension, values_from = position, names_prefix = "dimension_")

  ggplot(value_function_base, aes(x,y)) +
    geom_raster(aes(fill = value)) +
    scale_x_continuous(limits = c(min_value, max_value)) +
    scale_y_continuous(limits = c(min_value, max_value)) +
    geom_point(data = points, aes(dimension_1 , dimension_2)) +
    gganimate::transition_states(iteration,
                      transition_length = 3,
                      state_length = 1) +
    theme_bw()
}
