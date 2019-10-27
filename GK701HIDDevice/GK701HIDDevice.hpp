//
//  GK701HIDDevice.hpp
//  GK701HIDDevice
//
//  Created by osy86 on 8/3/18.
//  Copyright © 2018 osy86. All rights reserved.
//

#ifndef GK701HIDDevice_h
#define GK701HIDDevice_h

#include <IOKit/usb/IOUSBHostHIDDevice.h>

class GK701HIDDevice : public IOUSBHostHIDDevice
{
    OSDeclareDefaultStructors(GK701HIDDevice)
    
public:
    virtual bool start (IOService *provider);
};

#endif /* GK701HIDDevice_h */
