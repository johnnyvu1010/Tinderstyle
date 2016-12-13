//
//  ViewProfile.h
//  Binder
//
//  Created by Admin on 02/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webservice.h"

@interface ViewProfile : UIViewController<WebServiceDelegate,UIScrollViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

@end
