##################################################
### SIR simulations Gillespie
###################################################
######################################################################
# Author: Gilles Kratzer <gilles.kratzer@gmail.com>
# Info: 
#
# History 
# -- 08/04/2015 File created
# -- 21/08/2015 Functionalization/speedup code
######################################################################
#Paramers:
# parms
# - m : birth and death rate in the compartemnts
# - b : force of infection
# - v : (additional) death rate due to infection
# - r : recovery rate
# X0 : initial state (S, I, R)
# Time.window : (min, max)
# processes : a 7x3 matrix
# - "birth"
# - "death.S"
# - "death.I"
# - "death.R"
# - "infection"
# - "death.infec"
# - "recovery"
# - c("dS","dI","dR")
#
# Returns:
#  a matrix containing :
# Time : time step of the evaluation of the compartments number
# A number of column (size of start) that contain the number of indivuduals 
# in each compartements for each time step
#######################################################################

##package
library(foreach)
library(iterators)
library(doParallel)
library(snow)
library(plyr)
library(nws)


##seed
set.seed(01042015, kind = "L'Ecuyer-CMRG")

##Function
gillespieMultTraj<-function(parms=c(m=1e-4,b=0.02,v=0.1,r=0.3) , X0=c(S=97, I=3, R=0), time.window=c(0,100), processes=processes, NbTraj=100, NbCPU=2, ClockTime=FALSE, maxLine=1000){
  # Start the clock!
  if(ClockTime==TRUE) ptm <- proc.time()

gillespie<-function(parms=c(m=1e-4,b=0.02,v=0.1,r=0.3) , X0=c(S=97, I=3, R=0), time.window=c(0,100), processes=processes, maxLine=1000){
 
  # initialize state and time variables and write them into output  
  X <- X0
  
  time <-  time.window[1]
  
  # define output dataframe
  out <- data.frame(t=time,S=X0["S"], I=X0["I"], R=X0["R"],row.names=1)
  
  
  # process probabilities
  probabilities <- function(X, parms){
    
    a<-matrix(data = 0,nrow = 7,ncol = 1)
    a[1] = parms["m"]*(X["S"]+X["I"]+X["R"])
    a[2] = parms["m"]*X["S"]
    a[3] = parms["m"]*X["I"]
    a[4] = parms["m"]*X["R"]
    a[5] = parms["b"]*X["S"]*X["I"]
    a[6] = parms["v"]*X["I"]
    a[7] = parms["r"]*X["I"]
    return(a)
  }
  
  
  while(time < time.window[2] & X["I"]>0){
    
    # calculate process probabilities for current state
    a<-probabilities(parms = parms, X = X)
    
    # WHEN does the next process happen?
    elapsed.time <- rexp(1, rate=sum(a))
    
    # update time
    time<-time+elapsed.time
    
    # Which process happens % update states
    which.trans <-sample(length(a),1,prob=a)
    X<-X+processes[which.trans,]
    
    # write into output
    out <- rbind(out,c(time,X))
    
  }
  l<-length(out[,1])
  while(l < maxLine){
    out <- rbind(out,c(NA, NA, NA, NA))
    l=l+1
  }
  return(out)
}

#array of results

gillespie.mult.traj<-array(data = NA, dim = c(maxLine,4, NbTraj))

######################
#Parallel Computation#
######################

#setup parallel backend to use CPU efficiently
#cl2<-makeCluster(detectCores(logical = FALSE), "localhost")
registerDoParallel(cl = detectCores(logical = FALSE), cores = detectCores(logical = FALSE))

gillespie.mult.traj<-foreach(icount(NbTraj), .packages="foreach", .combine = "cbind") %dopar% {
  gillespie(parms, X0, time.window, processes, maxLine)
}

#close multicore
#stopCluster(cl2)

gillespie.mult.traj.array<-array(NA, dim = c(dim(gillespie.mult.traj)[1],4, NbTraj))
gillespie.mult.traj.array[,1,]<-data.matrix(gillespie.mult.traj[,c(TRUE,rep(FALSE,3))], rownames.force = NA)
gillespie.mult.traj.array[,2,]<-data.matrix(gillespie.mult.traj[,c(FALSE,TRUE,rep(FALSE,2))], rownames.force = NA)
gillespie.mult.traj.array[,3,]<-data.matrix(gillespie.mult.traj[,c(FALSE, FALSE,TRUE,FALSE)], rownames.force = NA)
gillespie.mult.traj.array[,4,]<-data.matrix(gillespie.mult.traj[,c(FALSE, FALSE,FALSE, TRUE)], rownames.force = NA)
# Stop the clock!
if(ClockTime==TRUE){
  ClockTime<-proc.time() - ptm
  cat("user" , "system", "elapsed", "\n", ClockTime)
}
return(gillespie.mult.traj.array)
}
