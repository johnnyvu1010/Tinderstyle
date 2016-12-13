//
//  LogIn.h
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

#define TEXT_EMAIL 01
#define TEXT_PASSWORD 02


@interface LogIn : UIViewController<UITextFieldDelegate, WebServiceDelegate>

@end
