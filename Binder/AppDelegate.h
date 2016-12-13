//
//  AppDelegate.h
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)NSString *strDeviceToken, *strLatitude, *strLongitude, *strAppState, *strIsLoggedOut, *strLoginStatus, *strSattus, *strUserCount, *strProUser, *strSwipeLat, *strSwipeLong, *strCityName, *strGender, *strIsFrmChat;

@property(strong,nonatomic)NSString *strEmail, *strID, *strName, *strPicture, *strToken, *strEidtBtnClicked, *strWchAppSetting, *strAddNewLocClicked, *strisFrmBindPlus, *strCityDeleted, *StrSocialType;

@property(weak, nonatomic)NSString        *is_from_push;
@property(strong, nonatomic)NSDictionary *dictNotiDetails;
@property(strong, nonatomic)NSString *strNotiType, *isFrmMessage;
@end

