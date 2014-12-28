with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes;

package body Read is
   procedure Par_Seq_Read(file1,file2: in string; data: out TPar_Seq) is
      f: File_Type;
      temp: TempArray2;
      temp1: TempArray1;
      i,j: integer;
      temp2: TempArray3;
      temp3: TempArray4;
   begin
      open(f,In_File,file1);
      get(f,data.m);
      for i in temp1'Range loop
         get(f,temp1(i));
      end loop;
      i := 1;
      j := 0;
      for k in temp1'Range loop
         j := j + 1;
         temp(i,j) := temp1(k);
         if (k mod 3 = 0) then
            j := 0;
            i := i + 1;
         end if;
      end loop;
      for i in 1..20 loop
         data.lambda(i) := temp(i,1);
         data.lambda1(i) := temp(i,2);
         data.cc(i) := temp(i,3);
      end loop;
      get(f,data.C);
      get(f,data.N);
      close(f);
      open(f,In_File,file2);
      for i in temp2'Range loop
      	get(f,temp2(i));
      end loop;
      i := 1;
      j := 0;
      for k in temp2'Range loop
         j := j + 1;
         temp3(i,j) := temp2(k);
         if (k mod 20 = 0) then
            j := 0;
            i := i + 1;
         end if;
      end loop;
      i := 0;
      j := 0;
      for k in 1..200 loop
         if (k mod 2 = 0) then
            i := i + 1;
            for z in 1..20 loop
            	data.maintime(i,z) := temp3(k,z);
            end loop;
         else
            j := j + 1;
            for z in 1..20 loop
            	data.reservetime(j,z) := temp3(k,z);
            end loop;
         end if;
      end loop;
   end Par_Seq_Read;

begin
	null;
end Read;
