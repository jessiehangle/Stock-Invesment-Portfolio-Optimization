# Stock Investment Portfolio Optimization 

#### Tools: R (quantmod, ggplot2), Simulated Annualing K-means Clustering optimizating algorithm, Decision Tree 

## Goal of the Project
Phoenix Fund is establishing a stock investment portfolio for company ABC. which considers invest $4million US dollars only in S&P 500 companies. Phoenix Fund will choose 40 stocks to invest and only consider buying or selling these stocks during the three-year-long investment period. The decision of buying and selling will based on the result of scenario tree with the predication on the economy of the United States and the network optimization to maximize the total revenue generated from the stock investment portfolio. Finally, there will be eight investment portfolios for different conditions and predictions. At the same time, to lower the risk, the stocks to be chosen are divides into two groups: better performance in good economy (positive beta compared to SP500 index-SPY) (Group 1) and better performance in bad economy (negative beta compared to SPY) (Group 2). The observations are extracted from the stock market in 2018. Based on the predictions and results, Phoenix Fund is able to make some decisions for the investment in 2019, 2020, 2021 and 2022 in the U.S. stock market.
## Assumptions
The Performances of Stock in Different Conditions1: In good economy, the Group 1 stocks that perform better in good economy will increase in the range of 2% to 10%, and the Group 2 stocks that perform worse in good economy will decrease in the range of 1% to 14%. In bad economy, the Group 1 stocks will increase in the range of -1% to 8%, however the Group 2 stocks will decrease in the range of 5% to 11%. Initial investment: To diversify our portfolio, we limit the number of shares we invest in each stock to be equal or greater than 5 shares. Transaction Cost: Transaction cost will be charged for each action but with different rates, which is 1.5% of transaction amount for buying and 1.2% for selling. Selling and Buying: To reduce the prediction error, we limit the number of shares to buy to 150 shares and sell to 100 shares at each period of time, and the cash balance after each investment period to be at least $200.

## Data
To perform the analysis, we collect stock data of 40 companies from S&P list companies from Yahoo Finance. The data we collected is for 4-year period: 2015 to March, 2019 and then we calculate the return for each stock per year. Apart from stock prices, we also collected data of United States GDP for the same period of time as an input for our model.

## Methodology
#### 1. Economical Condition Based on Time Series 
#### 2. Clustering Based on Simulated Annealing Algorithm
#### 3. Scenario Tree for Optimization

## General Model

![Screen Shot 0031-04-21 at 21 49 01](https://user-images.githubusercontent.com/49817101/56478721-5919d480-647f-11e9-8f2a-5c7fdd7c27d9.png)

## Model Implementation 

![Screen Shot 0031-04-21 at 21 51 59](https://user-images.githubusercontent.com/49817101/56478806-d34a5900-647f-11e9-9a74-526e2c09d18c.png)
![Screen Shot 0031-04-21 at 21 52 14](https://user-images.githubusercontent.com/49817101/56478808-d5acb300-647f-11e9-94f0-6e6fc8b488e6.png)

