--Pensylvania Huy Nguyen
--
package Layout is
   pragma Pure (Layout);

      --This child package provides types and procedures to determine the layout
      --of the map. It provides information about block id, turns out id, and
      --how they connect to each other.


      -- Types for an individual block


   subtype Block_ID is Integer range 0 .. 40;
   -- 0 indicates there is no such block

   type Block_Direction is (Normal, Reversed);
   -- Return the polarity of a block

   type Block_Array is array (Positive range <>) of Block_ID;
   --Return a list of block with ID


      -- Types for an individual turn out.


   subtype Turnout_ID is Integer range 0 .. 26;
   --0 means there is no ID

   type Turnout_Direction is (Left, Right);
   -- Return the polarity of a TurnOut

   type Turnout_Joint is (Joint, Disjoint);
   --Return Normal for not joint turnout, Joint for joint turn out

   type Turnout_Set is (Left_set, Right_set);------------------------------------------------


      -- Types for an individual Sensor.


   subtype Sensor_ID is Integer range 1 .. 51;

   type Sensor_Status is (On, Off);

   type Sensor_Type is
   --the details of a Sensor (ID and the 2 block it separated)
      record
         Block1     : Block_ID;
         Block2     : Block_ID;
         Status     : Sensor_Status;
      end record;

   -- Types for an Terminator
   type Terminator_Type is (Turnout, Block, Deadend);
   --Return the type of the end of a block, or turnout.



   -----------------------------------------------------------------------------
   --functions and procedures in our layout.
   -----------------------------------------------------------------------------
   function Opposite (Direction : in Block_Direction) return Block_Direction;
   --function to return the opposite of a given block direction

   function Opposite (Direction : in Turnout_Direction) return
     Turnout_Direction;
   --function to return the opposite of a given turn direction

   procedure Separated (Sensor : in Sensor_ID;
                         Block1 : out Block_ID;
                         Block2 : out Block_ID);
   --function to return the Block IDs that got separated by a given Sensor ID

   procedure Is_Force (Block_Num : in Block_ID;
                       Direction : in Block_Direction;
                       Answer    : out Boolean);
   --procedure to return whether there is a force turnout on the end of the
   --block given block ID and Direction

   procedure Force_With (Block_Num        : in Block_ID;
                         Direction        : in Block_Direction;
                         Turn_ID          : out Turnout_ID;
                         Turn_Direction   : out Turnout_Direction);
   --procedure to return the force turnout ID at the end of the
   --given block as well
   --as set up the direction for that turn outblock given block ID and Direction

   procedure Is_Joint (Turn     : in Turnout_ID;
                       Direction : in Turnout_Direction;
                       Answer   : out Boolean);
   --function answer whether a turn out is half of a joint turnout.

   procedure Joint_With (Turn     : in Turnout_ID;
                         Direction : in Turnout_Direction;
                         Joint    : out Integer);
   --function returns the other JOint ID if the given Turnout_ID is
   -- a half of a joint


   function Cross_Block (Block : in Block_ID) return Block_ID;
   --function that returns list of block that crosses the given block ID

   procedure Next_Choice (Block_Num         : in Block_ID;
                          Direction         : in Block_Direction;
                          Turnout_Num       : out Turnout_ID);
   --function that returns the next choice turnout ID of the given direction
   -- Block

   -----------------------------------------------------------------------------
   -- helper procedures, functions in our layout.
   -----------------------------------------------------------------------------
   procedure Get_Next        (Block_Num     : in Block_ID;
                              Direction     : in Block_Direction;
                              ID            : out Integer;
                              Terminator    : out Terminator_Type);
   --procedure that takes in Block_ID, and Direction of the Block, check the
   --End_Of_Block array on the Direction end to see whether it is a block
   -- or a choice.

   procedure Get_Next_Of_Block (Block_Num     : in Block_ID;
                                Direction     : in Block_Direction;
                                ID            : out Integer;
                                Terminator    : out Terminator_Type);
   --procedure that takes in Block_ID, and Direction of the Block, check the
   --End_Of_Block array on the Direction end to see whether it is a block
   -- or a choice.
   procedure Get_Next_Of_Turnout (Turnout_Num : in Turnout_ID;
                            	  Direction   : in Turnout_Direction;
                             	  Block_Num   : out Block_ID);
   --procedure that takes in Turnout_ID which is a choice, then depends on the
   --direction of the turn out, will return the accordingling Block_ID on the
   -- limb.
   procedure Is_On (Block_1 : in Block_ID;
                    Block_2 : in Block_ID;
                    Answer  : out Boolean);
   --function that returns whether the Sensor between these 2 blocks are On or
   --Off base on our Layout_Sensors
end Layout;
