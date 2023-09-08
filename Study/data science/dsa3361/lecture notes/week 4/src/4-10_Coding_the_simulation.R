# Slide 3: Learning Objectives

# Slide 4: Libraries used
library(simmer)
library(simmer.plot)
library(triangle)
set.seed(2909)

# Slide 5: 

# Slide 6: Student trajectory
student <-
  trajectory("Student") %>%
  log_("Here I am") %>%
  timeout(function() {runif(1, min=20/60, max=45/60)}) %>%
  log_("I have affixed my name tag!") %>%
  set_attribute("type",1) %>%
  branch(function() runif(1) < 0.5, continue = TRUE,
         trajectory() %>%
           timeout(function() {rtriangle(1, 10, 45, 15)}) %>%
           set_attribute("type",2) %>%
           branch((function() runif(1) < 0.1), continue = FALSE,
                  trajectory() %>%
                    set_attribute("type",3) %>%
                    log_(function() {paste("I am timid/tired... leaving!: ", now(mixer))}))
  ) %>%
  log_("I shall join the queue and talk to a MalWart recruiter") %>%
  seize("MalWart") %>%
  timeout(function() rexp(1, 1/3)) %>%
  release("MalWart") %>%
  log_("I am done chatting with MalWart recruiter, now joining the queue and talk to a JHBunt recruiter") %>%
  seize("JHBunt") %>%
  timeout(function() rexp(1, 1/6)) %>%
  release("JHBunt") %>%
  log_(function() {paste("I am leaving!: ", now(mixer))})

# Slide 7: Student trajectory
# The code shown in this slide is a truncated version of the above

# Slide 8: Student trajectory
# The code shown in this slide is a truncated version of the above

# Slide 9: Visualising trajectory
library(DiagrammeRsvg)
library(rsvg) 
library(scales)

get_palette <- brewer_pal(type = "qual", 
                          palette = 1)
plot(student, fill = get_palette)

# output to png
plot(student, fill = get_palette) %>%
  export_svg() %>%
  charToRaw %>% 
  rsvg_png('flow.png')

# Slide 10: A single replication
mixer <-
  simmer("mixer") %>%
  add_resource("MalWart", capacity = 2) %>%
  add_resource("JHBunt", capacity = 3) %>%
  add_generator("Student", student, function() rexp(1, 1/2), 
                 mon = 2)

mixer %>% run(until = 60)

# Slide 11: Multiple replications
mm1.envs  <- replicate(10, 
  simmer("mixer") %>%
  add_resource("MalWart", capacity = 2) %>%
  add_resource("JHBunt", capacity = 3) %>%
  add_generator("Student", student, function() rexp(1, 1/2), 
                    mon = 2) %>% 
    run(until = 360) %>% wrap() 
  )

# Slide 12: Summary

