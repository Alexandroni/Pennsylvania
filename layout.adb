--Pensylvania Huy Nguyen
--         -- Joao Pedro Alexandroni

with layout;
package body layout is

   -----------
   -- Variant procedure for Block, Turnout, Deadend Rec)
   ---------
   type Terminator_Rec (Which : Terminator_Type := Block) is
      record
         case Which is
            when Block =>
               Block_Num     : Block_ID;
            when Turnout =>
               Turnout_Num   : Turnout_ID;
            when Deadend =>
               null;
         end case;
      end record;

   type Turnout_Rec is
      record
         First_Joint : Turnout_ID;
         Second_Joint: Turnout_ID;
         Joint_At    : Turnout_Direction;
      end record;

   type Cross_block_Rec is
      record
         Block1      : Block_ID;
         Block2      : Block_ID;
      end record;

   ----------------------------------------------------------------------------
   --Array, Rec for list of Block, Turn, Sensor extended
   ---------------------------------------------------------------------------


   type Turnout_Type is array (Turnout_ID, Turnout_Direction) of Block_ID;
   Turnout_block_list : constant Turnout_Type :=
                  (1 => (13,12),
                   2 => (2,14),
                   3 => (13,1),
                   4 => (26,14),
                   5 => (16,28),
                   6 => (3,17),
                   7 => (16,17),
                   8 => (30,17),
                   9 => (34,38),
                   10 => (39,7),
                   11 => (25,28),
                   12 => (9,27),
                   13 => (9,29),
                   14 => (25,27),
                   15 => (11,12),
                   16 => (36,32),
                   17 => (4,19),
                   18 => (18,3),
                   19 => (35,19),
                   20 => (39,20),
                   21 => (22,23),
                   22 => (22,5),
                   23 => (6,40),
                   24 => (40,40),
                   25 => (40,40),
                   26 => (40,40));


   type Sensor_Array is array (Sensor_ID) of Sensor_Type;

   Layout_Sensors : constant Sensor_Array :=
                     (1 =>  (1, 11,Off),
                      2 => (13, 31,Off),
                      3 => (31, 12,On),
                      4 => (31, 36,On),
                      5 => (31, 32,On),
                      6 => (11, 10,Off),
                      7 => (12, 10,Off),
                      8 => (14, 13,Off),
                      9 => (2, 13,Off),
                      10 => (2, 1,Off),
                      11 => (15, 14,Off),
                      12 => (15, 26,Off),
                      13 => (37, 36,Off),
                      14 => (33, 32,Off),
                      15 => (16, 15,Off),
                      16 => (15, 28,Off),
                      17 => (26, 25,Off),
                      18 => (26, 27,Off),
                      19 => (10, 9,Off),
                      20 => (10, 29,Off),
                      21 => (17, 16,Off),
                      22 => (17, 2,Off),
                      23 => (3, 2,Off),
                      24 => (34, 33,Off),
                      25 => (38, 37,Off),
                      26 => (24, 28,On),
                      27 => (25, 24,Off),
                      28 => (27, 8,Off),
                      29 => (9, 8,Off),
                      30 => (29, 30,On),
                      31 => (8, 39,On),
                      32 => (8, 7,Off),
                      33 => (17, 18,Off),
                      34 => (30, 18,Off),
                      35 => (38, 35,Off),
                      36 => (34, 36,Off),
                      37 => (23, 24,Off),
                      38 => (3, 4,Off),
                      39 => (18, 4,Off),
                      40 => (18, 19,Off),
                      41 => (19, 20,Off),
                      42 => (35, 20,Off),
                      43 => (20, 21,Off),
                      44 => (39, 21,Off),
     		      45 => (5, 4,Off),
     		      46 => (23, 21,Off),
                      47 => (22, 21,Off),
                      48 => (6, 22,Off),
                      49 => (5, 6,Off),
                      50 => (7, 6,Off),
                      51 => (40, 7,Off));

   -- create record of array of turnout
      type End_Of_Block_Array is array (Block_ID, Block_Direction) of
        Terminator_Rec;
   --create a record of end of block



   End_Of_Block : constant End_Of_Block_Array :=
                    (1 => ((Which => Block, Block_Num => 2),
                           (Which => Block, Block_Num => 11)),
                     2 => ((Which => Turnout, Turnout_Num => 6),
                           (Which => Turnout, Turnout_Num => 3)),
                     3 => ((Which => Block, Block_Num => 4),
                           (Which => Block, Block_Num => 2)),
                     4 => ((Which => Block, Block_Num => 5),
                           (Which => Turnout, Turnout_Num => 18)),
                     5 => ((Which => Block, Block_Num => 6),
                           (Which => Block, Block_Num => 4)),
                     6 => ((Which => Block, Block_Num => 7),
                           (Which => Turnout, Turnout_Num => 22)),
                     7 => ((Which => Block, Block_Num => 8),
                           (Which => Turnout, Turnout_Num => 23)),
                     8 => ((Which => Turnout, Turnout_Num => 12),
                           (Which => Turnout, Turnout_Num => 10)),
                     9 => ((Which => Block, Block_Num => 10),
                           (Which => Block, Block_Num => 8)),
                     10 => ((Which => Turnout, Turnout_Num => 15),
                            (Which => Turnout, Turnout_Num => 13)),
                     11 => ((Which => Block, Block_Num => 1),
                            (Which => Block, Block_Num => 10)),
                     12 => ((Which => Block, Block_Num => 31),
                            (Which => Block, Block_Num => 10)),
                     13 => ((Which => Turnout, Turnout_Num => 2),
                            (Which => Block, Block_Num => 31)),
                     14 => ((Which => Block, Block_Num => 15),
                            (Which => Block, Block_Num => 13)),
                     15 => ((Which => Turnout, Turnout_Num => 5),
                            (Which => Turnout, Turnout_Num => 4)),
                     16 => ((Which => Block, Block_Num => 17),
                            (Which => Block, Block_Num => 15)),
                     17 => ((Which => Block, Block_Num => 18),
                            (Which => Turnout, Turnout_Num => 7)),
                     18 => ((Which => Turnout, Turnout_Num => 17),
                            (Which => Turnout, Turnout_Num => 8)),
                     19 => ((Which => Block, Block_Num => 20),
                            (Which => Block, Block_Num => 18)),
                     20 => ((Which => Block, Block_Num => 21),
                            (Which => Turnout, Turnout_Num => 19)),
                     21 => ((Which => Turnout, Turnout_Num => 21),
                            (Which => Turnout, Turnout_Num => 20)),
                     22 => ((Which => Block, Block_Num => 6),
                            (Which => Block, Block_Num => 21)),
                     23 => ((Which => Block, Block_Num => 24),
                            (Which => Block, Block_Num => 21)),
                     24 => ((Which => Turnout, Turnout_Num => 11),
                            (Which => Block, Block_Num => 23)),
                     25 => ((Which => Block, Block_Num => 26),
                            (Which => Block, Block_Num => 24)),
                     26 => ((Which => Block, Block_Num => 15),
                            (Which => Turnout, Turnout_Num => 14)),
                     27 => ((Which => Block, Block_Num => 26),
                            (Which => Block, Block_Num => 8)),
                     28 => ((Which => Block, Block_Num => 24),
                            (Which => Block, Block_Num => 15)),
                     29 => ((Which => Block, Block_Num => 10),
                            (Which => Block, Block_Num => 30)),
                     30 => ((Which => Block, Block_Num => 18),
                            (Which => Block, Block_Num => 29)),
                     31 => ((Which => Turnout, Turnout_Num => 1),
                            (Which => Turnout, Turnout_Num => 16)),
                     32 => ((Which => Block, Block_Num => 33),
                            (Which => Block, Block_Num => 31)),
                     33 => ((Which => Block, Block_Num => 34),
                            (Which => Block, Block_Num => 32)),
                     34 => ((Which => Block, Block_Num => 35),
                            (Which => Block, Block_Num => 33)),
                     35 => ((Which => Block, Block_Num => 20),
                            (Which => Turnout, Turnout_Num => 9)),
                     36 => ((Which => Block, Block_Num => 37),
                            (Which => Block, Block_Num => 31)),
                     37 => ((Which => Block, Block_Num => 38),
                            (Which => Block, Block_Num => 36)),
                     38 => ((Which => Block, Block_Num => 35),
                            (Which => Block, Block_Num => 37)),
                     39 => ((Which => Block, Block_Num => 21),
                            (Which => Block, Block_Num => 8)),
                     40 => ((Which => Block, Block_Num => 7),
                            (Which => Deadend)));

   --array contai joint turnouts
   type Joint_Turnout is array (1..6) of Turnout_Rec;
   Joint_Turnout_Array : constant Joint_Turnout :=
                     (1 => (2,3,Left),
                      2 => (3,2,Left),
                      3 => (6,7,Right),
                      4 => (7,6,Right),
                      5 => (17,18,Left),
                      6 => (18,17,Left));

   --Array contains block cross
    type Block_Cross is array (1..3) of Cross_block_Rec;
   Block_Cross_Array : constant Block_Cross :=
                     (1 => (8,29),
                      2 => (23,39),
                      3 => (24,30));

   ----------------------------------------------------------------------------
   --Functions and Procedures
   ----------------------------------------------------------------------------

   --------------
   -- Opposite --
   --------------

   function Opposite (Direction : in Block_Direction) return Block_Direction is
   begin
      if Direction = Normal then
         return Reversed;
      else
         return Normal;
      end if;
   end Opposite;

   --------------
   -- Opposite --
   --------------

   function Opposite (Direction : in Turnout_Direction) return Turnout_Direction
   is
   begin
      if Direction = Left then
         return Right;
      else
         return Left;
      end if;
   end Opposite;

   -------------------
   -----Get_Next------
   -------------------
   --Return the terminator of a block
   procedure Get_Next(Block_Num : in Block_ID;
                      Direction : in Block_Direction;
                      Terminator: out Terminator_Type) is
   begin
      Terminator := End_Of_Block(Block_Num,Direction).Which;
   end Get_Next;


   ---------------------
   --Get Next Block ID--
   ---------------------
   procedure Get_Next_Block_ID (Block_N   : in Block_ID;
                                Direction : in Block_Direction;
                                Next_ID   : out Block_ID) is
      Next_Terminator : Terminator_Type;
   begin

      Get_Next(Block_Num  => Block_N,
               Direction  => Direction,
               Terminator => Next_Terminator);

      if Next_Terminator = Block then
         Next_ID := End_Of_Block(Block_N,Direction).Block_Num;
      end if;

   end Get_Next_Block_ID;

   -----------------------
   --Get Next Turnout ID--
   -----------------------
   procedure Get_Next_Turnout_ID (Block     : in Block_ID;
                                  Direction : in Block_Direction;
                                  Next_ID   : out Turnout_ID) is
      Terminator : Terminator_Type;
   begin

      Get_Next(Block_Num  => Block,
               Direction  => Direction,
               Terminator => Terminator);

      if Terminator = Turnout then
         Next_ID := End_Of_Block(Block,Direction).Turnout_Num;
      end if;

   end Get_Next_Turnout_ID;


   -----------------
   --Sensor Blocks--
   -----------------
   --Return two blocks next to a sensor
   procedure Sensor_Blocks (Sensor  : in Sensor_ID;
                            Block1  : out Block_ID;
                            Block2  : out Block_ID) is
   begin
      Block1 := Layout_Sensors (Sensor).Block1;
      Block2 := Layout_Sensors (Sensor).Block2;
   end Sensor_Blocks;

   -----------------
   ------Is On------
   -----------------

   procedure Is_On (Block1 : in Block_ID;
                    Block2 : in Block_ID;
                    Status : out Sensor_Status) is
   begin

      for Index in Layout_Sensors'Range loop

         if Layout_Sensors(Index).Block1 = Block1 and Layout_Sensors(Index).Block2 = Block2 then
             Status := Layout_Sensors(Index).Status;
         elsif Layout_Sensors(Index).Block1 = Block2 and Layout_Sensors(Index).Block2 = Block1 then
             Status := Layout_Sensors(Index).Status;
         end if;

      end loop;

   end Is_On;

   -----------------
   ----Is Force ----
   -----------------
   --Return True if exist a force turnout next to a block

   procedure Is_Force (Block_Num   : in Block_ID;
                       Direction   : in Block_Direction;
                       Answer      : out Boolean)  is
      Next_Blc_ID : Block_ID;
      Terminator  : Terminator_Type;
      Status      : Sensor_Status;
   begin
      Get_Next( Block_Num  => Block_Num,
                Direction  => Direction,
                Terminator => Terminator);

      if Terminator = Turnout then
         Answer := False;
      elsif Terminator = Block then

         Get_Next_Block_ID (Block_N    => Block_Num,
                            Direction  => Direction,
                            Next_ID    => Next_Blc_ID);

         Is_On(Block1 => Block_Num,
               Block2 => Next_Blc_ID,
               Status => Status);

         if Status = On then
            Get_Next(Block_Num  => Next_Blc_ID,
                     Direction  => Direction,
                     Terminator => Terminator);
         else
            Get_Next(Block_Num  => Next_Blc_ID,
                     Direction  => Opposite(Direction),
                     Terminator => Terminator);
         end if;

         if Terminator = Turnout then
            Answer := True;
         else
            Answer := False;
         end if;
      end if;
   end Is_Force;

   ------------------
   ---Who is Force---
   ------------------
   --Return turnout id and his set if is force turnout
   procedure Who_is_Force (Block_Num       : in Block_ID;
                           Block_Dir       : in Block_Direction;
                           Turn_ID         : out Turnout_ID;
                           Turnout_Choice  : out Turnout_Direction) is
      Answer     : Boolean;
      Next_ID    : Block_ID;
      Status     : Sensor_Status;
   begin

      Is_Force(Block_Num  => Block_Num,
               Direction  => Block_Dir,
               Answer     => Answer);

      if Answer = True then

         Get_Next_Block_ID(Block_N    => Block_Num,
                           Direction  => Block_Dir,
                           Next_ID    => Next_ID);


         Is_On(Block1 => Block_Num,
               Block2 => Next_ID,
               Status => Status);

         if Status = On then

            Get_Next_Turnout_ID(Block     => Next_ID,
                                Direction => Block_Dir,
                                Next_ID   => Turn_ID);
         else

            Get_Next_Turnout_ID(Block     => Next_ID,
                                Direction => Opposite(Block_Dir),
                                Next_ID   => Turn_ID);
         end if;

         if Turnout_block_list(Turn_ID,Left) = Block_Num then
            Turnout_Choice := Left;
         else
            Turnout_Choice := Right;
         end if;

      end if;

   end Who_is_Force;

   ----------------
   ----Is Joint----
   ----------------
   --Return True if the turnout is joint

   function Is_Joint (Turnout_Num : in Turnout_ID;
                      Direction   : in Turnout_Direction) return Boolean is
   begin

      for Index in Joint_Turnout_Array'Range loop

         if Turnout_Num = Joint_Turnout_Array (Index).First_Joint or Turnout_Num = Joint_Turnout_Array (Index).Second_Joint then

            if Direction = Joint_Turnout_Array (Index).Joint_At then
               return True;
            else
               return False;
            end if;
         else
            return False;
         end if;

      end loop;

   end Is_Joint;

   ----------------
   --Who is Joint--
   ----------------
   --Return the Turnout id and his direction of its joint

   function Who_is_Joint (Turnout_Num    : in Turnout_ID;
                           Direction     : in Turnout_Direction) return Turnout_ID is
      Answer : Boolean;
   begin

      Answer := Is_Joint(Turnout_Num, Direction);

      if Answer = True then

         for Index in Joint_Turnout_Array'Range loop

            if Turnout_Num = Joint_Turnout_Array (Index).First_Joint then

               if Direction = Joint_Turnout_Array (Index).Joint_At then
                  return Joint_Turnout_Array (Index).Second_Joint;
               end if;

            elsif Turnout_Num = Joint_Turnout_Array (Index).Second_Joint then

               if Direction = Joint_Turnout_Array (Index).Joint_At then
                  return Joint_Turnout_Array (Index).First_Joint;
               end if;

            end if;

         end loop;

      end if;

   end Who_is_Joint;

   --------------------
   -----Cross Block----
   --------------------
   function Cross_Blocks (Block : in Block_ID) return Block_ID is
   begin

      for Index in Block_Cross_Array'Range loop

         if Block = Block_Cross_Array(Index).Block1 then
            return Block_Cross_Array(Index).Block2;
         elsif Block = Block_Cross_Array(Index).Block2 then
            return Block_Cross_Array(Index).Block1;
         end if;

      end loop;

   end Cross_Blocks;


   --------------------
   ----Next Choice ----
   --------------------
   --Return the next choice turnout of a block

   procedure Next_choice (Block_Num      : in Block_ID;
                          Direction : in Block_Direction;
                          Choice_Turnout : out Turnout_ID) is
      Next_blc_ID : Block_ID;
      Blck_Direction : Block_Direction;
      Terminator  : Terminator_Type;
      Status      : Sensor_Status;
      Turn_ID     : Turnout_ID;
      Original_block : Block_ID;
   begin

      Blck_Direction := Direction;
      Original_block := Block_Num;

      Loop

         Get_Next(Block_Num => Original_block,
                     Direction => Blck_Direction,
                     Terminator => Terminator);

         if Terminator /= Turnout then

            Get_Next_Block_ID(Block_N   => Original_block,
                              Direction => Blck_Direction,
                              Next_ID   => Next_blc_ID);

            Is_On(Block1 => Original_block,
                  Block2 => Next_blc_ID,
                  Status => Status);

            if Status = On then

               Blck_Direction := Opposite(Blck_Direction);

            end if;

            Original_block := Next_blc_ID;

         else

            Get_Next_Turnout_ID(Block     => Original_block,
                                Direction => Blck_Direction,
                                Next_ID   => Turn_ID);
         end if;

         exit when Terminator = Turnout;
      end loop;

      Choice_Turnout := Turn_ID;


   end Next_choice;

end layout;
