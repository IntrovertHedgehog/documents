# load the libraries
library(simmer)
library(simmer.plot)
library(triangle)

# build the trajectory of students
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
             log_("I am timid/tired... leaving!: "))
  ) %>%
  log_("I shall join the queue and talk to a MalWart recruiter") %>%
  seize("MalWart") %>%
  timeout(function() rexp(1, 1/3)) %>%
  release("MalWart") %>%
  log_("I am done chatting with MalWart recruiter, now joining the queue and talk to a JHBunt recruiter") %>%
  seize("JHBunt") %>%
  timeout(function() rexp(1, 1/6)) %>%
  release("JHBunt") %>%
  log_("I am leaving!: ")

# Slide 4: Multiple Replications
set.seed(2909)
mm2.envs  <- replicate(50, 
  simmer("mixer") %>%
  add_resource("MalWart", capacity = 2) %>%
  add_resource("JHBunt", capacity = 3) %>%
  add_generator("Student", student, function() rexp(1, 1/2), mon = 2) %>% 
    run(until = 360) %>% wrap())

# Slide 5: Target Outcomes
mon_resources <- get_mon_resources(mm2.envs)
mon_arrivals <- get_mon_arrivals(mm2.envs)
mon_attributes <- get_mon_attributes(mm2.envs)

# Slide 6: Monitor the Resources Data
knitr::kable(head(mon_resources))

# the actual one used in the slide 6
knitr::kable(head(mon_resources)[,-6])
   
# Slide 7: Monitor the Arrivals Data
knitr::kable(head(mon_arrivals))

# Slide 8: Monitor the Arrivals Data (cont'd)
mon_arrivals_sub <- get_mon_arrivals(mm2.envs, per_resource = TRUE)
knitr::kable(head(mon_arrivals_sub))

# Slide 9: Monitor the Attributes Data
knitr::kable(tail(mon_attributes))

# Slide 10: Visualise the Resources Data
plot(mon_resources, metric="usage", items=c("queue", "server"), 
     limits=FALSE) 

# Slide 11: Visualise the Resources Data (cont'd)
plot(mon_resources[mon_resources$replication == 1, ], items=c("queue", "server"), 
     limits=FALSE)

# Slide 12: Visualise the Resources Data (cont'd)
plot(mon_resources[mon_resources$replication == 1, ], items=c("queue", "server"), 
     limists = FALSE, step = TRUE)

# Slide 13: Visualise the Resources Data (cont'd)
plot(mon_resources, metric="utilization")

# Slide 15: Waiting Time at Booths

# Extract waiting time at booths
ave_wait_time <- function(df) {
  mean(df$end_time - df$start_time - df$activity_time)
}
# Split the data frames into mutiple lists based on the replication
# numbers 
s_out <- split(mon_arrivals, ~replication)
# calculate the mean waiting time for each replication
w_vec <- sapply(s_out, ave_wait_time) 

mean(w_vec)

# Slide 16: Waiting Time at Booths
hist(w_vec)
abline(v = mean(w_vec), col = "red", lwd = 3)

# Slide 17: Waiting Time at Booths
## calculate the standard normal-based 95% confidence interval

summary(w_vec)
ci_95 <- c(mean(w_vec) + qnorm(0.025)*sd(w_vec)/sqrt(length(w_vec)),  
           mean(w_vec) - qnorm(0.025)*sd(w_vec)/sqrt(length(w_vec)))
ci_95

