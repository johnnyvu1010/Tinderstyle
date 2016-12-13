//
//  BinderHome.h
//  Binder
//
//  Created by Admin on 27/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ZLSwipeableView.h"
#import "webservice.h"

//#define BTN_LIKE 01
//#define BTN_SUPER 02
//#define BTN_NOPE 03

typedef enum : NSUInteger {
    CustomizationStateDefault = 0,
    CustomizationStateCustom,
    CustomizationStateCustomAttributed,
} CustomizationState;

@interface BinderHome : UIViewController<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UIActionSheetDelegate, UIScrollViewDelegate, WebServiceDelegate,SWRevealViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SideBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SideBarBinder;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SideBarMessage;
@property (nonatomic, strong) ZLSwipeableView *swipeableView;


- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;
@end
