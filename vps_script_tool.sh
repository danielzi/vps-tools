#!/bin/bash

# Function to display the menu
show_menu() {
  echo "===================================="
  echo "VPS Script Tool - Interactive Menu"
  echo "===================================="
  echo "1. VPS Test Scripts"
  echo "2. DD Reinstall Scripts"
  echo "3. Science Tools (WARP, BBR, etc.)"
  echo "4. Route and Latency Test Tools"
  echo "5. Maintenance and Optimization Tools"
  echo "6. Exit"
  echo "===================================="
}

# Function to handle VPS Test Scripts
vps_test_scripts() {
  echo "Select a VPS Test Script:"
  echo "1. LemonBench"
  echo "2. SuperBench"
  echo "3. YABS"
  echo "4. Back to Main Menu"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      echo "Running LemonBench..."
      wget -qO- https://raw.githubusercontent.com/LemonBench/LemonBench/main/LemonBench.sh | bash -s -- --fast
      ;;
    2)
      echo "Running SuperBench..."
      wget -qO- --no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash
      ;;
    3)
      echo "Running YABS..."
      curl -sL yabs.sh | bash
      ;;
    4)
      return
      ;;
    *)
      echo "Invalid choice, returning to main menu."
      ;;
  esac
}

# Function to handle DD Reinstall Scripts
dd_reinstall_scripts() {
  echo "Select a DD Reinstall Script:"
  echo "1. Leitbogioro's Script (Debian 12)"
  echo "2. Beta.gs's Script"
  echo "3. Back to Main Menu"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      echo "Running Leitbogioro's Script..."
      wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh && bash InstallNET.sh -debian 12 -pwd 'password'
      ;;
    2)
      echo "Running Beta.gs's Script..."
      bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 12 -v 64 -p password -port 22 -a -firmware
      ;;
    3)
      return
      ;;
    *)
      echo "Invalid choice, returning to main menu."
      ;;
  esac
}

# Function to handle Science Tools
science_tools() {
  echo "Select a Science Tool:"
  echo "1. WARP (Cloudflare)"
  echo "2. BBR (TCP Congestion Control)"
  echo "3. Back to Main Menu"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      echo "Running WARP Script..."
      bash <(curl -fsSL git.io/warp.sh) menu
      ;;
    2)
      echo "Running BBR Script..."
      echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
      echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
      sysctl -p
      sysctl net.ipv4.tcp_available_congestion_control
      lsmod | grep bbr
      ;;
    3)
      return
      ;;
    *)
      echo "Invalid choice, returning to main menu."
      ;;
  esac
}

# Function to handle Route and Latency Test Tools
route_latency_tools() {
  echo "Select a Route and Latency Test Tool:"
  echo "1. AutoTrace"
  echo "2. NextTrace"
  echo "3. Back to Main Menu"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      echo "Running AutoTrace..."
      wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh
      ;;
    2)
      echo "Running NextTrace..."
      curl nxtrace.org/nt | bash
      ;;
    3)
      return
      ;;
    *)
      echo "Invalid choice, returning to main menu."
      ;;
  esac
}

# Function to handle Maintenance and Optimization Tools
maintenance_tools() {
  echo "Select a Maintenance and Optimization Tool:"
  echo "1. Fail2ban (SSH Brute Force Protection)"
  echo "2. Memory Fill Test"
  echo "3. Back to Main Menu"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      echo "Running Fail2ban Script..."
      wget https://raw.githubusercontent.com/FunctionClub/Fail2ban/master/fail2ban.sh && bash fail2ban.sh 2>&1 | tee fail2ban.log
      ;;
    2)
      echo "Running Memory Fill Test..."
      apt-get update
      apt-get install wget build-essential -y
      wget https://raw.githubusercontent.com/FunctionClub/Memtester/master/memtester.cpp
      gcc -lstdc++ memtester.cpp
      ./a.out
      ;;
    3)
      return
      ;;
    *)
      echo "Invalid choice, returning to main menu."
      ;;
  esac
}

# Main loop
while true; do
  show_menu
  read -p "Enter your choice: " main_choice

  case $main_choice in
    1)
      vps_test_scripts
      ;;
    2)
      dd_reinstall_scripts
      ;;
    3)
      science_tools
      ;;
    4)
      route_latency_tools
      ;;
    5)
      maintenance_tools
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice, please try again."
      ;;
  esac
done
