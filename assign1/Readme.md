In this assignment, you need to simulate a person who works to buy stocks.
All transaction calculations are made in Integer type.

2 main acting packages(classes) are Person package and Company package.

-- Story --

      Person
      A person has a job and his level of experience. His salary can be calculated from those variables.
      For every month he works, his salary is added to his savings. He buys stocks from this saved money.

      Company
      A company sells stocks with a constant price, and they are selling it for a limited amount.
      The company keeps track of the owner list, and the amount of money received from sales.

      When a person buy one or multiple stocks from the company, his name is recorded as one of the owners.
      He can buy multiple times but the name must be recorded only once.
      The maximum number of owners is also limited.
      So even if there are stocks available, you cannot buy if the owner limit has reached to max.
      

-- Implementation --

Person_Package
      
      Provide a private Person type with following attributes.
            Name, Job, Experience, Savings      
            Job and Experience are generic types.
                  
      
            To initialize these values, you have to write one Init procedure and one Init function.   

            A person's salary can be calculated by multiplying the base salary of his job with his experience level.
            Use these lines of code to define the base salaries and multipliers for different experiences.
            
                  type MyJobType is (Doctor, Engineer, Businessman);
                  for MyJobType use (300, 400, 500);        

      
                  type MyExpType is (Junior, Medior, Senior);
                  for MyExpType use (1, 2, 3);
                     To get the values, use Enum_Rep property. MyJobType'Enum_Rep(Doctor) will give 300. 

                  Eg. a medior doctor's salary = 300 * 2 = 600;
            
            Savings is the accumulation of his salaries.
            Write an operation Save that takes the number of months as a parameter.
            This will calculate the amount of salary he gets within that number of months and add it to the savings.

                  Eg. a medior doctor works for 4 months, savings = savings + (4 * 600);
            
            Generic in Generic
                  Implement BuyStock procedure.
                  BuyStock is a generic procedure which needs GetStockPrice and ProcessPurchase as formal parameters.
                  Procedure's parameters include a Company and the ammount of stocks to buy.
                  Print out a message whether the purchase was made or not. ( You cannot buy when you don't have enough savings )
                  # Read about GetStockPrice and ProcessPurchase below. #


Company_Package
      Implement private Company type as following variables.
      ID, max_owner, stock_price, max_stock, fundings, owners ( You need to/can add more accordingly)
      Decide between discriminants and attributes because this type doesn't have Init procedure/function.
            
            ID is an integer identifier of a company.
            max_owner is the max number of owner a company can have.
            stock_price is the selling price of one stock.
            max_stock is the maximum number stock the company will sell.
            fundings is total money received from selling.
            owners is a list of name of the people who bought stocks.

      Implement AddOwnership. Parameter is a name. This adds the name to the list of owners.
      
      Implement ProcessPurchase. Parameters are a name and the amount of stocks.
            Here you check whether the purchase can be done or not and prints a message.
            If not, do nothing.
            If yes, make modifications to the company.

      Implement a getter of the stock_price.


Main Program

      Write test cases to show that everything is working.
      For this, create Print operations for both Person and Company that show the changing attributes along with their name/ID.

      You can implement your own functions or procedures as needed.

            ***   
                  Importing Company package into Person package using 'with' keyword is not allowed.
This defeats the purpose of generic.
                  The number of formal parameters for the generic package can be as many as you need.