package NetTypes is
   type DataArrayPar_Seq is array(1..20) of integer;
   type DataArrayPar_SeqFloat is array(1..20) of integer;
   type TempArray1 is array(1..60) of integer;
   type TempArray2 is array(1..20,1..3) of integer;
   type TempArray3 is array(1..4000) of float;
   type TempArray4 is array(1..200,1..20) of float;
   type TLifeTime is array(1..100,1..20) of float;
   type TM is array(1..100) of float;

   type TPar_Seq is
      record
         m,n,c: integer;
         lambda,lambda1: DataArrayPar_Seq;
         cc: DataArrayPar_Seq;
         F: float;
         X: DataArrayPar_Seq;
         maintime, reservetime: TLifeTime;
      end record;



end NetTypes;
