library(simmer)
library(simmer.plot)

#-----------------------------------------------------------------------------
# 6-1
bank <- simmer("bank")

customer <- trajectory("customer") %>% 
  log_("Arriving..") %>% 
  seize("counter") %>% 
  timeout(function() rexp(1, rate=2.1)) %>% 
  release("counter") %>%
  log_("Departing now...")

plot(customer)

set.seed(11)
bank %>% add_generator("Cust.", customer, 
                       distribution= function() rexp(1, rate=2)) %>% 
  add_resource("counter", 1) %>% 
  run(until=8)

plot(get_mon_resources(bank), metric="usage")

#------------------------------------------------------------------------
single_rep <- function() {
  bank <- simmer("bank")
  
  customer <- trajectory("customer") %>% 
    log_("Arriving..") %>% 
    seize("counter") %>% 
    timeout(function() rexp(1, rate=2.1)) %>% 
    release("counter") %>%
    log_("Departing now...")
  
  bank %>% add_generator("Cust.", customer, 
                         distribution= function() rexp(1, rate=2)) %>% 
    add_resource("counter", 1) %>% 
    run(until=8) %>% wrap()
}

set.seed(11)
bank_list <- replicate(100, single_rep())

all_arrivals <- get_mon_arrivals(bank_list, ongoing=TRUE)
head(all_arrivals)
tail(all_arrivals)

# Notice that the customer 11 has his/her start time at -1, which 
# marks the end of the simulation. 

arr_times <- all_arrivals$start_time[all_arrivals$start_time > 0]
hist(arr_times, main="Histogram of arrival times")

length(arr_times)/100  # the mean number of customers per replication

#------------------------------------------------------------------------
plot_hist <- function(df) {
  df_1 <- df$start_time[df$start_time > 0]
  hist(df_1, main = "Histogram of arrival times")
}
s_out <- split(all_arrivals, ~replication)

# The following is to plot 100 histograms for those replications
# w_vec <- sapply(s_out, plot_hist)

# Let us randomly pick 9 replications and plot the relevant histograms

sample1 <- sample(100, 9)

par(mfrow=c(3,3))

w_vec <- sapply(sample1, function(i) plot_hist(s_out[[i]]))

par(mfrow=c(1,1))

# As can be seen in the chart, the distribution of the arrival times
# for each replication is not close to uniform distribution, indicating
# a high variance.

num_cust <- function(df) {
  df_1 <- df$start_time[df$start_time > 0]
  length(df_1)
}
w_vec2 <- sapply(s_out, num_cust)
w_vec2  # the number of customers for 100 replications

hist(w_vec2) 
summary(w_vec2)  # the mean is 15.84

#--------------------------------------------------------
# To calculate the number of customers who arrived before 8 mins 
# for each replication.

# Approach 1: (shown above)
s_out <- split(all_arrivals, ~replication)
num_cust <- function(df) {
  df_1 <- df$start_time[df$start_time > 0]
  length(df_1)
}
w_vec2 <- sapply(s_out, num_cust)
w_vec2[1:10]

# Approach 2:
library(dplyr)
all_arrivals %>% filter(start_time > 0) %>%
                group_by(replication)   %>%
                summarise(num_cust = length(start_time))

#--------------------------------------------------------
# Simmer Code (Non-constant arrivals)

lam_fn <- function(x) {
  if(x <= 4) {
    return(2)
  } else if (x <= 5){
    return(6)
  } else {
    return(2)
  }
}

lam_fn(3.4)

lam_fn(c(3.4, 4.1, 4.2, 7.6))  # why this does not work?

l2 <- Vectorize(lam_fn)
# test the function:
l2(c(3.4, 4.1, 4.2, 7.6))

ihpp <- function (lambda_fn, lambda_bound, end_time) {
  # lambda_fn is a function, which specifies the intensity at different
  # times; lambda_bound is the maximal intensity.
  x_vec <- NULL
  x <- 0
  while (TRUE) {
    U <- runif(1)
    x <- x - (1/lambda_bound) * log(U)
    if (x > end_time) 
      break
    V <- runif(1)
    ratio1 <- lambda_fn(x)/lambda_bound
    if (V <= ratio1) 
      x_vec <- c(x_vec, x)
  }
  x_vec
}

set.seed(11)
ihpp(lam_fn, 6, 8)

set.seed(11)
ihpp(l2, lambda_bound = 6, end_time = 8)

# It is not surprising that lam_fn and l2 work the same way here.

single_rep2 <- function() {
  arr_times <- ihpp(lambda_fn = l2, lambda_bound = 6, end_time = 8)
  bank <- simmer("bank")
  
  customer <- trajectory("customer") %>% 
    log_("Arriving..") %>% 
    seize("counter") %>% 
    timeout(function() rexp(1, rate=2.1)) %>% 
    release("counter") %>%
    log_("Departing now...")
  
  bank %>% add_generator("Cust.", customer, distribution= at(arr_times)) %>% 
    add_resource("counter", 1) %>% 
    run(until=8) %>% wrap()
}

set.seed(11)
bank_list2 <- replicate(100, single_rep2())

all_arrivals2 <- get_mon_arrivals(bank_list2, ongoing=TRUE)
arr_times <- all_arrivals2$start_time[all_arrivals2$start_time > 0]
hist(arr_times, main="Histogram of arrival times")

#-----------------------------------------------------------------------------
# 8-2

insurance_env <- simmer() %>% 
  add_global("a0", 3500) %>% 
  add_global("p0", .5)

m4 <- trajectory("policyholder") %>% 
  log_("Policy begins..") %>% 
  set_attribute("dep_time", values = function() now(insurance_env) + rexp(1, rate=1/20)) %>% 
  set_attribute("tt_next_claim", values = function() rexp(1, rate=1)) %>% 
  branch(function() {
    attribs <- get_attribute(insurance_env, c("dep_time", "tt_next_claim"))
    if(attribs[1] < now(insurance_env) + attribs[2]){
      return (1) # depart sub-trajectory
    } else {
      return (2) # claim sub-trajectory
    }
  }, continue=FALSE,
  trajectory() %>%   # depart sub-trajectory
    set_attribute("premium_time", 
                  function() get_attribute(insurance_env, "dep_time") - now(insurance_env)) %>% 
    timeout(function() get_attribute(insurance_env, "premium_time")) %>% 
    log_("Processing premiums") %>%
    set_global("a0", 
               function() get_global(insurance_env, "p0")*get_attribute(insurance_env, "premium_time"), 
               mod="+") %>% 
    log_("Ending policy.."),
  trajectory() %>%   # claim sub-trajectory
    timeout(function() get_attribute(insurance_env, "tt_next_claim")) %>% 
    log_("Processing premiums") %>%
    set_global("a0", function() 
      get_global(insurance_env, "p0")*get_attribute(insurance_env, "tt_next_claim"), mod="+") %>% 
    log_("Processing claim") %>% 
    set_global("a0", function() -rgamma(1, 10, 1.5), mod="+") %>% 
    rollback(7, Inf)
  ) 

plot(m4)

n0 <- 5
set.seed(41)
insurance_env %>% 
  add_generator("initial_holder", m4, at(rep(0, n0)), mon=2) %>%
  add_generator("new_holder", m4, function() rexp(1, 3), mon=2) %>% 
  run(until=24)

get_attributes <- get_mon_attributes(insurance_env)
head(get_attributes)
tail(get_attributes)

# check how many attributes
unique(get_attributes$key)

# a0 and p0 are global attributes
# dep_time, tt_next_claim and premium_time are local attributes, or,
# entity-specific attributes, namely, they are associated to some
# policy holders.

# Let us check how a0 changes over time

get_a0 <- get_attributes[get_attributes$key == "a0",]
any(get_a0$value < 0)   # is there any negative a0 ?
tail(get_a0)

neg_set <- which(get_a0$value <= 0)
summary(neg_set)
get_a0[c(1149,1150,1151),]

# By 21.2 months, we run out of money in our pool. 

# Alternatively, we could do the following:
library(dplyr)
filter(get_attributes, key == "a0") %>% 
  filter(value < 0) %>% 
  arrange(time) %>% head()

# Next, let us check how many policy holders are there

get_arrivals <- get_mon_arrivals(insurance_env)
str(get_arrivals)
sort(unique(get_arrivals$name))

# There are 4 initial holders and 31 new holders who finished the 
# contracts and did not continue by the time of 24 months. 

# Q: How many policy holders joined the company by 24 months? 

n <- 4
check_iniholder <- get_attributes[get_attributes$name == paste("initial_holder", n, sep = ""),]
check_iniholder

n <- 30
check_newholder <- get_attributes[get_attributes$name == paste("new_holder", n, sep = ""),]
check_newholder

# Q: What is the difference between the above two customers?

# Feel free to change the parameters (i.e., rates) and re-run the model.

#-------------------------------------------------------------------
# 8-3

repair_env <- simmer() %>%
  add_global("S", 3) %>%  # 3 spares at the beginning
  add_global("CRASH", 0)  # 0 means not crash; 1 means crash

m2 <- trajectory("station") %>% 
  log_("Starting work now..") %>% 
  timeout(function() runif(1, 5, 20)) %>% 
  branch(function() {
    num_spares <- get_global(repair_env, "S")
    crashed_status <- get_global(repair_env, "CRASH")
    if(num_spares > 0) {
      return(0)  # Still get some spare to replace the ill-functioning one
    } else if (crashed_status == 0) {
      return(1)   # No more spare, and claim a CRASH
    } else {
      return(2)   # Already crashed
    }
  }, continue = c(FALSE, FALSE),
  trajectory() %>%  
    set_global("crash_time", function() now(repair_env)) %>%  
    set_global("CRASH", 1) %>% 
    log_("Just crashed.. no more spares.. shutting down."),
  trajectory() %>%  
    log_("No more spares.. shutting down.")
  )  %>% 
  set_global("S", -1, mod="+") %>% 
  clone(n=2, 
        trajectory() %>% 
          log_("Going for repair now") %>%  
          seize("repairman") %>%  
          timeout(function() runif(1, 2, 6)) %>% 
          release("repairman") %>%  
          branch(function() {get_global(repair_env, "CRASH") != 1}, 
                 continue = TRUE,
                 trajectory() %>% set_global("S", 1, mod="+")) %>% 
          # the above branch is only to update spares' number when 
          # the system has not crashed yet. 
          log_("finished repair"),
        trajectory() %>% 
          log_("Re-starting with replacement") %>% 
          rollback(amount = 5, times=Inf)
  )

plot(m2)

set.seed(15)
repair_env %>% 
  add_generator("M", m2, at(rep(0, 10)), mon=2)  %>% 
  add_resource("repairman", capacity = 1) %>% 
  run()

get_global(repair_env, "crash_time") # Compare with the logs

mon_resources <- get_mon_resources(repair_env)
mon_arrivals <- get_mon_arrivals(repair_env)
mon_attributes <- get_mon_attributes(repair_env)

mon_resources

mon_arrivals

# Q: from the arrivals table, why did M1 appear at two different rows?

mon_attributes

# Q: Vary the spares part from 1 to 5, as well as the repairmen 
# from 1 to 4, and run 10 replications for each combination. 
# Find the maximum crash time based on these combinations. 
# In other words, we want the system well operating as long as possible.
