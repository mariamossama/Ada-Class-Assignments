Let's stimulate a stock market.

Create a protected object type for printing the outputs.
Use a variable of that type to do the printing.
The type contains only this procedure.
      procedure Print(strinigToPrint : String);

# E.g, MyPrinter : PrinterType; MyPrinter.Print(stringToPrint);

Main actors -> Market, Person, Monitor
================================================

@@@@@@ Market
Market is a protected object where we store the prices and make modifications to them.
Let's give a stock type to our program.
      type StockType is (TSLA, NFLX, APPL);
Our Market has a price chart, which is of this type.
      type PriceChart is array(StockType) of Float;

1) You must add a procedure called InitPrices which takes an array of float values(Index is your choice), to
set our stocks' initial prices.

2) Customers are going to place orders in the market. And these orders will affect the stock price. For this,
we will create an entry called PlaceOrder.
      entry PlaceOrder(stock : StockType; mode : Integer);
      # This entry is going to be called by the customers.
      # 'stock' is the stock our customer will trade.
      # 'mode' is the mode of trade. It can have two values, 1 or -1. 1 means buy and -1 means sell.
      # Buying increases the demand so the stock price rises, and selling the other way around.
      # The equation to modify the stock price is => original_price = original_price + mode * 0.01;

      # We also want to pause accepting orders once in a while to stabilize the prices(just a story).
      # The market can accept orders for 3 seconds, followed by a 1 second pause.
      # This will be the guard condition to our PlaceOrder.
      

3) Now, create a Report procedure which prints out the price chart in this format.
      # TSLA : value
      # NFLX : value
      # APPL : value


Full Market Declartion will look like this.



================================================

@@@@@@ Person
Person is a task that will trade stocks in our market.
It will keep buying(multiple attempts) until it is stopped. ( Read Monitor for more information on stopping )

Trading
1) It waits for a random duration between 1.5 to 2.0 seconds.
2) It chooses a random stock from stocktype.
3) It decides whether to buy or sell, based on a random float generator.
      # If generated_value > 0.5 => Buy
      # Else Sell
4) Make a trading call to our market with the generated stock and trading mode.
      # But due to 1 second pauses of the Market, our call might not be processed.
      # So let's put a 0.5 second timeout to avoid hanging.

After finishing those steps, we will either stop or continue with the following rule.
To stop our person task, add an entry named Stop.
If Stop is called, we will stop buying.
If not called RIGHT AWAY, repeat the Trading steps above.

Make an array of five Person tasks and call it People.

================================================

@@@@@@ Monitor
This is also a task. It's functionality is to simulate our story for certain amount of time.
1) Make a 0.5 second delay to wait for the units that need initialization.
      # They include the Market, and Resets for the random generators we use in the program.
2) Initialize People array.
3) Starts simulating.
      # The simulation lasts 8 seconds
      # The Market reports every 3.5 seconds.
4) At the end of simulating, we stop our People.
5) End of our program.

!!!! The simulation time is 8 seconds but the program is longer !!!!
================================================

Good Luck!