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
   package Turnout_Joint_IO is new Ada.Text_IO.Enumeration_IO (Turnout_Joint);
   package Turnout_Set_IO is new Ada.Text_IO.Enumeration_IO (Turnout_Set);

   package Sensor_ID_IO is new Ada.Text_IO.Enumeration_IO (Sensor_ID);
   package Sensor_Status_IO is new Ada.Text_IO.Enumeration_IO (Sensor_Status);

   package Terminator_Type_IO is new Ada.Text_IO.Enumeration_IO (Terminator_Type);

   -----------------------------------------------------------------------------
   --Test Functions/Procedures

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

   -----------------------------------------------------------------------------
   --Variables
   Block_Opposite   : Block_Direction;
   Turnout_Opposite : Turnout_Direction;

begin

   Opposite_test(Reversed,
                 Right,
                 Block_Opposite,
                 Turnout_Opposite);

end layout_test;
