//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "LogIn.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "CardIO.h"
#import "MBProgressHUD.h"




@interface SidebarTableViewController ()
{
    AppDelegate *appDelegete;
    NSString *strProAmount;
    NSString *strid , *strToken , *strSattus ;
}





@end

@implementation SidebarTableViewController
{
    NSArray *arrMenuItems;
  

    
}





#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];
    strSattus=[defaults valueForKey:@"status"];

    
   // tableViewMenu.backgroundColor=[UIColor colorWithRed:48.0f/255.0f green:49.0f/255.0f blue:50.0f/255.0f alpha:1];

}
-(void)viewWillAppear:(BOOL)animated
{
   // [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
    
    [tableViewMenu reloadData];
    // Start out working with the test environment! When you are ready, switch to PayPalEnvironmentProduction.
   
    
  // tableViewMenu.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroun.png"]];
    tableViewMenu.backgroundColor=[UIColor whiteColor];
    tableViewMenu.delegate=self;
    tableViewMenu.dataSource=self;
    
    
    imgProfileImage.layer.cornerRadius = imgProfileImage.frame.size.height / 2;
    imgProfileImage.clipsToBounds = YES;
    
    
        arrMenuItems = @[@"Discovery Settings",@"App Settings",@"Help",@"Logout"];
    
    if ([appDelegate.strName isEqualToString:@""])
    {
        lblProfileName.text=@"Name";
    }
    else
    {
        lblProfileName.text=appDelegate.strName;
    }
    
    if (![appDelegate.strPicture isEqualToString:@""])
    {
        AsyncImageView *async=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgProfileImage.frame.size.width, imgProfileImage.frame.size.height)];
        [async loadImageFromURL:[NSURL URLWithString:appDelegate.strPicture]];
        [imgProfileImage addSubview:async];
    }
    imgProfileImage.layer.cornerRadius = imgProfileImage.frame.size.height / 2;
    imgProfileImage.clipsToBounds = YES;

    

}

-(void)viewDidDisappear:(BOOL)animated
{
    //[self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -
#pragma mark - Action

-(IBAction)onViewProfile:(id)sender
{
    [self performSegueWithIdentifier:@"SlideBar_ViewProfile" sender:self];
}


#pragma mark - Table view data sources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrMenuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [arrMenuItems objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([CellIdentifier isEqualToString:@"Get Binder Plus"])
    {
         UIFont *fontname16 = [UIFont fontWithName:@"Roboto-Medium" size:16];
  
        if ([appDelegate.strProUser isEqualToString:@"1"])
        {
            UILabel *lblBPro=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 200, 30)];
            lblBPro.text=@"You Are Pro User";
           // [lblBPro setFont:[UIFont fontWithName:@"Avenir Next - Medium" size:16]];
            lblBPro.backgroundColor=[UIColor whiteColor];
            lblBPro.textColor=[UIColor blackColor];
            lblBPro.font=fontname16;
            [cell addSubview:lblBPro];
            cell.userInteractionEnabled=NO;

        }
    }
    [cell setBackgroundColor:[[UIColor whiteColor]colorWithAlphaComponent:0]];
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
   //      cell.textLabel.textColor=[UIColor whiteColor];
    
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [arrMenuItems objectAtIndex:indexPath.row];
    NSLog(@"%@",CellIdentifier);
    
    if ([CellIdentifier containsString:@"Logout"])
    {
        appDelegate.strIsLoggedOut=@"yes";
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"" forKey:@"email"];
        [defaults setValue:@"" forKey:@"id"];
        [defaults setValue:@"" forKey:@"name"];
        [defaults setValue:@"" forKey:@"picture"];
        [defaults setValue:@"" forKey:@"token"];
        [defaults setValue:@"" forKey:@"ProUser"];
        
        appDelegate.strLoginStatus=@"LoggedOut";
        [defaults setValue:appDelegate.strLoginStatus forKey:@"LoginStatus"];
        
        //[defaults setValue:@"LoggedOut" forKey:@"LoginStatus"];
        //appDelegate.strLoginStatus=@"LoggedOut";
        [self performSegueWithIdentifier:@"SlideBar_Login(Logout)" sender:self];
        
    }
    if ([CellIdentifier containsString:@"Get Binder Plus"])
    {
       // [self onGetAmount:nil];
        appDelegate.strisFrmBindPlus=@"yes";
    }
    
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    //    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [tableViewMenu indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[arrMenuItems objectAtIndex:indexPath.row] capitalizedString];
    
    }




@end
