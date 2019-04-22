# GDP WITH TIME SERIES
  GDP<-read.csv("/Users/hpl23/Desktop/GDP.csv")
  GDP<-ts(GDP,start=1,frequency=4)
  y<-as.data.frame(GDP)
  y<-y$GDP
  length(y)
  t<-(1:288)
  t2<-t^2  
  reg<-lm(y~t+t2)
  summary(reg)    
  trendy<-890.81-30.43*t+0.34*t2
  ts.plot(GDP,trendy,col=1:2,ylab="Trend vs. Acutal GDP")
  dt<-GDP-trendy
  plot(dt[,2])
  par(mfrow=c(2,1))
  acf(dt,100)
  pacf(dt,100)
  Eco<-dt[285:288,2]
  dataall<-read.csv("/Users/hpl23/Desktop/DATA_ALL_a.csv")
  dataall<-dataall[1:40,]
  y_2015<-dataall[,3]
  y_2018<-dataall[,9]
  change<-round(cbind(y_2015,y_2018),2)
  change<-as.data.frame(change)
  
  # CLUSTERING STOCKS WITH SIMULATED ANNEALING
  # In Bad Economy
  data<-dataall$Return_a
  data<-scale(data)
  rcur<-runif(40,0,1)
  CurCluster <- ifelse(rcur<0.5,0,1)
  CurCluster <- as.matrix(CurCluster,ncol=1,nrow=40)
  data<-cbind(CurCluster,data)
  C11<-sum(data[which(data[,1]==1),2])/length(data[which(data[,1]==1),2]) 
  Center1<-c(C11)                      
  C21<-sum(data[which(data[,1]==0),2])/length(data[which(data[,1]==0),2])  
  Center2<-c(C21)                     
  CurDist<-sum(sum((data[which(data[,1]==1),2]-C11)**2),
               sum((data[which(data[,1]==0),2]-C21)**2))
  BestCluster <- CurCluster 
  MinDist <- CurDist
  
  
  T<-3
  r<-0.9
  L<-10
  frozen<-0.01

  while (T > frozen) {
    for (i in 1:L) {
      rObs<-runif(1,1,41)                                                       
      NeighCluster<-CurCluster                                                  
      NeighCluster[rObs,1]<-1-NeighCluster[rObs,1]                              
      data<-cbind(NeighCluster,df)                                                                      
      C11<-sum(data[which(data[,1]==1),2])/length(data[which(data[,1]==1),2])   
      Center1<-c(C11)                      
      C21<-sum(data[which(data[,1]==0),2])/length(data[which(data[,1]==0),2])  
      Center2<-c(C21) 
      NeighDist<-sum(sum((data[which(data[,1]==1),2]-C11)**2),
                     sum((data[which(data[,1]==0),2]-C21)**2))
      print(NeighDist)
      if (NeighDist < CurDist) 
      { CurDist <- NeighDist
      CurCluster <- NeighCluster
      if (NeighDist < MinDist) { MinDist <- NeighDist
      BestCluster <- NeighCluster 
      }
      } 
      else {
        if (runif(1,0,1) > exp(-(CurDist-NeighDist)/T) ) {
          CurDist <- NeighDist
          CurCluster <- NeighCluster
        }
      }
    }
    T <- r*T
  }
  
  BestCluster_BAD<-BestCluster
  MinDist_BAD<-MinDist
  
  