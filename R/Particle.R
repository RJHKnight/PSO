
#' @import dplyr
pso <- function(value_function, num_dimensions,
                min_value, max_value,
                num_iterations = 100,
                swarm_size = 50,
                w_damping = TRUE,
                return_full = FALSE)
{
  initial_particles <- get_initial_particles(min_value, max_value, num_dimensions, swarm_size, value_function)
}


# Creates an data.frame with position set to uniform random values, velocities set to zero
# and best values and costs set to their initial values.
get_initial_particles <- function(min_value, max_value, num_dimensions, swarm_size, value_function)
{
  initial <- expand.grid(
    dimension = 1:num_dimensions,
    particle_id = 1:swarm_size) %>%
    mutate(
    position = runif(num_dimensions * swarm_size, min = min_value, max = max_value),
    velocity = 0,
    best_position = 0,
    best_cost = Inf,
    iteration = 0
  )

  initial <- calculate_cost_and_update(initial, value_function)

  return (initial)
}


# Apply the value function to get the result of the current cost. If this cost is better than
# the particles previous best, update the best columns.
calculate_cost_and_update <- function(positions, value_function)
{
  current_cost <- positions %>%
    group_by(particle_id) %>%
    summarise(current_cost = value_function(position))

  return (
    positions %>%
      left_join(current_cost, by = "particle_id") %>%
      mutate(
        best_position = if_else(current_cost < best_cost, position, best_position),
        best_cost = if_else(current_cost < best_cost, current_cost, best_cost)
      ) %>%
      select(-current_cost)
  )
}
