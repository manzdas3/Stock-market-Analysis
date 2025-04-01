CREATE DATABASE STOCK_MARKET_ANALYSIS;
USE STOCK_MARKET_ANALYSIS;
ALTER TABLE stock_market_data CHANGE `ï»¿Date`  Stock_Date TEXT(100);
ALTER TABLE stock_market_data CHANGE `Dividend Amount` Dividend_Amount Double;
ALTER TABLE stock_market_data CHANGE `52 Week High` 52_Week_High Double;
ALTER TABLE stock_market_data CHANGE `52 Week Low` 52_Week_Low Double;
ALTER TABLE stock_market_data CHANGE `Market Cap` Market_Cap  Double;
ALTER TABLE stock_market_data CHANGE `PE Ratio`  PE_Ratio Double;
ALTER TABLE stock_market_data CHANGE `RSI (14 days)`  RSI_14_days Double;
ALTER TABLE stock_market_data CHANGE `Year`  Year_ Double;


SELECT * FROM stock_market_data;
SET SQL_SAFE_UPDATES = 0;
#--------------------------------------------------SELECT YEAR HERE------------------------------------

SET @YearFilter = NULL;  -- Change this to a specific year when filtering, otherwise keep NULL

#-----------------------------------------KPI 1 AVERAGE DAILY TRADING VOLUME------------------------------------------

Select Ticker,round(avg(Volume),2) as Average_Trading_Volume,Year_ as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(Volume),2) Desc;

#------------------------------------------------MOST VOLATILE STOCK--------------------------------------------------

Select Ticker,round(avg(Beta),5) as Volatility,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(Beta),5) Desc;

#----------------------------------------STOCKS WITH HIGHEST AND LOWEST DIVIDEND--------------------------------------

SELECT Ticker,round(avg(Dividend_Amount),5) as Dividend_Amount,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(Dividend_Amount),5) Desc;

#-----------------------------------------HIGHEST AND LOWEST PE RATIO--------------------------------------------------

SELECT Ticker,round(avg(PE_Ratio),2) as PE_RATIO,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(PE_Ratio),2) Desc;

#-----------------------------------------STOCKS WITH HIGHEST MARKET CAP------------------------------------------------

SELECT Ticker,round(avg(Market_Cap),2) as Market_Cap,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(Market_Cap),2) Desc;

#-----------------------------------------STOCKS NEAR 52 WEEK HIGH------------------------------------------------------

SELECT Ticker,round(avg(52_Week_High),2) as 52_Week_High,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(52_Week_High),2) Desc;

#------------------------------------------STOCKS WITH 52 WEEK LOW------------------------------------------------------

SELECT Ticker,round(avg(52_Week_Low),2) as 52_Week_Low,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(52_Week_Low),2) Desc;



#--------------------------------------STOCKS WITH STRONG BUY AND SELL SIGNAL-------------------------------------------

SELECT Ticker,round(avg(MACD),2) AS Strong_Buy_Signal,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(MACD),2) Desc;

SELECT Ticker,round(avg(RSI_14_days),2) as Strong_Sell_Signal,Year_  as Year
from stock_market_data
WHERE @YearFilter IS NULL OR Year_ = @YearFilter
group by Year_,Ticker
Order by Year_,round(avg(RSI_14_days),2) Desc;

#-----------------------------END------------------------------------------------------------------------
