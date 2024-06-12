with Ada.Text_IO; use Ada.Text_IO;
package body Company_Package is


   --  procedure Initialize_Company(C : out Company; ID : Integer; Max_Owner : Integer;
   --                                Stock_Price : Integer; Max_Stock : Integer; Fundings : Integer := 0) is
   --   begin
   --       C.ID := ID;
   --       C.Max_Owner := Max_Owner;
   --       C.Stock_Price := Stock_Price;
   --       C.Max_Stock := Max_Stock;
   --       C.Fundings := Fundings;
   --       --  C.Owners := String_Vectors.Vector'(); -- Initialize the owners vector.
   --   end Initialize_Company;



procedure AddOwnership(CompanyObj: in out Company; Name: String) is
    -- Function to count the current number of owners based on the number of commas.
    function Count_Owners(Owners : Unbounded_String) return Natural is
        Count : Natural := 0;
    begin
        for I in 1 .. Length(Owners) loop
            if Element(Owners, I) = ',' then
                Count := Count + 1;
            end if;
        end loop;
        -- Add one to count for the last owner (or the only one if no commas are present).
        return Count + 1;
    end Count_Owners;

    Current_Num_Owners : Natural;
begin
    -- Count the current number of owners.
    Current_Num_Owners := Count_Owners(CompanyObj.Owners);

    -- Check if we can add another owner.
    if Current_Num_Owners < CompanyObj.Max_Owner then
        -- Add the new owner's name.
        if Length(CompanyObj.Owners) > 0 then
            CompanyObj.Owners := CompanyObj.Owners & To_Unbounded_String(", ") & To_Unbounded_String(Name);
            Ada.Text_IO.Put_Line(Name &" Has Been added as an owner.");
        else
            CompanyObj.Owners := To_Unbounded_String(Name);
             Ada.Text_IO.Put_Line(Name &" Has Been added as an owner.");
        end if;
    else
        Ada.Text_IO.Put_Line("Cannot add more owners. The maximum number of owners has been reached.");
    end if;
end AddOwnership;


   function ProcessPurchase(CompanyObj: in out Company; Name: String; NumStocks: Integer) return Boolean is
      function Count_Owners(Owners : Unbounded_String) return Natural is
         Count : Natural := 0;
        begin
         for I in 1 .. Length(Owners) loop
            if Element(Owners, I) = ',' then
               Count := Count + 1;
            end if;
         end loop;
         -- Add one to count for the last owner (or the only one if no commas are present).
         return Count + 1;
        end Count_Owners;

      Current_Num_Owners : Natural;
      begin
      -- Count the current number of owners.
      Current_Num_Owners := Count_Owners(CompanyObj.Owners);

      if NumStocks > 0 and then (CompanyObj.Max_Stock - NumStocks) >= 0 and then Count_Owners(CompanyObj.Owners) < CompanyObj.Max_Owner then
        CompanyObj.Max_Stock := CompanyObj.Max_Stock - NumStocks;
        CompanyObj.Fundings := CompanyObj.Fundings + (NumStocks * CompanyObj.Stock_Price);
        AddOwnership(CompanyObj, Name); -- Assumes this always succeeds or also checks internally
        return True;
    else
        return False;
    end if;
   end ProcessPurchase;

   function GetStockPrice(CompanyObj: Company) return Integer is
   begin
      return CompanyObj.Stock_Price;
   end GetStockPrice;

   procedure Set_Stock_Price(Comp : in out Company; Price : Integer) is
   begin
      Comp.Stock_Price := Price;
   end Set_Stock_Price;


   -- Setters Implementation
    procedure Set_ID(CompanyObj : in out Company; Value : Integer) is
    begin
        CompanyObj.ID := Value;
    end Set_ID;

    procedure Set_Max_Owner(CompanyObj : in out Company; Value : Integer) is
    begin
        CompanyObj.Max_Owner := Value;
    end Set_Max_Owner;

    procedure Set_Max_Stock(CompanyObj : in out Company; Value : Integer) is
    begin
        CompanyObj.Max_Stock := Value;
    end Set_Max_Stock;

    procedure Set_Fundings(CompanyObj : in out Company; Value : Integer) is
    begin
        CompanyObj.Fundings := Value;
    end Set_Fundings;

   procedure Print(CompanyObj : in Company) is
   begin
      Ada.Text_IO.Put_Line("Company ID: " & Integer'Image(CompanyObj.ID));
      Ada.Text_IO.Put_Line("Max Owners: " & Integer'Image(CompanyObj.Max_Owner));
      Ada.Text_IO.Put_Line("Stock Price: " & Integer'Image(CompanyObj.Stock_Price));
      Ada.Text_IO.Put_Line("Max Stock: " & Integer'Image(CompanyObj.Max_Stock));
      Ada.Text_IO.Put_Line("Fundings: " & Integer'Image(CompanyObj.Fundings));
      Ada.Text_IO.Put_Line("Owners: " & To_String(CompanyObj.Owners));
   end Print;

end Company_Package;
