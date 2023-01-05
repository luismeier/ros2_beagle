import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

    servos = launch_ros.actions.Node(
        package='beagle_io', executable='beagle_io_servos', output='screen')

    imu = launch_ros.actions.Node(
        package='beagle_io', executable='beagle_io_imu', output='screen')

    return launch.LaunchDescription([
        imu,
        servos,
    ])


