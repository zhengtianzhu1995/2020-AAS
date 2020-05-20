Beta <- function(b, A){
  
  opts.gtol = 1e-5
  opts.xtol = 1e-5
  opts.ftol = 1e-8
  
  opts.tau  = 1e-3     
  opts.rhols  = 1e-4  
  opts.eta  = 0.1  
  opts.retr = 0
  opts.gamma  = 0.85   
  opts.STPEPS  = 1e-10
  opts.nt  = 2        
  opts.maxit  = 1000 
  opts.record = 0 
  opts.tiny = 1e-13
  
  gtol = opts.gtol
  xtol = opts.xtol
  ftol = opts.ftol
  maxit = opts.maxit
  rhols = opts.rhols
  eta   = opts.eta
  gamma = opts.gamma
  retr = opts.retr
  record = opts.record
  nt = opts.nt
  STPEPS = opts.STPEPS
  tiny = opts.tiny
  crit <- matrix(1,nrow = nt,ncol = 3)
  
  n <- nrow(b)
  k <- ncol(b)
  
  f <- Fun(b, A)
  g <- gradient(b, A)
  
  GX <- t(g)%*%b
  
  dtX <- g - b%*%GX
  nrmG <- norm(dtX,"F")
  
  Q <- 1
  Cval <- f
  tau <- opts.tau
  
  for (itr in 1:opts.maxit){
    XP <- b
    FP <- f
    GP <- g
    dtXP <- dtX
    
    nls <- 1
    deriv <- rhols*nrmG^2
    while (1){
      resultqr1 <- qr(XP - tau*dtX)
      b <- qr.Q(resultqr1)
      RR <- qr.R(resultqr1)
      
      if (norm(t(b)%*%b - diag(k),"F") > tiny){
        resultqr2 <- qr(b)
        b <- qr.Q(resultqr2)
      }
      f <- Fun(b, A)
      g <- gradient(b, A)
      
      if(f <= Cval - tau*deriv||nls >= 5){break}
      
      tau <- eta*tau
      nls <- nls+1
    }
    GX <- t(g)%*%b
    
    dtX <- g - b%*%GX
    nrmG <- norm(dtX,"F")
    S <- b - XP
    XDiff <- norm(S,"F")/sqrt(n)
    tau <- opts.tau
    FDiff <- abs(FP-f)/(abs(FP)+1)
    
    Y1 <- dtX - dtXP
    SY <- abs(sum(S*Y1))
    
    if (itr%%2 == 0)
    {tau <- (norm(S,"F"))^2/SY}else 
        {tau <- SY/(norm(Y1,"F"))^2}
    tau <- max(min(tau,1e20),1e-20)
    
    crit <- rbind(crit,c(nrmG, XDiff, FDiff))
    if (itr > 1)
    {mcrit <- apply(crit[(itr-min(nt,itr)+1):itr,],1,mean)}
    else{mcrit <- crit[(itr-min(nt,itr)+1):itr,]}
    
    if ((XDiff < xtol && FDiff < ftol) || nrmG < gtol || (mcrit[2] < 10*xtol && mcrit[3] < 10*ftol))
    {break}
    
    Qp <- Q
    Q <- gamma*Qp+1
    Cval <- (gamma*Qp*Cval + f)/Q
  }
  return(b)
}
