//+------------------------------------------------------------------+
//|                                                      YHODLOD.mq4 |
//|                                                            Thijs |
//|                                             http://www.inseed.nl |
//+------------------------------------------------------------------+
#property copyright "Thijs"
#property link      "http://www.inseed.nl"
#property version   "1.00"
#property strict
#property indicator_chart_window

//external parameters
enum widths{
   One = 1,
   Two = 2,
   Three = 3,
   Four = 4,
   Five = 5,
};


extern int days=30;
input color col = Aqua;
input widths width = One; 


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

double yHighs[], yLows[];
void Dline(string name, datetime time0, double val0, datetime time1, double val1){
   ObjectCreate(0,name,OBJ_TREND,0,time0, val0, time1, val1);
   ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
   ObjectSet(name, OBJPROP_COLOR, col);
   ObjectSet(name, OBJPROP_WIDTH, width);
   ObjectSet(name, OBJPROP_RAY, false);
   ObjectSet(name, OBJPROP_BACK, false);
   ObjectSet(name, OBJPROP_READONLY, true);
   ObjectSet(name, OBJPROP_SELECTABLE, false);
}

void Past(string symbol, int pass){
   CopyHigh(symbol,PERIOD_D1, iTime(NULL, PERIOD_D1,1), days, yHighs);
   CopyLow(symbol,PERIOD_D1, iTime(NULL, PERIOD_D1,1), days, yLows);
   ArraySetAsSeries(yHighs,true); 
   ArraySetAsSeries(yLows,true);  
   
   int y = 2;
   Dline(StringConcatenate("Geert de lijn (.5)"), iTime(NULL, PERIOD_D1,0), yHighs[1], iTime(NULL, PERIOD_D1,0),yHighs[0]);
   Dline(StringConcatenate("Eduard de andere lijn (.5)"), iTime(NULL, PERIOD_D1,0), yLows[1], iTime(NULL, PERIOD_D1,0),yLows[0]);
   
   for(int i = 1; i < pass - 1; i++){
      Dline(StringConcatenate("Geert de lijn (", IntegerToString(i, 2),")"), iTime(NULL, PERIOD_D1,i-1), yHighs[i], iTime(NULL, PERIOD_D1,y-1),yHighs[i]); //highs
      Dline(StringConcatenate("Geert de lijn (", IntegerToString(i+1, 2),".5)"), iTime(NULL, PERIOD_D1,i), yHighs[i], iTime(NULL, PERIOD_D1,i),yHighs[i+1]); //connect highs
      Dline(StringConcatenate("Eduard de andere lijn (", IntegerToString(i, 2),")"), iTime(NULL, PERIOD_D1,i-1), yLows[i], iTime(NULL, PERIOD_D1,y-1),yLows[i]); //lows
      Dline(StringConcatenate("Eduard de andere lijn (", IntegerToString(i+1, 2),".5)"), iTime(NULL, PERIOD_D1,i), yLows[i], iTime(NULL, PERIOD_D1,i),yLows[i+1]); //connect lows
      y++;
   }
}

int OnInit()
  {
//--- indicator buffers mapping
    
//---
   Past(Symbol(), days);
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
   double yHi = iHigh(NULL,PERIOD_D1,1); 
   double yLo = iLow(NULL,PERIOD_D1,1); 
   Dline("geert de lijn", iTime(NULL, PERIOD_D1,0), yHi,iTime(NULL, PERIOD_M1,0),yHi);   
   Dline("eduard de andere lijn", iTime(NULL, PERIOD_D1,0), yLo,iTime(NULL, PERIOD_M1,0),yLo);
  
   return(rates_total);
  }
//+------------------------------------------------------------------+

void OnDeinit(const int reason){
   Print("reason: ", IntegerToString(reason));
   int totalObjects  = ObjectsTotal();
   
   for(int i=totalObjects - 1 ;  i >= 0 ;  i-- ) {
           ObjectDelete(ObjectName(i));
   }
   
   return;
}
