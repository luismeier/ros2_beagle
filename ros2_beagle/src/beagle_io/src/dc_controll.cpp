#include "beagle_io/dc_controll.h"
#include <rc/motor.h>

namespace beagle_io {

  DC_CONTROLL::DC_CONTROLL() : Node("beagle_io_dc") {
    sub_joy = create_subscription<sensor_msgs::msg::Joy>(
        "joy", 10, std::bind(&DC_CONTROLL::set_dc_values, this, _1));

    // Init dc driver
    rc_motor_init_freq(RC_MOTOR_DEFAULT_PWM_FREQ);
  }

  DC_CONTROLL::~DC_CONTROLL()
  {
    rc_motor_cleanup();
  }

  void DC_CONTROLL::set_dc_values(const sensor_msgs::msg::Joy::SharedPtr joy)
  {
    rc_motor_set(1, joy->axes[4]);
    rc_motor_set(2, -joy->axes[1]);
  }
}


int main(int argc, char *argv[]) {
  rclcpp::init(argc, argv);
  auto node = std::make_shared<beagle_io::DC_CONTROLL>();
  rclcpp::spin(node);
  rclcpp::shutdown();
  return 0;
}
