with NetTypes;
use NetTypes;

package body Budget is
   function BudgetPar_Seq(data: TPar_Seq) return boolean is
      protected Sum is
         procedure Plus(var: integer);
         function GetSum return integer;
      private
         s : integer := 0;
      end Sum;

      protected body Sum is
         procedure Plus(var: integer) is
         begin
            s := s + var;
         end Plus;
         function GetSum return integer is
         begin
            return s;
         end GetSum;
      end Sum;

      task type StepSum is
         entry Start(data1: TPar_Seq; fst1,lst1: integer);
      end StepSum;

      task body StepSum is
         data: TPar_Seq;
         fst,lst: integer;
         s: integer := 0;
      begin
         accept Start(data1: TPar_Seq; fst1,lst1: integer) do
            data := data1;
            fst := fst1;
            lst := lst1;
         end Start;
         for i in fst..lst loop
            s := s + data.cc(i)*data.X(i);
         end loop;
         Sum.Plus(s);
      end StepSum;

      type tasks is array(1..4) of StepSum;
      Steps: tasks;
      i,j: integer;
      summa : integer;
   begin
      i := 1;
      j := 5;
      for k in Steps'Range loop
         Steps(k).Start(data,i,j);
         i := i + 5;
         j := j + 5;
      end loop;
      summa := Sum.GetSum;
      if (summa <= data.C) then
         return true;
      else
         return false;
      end if;
   end;

begin
   null;
end Budget;
