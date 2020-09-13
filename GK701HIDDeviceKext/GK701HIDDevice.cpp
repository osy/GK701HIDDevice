//
//  GK701HIDDevice.cpp
//  GK701HIDDevice
//
//  Created by osy86 on 8/3/18.
//  Copyright © 2018 osy86. All rights reserved.
//

#include "GK701HIDDevice.hpp"

OSDefineMetaClassAndStructors(GK701HIDDevice, IOUSBHostHIDDevice)
#define super IOUSBHostHIDDevice

bool GK701HIDDevice::start(IOService* provider)
{
    if(super::start(provider) == false)
    {
        return false;
    }
    
    SetIdleMillisecs(0);
    
    return true;
}
