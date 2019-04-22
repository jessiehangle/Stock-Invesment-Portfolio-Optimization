############################################Scenario1########################################################
library(xlsx)
df <- read.xlsx("Price_8Scenario.xlsx", sheetIndex = 2)
price<-df[,4:7]
p0<-round(price$P0,0)
p1<-round(price$P1,0)
p2<-round(price$P2,0)
p3<-round(price$P3,0)


# OPTIMIZATITON: 
# Max: P3X0 - 0.015(P1-P0)B1 - 0.012(P1-P0)S1 - 0.015(P2-P1)B2 - 0.012(P2-P1)S2 + C0
X0<-as.vector(p3)
B1<-as.vector(-0.015*(p1-p0))
S1<-as.vector(-0.012*(p1-p0))
B2<-as.vector(-0.015*(p2-p1))
S2<-as.vector(-0.012*(p2-p1))
C0<-as.vector(c(1))
F<-as.vector(c(X0,B1,S1,B2,S2,C0))

# Constratint 1: X0-S1>=0
C11<-diag(40)                                  # X0
C12<-matrix(rep(0,40*40),nrow=40,ncol=40)      # B1
C13<--diag(40)                                 # S1
C14<-matrix(rep(0,80*40),nrow=40,ncol=80)      # B2,S2
C15<-matrix(rep(0,40),nrow=40,ncol=1)          # C0 
C1<-cbind(C11,C12,C13,C14,C15)

# Constraint 2: X1-S2>=0:    X0 + B1 -S2 >=0
C21<-diag(40)                                  # X0
C22<-diag(40)                                  # B1
C23<-matrix(rep(0,80*40),nrow=40,ncol=80)      # S1,B1
C24<--diag(40)                                 # S2
C25<-matrix(rep(0,40),nrow=40,ncol=1)          # C0 
C2<-cbind(C21,C22,C23,C24,C25)

# Constraint 3: sum(X0P0) + C = 4000000                         
C31<-matrix(p0,nrow=1,ncol=40)                 # X0
C32<-matrix(rep(0,160),nrow=1,ncol=160)        # B1,B2,S1,S2
C33<-diag(1)                                   # C0
C3<-cbind(C31,C32,C33)

# Constraint 4: P3(X0+B1-S1+B2-S2) >= 5000000                               
C41<-matrix(p3,nrow=1,ncol=40)                 # X0           
C42<-matrix(p3,nrow=1,ncol=40)                 # B1
C43<--matrix(p3,nrow=1,ncol=40)                # S1           
C44<-matrix(p3,nrow=1,ncol=40)                 # B2
C45<--matrix(p3,nrow=1,ncol=40)                # S2
C46<-matrix(c(0))                              # C0
C4<-cbind(C41,C42,C43,C44,C45,C46)

# Constraint 5: X0 >= 5
C51<-diag(40)                                  # X0
C52<-matrix(rep(0,161*40),nrow=40,ncol=161)    # B1,S1,B2,S2,C0
C5<-cbind(C51,C52)

# Constraint 6: B1 <= 150
C61<-matrix(rep(0,40*40),nrow=40,ncol=40)      # X0
C62<-diag(40)                                  # B1
C63<-matrix(rep(0,121*40),nrow=40,ncol=121)    # S1,B2,S2,C0
C6<-cbind(C61,C62,C63)

# Constraint 7: B2 <= 150
C71<-matrix(rep(0,120*40),nrow=40,ncol=120)    # X0,B1,S1
C72<-diag(40)                                  # B2
C73<-matrix(rep(0,41*40),nrow=40,ncol=41)      # S2,C0
C7<-cbind(C71,C72,C73)

# Constraint 8: S1 <= 50            
C81<-matrix(rep(0,40*80),nrow=40,ncol=80)      # X0,B1                                                  
C82<-diag(40)                                  # S1     
C83<-matrix(rep(0,81*40),nrow=40,ncol=81)      # B2,S2,C0
C8<-cbind(C81,C82,C83)                                                

# Constraint 9: S2 <= 50           
C91<-matrix(rep(0,160*40),nrow=40,ncol=160)    # X0,B1,S1,B2
C92<-diag(40)                                  # S2
C93<-matrix(rep(0,1*40),nrow=40,ncol=1)        # C0
C9<-cbind(C91,C92,C93)

# Constraint 10: C0 >= 200
C101<-matrix(rep(0,200*1),nrow=1,ncol=200)     # X0,B1,S1,B2,S2
C102<-diag(1)                                  # C0
C10<-cbind(C101,C102)

# Constraint 11: C1 >= 200
C111<-matrix(rep(0,40),nrow=1,ncol=40)         # X0
C112<-matrix(-1.015*p1,nrow=1,ncol=40)         # B1
C113<-matrix(0.998*p1,nrow=1,ncol=40)          # S1
C114<-matrix(rep(0,81),nrow=1,ncol=81)         # B2,S2,C0
C11<-cbind(C111,C112,C113,C114)

# Constraint 12: C2 >= 200
C121<-matrix(rep(0,40),nrow=1,ncol=40)         # X0
C122<-matrix(-1.015*p1,nrow=1,ncol=40)         # B1
C123<-matrix(0.998*p1,nrow=1,ncol=40)          # S1
C124<-matrix(-1.015*p2,nrow=1,ncol=40)         # B2
C125<-matrix(0.998*p2,nrow=1,ncol=40)          # S2
C126<-matrix(c(1))                             # C0
C12<-cbind(C121,C122,C123,C124,C125,C126)

# Constraint 13: B1 >= 0 
C131<-matrix(rep(0,40*40),nrow=40,ncol=40)      # X0
C132<-diag(40)                                  # B1
C133<-matrix(rep(0,121*40),nrow=40,ncol=121)    # S1,B2,S2,C0
C13<-cbind(C131,C132,C133)

# Constraint 14: B2 >= 0
C141<-matrix(rep(0,120*40),nrow=40,ncol=120)    # X0,B1,S1
C142<-diag(40)                                  # B2
C143<-matrix(rep(0,41*40),nrow=40,ncol=41)      # S2,C0
C14<-cbind(C141,C142,C143)

# Constraint 15: S1 >= 0            
C151<-matrix(rep(0,40*80),nrow=40,ncol=80)      # X0,B1                                                  
C152<-diag(40)                                  # S1     
C153<-matrix(rep(0,81*40),nrow=40,ncol=81)      # B2,S2,C0
C15<-cbind(C151,C152,C153)                                                

# Constraint 16: S2 >= 0           
C161<-matrix(rep(0,160*40),nrow=40,ncol=160)    # X0,B1,S1,B2
C162<-diag(40)                                  # S2
C163<-matrix(rep(0,1*40),nrow=40,ncol=1)        # C0
C16<-cbind(C161,C162,C163)


A<-as.matrix(rbind(C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16))
                         #Cons3  #Cons4              #Cons6      #Cons7      #Cons8     #Cons9  #Cons10-12
b<-c(rep(0,40),rep(0,40),4000000,4000000,rep(5,40),rep(150,40),rep(150,40),rep(50,40),rep(50,40),rep(200,3),rep(0,4*40))
signs<-c(rep(">=",40),rep(">=",40),"=",">=",rep(">=",40),rep("<=",40),rep("<=",40),rep("<=",40),rep("<=",40),rep(">=",3),rep(">=",4*40))
res = lpSolve::lp('max',F,A,signs,b)
# Because we take the integer constraint out of the constraint, the result we have is the upper-bound
upsol<-res$solution
objup<-res$objval
# Lower bound
low<-round(res$solution[1:200])
x0<-round(res$solution[1:40])
b1<-floor(res$solution[41:80])
s1<-floor(res$solution[81:120])
b2<-floor(res$solution[121:160])
s2<-floor(res$solution[161:200])
C0<-4000000-sum(x0*p0)
lowsol<-c(low,C0)
objlow<-sum(p3*x0)-0.015*sum((p1-p0)*b1)-0.012*sum((p1-p0)*s1)-0.015*sum((p2-p1)*b2)-0.012*sum((p2-p1)*s2)+C0
#### Solution ####
#Upperbound value of decision variable
upsol
# Lowerbound value of decision variable
lowsol
#Upperbound objective value
objup
# Lowerbound value of objective value
objlow


