//+------------------------------------------------------------------+
//|                                                         EMAs.mq4 |
//|                                                            Thijs |
//|                                             http://www.inseed.nl |
//+------------------------------------------------------------------+
#property copyright "Thijs"
#property link      "http://www.inseed.nl"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 5
#property indicator_plots   5
//--- plot Mustard
#property indicator_label1  "Mustard"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrYellow
#property indicator_style1  STYLE_SOLID
#property indicator_width1  2
//--- plot Ketchup
#property indicator_label2  "Ketchup"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  2
//--- plot Water
#property indicator_label3  "Water"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrAqua
#property indicator_style3  STYLE_SOLID
#property indicator_width3  2
//--- plot Mayo
#property indicator_label4  "Mayo"
#property indicator_type4   DRAW_LINE
#property indicator_color4  clrWhite
#property indicator_style4  STYLE_SOLID
#property indicator_width4  2
//--- plot BlueBerry
#property indicator_label5  "BlueBerry"
#property indicator_type5   DRAW_LINE
#property indicator_color5  clrMediumBlue
#property indicator_style5  STYLE_SOLID
#property indicator_width5  2
//--- indicator buffers
double         MustardBuffer[];
double         KetchupBuffer[];
double         WaterBuffer[];
double         MayoBuffer[];
double         BlueBerryBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,MustardBuffer);
   SetIndexBuffer(1,KetchupBuffer);
   SetIndexBuffer(2,WaterBuffer);
   SetIndexBuffer(3,MayoBuffer);
   SetIndexBuffer(4,BlueBerryBuffer);
   
//---
   return(INIT_SUCCEEDED);
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
   bool as_series_time=ArrayGetAsSeries(time);
   bool as_series_close=ArrayGetAsSeries(close);

   if( as_series_time ) {
     // Print("Time as series.");
     ArraySetAsSeries(time,false);
   }

   if( as_series_close ) {
     // Print("Time as series.");
     ArraySetAsSeries(close,false);
   }
   
   double close_copied[];
   ArrayCopy(close_copied, close, 0,0,WHOLE_ARRAY);
   
   int limit = rates_total - prev_calculated;
   
   if(limit == 0){
      limit = 1;
   }
   
   for(int i=0; i< limit; i++){
      MustardBuffer[i] =    iMAOnArray(close_copied, 0, 5, 0, MODE_EMA, i);
      KetchupBuffer[i] =    iMAOnArray(close_copied, 0, 13, 0, MODE_EMA, i);
      WaterBuffer[i] =      iMAOnArray(close_copied, 0, 50, 0, MODE_EMA, i);
      MayoBuffer[i] =       iMAOnArray(close_copied, 0, 200, 0, MODE_EMA, i);
      BlueBerryBuffer[i] =  iMAOnArray(close_copied, 0, 800, 0, MODE_EMA, i);
      
   };
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
