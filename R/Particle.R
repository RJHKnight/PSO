
#' @import dplyr
#' @export
pso <- function(value_function, num_dimensions,
                min_value, max_value,
                num_iterations = 100,
                swarm_size = 50,
                w_damping = TRUE,
                return_full = FALSE)
{

  particles <- get_initial_particles(min_value, max_value, num_dimensions, swarm_size, value_function)
  global_best <- calc_global_values(particles)
  w <- 1

  if (return_full)
  {
    all_values <- particles
  }

  for (i in 1:num_iterations)
  {
    particles <- update(particles, global_best, value_function, w, 2, 2)
    global_best <- calc_global_values(particles)

    if (w_damping)
    {
      w <- w * 0.99
    }

    if (return_full)
    {
      all_values <- rbind(all_values, particles)
    }

    cat(paste("Iteration", i, "global_best_cost:", format(global_best$global_best_cost[1]), "\n"))
  }

  if (return_full)
    return (all_values)

  return (global_best)
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
# the previous best, update the best columns.
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

calc_global_values <- function(particles)
{
  particles %>%
    filter(best_cost == min(best_cost)) %>%
    select(dimension, best_position, best_cost) %>%
    rename(global_best_position = best_position,
           global_best_cost = best_cost)
}


update <- function(particles, global_best, value_function, w, c1, c2)
{
  particles <- particles %>%
    # Add global best
    left_join(global_best, by = "dimension") %>%
    # Prepare the random numbers
    mutate(r1 = runif(n()), r2 = runif(n())) %>%
    # Calculate the new velocity
    mutate(
      velocity = w * velocity +                        # Inertia
        c1 * r1 * (best_position - position) +         # Personal Best
        c2 * r2 * (global_best_position - position)    # Social Best
    ) %>%
    mutate(position = position + velocity) %>%
    select(-contains("global"), -r1, -r2) %>%
    mutate(iteration = iteration + 1)

  particles <- calculate_cost_and_update(particles, value_function)

  return (particles)
}
