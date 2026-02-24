#!/usr/bin/env python3
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
