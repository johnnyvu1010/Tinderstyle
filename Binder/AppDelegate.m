//
//  AppDelegate.m
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "PayPalMobile.h"
#import "MainPage.h"

@interface AppDelegate ()
{
    NSMutableArray *arrLocalNoti;
}
@end

@implementation AppDelegate
@synthesize strDeviceToken;
@synthesize strLatitude;
@synthesize strLongitude;
@synthesize strAppState;
@synthesize strToken;
@synthesize strID;
@synthesize strName;
@synthesize strEmail;
@synthesize strPicture;
@synthesize strEidtBtnClicked;
@synthesize strWchAppSetting;
@synthesize strIsLoggedOut;
@synthesize strLoginStatus;
@synthesize strSattus;
@synthesize strUserCount;
@synthesize strProUser;
@synthesize strAddNewLocClicked;
@synthesize strSwipeLat;
@synthesize strSwipeLong;
@synthesize strCityName;
@synthesize strisFrmBindPlus;
@synthesize strCityDeleted;
@synthesize StrSocialType;
@synthesize strGender;
@synthesize strIsFrmChat;
@synthesize dictNotiDetails;
@synthesize strNotiType;
@synthesize isFrmMessage;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    strCityName=@"My Current Location";
    
     [GMSServices provideAPIKey:@"AIzaSyAxZLQTUlRfbzaivVK8X5Zv6vUmQbscpro"];
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction :@"AVOtBo2ZjLSqFqrCRNnYgx3VS7XYqeI1tc0yPpdF6kgGD1-3YoMIVYXXr3l7kz2umL90jv92n0QVmrAA",
                                                           PayPalEnvironmentSandbox : @"AaT1BZ33Nk6QT7Bp_C14VRMj-G6xdpI3NJx5q9PgnMBGa96vFF8RxUa_spW2HF542i5cAByrTMrUqvry"}];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strAppState=[defaults valueForKey:@"AppStatus"];
    
    strToken=[defaults valueForKey:@"token"];
    strID=[defaults valueForKey:@"id"];
    strName=[defaults valueForKey:@"name"];
    strEmail=[defaults valueForKey:@"email"];
    strPicture=[defaults valueForKey:@"picture"];
    strLoginStatus=[defaults valueForKey:@"LoginStatus"];
    strSattus=[defaults valueForKey:@"status"];
    strProUser=[defaults valueForKey:@"ProUser"];
    strSwipeLong=[defaults valueForKey:@"SwipeLong"];
    strSwipeLat=[defaults valueForKey:@"SwipeLat"];
     strGender=[defaults valueForKey:@"gender"];
    
    if ([[defaults valueForKey:@"CityName"]length]!=0)
    {
        strCityName=[defaults valueForKey:@"CityName"];
    }
    
    
    if ([strLoginStatus isEqualToString:@"LoggedIn"])
    {
        UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWRevealViewController *BinderHome = [mainstoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [(UINavigationController *)self.window.rootViewController pushViewController:BinderHome animated:YES];
        [self.window makeKeyAndVisible];

    }
    
    // Override point for customization after application launch.
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
#endif
    }
    else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }

    
    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey])
    {
        NSLog(@"App opened from killed stage");
        
        
        [self application:application didReceiveRemoteNotification:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
    }
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (localNotif) {
       // NSString *json = [localNotif valueForKey:@"data"];
        // Parse your string to dictionary
    }
    
    arrLocalNoti=[[NSMutableArray alloc]init];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // NS_AVAILABLE_IOS(8_0);
{
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strDeviceToken=token;
    NSLog(@"%@",strDeviceToken);
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo  %@",userInfo);
    NSDictionary *dictInfo = [userInfo valueForKey:@"aps"];
    strNotiType=[NSString stringWithFormat:@"%@",[dictInfo valueForKey:@"type"]];
    dictNotiDetails=[dictInfo valueForKey:@"Details"];
    
    
    UIApplicationState state    = [application applicationState];
    
    if (state == UIApplicationStateActive)
    {
        
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo = userInfo;
       // localNotification.soundName = "default"
        localNotification.alertBody = [dictInfo valueForKey:@"alert"];
        localNotification.fireDate = [NSDate date];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        self.is_from_push = @"yes";
        
    }
    else if (state == UIApplicationStateInactive)
    {
        self.is_from_push = @"yes";
        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber - 1;
        
        if ([strNotiType isEqualToString:@"1"])
        {
            if ([strLoginStatus isEqualToString:@"LoggedIn"])
            {
                UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SWRevealViewController *BinderHome = [mainstoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                [(UINavigationController *)self.window.rootViewController pushViewController:BinderHome animated:YES];
                [self.window makeKeyAndVisible];
                
            }
            else
            {
                UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainPage *frontPage = [mainstoryboard instantiateViewControllerWithIdentifier:@"MainPage"];
                [(UINavigationController *)self.window.rootViewController pushViewController:frontPage animated:YES];
                [self.window makeKeyAndVisible];
            }
            
        }
        else
        {
        UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainPage *frontPage = [mainstoryboard instantiateViewControllerWithIdentifier:@"MainPage"];
        [(UINavigationController *)self.window.rootViewController pushViewController:frontPage animated:YES];
        [self.window makeKeyAndVisible];
        }
    }
   
    
    
}
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification  *)notif
{
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
       
        
        self.is_from_push = @"yes";
        
        if ([strNotiType isEqualToString:@"1"])
        {
            if ([strLoginStatus isEqualToString:@"LoggedIn"])
            {
                UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SWRevealViewController *BinderHome = [mainstoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                [(UINavigationController *)self.window.rootViewController pushViewController:BinderHome animated:YES];
                [self.window makeKeyAndVisible];
                
            }
            else
            {
                UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainPage *frontPage = [mainstoryboard instantiateViewControllerWithIdentifier:@"MainPage"];
                [(UINavigationController *)self.window.rootViewController pushViewController:frontPage animated:YES];
                [self.window makeKeyAndVisible];
            }
            
        }
        else
        {
            UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainPage *frontPage = [mainstoryboard instantiateViewControllerWithIdentifier:@"MainPage"];
            [(UINavigationController *)self.window.rootViewController pushViewController:frontPage animated:YES];
            [self.window makeKeyAndVisible];
        }

        NSLog(@"user has tapped notification");        // user has tapped notification
    }
    else
    {
        NSLog(@"user opened app from app icon");  // user opened app from app icon
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   
        NSLog(@"Application Backgrounded");
        
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
