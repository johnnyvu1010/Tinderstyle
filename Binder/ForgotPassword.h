//
//  ForgotPassword.h
//  Binder
//
//  Created by Admin on 25/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "webservice.h"

#define  TEXT_EMAIL 01

@interface ForgotPassword : UIViewController<WebServiceDelegate, UITextFieldDelegate>

@end
