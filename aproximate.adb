with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes, Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes, Ada.Numerics.Elementary_Functions;
--with Ada.Numerics.Generic_Complex_Elementary_Functions;

package body Aproximate is
   function AproximatePar(data: TPar_Seq) return float is
      t: float;
      eta: float;
      maxes: TM;
      temp: float;
      protected Sum is
         procedure Plus(var: float);
         function GetSum return float;
      private
         s: float := 0.0;
      end Sum;
      protected body Sum is
         procedure Plus(var: float) is
         begin
            s := s + var;
         end Plus;

         function GetSum return float is
         begin
            return s;
         end GetSum;
      end Sum;

      task type SumStep is
         entry start(arr1: TM; fst1,lst1: integer);
      end SumStep;

      task body SumStep is
         summ: float := 0.0;
         arr: TM;
         fst,lst: integer;
      begin
         accept start(arr1: TM; fst1,lst1: integer) do
            arr := arr1;
            fst := fst1;
            lst := lst1;
         end start;
         for i in fst..lst loop
            summ := summ + arr(i);
         end loop;
         Sum.Plus(summ);
      end SumStep;

      type tasks is array(1..4) of SumStep;
      Steps: tasks;

      i,j: integer;

   begin
      for i in maxes'Range loop
         t := Float(data.lambda(1))*log(1.0/(1.0 - data.maintime(i,1)));
         eta := Float(data.lambda1(1))*log(1.0/(1.0 - data.reservetime(i,1)));
         maxes(i) := t + eta*Float(data.X(1));
         for j in 2..20 loop
            t := Float(data.lambda(j))*log(1.0/(1.0 - data.maintime(i,j)));
            eta := Float(data.lambda1(j))*log(1.0/(1.0 - data.reservetime(i,j)));
            temp := t+eta*Float(data.X(j));
            if (temp > maxes(i)) then
               maxes(i) := temp;
            end if;
         end loop;
      end loop;
      i := 1;
      j := 25;
      for k in Steps'Range loop
         Steps(k).Start(maxes,i,j);
         i := i + 25;
         j := j + 25;
      end loop;
      temp := Sum.GetSum;
      temp := 1.0/Float(data.n)*temp;
      return temp;
   end AproximatePar;

   function AproximateSeq(data: TPar_Seq) return float is
      t: float;
      eta: float;
      mins: TM;
      temp: float;
      protected Sum is
         procedure Plus(var: float);
         function GetSum return float;
      private
         s: float := 0.0;
      end Sum;
      protected body Sum is
         procedure Plus(var: float) is
         begin
            s := s + var;
         end Plus;

         function GetSum return float is
         begin
            return s;
         end GetSum;
      end Sum;

      task type SumStep is
         entry start(arr1: TM; fst1,lst1: integer);
      end SumStep;

      task body SumStep is
         summ: float := 0.0;
         arr: TM;
         fst,lst: integer;
      begin
         accept start(arr1: TM; fst1,lst1: integer) do
            arr := arr1;
            fst := fst1;
            lst := lst1;
         end start;
         for i in fst..lst loop
            summ := summ + arr(i);
         end loop;
         Sum.Plus(summ);
      end SumStep;

      type tasks is array(1..4) of SumStep;
      Steps: tasks;

      i,j: integer;

   begin
      for i in mins'Range loop
         t := Float(data.lambda(1))*log(1.0/(1.0 - data.maintime(i,1)));
         eta := Float(data.lambda1(1))*log(1.0/(1.0 - data.reservetime(i,1)));
         mins(i) := t + eta*Float(data.X(1));
         for j in 2..20 loop
            t := Float(data.lambda(j))*log(1.0/(1.0 - data.maintime(i,j)));
            eta := Float(data.lambda1(j))*log(1.0/(1.0 - data.reservetime(i,j)));
            temp := t+eta*Float(data.X(j));
            if (temp > mins(i)) then
               mins(i) := temp;
            end if;
         end loop;
      end loop;
      i := 1;
      j := 25;
      for k in Steps'Range loop
         Steps(k).Start(mins,i,j);
         i := i + 25;
         j := j + 25;
      end loop;
      temp := Sum.GetSum;
      temp := 1.0/Float(data.n)*temp;
      return temp;
   end AproximateSeq;

begin
	null;
end;
