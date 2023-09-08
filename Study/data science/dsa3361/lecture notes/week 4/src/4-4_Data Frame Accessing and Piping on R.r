# Slide 3: Learning Objectives

# Slide 4: 

# Slide 5: Data frame accessing through \texttt{mtcars} example
mtcars

# Slide 6: Data frame accessing through \texttt{mtcars} example
library(tibble)
as_tibble(mtcars)

# Slide 7: Data frame accessing through \texttt{mtcars} example

# Slide 8: Data frame accessing through \texttt{mtcars} example
tibble(-2909,1507,0.610,0.2216)

# Slide 9: Data frame accessing through \texttt{mtcars} example
mtcars$mpg

# Slide 10: Data frame accessing through \texttt{mtcars} example
mtcars$hp / mtcars$wt

# Slide 11: 

# Slide 12: Pipe operator \texttt{\%\textgreater{}\%}

# Slide 13: Pipe Operator \texttt{\%\textgreater{}\%}
# The follow codes are for illustrative purposes only; you will only run them in
# a later video

bank %>% run(until = 1000)
run(bank, until = 1000)

# Slide 14: Pipes and Readable Code
trajectory %>% seize( ...  ) %>% timeout( ... ) %>% release( ... ) 
trajectory %>% 
  seize( ...  ) %>% 
  timeout( ... ) %>% 
  release( ... ) %>% 
  log_( ... )

# Slide 15: Pipes and Readable Code
temp1 <- seize(trajectory, ... )
temp2 <- timeout(temp1, ... )
temp3 <- release(temp2, ... )
temp4 <- log_(temp3, ... )
trajectory %>% 
  seize( ...  ) %>% 
  timeout( ... ) %>% 
  release( ... ) %>% 
  log_( ... )

# Slide 16: Summary

