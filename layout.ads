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

   type Turnout_Set is (Left_set, Right_set);--------------------------


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

    procedure Sensor_Blocks (Sensor  : in Sensor_ID;
                             Block1  : out Block_ID;
                             Block2  : out Block_ID);
   --function to return the Block IDs that got separated by a given Sensor ID

   procedure Is_Force (Block_Num   : in Block_ID;
                       Direction   : in Block_Direction;
                       Answer      : out Boolean);
   --procedure to return whether there is a force turnout on the end of the
   --block given block ID and Direction

   procedure Who_is_Force (Block_Num       : in Block_ID;
                           Block_Direction : in Block_Direction;
                           Turnout_Num     : out Turnout_ID;
                           Turnout_Choice  : out Turnout_Set);
   --procedure to return the force turnout ID at the end of the
   --given block as well
   --as set up the direction for that turn outblock given block ID and Direction

   procedure Is_Joint (Turnout_Num : in Turnout_ID;
                       Direction   : in Turnout_Direction;
                       Answer      : out Boolean);
   --function answer whether a turn out is half of a joint turnout.

   procedure Who_is_Joint (Turnout_Num     : in Turnout_ID;
                           Direction       : in Turnout_Direction;
                           Joint_Turnout   : out Turnout_ID);
   --function returns the other JOint ID if the given Turnout_ID is
   -- a half of a joint

   procedure Next_choice (Block_Num      : in Block_ID;
                          Direction      : in Block_Direction;
                          Choice_Turnout : out Turnout_ID);
   --function that returns the next choice turnout ID of the given direction
   -- Block

   -----------------------------------------------------------------------------
   -- helper procedures, functions in our layout.
   -----------------------------------------------------------------------------
   procedure Get_Next(Block_Num : in Block_ID;
                      Direction : in Block_Direction;
                      ID        : out Integer;
                      Terminator: out Terminator_Type);
   --procedure that takes in Block_ID, and Direction of the Block, check the
   --End_Of_Block array on the Direction end to see whether it is a block
   -- or a choice.

   procedure Is_On (Sensor : in Sensor_ID;
                    Status : out Sensor_Status);
   --function return the status of a sensor
end Layout;
