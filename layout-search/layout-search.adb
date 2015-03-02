--Pensylvania Huy Nguyen
with Layout;
use Layout;
package body Layout.Search is

-- Using function, procedures in Layout to locate the blocks under
--the train.
   ------------------
   --append_Turnout--
   ------------------

   procedure append_Turnout (Rec  : in Turnout_Rec;
                             List : out Turnout_List) is
   begin
      List.Size  := List.Size + 1;
      List.Items := (List.Size => Rec);
   end append_Turnout;

   ----------------
   --append_Block--
   ----------------

   procedure append_Block (Rec  : in Block_Rec;
                           List : out Block_List) is
   begin
      List.Size  := List.Size + 1;
      List.Items := (List.Size => Rec);
   end append_Block;

   ---------------
   --pop_Turnout--
   ---------------

   procedure pop_Turnout ( List : out Turnout_List) is

   begin
      --Decrementing the size does not physically remove the elements, by make it
      --logically inaccessible
      List.Size := List.Size -1;
   end pop_Turnout;

   -------------
   --pop_Block--
   -------------
   procedure pop_Block ( List : out Block_List) is

   begin
      List.Size := List.Size -1;
   end pop_Block;

   -------------------
   --Blocks_Beaneath--
   -------------------

   procedure Blocks_Beneath (Loco     : in  Block_ID;         -- Front of train
                             Caboose  : in  Block_ID;         -- Rear of train
                             Blocks   : out Block_List;       -- Under train
                             Turnouts : out Turnout_List;     -- Under train
                             Success  : out Boolean) is

   Direction : Block_Direction := Normal;
   begin

   Helper_Blocks_Beneath (Loco            => Loco,
                          Caboose         => Caboose,
                          Direction_Block => Direction,
                          Blocks          => Blocks,
                          Turnouts        => Turnouts,
                          Success         => Success);
   --check on the normal

   if not Success then

   Turnouts.Size :=0;
   --set the Turnout List to nothing

   Blocks.Size :=0;
   --set the Block List to nothing

   Direction := Reversed;
      Helper_Blocks_Beneath (Loco            => Loco,
                             Caboose         => Caboose,
                             Direction_Block => Direction,
                             Blocks          => Blocks,
                             Turnouts        => Turnouts,
                             Success         => Success);
   --check on the reverse, answer depends on the Success value

      if not Success then

         Turnouts.Size :=0;
         --set the Turnout List to nothing

         Blocks.Size :=0;
         --set the Block List to nothing

      end if;

   end if;

   end Blocks_Beneath;


   --------------------------
   --Helper_Blocks_Beaneath--
   --------------------------


   procedure Helper_Blocks_Beneath (Loco            : in  Block_ID;           -- Front of train
                                    Caboose         : in  Block_ID;           -- Rear of train
                                    Direction_Block : in out Block_Direction; -- Normal or Reversed
                                    Blocks          : out Block_List;         -- Under train
                                    Turnouts        : out Turnout_List;       -- Under train
                                    Success         : out Boolean) is
   Direction_Turnout : Turnout_Direction;
   Block_Num         : Block_ID;
   Turnout_Num       : Turnout_ID;
   Terminator        : Terminator_Type;
   Status            : Sensor_Status;
   Answer            : Boolean;
   begin

      --the logic is that, at 1st check the next one of Locomotive
      --A. if it is a Block
      --1.Check if there is a Sensor is On, if it is, revert the direction
      --of the second Block to proceed.
      --2.Append the Block_ID in our Block_list with its direction
      --3.Check if there is a force turnout, if there is, append the
      --turnout ID with its direction into our Turnout List.
      --B. if it is a Turnout
      --1.Append the turnout ID into our Turnout_List, set the direction to left
      --2.Store our 1st Block ID left as Value and begin to the left
      --and store the 2nd Block_Right to another value
      --C. if it is a Deadend, check the size of our Block_List, if it is 3,
      --check if the Cabooze is 40, if not, return Success= False, else,
      --return true

      --continue with this algorithm as long as the Block_List size is
      --less than Max_Size
      --Do the same thing on Reverse direction if Nothing is found on Reverse

      Direction_Turnout := Left;
      --set the direction to Left

      Success := False;
      --set Success to False

      if Blocks.Size <= BLocks.Max_Size and Success = False then
      --Stop the loop if Block List size is bigger than max size
      -- or Loco is the Caboose through Recursive

         Get_Next(Block_Num  => Loco,
                  Direction  => Direction_Block,
                  Terminator => Terminator);

         Case Terminator is
            when Block =>
            --check if it is a block

               Is_Force (Block_Num => Loco,
                         Direction => Direction_Block,
                         Answer    => Answer);
               --check if there is a force turnout at the end of our
               --initial block

               if Answer then

                  Who_is_Force (Block_Num => Loco,
                                Block_Dir => Direction_Block,
                                Turn_ID   => Turnout_Num,
                               Turnout_Choice => Direction_Turnout);
                  --get the Turnout ID and the Direction of it

                  append_Turnout (Rec  => (Turnout_Num,Direction_Turnout),
                               List => Turnouts);
                  --append the Turnout Rec into our Turnout List

               end if;

               Get_Next_Block_ID (Block_N   => Loco,
                                  Direction => Direction_Block,
                                  Next_ID   => Block_Num);
               --get the Block ID of the next Block

               Is_On (Block1 => Loco,
                      Block2 => Block_Num,
                      Status => Status);
               --check if there is a reverse sensor between the 2 blocks

               if Status = On then

                  Direction_Block := Opposite (Direction_Block);
                     --revert the Direction

               end if;
               append_Block (Rec  => (Block_Num,Direction_Block),
                             List => Blocks);


               Helper_Blocks_Beneath (Loco            => Block_Num,
                               Caboose         => Caboose,
                               Direction_Block => Direction_Block,
                               Blocks          => Blocks,
                               Turnouts        => Turnouts,
                               Success         => Success);
               --using recursive call

               if Loco = Caboose then

                  Success := True;

               end if;

            when Turnout =>
               --check if it is a choice turnout

               Get_Next_Turnout_ID ( Block     => Loco,
                                     Direction => Direction_Block,
                                     Next_ID   => Turnout_Num);
               --get the Turnout ID


               --follow through left limb--

               Get_Block  (Turnout   => Turnout_Num,
                           Direction => Direction_Turnout,
                           Block     => Block_Num);
               --get the Block ID number on the left limb

               append_Turnout (Rec  => (Turnout_Num,Direction_Turnout),
                               List => Turnouts);
               --append the turnout ID to the Turnout List with
               --Direction Left

               Is_On (Block1 => Loco,
                      Block2 => Block_Num,
                      Status => Status);
               --check if there is a reverse sensor between the the
               --2 blocks

               if Status = On then

                  Direction_Block := Opposite(Direction_Block);
                  --revert the block direction

               end if;
               append_Block (Rec  => (Block_Num,Direction_Block),
                             List => Blocks);


               Helper_Blocks_Beneath (Loco            => Block_Num,
                                      Caboose         => Caboose,
                                      Direction_Block => Direction_Block,
                                      Blocks          => Blocks,
                                      Turnouts        => Turnouts,
                                      Success         => Success);
               --using recursive call

               if Loco = Caboose then

                  Success := True;

               end if;


                --follow through right limb--

               Direction_Turnout:= Opposite(Direction_Turnout);
               --revert the turnout limb to Right limb

               Get_Block  (Turnout   => Turnout_Num,
                           Direction => Direction_Turnout,
                           Block     => Block_Num);
               --get the Block ID number on the Right limb

               pop_Turnout (List => Turnouts);
               --pop the last turnout with the wrong limb

               append_Turnout (Rec  => (Turnout_Num,Direction_Turnout),
                               List => Turnouts);
               --append our turnout to the Turnout list
               --with Direction Right

               pop_Turnout (List => Turnouts);
               --pop the last Block on the wrong limb

               Is_On (Block1 => Loco,
                      Block2 => Block_Num,
                      Status => Status);
               --check if there is a reverse sensor between the the
               -- 2 blocks


               if Status = On then

                  Direction_Block := Opposite(Direction_Block);
                  --revert the block direction

               end if;
               append_Block (Rec  => (Block_Num,Direction_Block),
                             List => Blocks);

               Helper_Blocks_Beneath (Loco            => Block_Num,
                                      Caboose         => Caboose,
                                      Direction_Block => Direction_Block,
                                      Blocks          => Blocks,
                                      Turnouts        => Turnouts,
                                      Success         => Success);
               --using recursive call

               if Loco = Caboose then

                  Success := True;

               end if;


            when Deadend =>
               null;

         end case;
      end if;


   end Helper_Blocks_Beneath;

end Layout.Search;
