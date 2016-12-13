//
//  DiscoverySettings.h
//  Binder
//
//  Created by Admin on 03/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

#define SWT_DISCOV 01
#define SWT_MEN 02
#define SWT_WOMEN 03

typedef enum : NSUInteger {
    CustomizationStateDefault = 0,
    CustomizationStateCustom,
    CustomizationStateCustomAttributed,
} CustomizationState;



@interface DiscoverySettings : UIViewController<WebServiceDelegate>

@end
