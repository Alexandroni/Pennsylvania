package controller is
   --specification for hand held controllers

--------------------------------------------------------
--types of buttons
--------------------------------------------------------
   type Controller_ID is (A, B, C);
   type Button_Push is (Pushed, Released);
   type Toggle_Left is (Up, Down);
   type Toggle_Bottom is (Left, Mid, Right);
   type Percentage is delta 0.1 range 0.0 .. 100.0;


----------------------------------------------------------
--procedures
----------------------------------------------------------
   procedure Get_Digital (Controller	 : in  Controller_ID;
                      Red_Button 	 : out Button_Push;
                      Black_Button	 : out Button_Push;
                      Left_Toggle	 : out Toggle_Left;
                          Bottom_Toggle	 : out Toggle_Bottom);

   procedure Get_Analog (Controller	 : in Controller_ID;
                         Knob		      : out Percentage
                           );


end controller;





