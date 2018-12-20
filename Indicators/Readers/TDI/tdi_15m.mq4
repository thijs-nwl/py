//+------------------------------------------------------------------+
//|                                                       custom.mq4 |
//|                                                            Thijs |
//|                                             http://www.inseed.nl |
//+------------------------------------------------------------------+
#property copyright "Thijs"
#property link      "http://www.inseed.nl"
#property version   "1.00"
#property strict
#property indicator_chart_window

extern string pair = "EURUSD";
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   double val0 = iCustom(pair, PERIOD_H1, "TrueBTMM\\!btmm_TDI_Plus", 0, 0);
   double val1 = iCustom(pair, PERIOD_H1, "TrueBTMM\\!btmm_TDI_Plus", 1, 12000);
   double val2 = iCustom(pair, PERIOD_H1, "TrueBTMM\\!btmm_TDI_Plus", 2, 12000);
   double val3 = iCustom(pair, PERIOD_H1, "TrueBTMM\\!btmm_TDI_Plus", 3, 12000);
   double val4 = iCustom(pair, PERIOD_H1, "TrueBTMM\\!btmm_TDI_Plus", 4, 12000);
   
//---
   IndicatorBuffers(5);
   Print("val0: ", val0); //upperBand
   Print("val1: ", val1); //lowerBand
   Print("val2: ", val2); //baseLine
   Print("val3: ", val3); //RSI
   Print("val4: ", val4); //signalLine
   
   return(INIT_SUCCEEDED);
  }

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
   return(rates_total);
  }
