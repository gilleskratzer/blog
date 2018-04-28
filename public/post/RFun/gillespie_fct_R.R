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

##seed
set.seed(01042015, kind = "L'Ecuyer-CMRG")

##Function

gillespie<-function(parms=c(m=1e-4,b=0.02,v=0.1,r=0.3) , X0=c(S=97, I=3, R=0), time.window=c(0,100), processes=processes, pb=FALSE){
  
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

##Progress bar
if(pb==TRUE) pbPrint <- txtProgressBar(min = 0, max = time.window[2], style = 3)
  
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
  
  # update progress bar
  if(pb==TRUE){setTxtProgressBar(pb = pbPrint, value = time)}
}

out
}
