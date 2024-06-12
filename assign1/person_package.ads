with Ada.Text_IO; use Ada.Text_IO;
generic 
     type Company is private;
package Person_Package is
   Can_Purchase : Boolean := False;
   type Person is private;
   type MyJobType is (Doctor, Engineer, Businessman);
   for MyJobType use (300, 400, 500);
   type jobs is array(MyJobType) of Integer;
   salaries : constant jobs := ( Doctor=>300 , Engineer=>400 , Businessman=>500);
   

   type MyExpType is (Junior, Medior, Senior);
   for MyExpType use (1, 2, 3);
   type experience is array(MyExpType) of Integer;
   levels : constant experience := (Junior=>1 , Medior=>2 , Senior=>3);
   
   generic
      with function ProcessPurchase(Name: String; NumStocks: Integer) return Boolean;
      with function GetStockPrice return Integer;
      procedure BuyStock(P: in out Person; C: in out Company; Amount: Integer);

   

   procedure Init(P: out Person; Name: String; Job: MyJobType; Experience: MyExpType; Savings: Integer);
   function Init(Name: String; Job: MyJobType; Experience: MyExpType; Savings: Integer) return Person;

   function Calculate_Salary(P: Person) return Integer;
   
   procedure Save(P: in out Person; Months: Integer);
   procedure print_person(P : in out Person);
   

private
   type Person is record
      Name: String(1..4);
      Job: MyJobType;
      Experience: MyExpType;
      Savings: Integer;
   end record;
end Person_Package;


