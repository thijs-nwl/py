//+------------------------------------------------------------------+
//|                                                    OHCLtoCSV.mq4 |
//|                                                            Thijs |
//|                                             http://www.inseed.nl |
//+------------------------------------------------------------------+
#property copyright "Thijs"
#property link      "http://www.inseed.nl"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {

   double data[2];
   
   OHLC(data);
   Print(data[0]);
   Print(data[1]);
   
   return(INIT_SUCCEEDED);
  }
  
 double OHLC(double& arr[]){
   arr[0] = iTime("USDCHF",PERIOD_H1,1);
   arr[1] = iClose("USDCHF",PERIOD_H1,1);
   return(arr[]);
 }
  
  
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
