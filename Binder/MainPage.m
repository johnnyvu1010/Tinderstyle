//
//  MainPage.m
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MainPage.h"
#import "AppDelegate.h"
#import "EditProfile.h"
#import "DiscoveryQuestionaries.h"
#import "DiscoverySettings.h"
#import "AppSettings.h"
//#import "ViewProfile.h"
#import "SWRevealViewController.h"
#import "SingleViewInChatting.h"
#import "ChatView.h"

@interface MainPage ()
{
    AppDelegate *appDelegate;
     }
@end

@implementation MainPage
@synthesize locationManager;

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      [[self navigationController] setNavigationBarHidden:YES animated:YES];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
   //  To find font name
//        for (NSString* family in [UIFont familyNames])
//        {
//            NSLog(@"%@", family);
//    
//            for (NSString* name in [UIFont fontNamesForFamilyName: family])
//            {
//                NSLog(@"  %@", name);
//            }
//        }
    
    
 // appDelegate.strAppState=@"SignUpDone";
    
     //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home BG.jpg"]];
//    
//    UIView *viewBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    viewBG.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home BG.jpg"]];
//    [self.view addSubview:viewBG];
    
     [self start_to_detect_location:nil];
    
    NSLog(@"%@",appDelegate.strAppState);
    
    if([appDelegate.is_from_push isEqualToString:@"yes"])
    {
        //app_delegate.is_from_push = @"";
        
        [self pushNotificationReceived];
    }
    
    if ([appDelegate.strAppState isEqualToString:@"SignUpDone"])
    {
        [self SignUpDone];
    }
    
    if ([appDelegate.strAppState isEqualToString:@"EditProfileDone"])
    {
        [self EditProfileDone];
    }
       
    
    if ([appDelegate.strAppState isEqualToString:@"DisCoverySetting"])
    {
        [self DisSetting];
    }
    if ([appDelegate.strAppState isEqualToString:@"AppSetting"])
    {
        [self AppSetting];
    }
//    if ([appDelegate.strAppState isEqualToString:@"ViewProfile"])
//    {
//        [self ViewProfile];
//    }
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
   
    UIFont *fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    UIButton *btnBG=[UIButton buttonWithType:UIButtonTypeCustom];
    btnBG.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIImage *imgBG=[UIImage imageNamed:@"Home BG.jpg"];
    [btnBG setImage:imgBG forState:UIControlStateNormal];
    btnBG.userInteractionEnabled=NO;
    [self.view addSubview:btnBG];
    
    UIButton *btnLogo=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLogo.frame=CGRectMake((self.view.frame.size.width/2)-50, (self.view.frame.size.height/2)-120, 100, 33);
    UIImage *imgLogo=[UIImage imageNamed:@"logo.png"];
    [btnLogo setImage:imgLogo forState:UIControlStateNormal];
    btnLogo.userInteractionEnabled=NO;
    [self.view addSubview:btnLogo];
    
    
    
    UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame=CGRectMake(10, self.view.frame.size.height-140, self.view.frame.size.width-20, 40);
    //    UIImage *imgLoginBG=[UIImage imageNamed:@"OrangeBgBtn.png"];
    //     [btnLogin setBackgroundImage:imgLoginBG forState:UIControlStateSelected];
    [btnLogin setTitle:@"Log In" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     btnLogin.titleLabel.font=fontname18;
   // [btnLogin addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [btnLogin addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
    // [btnLogin setBackgroundColor:[UIColor blackColor]];
    [[btnLogin layer]setBorderWidth:1.0];
    btnLogin.tag=01;
    [[btnLogin layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [self.view addSubview:btnLogin];
    
    
    UIButton *btnSignUp=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSignUp.frame=CGRectMake(10, self.view.frame.size.height-70, self.view.frame.size.width-20, 40);
    //    UIImage *imgLogin1=[UIImage imageNamed:@"Register button.png"];
    //    [btnRegister setBackgroundImage:imgLogin1 forState:UIControlStateNormal];
    [btnSignUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    [btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSignUp.titleLabel.font=fontname18;
    [btnSignUp addTarget:self action:@selector(onSignUp:) forControlEvents:UIControlEventTouchDown];
    // [btnSignUp setBackgroundColor:[UIColor blackColor]];
    [[btnSignUp layer]setBorderWidth:1.0];
    btnSignUp.tag=02;
    [[btnSignUp layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [self.view addSubview:btnSignUp];
}

-(void)DisSetting
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DiscoverySettings *DisSetting = (DiscoverySettings *)[sb instantiateViewControllerWithIdentifier:@"DiscoverySettings"];
    [self.navigationController pushViewController:DisSetting animated:YES];
    
}

-(void)AppSetting
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AppSettings *DisSetting = (AppSettings *)[sb instantiateViewControllerWithIdentifier:@"AppSettings"];
    [self.navigationController pushViewController:DisSetting animated:YES];
    
}
//
//-(void)ViewProfile
//{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewProfile *DisSetting = (ViewProfile *)[sb instantiateViewControllerWithIdentifier:@"ViewProfile"];
//    [self.navigationController pushViewController:DisSetting animated:YES];
//
//}

-(void)SignUpDone
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditProfile *Edit_Profile = (EditProfile *)[sb instantiateViewControllerWithIdentifier:@"EditProfile"];
    [self.navigationController pushViewController:Edit_Profile animated:YES];
    
}

-(void)EditProfileDone
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DiscoveryQuestionaries *DisQues = (DiscoveryQuestionaries *)[sb instantiateViewControllerWithIdentifier:@"DiscoveryQuestionaries"];
    [self.navigationController pushViewController:DisQues animated:YES];
    
}
-(void)LoginAftBlink
{
    [self performSegueWithIdentifier:@"Main_Login" sender:self];
}

-(void)SignUpAftBlink
{
    [self performSegueWithIdentifier:@"Main_SignUp" sender:self];
}

-(void)pushNotificationReceived
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushNotification" object:nil];
    NSLog(@"Status: %@",appDelegate.strAppState);
    
    if ([appDelegate.strLoginStatus isEqualToString:@"LoggedIn"])
    {

        
        if ([appDelegate.strNotiType isEqualToString:@"2"])
        {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SingleViewInChatting *Single_vc = (SingleViewInChatting *)[sb instantiateViewControllerWithIdentifier:@"SingleViewInChatting"];
            [self.navigationController pushViewController:Single_vc animated:YES];
        }
        else if ([appDelegate.strNotiType isEqualToString:@"3"])
        {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ChatView *Single_vc = (ChatView *)[sb instantiateViewControllerWithIdentifier:@"ChatView"];
            [self.navigationController pushViewController:Single_vc animated:YES];
        }
       
        
        
                
        
    }
    else
    {
        [self performSegueWithIdentifier:@"Main_Login" sender:self];
        NSLog(@"Notification: %@",appDelegate.is_from_push);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - Actions

-(IBAction)onTouchDown:(id)sender
{
     UIButton *btnLogin=(UIButton *)[self.view viewWithTag:01];
     UIImage *imgLoginBG=[UIImage imageNamed:@"OrangeBgBtn.png"];
     [btnLogin setBackgroundImage:imgLoginBG forState:UIControlStateNormal];
     [[btnLogin layer]setBorderWidth:0.0];
}




-(IBAction)onLogin:(id)sender
{
    UIButton *btnLogin=(UIButton *)[self.view viewWithTag:01];
    
    [UIView animateWithDuration:0.3 animations:^{
        btnLogin.alpha = 0;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        btnLogin.alpha = 1;
    }];

    
     [self performSelector:@selector(LoginAftBlink) withObject:nil afterDelay:0.3];
    
}


-(IBAction)onSignUp:(id)sender
{
    UIButton *btnSignUp=(UIButton *)[self.view viewWithTag:02];
    
    [UIView animateWithDuration:0.3 animations:^{
        btnSignUp.alpha = 0;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        btnSignUp.alpha = 1;
    }];
    
    
    [self performSelector:@selector(SignUpAftBlink) withObject:nil afterDelay:0.3];
}


#pragma mark -
#pragma mark - Current Location

-(void)start_to_detect_location:(id)sender
{
    
    
    locationManager                   = [[CLLocationManager alloc] init];
    locationManager.delegate          =   self;
    locationManager.desiredAccuracy   =   kCLLocationAccuracyBest;
    
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied)
    {
        NSLog(@"authentication failure");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [locationManager stopUpdatingLocation];
    NSLog(@"didFailWithError: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    appDelegate.strLatitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    appDelegate.strLongitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];;
    [locationManager stopUpdatingLocation];
    
    NSLog(@"Lat: %@", appDelegate.strLatitude);
     NSLog(@"Long: %@", appDelegate.strLongitude);
    
    //  strCityName=@"My Current Location";
    
    if ([appDelegate.strCityName isEqualToString:@"My Current Location"])
    {
        appDelegate.strSwipeLat=appDelegate.strLatitude;
        appDelegate.strSwipeLong=appDelegate.strLongitude;
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
