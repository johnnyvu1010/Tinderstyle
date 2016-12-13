//
//  DiscoveryQuestionaries.h
//  Binder
//
//  Created by Admin on 27/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

#define BTN_INDUS 05
#define BTN_QUALI 06
#define BTN_INCOME 07
#define BTN_EXP 10


@interface DiscoveryQuestionaries : UIViewController<WebServiceDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate,UITableViewDataSource>
{
    
}
@property(nonatomic,strong)NSDictionary *updProfResp;
@property(nonatomic,strong)NSArray  *arrSli, *arrDr, *arrDrop_Ques, *arrSli_Ques;
@end
