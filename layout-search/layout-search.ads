--Pensylvania Huy Nguyen
with Layout;
package Layout.Search is
   pragma Pure (Layout.Search);

   -- This child package provides types and a procedure to determine the
   -- blocks and the turnouts beneath a train given the location of its
   -- locomotive and caboose.


   -----------------------------------------------------------------------------
   -- Types for a list of blocks
   -----------------------------------------------------------------------------

   type Block_Rec is   -- Elements in the list of blocks
      record
         Block     : Layout.Block_ID;
         Direction : Layout.Block_Direction;
      end record;
   type Block_Array is array (Positive range <>) of Block_Rec;

   -- The value of the record discriminant Max_Size determines the maximum
   -- number of blocks in the list.  This discriminant is set when a variable
   -- of type Block_List is declared

   type Block_List (Max_Size : Positive) is
      record
         Size : Natural := 0;
         Items : Block_Array (1 .. Max_Size);
      end record;

   -----------------------------------------------------------------------------
   -- Types for a list of turnouts
   -----------------------------------------------------------------------------

   type Turnout_Rec is   -- Elements in the list of turnouts
      record
         Turnout   : Layout.Turnout_ID;
         Direction : Layout.Turnout_Direction;
      end record;
   type Turnout_Array is array (Positive range <>) of Turnout_Rec;

   -- The value of the record discriminant Max_Size determines the maximum
   -- number of turnouts in the list.  This discriminant is set when a variable
   -- of type Turnout_List is declared

   type Turnout_List (Max_Size : Positive) is
      record
         Size : Natural := 0;
         Items : Turnout_Array (1 .. Max_Size);
      end record;



   -----------------------------------------------------------------------------
   procedure Blocks_Beneath (Loco     : in  Block_ID;         -- Front of train
                             Caboose  : in  Block_ID;         -- Rear of train
                             Blocks   : out Block_List;       -- Under train
                             Turnouts : out Turnout_List;     -- Under train
                             Success  : out Boolean);

   -- Search the layout for the blocks and turnouts beneath a train
   --
   -- Preconditions  : Loco /= Caboose
   --                  Loco is a Block ID, Caboose is a BLock ID
   --
   -- Postconditions : If Success then
   --                     Blocks is a list of blocks under the train and the
   --                        direction each block should be powered to move
   --                        the train in the forward direction.
   --                        The blocks in this list are in order from
   --                        Caboose to Loco.
   --                     Turnouts is a list of turnouts under the train and
   --                        the direction each turnout should be set.
   --                        The turnouts in this list are in no order.
   --                  Else
   --                      We were unable to locate the train.  Based on the
   --                      input, there are more blocks or turnouts under the
   --                      train than will fit on the lists.
   --                      Blocks and Turnouts are undefined.

   -----------------------------------------------------------------------------
   procedure Helper_Blocks_Beneath (Loco            : in  Block_ID;        -- Front of train
                                    Caboose         : in  Block_ID;        -- Rear of train
                                    Direction_Block : in out Block_Direction; -- Normal or Reverse
                                    Blocks          : out Block_List;   -- Under train
                                    Turnouts        : out Turnout_List; -- Under train
                                    Success         : out Boolean);

   -- Search the layout for the blocks and turnouts beneath a train
   -- Helper procedure with either normal or reverse direction
   -- Preconditions  : Loco /= Caboose
   --                  Loco is a Block ID, Caboose is a BLock ID
   --
   -- Postconditions : If Success then
   --                     Blocks is a list of blocks under the train and the
   --                        direction each block should be powered to move
   --                        the train in the forward direction.
   --                        The blocks in this list are in order from
   --                        Caboose to Loco.
   --                     Turnouts is a list of turnouts under the train and
   --                        the direction each turnout should be set.
   --                        The turnouts in this list are in no order.
   --                  Else
   --                      We were unable to locate the train.  Based on the
   --                      input, there are more blocks or turnouts under the
   --                      train than will fit on the lists.
   --                      Blocks and Turnouts are undefined.



   -----------------------------------------------------------------------------
   --helpers procedure append and pop Block lists
   -----------------------------------------------------------------------------
   procedure append_Block (Rec  : in Block_Rec;
                           List : out Block_List);
   --this procedure will append the new array to the Block List at the end
   --Precondition : the in parameter have to be a block record
   --Postcondition: the out parameter is new block list that appends the rec

   procedure append_Turnout (Rec : in Turnout_Rec;
                             List: out Turnout_List);
   --this procedure will append the new array to the Block List at the end
   --Precondition : the in parameter have to be a block record
   --Postcondition: the out parameter is new block list that appends the rec

   procedure pop_Block (List : out Block_List);
   --this procedure will pop the last index of the
   --Block list , makes it unreachable logically
   --Precondition : the Block List is not empty ( List.Size >0)
   --Postcondition: Decrement the List.Size by 1.

   procedure pop_Turnout ( List : out Turnout_List);
   --this procedure will pop the last index of the
   --Turnout list , makes it unreachable logically
   --Precondition : the Turnout List is not empty ( List.Size >0)
   --Postcondition: Decrement the List.Size by 1.


end Layout.Search;
