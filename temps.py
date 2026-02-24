#!/usr/bin/env python3
import psutil
import subprocess
import time
import os

def get_cpu_temperature():
    """Get CPU temperature using psutil"""
    if hasattr(psutil, "sensors_temperatures"):
        temps = psutil.sensors_temperatures()
        # Look for common MacBook temperature sensors
        for sensor in ['coretemp', 'k10temp', 'applesmc']:
            if sensor in temps:
                return temps[sensor][0].current
    return None

def set_fan_speed(manual_control=False, speed_percent=50):
    """
    Control fan speed (requires mbpfan to be stopped first)
    Only use this if you want manual control instead of mbpfan
    """
    if manual_control:
        # This is a simplified example - actual fan control requires
        # writing to /sys/devices/platform/applesmc.768/fan*_manual
        # and /sys/devices/platform/applesmc.768/fan*_output
        try:
            # First, disable automatic control
            with open('/sys/devices/platform/applesmc.768/fan1_manual', 'w') as f:
                f.write('1')
            
            # Set fan speed (RPM)
            min_rpm = 2000
            max_rpm = 6200
            target_rpm = int(min_rpm + (max_rpm - min_rpm) * (speed_percent / 100))
            
            with open('/sys/devices/platform/applesmc.768/fan1_output', 'w') as f:
                f.write(str(target_rpm))
                
            return f"Fan set to {target_rpm} RPM ({speed_percent}%)"
        except Exception as e:
            return f"Error: {e}"
    return "Automatic mode (mbpfan running)"

def monitor_system():
    """Monitor temperatures and fan speeds"""
    print("MacBook Fan Monitor (press Ctrl+C to stop)")
    print("-" * 50)
    
    try:
        while True:
            # Get temperature
            temp = get_cpu_temperature()
            
            # Get fan speeds using psutil [citation:3][citation:6]
            fans = psutil.sensors_fans() if hasattr(psutil, "sensors_fans") else {}
            
            # Clear screen for cleaner output
            os.system('clear' if os.name == 'posix' else 'cls')
            
            print(f"Time: {time.strftime('%H:%M:%S')}")
            if temp:
                print(f"CPU Temperature: {temp:.1f}°C")
            else:
                print("CPU Temperature: Unable to read")
            
            # Display fan speeds
            if fans:
                for fan_name, entries in fans.items():
                    for entry in entries:
                        print(f"{entry.label or fan_name}: {entry.current} RPM")
            else:
                print("Fan speeds: Unable to read")
            
            print("\nControl Status: Using mbpfan automatic control")
            print("To manually control fans, stop mbpfan first:")
            print("  sudo systemctl stop mbpfan")
            
            time.sleep(2)
            
    except KeyboardInterrupt:
        print("\nMonitoring stopped.")

if __name__ == "__main__":
    monitor_system()
	