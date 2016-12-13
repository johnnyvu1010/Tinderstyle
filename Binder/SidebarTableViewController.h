//
//  SidebarTableViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "AppDelegate.h"




@interface SidebarTableViewController : UIViewController<WebServiceDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tableViewMenu;
    AppDelegate *appDelegate;
    
  IBOutlet UIImageView *imgProfileImage;
    IBOutlet UILabel *lblProfileName;
    IBOutlet UIButton *btnViewProfile;
    
}
//   arrMenuItems = @[@"Discovery Settings",@"App Settings",@"Help",@"Get Binder Plus",@"Logout"];


@end
