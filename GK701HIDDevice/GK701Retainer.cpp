//
//  GK701Retainer.cpp
//  GK701HIDDevice
//
//  Created by osy86 on 7/14/19.
//  Copyright © 2019 osy86. All rights reserved.
//

#include "GK701Retainer.hpp"

OSDefineMetaClassAndStructors(GK701Retainer, IOService)
#define super IOService


bool GK701Retainer::start(IOService* provider)
{
    retain();
    return super::start(provider);
}
