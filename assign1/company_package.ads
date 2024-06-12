with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Company_Package is
   type company is private;
    Is_Purchased : Boolean := False;

   procedure AddOwnership(CompanyObj: in out Company; Name: String);
   --  procedure Initialize_Company(C : out Company; ID : Integer; Max_Owner : Integer; Stock_Price : Integer; Max_Stock : Integer; Fundings : Integer := 0);
   function ProcessPurchase(CompanyObj: in out Company; Name: String; NumStocks: Integer) return Boolean;
   function GetStockPrice(CompanyObj: Company) return Integer;
   procedure Set_Stock_Price(Comp : in out Company; Price : Integer);
   procedure Print(CompanyObj : in Company);

   --setters
   procedure Set_ID(CompanyObj : in out Company; Value : Integer);
   procedure Set_Max_Owner(CompanyObj : in out Company; Value : Integer);
   procedure Set_Max_Stock(CompanyObj : in out Company; Value : Integer);
   procedure Set_Fundings(CompanyObj : in out Company; Value : Integer);

   private
      type Company is record
      ID: Integer;
      Max_Owner: Integer;
      Stock_Price: Integer;
      Max_Stock: Integer;
      Fundings: Integer;
      Owners: Unbounded_String; -- List of names of people who bought stocks
      end record;

end Company_Package;
