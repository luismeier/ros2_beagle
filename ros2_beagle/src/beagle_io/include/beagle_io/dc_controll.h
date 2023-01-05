#ifndef DC_CONTROLL_H_
#define DC_CONTROLL_H_

#include "rclcpp/rclcpp.hpp"
#include <sensor_msgs/msg/joy.hpp>


using std::placeholders::_1;

namespace beagle_io
{
    class DC_CONTROLL: public rclcpp::Node
    {
        public:
        DC_CONTROLL();
        ~DC_CONTROLL();

        private:
    rclcpp::Subscription<sensor_msgs::msg::Joy>::SharedPtr sub_joy;

    // callback function
    void set_dc_values(const sensor_msgs::msg::Joy::SharedPtr joy);

    }

}

#endif // DC_CONTROLL_H_