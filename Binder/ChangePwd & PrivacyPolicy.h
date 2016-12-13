//
//  ChangePwd & PrivacyPolicy.h
//  Binder
//
//  Created by Admin on 06/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

#define TEXT_NEW_PASSWORD 01
#define TEXT_CONF_PASSWORD 02
#define TEXT_CURR_PASSWORD 03

@interface ChangePwd___PrivacyPolicy : UIViewController<WebServiceDelegate,  UITextFieldDelegate>

@end
