package body controller is

   type Digital_Rec is  -- Elements on the controllers
      record
         Red_Button        : Button_Push;
         Black_Button      : Button_Push;
         Direction_Switch  : Toggle_Left;
         Turn_Switch	   : Toggle_Bottom;
      end record;

   for Digital_Rec use
      record
         Red_Button        at 0 range 0 .. 0;
         Black_Button      at 0 range 1 .. 1;
         Direction_Switch  at 0 range 2 .. 2;
         Turn_Switch       at 0 range 3 .. 4;
      end record;
   -----------------
   -- Get_Digital --
   -----------------

   procedure Get_Digital
     (Controller	 : in  Controller_ID;
      Red_Button 	 : out Button_Push;
      Black_Button	 : out Button_Push;
      Left_Toggle	 : out Toggle_Left;
      Bottom_Toggle	 : out Toggle_Bottom)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Digital unimplemented");
      raise Program_Error with "Unimplemented procedure Get_Digital";
   end Get_Digital;

   ----------------
   -- Get_Analog --
   ----------------

   procedure Get_Analog
     (Controller	 : in Controller_ID;
      Knob		 : out Percentage)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Analog unimplemented");
      raise Program_Error with "Unimplemented procedure Get_Analog";
   end Get_Analog;

end controller;
