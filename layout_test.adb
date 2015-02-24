--Joao Pedro Alexandroni
--Layout TEST

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with layout; use layout;

procedure layout_test is

   --Packages to put types out
   package Block_ID_IO is new Ada.Text_IO.Enumeration_IO (Block_ID);
   package Block_Direction_IO is new Ada.Text_IO.Enumeration_IO (Block_Direction);

   package Turnout_ID_IO is new Ada.Text_IO.Enumeration_IO (Turnout_ID);
   package Turnout_Direction_IO is new Ada.Text_IO.Enumeration_IO (Turnout_Direction);

   package Sensor_ID_IO is new Ada.Text_IO.Enumeration_IO (Sensor_ID);
   package Sensor_Status_IO is new Ada.Text_IO.Enumeration_IO (Sensor_Status);

   package Terminator_Type_IO is new Ada.Text_IO.Enumeration_IO (Terminator_Type);

   -----------------------------------------------------------------------------
   --Test Functions/Procedures

   --OPPOSITE TEST--
   procedure Opposite_test (Blck_dir      : in Block_Direction;
                            Turn_dir      : in Turnout_Direction;
                            B_Dir_changed : out Block_Direction;
                            T_Dir_changed : out Turnout_Direction) is
   begin

      B_Dir_changed := layout.Opposite(Blck_dir);
       Block_Direction_IO.Put(Item => B_Dir_changed);
      New_Line;
      T_Dir_changed := layout.Opposite(Turn_dir);
      Turnout_Direction_IO.Put(Item => T_Dir_changed);
      New_Line;

   end Opposite_test;

   --GET NEXT TEST--------------------------------------------------------------
   procedure Get_next_test (Block_number : in Block_ID;
                            Blck_Direct  : in Block_Direction) is

      Next_Termt   : Terminator_Type;
      Next_Blck_ID : Block_ID;
      Next_Turn_ID : Turnout_ID;
   begin

      layout.Get_Next(Block_Num  => Block_number,
                      Direction  => Blck_Direct,
                      Terminator => Next_Termt);

      Put_Line("Block ID: ");
      Block_ID_IO.Put(Item => Block_number);
      New_Line;

      Put_Line("Direction: ");
      Block_Direction_IO.Put(Item => Blck_Direct);
      New_Line;

      Put_Line("Next Terminator: ");
      Terminator_Type_IO.Put(Item => Next_Termt);
      New_Line;

      if Next_Termt = Block then

         layout.Get_Next_Block_ID(Block_N   => Block_number,
                                  Direction => Blck_Direct,
                                  Next_ID   => Next_Blck_ID);

         Put_Line("Next Block ID: ");
         Block_ID_IO.Put(Item => Next_Blck_ID);

      else

         Layout.Get_Next_Turnout_ID(Block     => Block_number,
                                    Direction => Blck_Direct,
                                    Next_ID   => Next_Turn_ID);

         Put_Line("Next Turnout ID: ");
         Turnout_ID_IO.Put(Item => Next_Turn_ID);

      end if;

   end Get_next_test;

   --GET BLOCK TEST-------------------------------------------------------------
   procedure Get_Block_test (Turnout_Num : in Turnout_ID;
                             Turn_Direct : in Turnout_Direction) is
      Next_Block : Block_ID;
   begin

      Layout.Get_Block(Turnout   => Turnout_Num,
                       Direction => Turn_Direct,
                       Block     => Next_Block);

      Put_Line("Turnout ID: ");
      Turnout_ID_IO.Put(Item => Turnout_Num);
      New_Line;

      Put_Line("Turn Direction: ");
      Turnout_Direction_IO.Put(Item => Turn_Direct);
      New_Line;

      Put_Line("Next Block: ");
      Block_ID_IO.Put(Item => Next_Block);


   end Get_Block_test;

   --SENSOR BLOCKS TEST---------------------------------------------------------
   procedure Sensor_blocks_test (Sensor_IN : in Sensor_ID) is

      Block_1 : Block_ID;
      Block_2 : Block_ID;

   begin

      layout.Sensor_Blocks (Sensor => Sensor_IN,
                            Block1 => Block_1,
                            Block2 => Block_2);

      Put_Line("Sensor ID: ");
      Sensor_ID_IO.Put(Item => Sensor_IN);
      New_Line;

      Put_Line("Block 1: ");
      Block_ID_IO.Put(Item => Block_1);
      New_Line;

      Put_Line("Block 2: ");
      Block_ID_IO.Put(Item => Block_2);

   end Sensor_blocks_test;

   --IS ON TEST-----------------------------------------------------------------
   procedure Is_On_Test (Block_1 : in Block_ID;
                         Block_2 : in Block_ID) is
      Sensor_Sts : Sensor_Status;
   begin

      Is_On(Block1 => Block_1,
            Block2 => Block_2,
            Status => Sensor_Sts);

      Put_Line("Block 1: ");
      Block_ID_IO.Put(Item => Block_1);
      New_Line;

      Put_Line("Block 2: ");
      Block_ID_IO.Put(Item => Block_2);
      New_Line;

      Put_Line("Sensor Status: ");
      Sensor_Status_IO.Put(Item => Sensor_Sts);

   end Is_On_Test;

   --IS FORCE TEST--------------------------------------------------------------
   procedure Is_Force_Test (Block_Number : in Block_ID;
                            Blck_Direct  : in Block_Direction) is
      Answer : Boolean;
   begin

      Is_Force(Block_Num => Block_Number,
               Direction => Blck_Direct,
               Answer => Answer);

      Put_Line("Block ID: ");
      Block_ID_IO.Put(Item => Block_Number);
      New_Line;

      Put_Line("Block Direction: ");
      Block_Direction_IO.Put(Item => Blck_Direct);
      New_Line;

      Put_Line("Is Force? ");
      Put(Item => Boolean'Image(Answer));

   end Is_Force_Test;

   --WHO IS FORCE TEST----------------------------------------------------------
   procedure Who_is_force_test (Block_Number : in Block_ID;
                                Direction    : in Block_Direction) is

      Turn_Num    : Turnout_ID;
      Turn_Choice : Turnout_Direction;
   begin

      Who_is_Force(Block_Num      => Block_Number,
                   Block_Dir      => Direction,
                   Turn_ID        => Turn_Num,
                   Turnout_Choice => Turn_Choice);

      Put_Line("Block ID: ");
      Block_ID_IO.Put(Item => Block_Number);
      New_Line;

      Put_Line("Block Direction: ");
      Block_Direction_IO.Put(Item => Direction);
      New_Line;

      Put_Line("Turnout ID: ");
      Turnout_ID_IO.Put(Item => Turn_Num);
      New_Line;

      Put_Line("Turnout Choice: ");
      Turnout_Direction_IO.Put(Item => Turn_Choice);

   end Who_is_force_test;

   --IS JOIN TEST---------------------------------------------------------------
   procedure Is_joint_test (Turn_Number : in Turnout_ID;
                            Turn_Direct : in Turnout_Direction) is
      Answer : Boolean;
   begin

      Answer := Layout.Is_Joint(Turn_Number, Turn_Direct);

      Put_Line("Turnout ID: ");
      Turnout_ID_IO.Put(Item => Turn_Number);
      New_Line;

      Put_Line("Turnout Direction: ");
      Turnout_Direction_IO.Put(Item => Turn_Direct);
      New_Line;

      Put_Line("Is Joint? ");
      Put(Item => Boolean'Image(Answer));

   end Is_joint_test;

   --WHO IS JOIN TEST-----------------------------------------------------------
   procedure Who_is_joint_test (Turn_Number : in Turnout_ID;
                                Turn_Direct : in Turnout_Direction) is
      Joint_Turn_ID : Turnout_ID;
   begin

      Joint_Turn_ID := Who_is_Joint(Turn_Number, Turn_Direct);

      Put_Line("Turnout ID: ");
      Turnout_ID_IO.Put(Item => Turn_Number);
      New_Line;

      Put_Line("Turnout Direction: ");
      Turnout_Direction_IO.Put(Item => Turn_Direct);
      New_Line;

      Put_Line("Joint Turnout: ");
      Turnout_ID_IO.Put(Item => Joint_Turn_ID);

   end Who_is_joint_test;

   -----------------------------------------------------------------------------
   procedure Is_crossing_test (Block_N : in Block_ID) is
      Answer : Boolean;
   begin

      Answer := Layout.Is_crossing(Block_N);

      Put_Line("Block ID: ");
      Block_ID_IO.Put(Item => Block_N);
      New_Line;

      Put_Line("Is crossing? ");
      Put(Item => Boolean'Image(Answer));

   end Is_crossing_test;

   --CROSS BLOCK TEST-----------------------------------------------------------
   procedure Cross_block_test (Block_Number : in Block_ID) is
      Cross_blocked : Block_ID;
   begin

      Cross_blocked := Cross_Blocks (Block_Number);

      Put_Line("Block ID: ");
      Block_ID_IO.Put(Item => Block_Number);
      New_Line;

      Put_Line("Cross Block: ");
      Block_ID_IO.Put(Item => Cross_blocked);
      New_Line;

   end Cross_block_test;

   --NEXT CHOICE TEST-----------------------------------------------------------
   procedure Next_choice_Test (Block_Number : in Block_ID;
                               Block_Direct : in Block_Direction) is
      Turn_Choice : Turnout_ID;
   begin

      Layout.Next_choice(Block_Num      => Block_Number,
                         Direction      => Block_Direct,
                         Choice_Turnout => Turn_Choice);

      Put_Line("Block ID: ");
      Block_ID_IO.Put(Item => Block_Number);
      New_Line;

      Put_Line("Block Direction: ");
      Block_Direction_IO.Put(Item => Block_Direct);
      New_Line;

      Put_Line("Next Choice Turnout: ");
      Turnout_ID_IO.Put(Item => Turn_Choice);

   end Next_choice_Test;

   --Variables
   --Block_Opposite   : Block_Direction;
   --Turnout_Opposite : Turnout_Direction;

begin

   --Opposite_test(Normal,
                 --Left,
                 --Block_Opposite,
                 --Turnout_Opposite);

   --Get_next_test(2, Reversed);

   --Get_Block_test(9, Right);

   --Sensor_blocks_test(3);

   --Is_On_Test(12,31);

   --Is_Force_Test(35, Normal);

   --Who_is_force_test(16, Normal);

   --Is_joint_test(17, Left);

   --Who_is_joint_test(6,right);

   --Is_crossing_test(1);

   --Cross_block_test(24);

   --Next_choice_Test(1, Reversed);

end layout_test;
