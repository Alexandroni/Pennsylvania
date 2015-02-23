--Pensylvania Huy Nguyen
--
package Layout is
   pragma Pure (Layout);

      --This child package provides types and procedures to determine the layout
      --of the map. It provides information about block id, turns out id, and
      --how they connect to each other.


   -- Types for an individual block

   type Block_ID is range 1 .. 40;
   -- Block ID Type 1 to 40
   type Block_Direction is (Normal, Reversed);
   -- Return the polarity of a block

   type Block_Array is array (Positive range <>) of Block_ID;
   --Return a list of block with ID


   -- Types for an individual turn out.
   type Turnout_ID is range 1 .. 26;
   --Turnout ID 1 to 26
   type Turnout_Direction is (Left, Right);
   -- Return the polarity of a TurnOut

   -- Types for an individual Sensor.

   type Sensor_ID is range 1 .. 51;

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

   procedure Get_Next(Block_Num : in Block_ID;
                      Direction : in Block_Direction;
                      Terminator: out Terminator_Type);
   --take a block ID, the direction, and return the terminator next to this block

   procedure Get_Next_Block_ID (Block     : in Block_ID;
                                Direction : in Block_Direction;
                                Next_ID   : out Block_ID);
   --take a block id, the direction, and return the next block id if there is a
   --block next

   procedure Get_Next_Turnout_ID (Block     : in Block_ID;
                                  Direction : in Block_Direction;
                                  Next_ID   : out Turnout_ID);
   --take a block id, the directio, and return the next turnout id if there is a
   --turnout next

   function Opposite (Direction : in Block_Direction) return Block_Direction;
   --function to return the opposite of a given block direction

   function Opposite (Direction : in Turnout_Direction) return
     Turnout_Direction;
   --function to return the opposite of a given turn direction

    procedure Sensor_Blocks (Sensor  : in Sensor_ID;
                             Block1  : out Block_ID;
                             Block2  : out Block_ID);
   --procedure to return the Block IDs that got separated by a given Sensor ID

   procedure Is_Force (Block_Num   : in Block_ID;
                       Direction   : in Block_Direction;
                       Answer      : out Boolean);
   --procedure to return whether there is a force turnout on the end of the
   --block given block ID and Direction

   procedure Who_is_Force (Block_Num       : in Block_ID;
                           Block_Dir       : in Block_Direction;
                           Turnout_Num     : out Turnout_ID;
                           Turnout_Choice  : out Turnout_Direction);
   --procedure to return the force turnout ID at the end of the
   --given block as well
   --as set up the direction for that turn outblock given block ID and Direction

   function Is_Joint (Turnout_Num : in Turnout_ID;
                      Direction   : in Turnout_Direction) return Boolean;
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

   procedure Is_On (Block1 : in Block_ID;
                    Block2 : in Block_ID;
                    Status : out Sensor_Status);
   --function return the status of a sensor
end Layout;
