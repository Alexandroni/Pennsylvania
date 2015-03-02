--Joao Pedro Alexandroni
--Layout TEST

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Layout; use Layout;
with layout.search; use layout.search;

procedure layout_search_test is

   --Packages to put types out
   package Block_ID_IO is new Ada.Text_IO.Enumeration_IO (layout.Block_ID);
   package Block_Direction_IO is new Ada.Text_IO.Enumeration_IO (layout.Block_Direction);

   package Turnout_ID_IO is new Ada.Text_IO.Enumeration_IO (layout.Turnout_ID);
   package Turnout_Direction_IO is new Ada.Text_IO.Enumeration_IO (layout.Turnout_Direction);

   package Sensor_ID_IO is new Ada.Text_IO.Enumeration_IO (layout.Sensor_ID);
   package Sensor_Status_IO is new Ada.Text_IO.Enumeration_IO (layout.Sensor_Status);

   package Terminator_Type_IO is new Ada.Text_IO.Enumeration_IO (layout.Terminator_Type);

   -----------------------------------------------------------------------------
   --Layout Search Test

   --HELPER BLOCKS BENEATH TEST----------------------------------------------------------
   procedure Helper_Blocks_Beneath_test(front     : in Block_ID;
                                        Back      : in Block_ID;
                                        Blc_Dirct : in Block_Direction) is
      List_blc_OUT  : Block_List(1);
      List_turn_out : Turnout_List(1);
      Answer        : Boolean;

      dirct : Block_Direction;
   begin

      dirct := Blc_Dirct;

      Layout.Search.Helper_Blocks_Beneath (Loco            => front,
                                           Caboose         => back,
                                           Direction_Block => dirct,
                                           Blocks          => List_blc_OUT,
                                           Turnouts        => List_turn_out,
                                           Success         => Answer);

      Put(Item => Boolean'Image(Answer));

      Ada.Integer_Text_IO.Put(Item => List_blc_OUT.Size);

      --Block_ID_IO.Put(Item => List_blc_OUT.Items.Block);


   end Helper_Blocks_Beneath_test;


   -----------------------------------------------------------------------------

begin

   Helper_Blocks_Beneath_test(5,4,Normal);

end layout_search_test;
