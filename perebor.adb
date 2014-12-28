with NetTypes, Budget, Aproximate, ada.Text_IO, ada.Float_Text_IO, ada.Integer_Text_IO;
use  NetTypes, Budget, Aproximate, ada.Text_IO, ada.Float_Text_IO, ada.Integer_Text_IO;

package body Perebor is
   function PereborPar(data: TPar_Seq; limit: DataArrayPar_Seq; border1,border2: integer; t: integer) return TPar_Seq is
      procedure Plus(data: in out TPar_Seq; border1,border2: integer) is
         i: integer := border2;
         f: boolean := true;
      begin
         if (data.X(i) = 0) then
            data.X(i) := 1;
         else
            f := true;
            while (i > border1) loop
               if (f = true) then
                  if (data.X(i) = 0) then
                     f := false;
                     data.X(i) := 1;
                  else
                     data.X(i) := 0;
                  end if;
               end if;
               i := i - 1;
            end loop;
         end if;
      end Plus;

      Function Stop(data: TPar_Seq; limit: DataArrayPar_Seq) return boolean is
         f: boolean := True;
      begin
         for i in limit'Range loop
            if (data.X(i) /= limit(i)) then
               f := false;
            end if;
         end loop;
         return f;
      end Stop;

      maxF : float;
      td: TPar_Seq;
      apro : float;
      maxX: DataArrayPar_Seq;
      count: integer := 1;
   begin
      td := data;
      maxF := AproximatePar(td);
      for i in 1..20 loop
      	maxX(i) :=  td.X(i);
      end loop;

      while not(Stop(td,limit)) loop
         Plus(td,border1,border2);
         count := count + 1;

         if ((BudgetPar_Seq(td) = true)) then
            apro := AproximatePar(td);
            if (apro > maxF) then
               put_line("Task #"&t'Img&"::Step #"&count'Img&"-----------------------------------------");
               maxF := apro;
               for i in 1..20 loop
                  maxX(i) :=  td.X(i);
               end loop;
               put("X = [");
               for i in 1..20 loop
                  put(td.X(i),3);
               end loop;
               put("]");
               put_line("");
               put_line("F(X) = "&maxF'Img);
            end if;

         end if;
      end loop;

      for i in 1..20 loop
      	td.X(i) :=  maxX(i);
      end loop;
      td.F := maxF;
      return td;
   end PereborPar;

begin
   null;
end Perebor;
