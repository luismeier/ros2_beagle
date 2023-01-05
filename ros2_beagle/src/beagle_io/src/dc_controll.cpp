#include "beagle_io/dc_controll.h"
#include "rc_usefulincludes.h"
#include "roboticscape.h"

namesapce beagle_io {

  DC_CONTROLL::DC_CONTROLL() : Node("beagle_io_dc") {
    sub_joy = create_subscription<sensor_msgs::msg::Joy>(
        "joy", 10, std::bind(&DC_CONTROLL::set_dc_values, this, _1));

    // Init dc driver
    rc_initialize();
    rc_enable_motors();
  }

  ~DC_CONTROLL::DC_CONTROLL()
  {
    rc_motor_cleanup();
  }

  void DC_CONTROLL::set_dc_values(const sensor_msgs::msg::Joy::SharedPtr joy)
  {
    rc_set_motor(1,joy->axes[4]);
  }
}