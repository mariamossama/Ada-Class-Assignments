with Company_Package; use Company_Package;

package body Person_Package is
   function Calculate_Salary(P: Person) return Integer is
      Base_Salary: constant Integer := MyJobType'Enum_Rep(P.Job);
      Experience_Multiplier: constant Integer := MyExpType'Enum_Rep(P.Experience);
   begin
      return Base_Salary * Experience_Multiplier;
   end Calculate_Salary;



   procedure Init(P: out Person; Name: String; Job: MyJobType; Experience: MyExpType; Savings: Integer) is
   begin
      P.Name := Name;
      P.Job := Job;
      P.Experience := Experience;
      P.Savings := Savings;
   end Init;

   function Init(Name: String; Job: MyJobType; Experience: MyExpType; Savings: Integer) return Person is
      P: Person;
   begin
      Init(P, Name, Job, Experience, Savings);
      return P;
   end Init;

   procedure Save(P: in out Person; Months: Integer) is
      Salary_Per_Month: Integer := Calculate_Salary(P);
   begin
      P.Savings := P.Savings + (Months * Salary_Per_Month);
   end Save;

   procedure BuyStock(P: in out Person; C: in out Company; Amount: Integer) is
    StockPrice: Integer;
    PurchaseSuccessful: Boolean;
begin
    StockPrice := GetStockPrice;
    declare
        TotalCost: Integer := StockPrice * Amount;
    begin
        if TotalCost <= P.Savings then
            PurchaseSuccessful := ProcessPurchase( P.Name, Amount); -- Adjusted to capture the Boolean result
            if PurchaseSuccessful then
                P.Savings := P.Savings - TotalCost;
                Put_Line(P.Name & " has successfully purchased " & Integer'Image(Amount) & " stocks from the company.");
            else
                Put_Line("Purchase could not be processed due to an error or restriction.");
            end if;
        else
            Put_Line("Purchase cannot be made. Not enough savings.");
        end if;
    end;
end BuyStock;

   procedure print_person(P : in out Person) is
   begin
      Put_Line("Person's Name is :"& P.Name);
      Put_Line("works as  :"& P.Job'Img);
      Put_Line(" experience  :" & P.Experience'Img);
      Put_Line("they saved :  :"  &P.Savings'Image);
   end print_person;

end Person_Package;
