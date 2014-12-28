with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, NetTypes;

package Read is
   procedure Par_Seq_Read(file1,file2: in string; data: out TPar_Seq);
  -- procedure Par_Seq_Write(file: in string; data: in TPar_Seq);
end Read;
