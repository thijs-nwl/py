//+------------------------------------------------------------------+
//|                                                    deleteAll.mq4 |
//|                                                            Thijs |
//|                                             http://www.inseed.nl |
//+------------------------------------------------------------------+
#property copyright "Thijs"
#property link      "http://www.inseed.nl"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int start()
{
int totalObjects  = ObjectsTotal();

for(int i=totalObjects - 1 ;  i >= 0 ;  i-- ) {
        ObjectDelete(ObjectName(i));
}

return 0 ;
}
//+------------------------------------------------------------------+
