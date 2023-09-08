# Slide 3: Learning Objectives

# Slide 4: 

# Slide 5: Introduction
library(simmer)

# Slide 6: 

# Slide 7: The \emph{Entity} code chunk
customer <-
  trajectory("Customer's path") %>%
  seize("counter") %>%
  timeout(12) %>%
  release("counter")

# Slide 8: Advance use of \texttt{timeout} function
task_duration <- function() {rexp(n = 1, rate = 1/12)}

customer <-
  trajectory("Customer's path") %>%
  log_("I arrived!") %>%
  timeout(task = task_duration)
  

# Slide 9: The \emph{Resource} code chunk
bank <-
  simmer("bank") %>%
  add_resource(name = "counter") %>%
  add_generator(name_prefix = "Customer", trajectory = customer,
                 distribution = at(0))


# Slide 10: The \emph{Resource} code chunk
#  add_resource("counter", capacity = 1, queue_size = 1)

# Slide 11: The \emph{Resource} code chunk
#  add_generator(name_prefix = "Customer", trajectory = customer,
#                 distribution = at(0))

# Slide 12: The \emph{Simulation} code chunk
bank %>% run(until = 100)

# Slide 13: The \texttt{log\_} funtion

# Slide 14: The \texttt{log\_} funtion
customer <-
  trajectory("Customer's path") %>%
  log_("I arrived!") %>%
  seize("counter") %>%
  timeout(12) %>%
  release("counter") %>%
  log_(function() {paste("I finished at", now(bank))})
  

# Slide 15: Summary

# Slide 16: References

