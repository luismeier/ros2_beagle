BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'


echo -e "${BLUE}This script installs ROS 2 on the Beaglebone Blue Board${NC}"

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

echo -e "${BLUE}Install some development and build tools ...${NC}"
sudo apt update

sudo apt install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    curl

echo -e "${BLUE}Adding ROS source...${NC}"
# Add the GPG key
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# add the repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo -e "${BLUE}Installing dev an ROS tools...${NC}"
sudo apt update
sudo apt install -y \
  libbullet-dev \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools \
  python3-vcstool \
  python3-colcon-common-extensions  

# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  vcstool
# install Fast-RTPS dependencies
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
sudo apt install --no-install-recommends -y \
  libcunit1-dev


eche -e "${BLUE}Cloning ROS 2 code ...${NC}"
mkdir -p ~/ros2_foxy/src
cd ~/ros2_foxy
vcs import --input https://raw.githubusercontent.com/ros2/ros2/foxy/ros2.repos src

eche -e "${BLUE}Done.${NC}"
eche -e "${BLUE}Installing dependencies ...${NC}"

sudo rosdep init
rosdep update
rosdep install --from-paths src \
    --ignore-src \
    -y \
    --skip-keys "fastcdr rti-connext-dds-5.3.1 urdfdom_headers"

touch \
    src/ros2/rviz/COLCON_IGNORE \
    src/ros2/urdf/COLCON_IGNORE \
    src/ros/kdl_parser/COLCON_IGNORE \
    src/ros/urdfdom/COLCON_IGNORE \
    src/ros/robot_state_publisher/COLCON_IGNORE \
    src/ros2/ros1_bridge/COLCON_IGNORE \
    src/ros2/demos/intra_process_demo/COLCON_IGNORE \
    src/ros2/demos/pendulum_control/COLCON_IGNORE \
    src/ros2/demos/pendulum_msgs/COLCON_IGNORE \
    src/ros2/rmw_connext/COLCON_IGNORE \
    src/ros2/rosidl_typesupport_connext/COLCON_IGNORE

eche -e "${BLUE}Done pulling src!${NC}"
exit
eche -e "${RED}Warning, the process could take hours!${NC}"
eche -e "${BLUE}Building the code in the workspace ...${NC}"
colcon build --symlink-install


eche -e "${BLUE}Done.${NC}"
eche -e "${BLUE}The build has been completed :)${NC}"


