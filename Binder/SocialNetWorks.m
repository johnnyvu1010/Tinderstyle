//
//  SocialNetWorks.m
//  Saladicious
//
//  Created by Admin on 18/11/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "SocialNetWorks.h"
#import "SWRevealViewController.h"


@interface SocialNetWorks ()
{
    AppDelegate *appDelegate;
    NSString *strTypeSocial;
}
@end

@implementation SocialNetWorks
@synthesize StrSocialType;

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];

     appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    strTypeSocial=appDelegate.StrSocialType;
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Social Media";
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    barBtn.tintColor=[UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:barBtn ];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    //    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.SideBarButton setTarget: self.revealViewController];
//        [self.SideBarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    
    if ([strTypeSocial isEqualToString:@"Twitter"])
    {
      self.navigationItem.title=@"Twitter";
    NSString *googleMapsURLString=@"https://twitter.com/appoets";
    NSURL *url = [NSURL URLWithString:googleMapsURLString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //[LocationView loadRequest:urlRequest];
    
    
    UIWebView *view=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view loadRequest:urlRequest];
    [self.view addSubview:view];
    }
    else if ([strTypeSocial isEqualToString:@"Skype"])
    {
         self.navigationItem.title=@"Skype";
        
        
       
    }
    else if ([strTypeSocial isEqualToString:@"Facebook"])
    {
        self.navigationItem.title=@"Facebook";
        NSString *googleMapsURLString=@"https://www.facebook.com/appoets";
        NSURL *url = [NSURL URLWithString:googleMapsURLString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        //[LocationView loadRequest:urlRequest];
        
        
        UIWebView *view=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [view loadRequest:urlRequest];
        [self.view addSubview:view];
    }
    else if ([strTypeSocial isEqualToString:@"Mail"])
    {
        

        
//        NSString *googleMapsURLString=@"https://www.pinterest.com/saladicious/";
//        NSURL *url = [NSURL URLWithString:googleMapsURLString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        //[LocationView loadRequest:urlRequest];
//        
//        
//        UIWebView *view=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        [view loadRequest:urlRequest];
//        [self.view addSubview:view];
    }

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onBack
{
   [self.navigationController popViewControllerAnimated:YES];
}

// Then implement the delegate method


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
