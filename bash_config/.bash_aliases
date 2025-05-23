alias cdros="cd ~/rosws"
alias clean-ros-logs="rm -r ~/.ros/log/*"
can-init(){
  for iface in can0 can1; do 
    echo Taking $iface down and back up.
    sudo ip link set $iface down
    sudo ip link set $iface up type can bitrate 1000000
    sudo ip link set $iface txqueuelen 1000
    sudo ip link set $iface up
  done
}
conda-setup(){
  eval "$(conda shell.bash hook)"
}

# https://answers.ros.org/question/292566/what-is-the-difference-between-local_setupbash-and-setupbash/
ros2-base(){
  if [[ ! $1 ]] then
    rosdistro="jazzy"
  else
    rosdistro=$1
  fi
  source /opt/ros/$rosdistro/local_setup.bash && PS1='($rosdistro) ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$' 
}
# source from the root of the workspace
ros2-this(){
  if [[ ! $1 ]] then
    rosdistro="jazzy"
  else
    rosdistro=$1
  fi
  if [ ! -f ./install/local_setup.bash ]; then
    echo "./install/local_setup.bash does not exist. Maybe an un-built workspace?"
    ros2-base $rosdistro
  else
    ros2-base $rosdistro && source ./install/local_setup.bash
  fi
}
ros2-setup(){
  if [[ ! $1 ]] then
    rosdistro="jazzy"
  else
    rosdistro=$1
  fi
  if [ ! -f ~/rosws/install/local_setup.bash ]; then
    echo "~/rosws/install/local_setup.bash does not exist. Maybe an un-built workspace?"
    ros2-base $rosdistro
  else
    ros2-base $rosdistro && source ~/rosws/install/local_setup.bash
  fi
}
alias dubig="du -h | sort -h -k1 -r"
