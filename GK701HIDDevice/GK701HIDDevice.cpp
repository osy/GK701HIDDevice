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
    IOUSBHostInterface *interface = NULL;
    const StandardUSB::InterfaceDescriptor *interfaceDesc = NULL;
    
    if(super::start(provider) == false)
    {
        return false;
    }
    
    interface = OSDynamicCast(IOUSBHostInterface, provider);
    if(interface == NULL)
    {
        return false;
    }
    
    interfaceDesc = interface->getInterfaceDescriptor();
    if(interfaceDesc == NULL)
    {
        return false;
    }
    
    // Fix for stupid keyboard issue
    if((kUSBHIDClass == interfaceDesc->bInterfaceClass)
       && (kUSBHIDBootInterfaceSubClass == interfaceDesc->bInterfaceSubClass)
       && (kHIDKeyboardInterfaceProtocol == interfaceDesc->bInterfaceProtocol))
    {
        SetIdleMillisecs(0);
    }
    
    return true;
}
