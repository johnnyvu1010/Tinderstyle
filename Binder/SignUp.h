//
//  SignUp.h
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

#define TEXT_NAME 01
#define TEXT_EMAIL 02
#define TEXT_PASSWORD 03
#define BTN_DOB 04

#define DATEPICKER_DOB 10




@interface SignUp : UIViewController<UITextFieldDelegate,WebServiceDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@end
