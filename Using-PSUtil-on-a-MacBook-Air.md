# Using PSUtil on a MacBook Air

These are my notes on using ``mbpfan`` to control the fans on a MacBook Air and then using ``PSUtil``, a Python program to check what temperatures your MacBook is running at.

## Question: How do I install PSUtil package on Zorin?

Since Zorin OS is based on Ubuntu, you can install the ``psutil`` Python package in two main ways. The recommended method for most users is using ``pip``,  [the Python package installer](https://hg-edge.mozilla.org/integration/autoland/diff/b1aa588704613c6d72f4c609f16527e4f417e09d/third_party/python/psutil/INSTALL.rst).

Here are the steps to get it installed.

## 🐍 Installation via pip (Recommended)

This is usually installed on Linux systems.

1. **Open a terminal.** You can do this by pressing ``Ctrl+Alt+T``.
  
2. First, ensure ``pip`` is installed for Python 3:

```bash  
   sudo apt update
   sudo apt install python3-pip
   
   # Also install the full python3 package.
   sudo apt install python3-full
```
  
3. **Install ``psutil``.** It's best practice to install it for your user only to avoid interfering with system packages -- [Installing PSUtil](https://hg-edge.mozilla.org/integration/autoland/diff/b1aa588704613c6d72f4c609f16527e4f417e09d/third_party/python/psutil/INSTALL.rst):
   
   ```bash
   pip3 install --user psutil
   ```    
   
If you need to install it for all users on the system (typically not recommended), you can use 
 ``sudo``:

```bash
sudo pip3 install psutil
```

After installation, you can verify it worked by running `pip3 list` in your terminal. You should see `psutil` in the list of installed packages [-- more on pip3 list](https://forum.zorin.com/t/unnecesary-pip-packages/46813/4).

## 📦 Alternative: Installation via apt

Zorin's repositories also include ``psutil``, so you can install it with ``apt`` -- [PSUtil installation](https://forum.zorin.com/t/unnecesary-pip-packages/46813/4). This method integrates the package with your system's package manager.

1. Open a terminal.
 
2. Update your package list and install the package:

```bash
sudo apt update
sudo apt install python3-psutil
```
   
    

### ⚙️ If You Run Into Issues

`psutil` interacts directly with system internals, so it may require some build tools to compile correctly. If the commands above fail, you might need to install the Python development headers and a C compiler first -- [Recompiling PSUtil](https://hg-edge.mozilla.org/integration/autoland/diff/b1aa588704613c6d72f4c609f16527e4f417e09d/third_party/python/psutil/INSTALL.rst):

```bash
sudo apt install python3-dev gcc
```

After installing these, try the ``pip3 install --user psutil`` command again.

## how do I use PSUtil?

Great! Let me show you how to use ``psutil`` with some common examples. It's a powerful library for system monitoring and process management.

## 🚀 Basic Usage Examples

### 1. **CPU Information**

**Python**:

```bash
import psutil

# CPU times
print(f"CPU times: {psutil.cpu_times()}")

# CPU percentage (overall)
print(f"CPU usage: {psutil.cpu_percent(interval=1)}%")

# CPU percentage per core
print(f"Per CPU usage: {psutil.cpu_percent(interval=1, percpu=True)}%")

# CPU count
print(f"Physical cores: {psutil.cpu_count(logical=False)}")
print(f"Logical cores: {psutil.cpu_count(logical=True)}")

# CPU frequency
print(f"CPU frequency: {psutil.cpu_freq()}")
```

### 2. **Memory Information**

**Python**:

```bash
import psutil

# Virtual memory
mem = psutil.virtual_memory()
print(f"Total memory: {mem.total / (1024**3):.2f} GB")
print(f"Available memory: {mem.available / (1024**3):.2f} GB")
print(f"Used memory: {mem.used / (1024**3):.2f} GB")
print(f"Memory usage: {mem.percent}%")

# Swap memory
swap = psutil.swap_memory()
print(f"Swap total: {swap.total / (1024**3):.2f} GB")
print(f"Swap used: {swap.used / (1024**3):.2f} GB")
```

### 3. **Disk Information**

**Python**:

```bash
import psutil

# Disk partitions
partitions = psutil.disk_partitions()
for partition in partitions:
    print(f"Device: {partition.device}")
    print(f"Mountpoint: {partition.mountpoint}")
    print(f"File system: {partition.fstype}")
    
    # Disk usage
    usage = psutil.disk_usage(partition.mountpoint)
    print(f"Total: {usage.total / (1024**3):.2f} GB")
    print(f"Used: {usage.used / (1024**3):.2f} GB")
    print(f"Free: {usage.free / (1024**3):.2f} GB")
    print(f"Usage: {usage.percent}%")
    print("-" * 40)

# Disk I/O counters
disk_io = psutil.disk_io_counters()
if disk_io:
    print(f"Read bytes: {disk_io.read_bytes / (1024**3):.2f} GB")
    print(f"Write bytes: {disk_io.write_bytes / (1024**3):.2f} GB")
```

### 4. **Network Information**

**Python**:

```bash
import psutil

# Network interfaces
print("Network interfaces:")
print(psutil.net_if_addrs())
print()

# Network I/O counters
net_io = psutil.net_io_counters()
print(f"Bytes sent: {net_io.bytes_sent / (1024**2):.2f} MB")
print(f"Bytes received: {net_io.bytes_recv / (1024**2):.2f} MB")
print(f"Packets sent: {net_io.packets_sent}")
print(f"Packets received: {net_io.packets_recv}")

# Network connections (requires root/sudo for some info)
# connections = psutil.net_connections()
```

### 5. **Process Management**

**Python**:

```bash
import psutil

# Get all process IDs
print(f"Running processes: {len(psutil.pids())}")

# Get process by PID (e.g., PID 1)
p = psutil.Process(1)  # init/systemd process
print(f"Process name: {p.name()}")
print(f"Process status: {p.status()}")
print(f"CPU usage: {p.cpu_percent()}%")
print(f"Memory usage: {p.memory_percent():.2f}%")
print(f"Create time: {p.create_time()}")

# List all running processes
print("\nTop 5 processes by CPU:")
processes = []
for proc in psutil.process_iter(['pid', 'name', 'cpu_percent']):
    try:
        processes.append(proc.info)
    except (psutil.NoSuchProcess, psutil.AccessDenied):
        pass

# Sort by CPU usage and show top 5
processes.sort(key=lambda x: x['cpu_percent'], reverse=True)
for proc in processes[:5]:
    print(f"PID: {proc['pid']}, Name: {proc['name']}, CPU: {proc['cpu_percent']}%")
```

### 6. **System Boot Time and Users**

**Python**:

```bash
import psutil
import datetime

# Boot time
boot_time = datetime.datetime.fromtimestamp(psutil.boot_time())
print(f"System boot time: {boot_time}")
print(f"System uptime: {datetime.datetime.now() - boot_time}")

# Users logged in
users = psutil.users()
for user in users:
    print(f"User: {user.name}, Terminal: {user.terminal}, Host: {user.host}")
```

## 💡 Real-World Example: System Monitor Script

Here's a simple system monitor that updates every 2 seconds:

**Python**:

```bash
import psutil
import time
import os

def clear_screen():
    os.system('clear' if os.name == 'posix' else 'cls')

def get_size(bytes):
    """Convert bytes to human readable format"""
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if bytes < 1024.0:
            return f"{bytes:.2f} {unit}"
        bytes /= 1024.0

while True:
    clear_screen()
    print("=" * 50)
    print("SYSTEM MONITOR")
    print("=" * 50)
    
    # CPU
    print(f"CPU Usage: {psutil.cpu_percent()}%")
    
    # Memory
    mem = psutil.virtual_memory()
    print(f"Memory: {mem.percent}% ({get_size(mem.used)} / {get_size(mem.total)})")
    
    # Disk
    disk = psutil.disk_usage('/')
    print(f"Disk: {disk.percent}% ({get_size(disk.used)} / {get_size(disk.total)})")
    
    # Top 3 CPU processes
    print("\nTop 3 CPU Processes:")
    processes = []
    for proc in psutil.process_iter(['pid', 'name', 'cpu_percent']):
        try:
            processes.append(proc.info)
        except:
            pass
    
    processes.sort(key=lambda x: x['cpu_percent'], reverse=True)
    for proc in processes[:3]:
        print(f"  {proc['name']}: {proc['cpu_percent']}%")
    
    time.sleep(2)
```

## 🔧 Installation Check

To verify your installation works:

**Python**:

```bash
import psutil

print(f"psutil version: {psutil.__version__}")
print(f"Python version: {psutil.PY3}")
print("Installation successful!")
```

## 📚 Common Use Cases

- **System monitoring tools**
   
- **Resource usage tracking**
   
- **Process management utilities**
   
- **Performance testing**
   
- **Server health checks**
   
- **Debugging tools**


## Question: I want to use it to control the fans on my MacBook Air using Zorin

Controlling fans on a MacBook running Linux is definitely possible. Let me clarify what ``psutil`` can and cannot do for you, and then show you the proper tools for the job.

## 🔍 What ``psutil`` Can Actually Do

First, let's check what ``psutil`` can see on your MacBook:

**Python**:

```bash

import psutil

# Check temperatures (psutil CAN do this)
if hasattr(psutil, "sensors_temperatures"):
    temps = psutil.sensors_temperatures()
    print("Temperatures:", temps)
# Check fan speeds (psutil CAN read these on Linux) [citation:5][citation:7]
if hasattr(psutil, "sensors_fans"):
    fans = psutil.sensors_fans()
    print("Fan speeds:", fans)
else:
    print("sensors_fans() not available")
```

Run this script first. **Important:** `psutil.sensors_fans()` was added in version 5.2.0 and works on Linux - [Check this post](https://marc.info/?l=python-announce-list&m=148871605327466&w=2)[](https://mail.python.org/archives/list/python-announce-list@python.org/message/STDU765SDIIOOVJF4X2T5IRKOQUIARCK/). Since Zorin is Linux-based, it should work - but on MacBooks specifically, the ``applesmc`` kernel module needs to be loaded.

## 🎯 The Right Tool: mbpfan

For MacBook fan control on Linux, the dedicated tool is **``mbpfan``** (MacBook Pro Fan). This is specifically designed for Apple MacBooks [](https://linux-packages.com/kali-linux/package/mbpfan).

### Installation on Zorin:

```bash
# Install mbpfan
sudo apt update
sudo apt install mbpfan

# After installation, configure it
sudo nano /etc/mbpfan.conf
```

### Configuration Example (``/etc/mbpfan.conf``):

```bash
min_fan_speed = 2000
# Maximum fan speed (RPM)
max_fan_speed = 6200
# Temperature thresholds (°C)
low_temp = 55
high_temp = 63
max_temp = 85
# Polling interval (seconds)
polling_interval = 1
```

### Start the service:

```bash
sudo systemctl start mbpfan
sudo systemctl enable mbpfan  # Auto-start on boot
```

## 💻 Combined Approach: Python + mbpfan

While ``mbpfan`` handles the fan control automatically, you can still use ``psutil`` to monitor temperatures and create your own custom fan curves if desired:

**Python**:

```bash
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
```

## ⚙️ Important Prerequisites

For fan control to work on a MacBook, you need:

1. **applesmc kernel module** (should load automatically):
    

```bash
lsmod | grep applesmc

# If not loaded:
sudo modprobe applesmc
```

2. **Check if fan control files exist**:
    

```bash
ls -la /sys/devices/platform/applesmc.768/
```

This is a set of around 50 files.

## 📝 Summary & Recommendations

1. **For automatic fan control**: Use ``mbpfan`` - it's purpose-built for MacBooks, works out of the box, and requires minimal configuration [-- more package details](https://linux-packages.com/kali-linux/package/mbpfan).
    
2. **For monitoring**: Use ``psutil`` to read temperatures and fan speeds. The example script above combines both.
    
3. **For custom solutions**: If you want to build your own fan controller, you can:
    
    - Stop the `mbpfan` service
        
    - Use `psutil` to monitor temperatures
        
    - Write directly to the ``applesmc sysfs`` interface (as shown in the manual control example)
        

The ``psutil`` library is excellent for **reading** sensor data, but actual **control** requires interacting with kernel interfaces or using dedicated tools like ``mbpfan``.
