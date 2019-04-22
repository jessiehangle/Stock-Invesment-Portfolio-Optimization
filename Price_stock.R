
# Loading the required libraries
library(quantmod) ; library(TTR);
start <- as.Date("2015-01-01")
end <- as.Date("2015-02-28")

# Pulling NSE data from Yahoo finance

company<-c("AAPL","ABBV","ABT","ACN","AGN","AIG","ALL","AMGN","AMZN","AXP","BA","BAC","BIIB","BK","BKNG","BLK","BMY","C","CAT","CELG","CHTR","CL","CMCSA","COF","COP","COST","CSCO","CVS","CVX","DHR","DIS","DUK","DWDP","EMR","EXC","F","FB","FDX","FOX","FOXA","GD","GE","GILD","GM","GOOG","GOOGL","GS","HAL","HD","HON","IBM","INTC","JNJ","JPM","KMI","KO","LLY","LMT","LOW","MA","MCD","MDLZ","MDT","MET","MMM","MO","MRK","MS","MSFT","NEE","NFLX","NKE","NVDA","ORCL","OXY","PEP","PFE","PG","PM","QCOM","RTN","SBUX","SLB","SO","SPG","T","TGT","TXN","UNH","UNP","UPS","USB","UTX","V","VZ","WBA","WFC","WMT","XOM")
for (i in company) {
symbol = c(i)
print(c(i))
data = getSymbols(symbol,  src = "yahoo", from = start, to = end,auto.assign = FALSE)
colnames(data) = c("Open","High","Low","Close","Volume","Adjusted")
for(i in data){
data$Stock = rep(c(i))
colnames(data) <- c("Stock","Open","High","Low","Close","Volume","Adjusted")
}

data = na.omit(data)
closeprice = Cl(data)


# Create the label 
data$Return = round(dailyReturn(data$Close, type='arithmetic'),2)
colnames(data) = c("Stock","Open","High","Low","Close","Volume","Adjusted","Return")

class = character(nrow(data))
class = ifelse(coredata(data$Return) >= 0,"Up","Down")


data = data.frame(class)
data = na.omit(data)

write.csv(data,file=paste("decision tree charting_",symbol,".txt"))
}

library(data.table)
csv_files <- list.files (path       = ".", 
                         pattern    = "*.csv", 
                         full.names = T)

# (2) Import All csv with 'fread()'
library (tibble)
DATA_ALL <- as_tibble (rbindlist (lapply (csv_files, fread)))

# (3) Save
save (DATA_ALL, file = 'DATA_ALL.Rda') 
write.csv(DATA_ALL, 'DATA_ALL.csv')

