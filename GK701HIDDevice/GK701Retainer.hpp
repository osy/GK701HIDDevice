//
//  GK701Retainer.hpp
//  GK701HIDDevice
//
//  Created by osy86 on 7/14/19.
//  Copyright © 2019 osy86. All rights reserved.
//

#ifndef GK701Retainer_hpp
#define GK701Retainer_hpp

#include <IOKit/IOService.h>

class GK701Retainer : public IOService
{
    OSDeclareDefaultStructors(GK701Retainer)
    
public:
    virtual bool start (IOService *provider);
};

#endif /* GK701Retainer_hpp */
