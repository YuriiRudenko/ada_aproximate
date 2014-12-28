with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes, Read, Budget, Perebor;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes, Read, Budget, Perebor;

with Aproximate;
use  Aproximate;

procedure main is
   par,par1,par2: TPar_Seq;
   protected Max is
      procedure Calc(input: TPar_seq);
      function GetMax return TPar_Seq;
   private
      max: TPar_seq;
      count : integer := 0;
   end Max;

   protected body Max is
      procedure Calc(input: TPar_Seq) is
      begin
         count := count + 1;
         if ((count = 1) or (input.F > max.F)) then
            max := input;
         end if;
      end Calc;

      function GetMax return TPar_Seq is
      begin
         return max;
      end GetMax;
   end Max;

   task type Maxis is
      entry start(data1: TPar_seq; limit1: DataArrayPar_Seq; b1,b2: integer; t1: integer);
   end Maxis;
   task body Maxis is
      data: TPar_Seq;
      limit: DataArrayPar_Seq;
      b11,b22,t: integer;
   begin
      accept start(data1:TPar_Seq; limit1: DataArrayPar_Seq; b1,b2: integer; t1: integer) do
         data := data1;
         limit := limit1;
         b11 := b1;
         b22 := b2;
         t := t1;
      end start;
      data := PereborPar(data,limit,b11,b22,t);
      Max.Calc(data);
   end Maxis;

   type tasks is array(1..2) of Maxis;
   Steps: tasks;

begin
   Par_Seq_Read(file1 => "par_09.dat", file2 => "par_09.tet", data  => par1);
   par1.X := (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
   par2 := par1;
   steps(1).start(par1,(0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1),11,20,1);
   steps(2).start(par2,(1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0),1,10,2);
   par := Max.GetMax;
   put("X = [");
   for i in 1..20 loop
      put(par1.X(i),3);
   end loop;
   put("]");
   put_line("");
   put_line("F(X) = "&par1.F'Img);
end main;
