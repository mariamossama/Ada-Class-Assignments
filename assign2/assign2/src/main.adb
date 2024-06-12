with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Discrete_Random;


procedure assign is
    type StockType is (TSLA, NFLX, APPL);
    type PriceChart is array (StockType) of Float;
   type FloatArray is array(StockType) of Float;
   package Stock_Random is new Ada.Numerics.Discrete_Random(StockType);
   Gen : Stock_Random.Generator;

   protected type PrinterType is
      procedure Print(StringToPrint : String);
   end PrinterType;

   protected body PrinterType is
      procedure Print(StringToPrint : String) is
      begin
         Ada.Text_IO.Put_Line(StringToPrint);
      end Print;
   end PrinterType;
   MyPrinter : PrinterType;

    protected type Market is
        entry PlaceOrder (Stock : StockType; Mode : Integer);
      procedure Report;
      procedure InitPrices(prices: FloatArray);
    private
        Chart : PriceChart;
      Start: Time := Clock;
   end Market;
   protected body Market is
   procedure InitPrices(prices: FloatArray) is
   begin
      for S in StockType loop
         chart(S) := prices(S);
      end loop;
   end InitPrices;

   procedure Report is
   begin
      for S in StockType loop
        MyPrinter.Print(StockType'Image(S) & " : " & Float'Image(chart(S)));
      end loop;
   end Report;
      --pause for 1 sec and accept for 3 sec
      --3+1 = 4
      entry PlaceOrder(stock: StockType; mode: Integer) when Integer(Clock - start) mod 4 < 3 is
      begin
         chart(stock) := chart(stock) + Float(mode) * 0.01;
      end PlaceOrder;


   Global_Market : Market;

   task type Person is
      entry Stop;
   end Person;

   task body Person is
      Gen1 : Ada.Numerics.Float_Random.Generator;
      mode: Integer;
      Random_value : Float ;
      mydelay : Float ;
      Random_Stock : StockType;
   begin
      loop
         select
            accept Stop;
            exit;
         else
            Stock_Random.Reset(Gen);
            Random_Value:= Ada.Numerics.Float_Random.Random (Gen1);
            mydelay := 1.5 + 0.5*Random_value;
            delay Duration(mydelay);  -- Random delay between trading attempts
             Random_Stock := Stock_Random.Random(Gen);      -- Randomly choose a stock (simplified)
            mode := (if Random_Value > 0.5 then 1 else -1);
            Global_Market.PlaceOrder(Random_Stock,mode);
         end select;
      end loop;
   end Person;
   task Monitor is
   end Monitor;

task body Monitor is
    People : array (1 .. 5) of Person;  -- An array of Person tasks
    Duration_To_Run : constant Duration := 8.0; -- Total simulation duration
    Report_Interval : constant Duration := 3.5; -- Interval for market reports
      Next_Report : Time := Clock + Report_Interval;
      Initial_Prices : FloatArray;
begin
    -- Initial delay to stabilize the environment
      delay Duration(0.5);
      -- Define initial prices for each stock type
      Initial_Prices := (TSLA => 1000.0, NFLX => 1000.0, APPL => 1000.0);
      Global_Market.InitPrices(Initial_Prices);

    -- Assuming People are already implicitly started when declared

    -- Run the simulation for a set duration
    declare
        End_Time : constant Time := Clock + Duration_To_Run;
    begin
        while Clock < End_Time loop
            -- Check if it's time to print a report
            if Clock >= Next_Report then
                Global_Market.Report;
                Next_Report := Next_Report + Report_Interval;
            end if;

            -- Sleep for a small amount of time to prevent a tight loop that consumes CPU
            delay Duration(0.1);
        end loop;
    end;

 for P of People loop
    P.Stop;
 end loop;


    Global_Market.Report;  -- Final report
end Monitor;


begin
      null;
end assign;
