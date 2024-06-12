with Ada.Text_IO; use Ada.Text_IO;
with Person_Package;
with Company_Package; use Company_Package;


procedure Main is
   sal : Integer;
   C : Company_Package.Company;
   type Company_Access is access all Company_Package.Company;
   cmp: Company_Access;

   -- Now, instantiate Person_Package with Company_Access as 'cmp'
   package My_Person_Package is new Person_Package(Company_Access);
   P : My_Person_Package.Person;
   myself : My_Person_Package.Person;
   function Wrapper_ProcessPurchase(Name : String; Amount : Integer) return Boolean is
   begin
      return Company_Package.ProcessPurchase(C, Name, Amount);
   end Wrapper_ProcessPurchase;

   function Wrapper_GetStockPrice return Integer is
   begin
      return Company_Package.GetStockPrice(C);
   end Wrapper_GetStockPrice;

   begin
   My_Person_Package.Init(P,"john",My_Person_Package.Doctor,My_Person_Package.Junior,1000);
   My_Person_Package.Init(myself,"mary",My_Person_Package.Businessman,My_Person_Package.Junior,1600);
   My_Person_Package.print_person(P);

   sal := My_Person_Package.Calculate_Salary(P);
   Put_Line("John's salary is " & Integer'Image(sal));

   --  Initialize_Company(C, ID => 1, Max_Owner => 5, Stock_Price => 100, Max_Stock => 500, Fundings => 0);
   Set_ID(C,1);
   Set_Max_Owner(C, 2);--only two owners can be added
   Set_Stock_Price(C, 100);
   Set_Max_Stock(C,2);
   Set_Fundings(C,0);
   Company_Package.Print(C);


   declare
      procedure Buy_Stock is new My_Person_Package.BuyStock(Wrapper_ProcessPurchase, Wrapper_GetStockPrice);
   begin
      --  --     Buy_Stock(P, cmp, 2);
      Buy_Stock(P, cmp, 1);
      Buy_Stock(myself, cmp, 1);
      Buy_Stock(myself, cmp, 1); --cant be buy because stocks "2 above" already purchased
   end;

   My_Person_Package.print_person(P);
   My_Person_Package.print_person(P);
   Company_Package.Print(C);



end Main;

