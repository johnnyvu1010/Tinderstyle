//
//  EditProfile.h
//  Binder
//
//  Created by Admin on 26/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

#define BTN_PHOTO1 01
#define BTN_PHOTO2 02
#define BTN_PHOTO3 03
#define BTN_PHOTO4 04
#define BTN_PHOTO5 05

#define IMG_PHOTO1 13
#define IMG_PHOTO2 14
#define IMG_PHOTO3 15
#define IMG_PHOTO4 16
#define IMG_PHOTO5 17




#define BTN_MALE 06
#define  BTN_FEMALE 07

#define  TEXT_ABOUT 10
#define TEXT_WORK 11
#define TEXT_SCHOOL 12


@interface EditProfile : UIViewController<UITextFieldDelegate, WebServiceDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIAlertController *alertController;
}
@property(nonatomic, strong)NSDictionary *signupRes, *dictUser;
@end
