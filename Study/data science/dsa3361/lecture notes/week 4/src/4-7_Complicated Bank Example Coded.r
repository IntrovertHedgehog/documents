library(simmer)

# Slide 3: Learning Objectives

# Slide 4: 

# Slide 5: Simulations with \texttt{simmer} package

# Slide 6: Scenario 1

# Slide 7: Scenario 1

# Slide 8: Scenario 1
set.seed(2909)
task_duration <- function() 
                     {rexp(n = 1, rate = 1/12)}

customer <-
  trajectory("Customer's path") %>%
  log_("I arrived!") %>%
  timeout(task = task_duration) %>%
  log_(function() {paste("I finished at", now(bank))})

gen_arrivals <- function() 
             {c(rexp(n = 50, rate = 1/10), -1)}
                    
bank <-
  simmer("bank") %>%
  add_generator(name_prefix = "Customer", 
                trajectory = customer, 
                distribution = gen_arrivals)

bank %>% run(until = 1000)

# Slide 9: Scenario 1

# Slide 10: Scenario 2

# Slide 11: Scenario 2
set.seed(2909)
task_duration <- function() {rexp(n = 1, rate = 1/12)}
curr_time <- function() {now(bank)}

customer <-
  trajectory("Customer's path") %>%
  log_("I arrived!") %>%
  set_attribute("start_time", curr_time) %>%
  seize("Counter") %>%
  log_(function() {paste("I waited for", 
   now(bank) - get_attribute(bank, "start_time"))}) %>%
  timeout(task = task_duration) %>%
  release("Counter") %>%
  log_(function() {paste("I finished at", now(bank))})

# Slide 12: Scenario 2
gen_arrivals <- function() 
              {c(rexp(n = 50, rate = 1/10), -1)}
                    
bank <-
  simmer("bank") %>%
  add_resource("Counter", capacity = 1) %>%
  add_generator(name_prefix = "Customer", 
                trajectory = customer, 
                distribution = gen_arrivals)

bank %>% run(until = 1000)

# Slide 13: Scenario 2

# Slide 14: Scenario 3a

# Slide 15: Scenario 3a
set.seed(2909)
task_duration <- function() {rexp(n = 1, rate = 1/12)}
curr_time <- function() {now(bank)}

customer <-
  trajectory("Customer's path") %>%
  log_("I arrived!") %>%
  set_attribute("start_time", curr_time) %>%
  seize("Counter") %>%
  log_(function() {paste("I waited for", 
   now(bank) - get_attribute(bank, "start_time"))}) %>%
  timeout(task = task_duration) %>%
  release("Counter") %>%
  log_(function() {paste("I finished at", now(bank))})


# Slide 16: Scenario 3a
gen_arrivals <- function() 
              {c(rexp(n = 50, rate = 1/10), -1)}
                    
bank <-
  simmer("bank") %>%
  add_resource("Counter", capacity = 2) %>%
  add_generator(name_prefix = "Customer", 
                trajectory = customer, 
                distribution = gen_arrivals)

bank %>% run(until = 1000)

# Slide 17: Scenario 3a

# Slide 18: Scenario 3b

# Slide 19: Scenario 3b
set.seed(2909)
task_duration <- function() {rexp(n = 1, rate = 1/12)}
curr_time <- function() {now(bank)}

customer <-
  trajectory("Customer's path") %>%
  log_("I arrived!") %>%
  set_attribute("start_time", curr_time) %>%
  select(c("Counter 1", "Counter 2"), 
          policy = "random") %>%
  seize_selected() %>%
  log_(function() {paste("I waited for", 
   now(bank) - get_attribute(bank, "start_time"))}) %>%
  timeout(task = task_duration) %>%
  release_selected() %>%
  log_(function() {paste("I finished at", now(bank))})

# Slide 20: Scenario 3b
gen_arrivals <- function() 
              {c(rexp(n = 50, rate = 1/10), -1)}
                    
bank <-
  simmer("bank") %>%
  add_resource("Counter 1", capacity = 1) %>%
  add_resource("Counter 2", capacity = 1) %>%
  add_generator(name_prefix = "Customer", 
                trajectory = customer, 
                distribution = gen_arrivals)

bank %>% run(until = 1000)

# Slide 21: Scenario 3b

# Slide 22: 

# Slide 23: Data-informed decision-making

# Slide 24: Summary

