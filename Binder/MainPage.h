//
//  MainPage.h
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainPage : UIViewController<CLLocationManagerDelegate>
{
    
}
@property(nonatomic,strong)CLLocationManager *locationManager;
@property (strong, nonatomic) UIWindow *window;
@end
