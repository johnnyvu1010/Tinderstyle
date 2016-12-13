//
//  AppSettings.m
//  Binder
//
//  Created by Admin on 02/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AppSettings.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LogIn.h"
#import "SWRevealViewController.h"
@interface AppSettings ()
{
     AppDelegate *appDelegate;
    UIScrollView *scrollView;
    NSString *strid, *strToken;
    UIFont *fontname10, *fontname13,*fontname14,*fontname16, *fontname18, *fontname15_16;
}
@end

@implementation AppSettings

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    fontname10 = [UIFont fontWithName:@"Roboto" size:10];
    fontname13 = [UIFont fontWithName:@"Roboto" size:13];
    fontname14 = [UIFont fontWithName:@"Roboto-Regular" size:14];
    fontname15_16 = [UIFont fontWithName:@"Roboto-Medium" size:16];
    fontname16 = [UIFont fontWithName:@"Roboto" size:16];
    fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];

    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];

    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblNav.text=@"App Settings";
    lblNav.textColor=[UIColor blackColor];
    lblNav.backgroundColor=[UIColor clearColor];
    [lblNav setFont:fontname18];

    self.navigationItem.titleView=lblNav;
    self.navigationController.navigationBar.translucent = NO;
    
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    barBtn.tintColor=[UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:barBtn ];
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.view addSubview:scrollView];
    
    int yPos=10;
    
    UILabel *lblLegal=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
    lblLegal.text=@"Legal";
    [lblLegal setFont:fontname15_16];
    lblLegal.textColor=[UIColor blackColor];
    [scrollView addSubview:lblLegal];
    yPos+=35;
    

    {
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,85)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];

        
        
        UIButton *btnPrivacy=[UIButton buttonWithType:UIButtonTypeCustom];
        btnPrivacy.frame=CGRectMake(10, 5, viewContent.frame.size.width-20, 35);
        // btnQuesAns.frame=CGRectMake(15, yPos, self.view.frame.size.width-30,45);
        //UIImage *imgSelect=[UIImage imageNamed:@"ButtonSelect1.png"];
        //[btnQuesAns setBackgroundImage:imgSelect forState:UIControlStateNormal];
        [btnPrivacy setTitle:@"Privacy Policy" forState:UIControlStateNormal];
        [btnPrivacy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnPrivacy.titleLabel.font=fontname14;
        btnPrivacy.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btnPrivacy addTarget:self action:@selector(onPrivacy:) forControlEvents:UIControlEventTouchDown];
        [viewContent addSubview:btnPrivacy];
        
    
        UIButton *btnTerms=[UIButton buttonWithType:UIButtonTypeCustom];
        btnTerms.frame=CGRectMake(10, 45, viewContent.frame.size.width-20, 35);
        // btnQuesAns.frame=CGRectMake(15, yPos, self.view.frame.size.width-30,45);
        //UIImage *imgSelect=[UIImage imageNamed:@"ButtonSelect1.png"];
        //[btnQuesAns setBackgroundImage:imgSelect forState:UIControlStateNormal];
        [btnTerms setTitle:@"Terms of Service" forState:UIControlStateNormal];
        [btnTerms setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnTerms.titleLabel.font=fontname14;
        btnTerms.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btnTerms addTarget:self action:@selector(onTerms:) forControlEvents:UIControlEventTouchDown];
        [viewContent addSubview:btnTerms];
    }
    
    yPos+=100;
    
        {
            
            UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,50)];
            viewContent.backgroundColor = [UIColor whiteColor];
            viewContent.layer.shadowOpacity = 0.6f;
            viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
            viewContent.layer.shadowRadius = 2.0f;
            viewContent.layer.cornerRadius = 2.5f;
            viewContent.tag=123;
            [scrollView addSubview:viewContent];
            
            
            
            UIButton *btnChgPwd=[UIButton buttonWithType:UIButtonTypeCustom];
            btnChgPwd.frame=CGRectMake(10, 5, viewContent.frame.size.width-20, 35);
            // btnQuesAns.frame=CGRectMake(15, yPos, self.view.frame.size.width-30,45);
            //UIImage *imgSelect=[UIImage imageNamed:@"ButtonSelect1.png"];
            //[btnQuesAns setBackgroundImage:imgSelect forState:UIControlStateNormal];
            [btnChgPwd setTitle:@"Change Password" forState:UIControlStateNormal];
            [btnChgPwd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnChgPwd.titleLabel.font=fontname14;
            btnChgPwd.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            [btnChgPwd addTarget:self action:@selector(onChangePassword:) forControlEvents:UIControlEventTouchDown];
            [viewContent addSubview:btnChgPwd];
            

    }
    
    yPos+=65;
    
    {
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,50)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        
        
        UIButton *btnLogout=[UIButton buttonWithType:UIButtonTypeCustom];
        btnLogout.frame=CGRectMake(10, 5, viewContent.frame.size.width-20, 35);
        // btnQuesAns.frame=CGRectMake(15, yPos, self.view.frame.size.width-30,45);
        //UIImage *imgSelect=[UIImage imageNamed:@"ButtonSelect1.png"];
        //[btnQuesAns setBackgroundImage:imgSelect forState:UIControlStateNormal];
        [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
        [btnLogout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnLogout.titleLabel.font=fontname14;
        btnLogout.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btnLogout addTarget:self action:@selector(onLogout:) forControlEvents:UIControlEventTouchDown];
        [viewContent addSubview:btnLogout];
        
        
    }
    
    yPos+=65;
    
    {
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,50)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        
        UIButton *btnDeleteAC=[UIButton buttonWithType:UIButtonTypeCustom];
        btnDeleteAC.frame=CGRectMake(10, 5, viewContent.frame.size.width-20, 35);
        // btnQuesAns.frame=CGRectMake(15, yPos, self.view.frame.size.width-30,45);
        //UIImage *imgSelect=[UIImage imageNamed:@"ButtonSelect1.png"];
        //[btnQuesAns setBackgroundImage:imgSelect forState:UIControlStateNormal];
        [btnDeleteAC setTitle:@"Delete Account" forState:UIControlStateNormal];
        [btnDeleteAC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnDeleteAC.titleLabel.font=fontname14;
        btnDeleteAC.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btnDeleteAC addTarget:self action:@selector(DeleteAction:) forControlEvents:UIControlEventTouchDown];
        [viewContent addSubview:btnDeleteAC];
        
        
    }
    

    

}

-(void)onDeleteAccount:(id)sender
{
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=1;
    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
    
    [service executeWebserviceWithMethod1:METHOD_DELETE_ACCOUNT withValues:strSend];
    
}

-(void)onBack
{
    [self performSegueWithIdentifier:@"AppSettings_Home" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - Actions

-(IBAction)onPrivacy:(id)sender
{
    appDelegate.strWchAppSetting=@"Privacy";
    [self performSegueWithIdentifier:@"AppSettings_ChangePwd" sender:self];
}

-(IBAction)onTerms:(id)sender
{
    appDelegate.strWchAppSetting=@"Terms";
    [self performSegueWithIdentifier:@"AppSettings_ChangePwd" sender:self];
}

-(IBAction)onChangePassword:(id)sender
{
    appDelegate.strWchAppSetting=@"ChangePwd";
    [self performSegueWithIdentifier:@"AppSettings_ChangePwd" sender:self];
}

-(IBAction)onLogout:(id)sender
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
    [self performSegueWithIdentifier:@"AppSetting_Login" sender:self];
 
}

-(IBAction)DeleteAction:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Binder"
                                  message:@"Are you sure want to delete your account ?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Delete"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //[alert dismissViewControllerAnimated:YES completion:nil];
                             [self onDeleteAccount:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -
#pragma mark - Webservice Delegate

-(void)receivedErrorWithMessage:(NSString *)message
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

    
}
-(void)receivedResponse:(NSDictionary *)dictResponse fromWebservice:(webservice *)webservice
{
     [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    if (webservice.tag==1)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:@"" forKey:@"email"];
            [defaults setValue:@"" forKey:@"id"];
            [defaults setValue:@"" forKey:@"name"];
            [defaults setValue:@"" forKey:@"picture"];
            [defaults setValue:@"" forKey:@"token"];
            
            
            appDelegate.strLoginStatus=@"LoggedOut";
            [defaults setValue:appDelegate.strLoginStatus forKey:@"LoginStatus"];

            
            [self performSegueWithIdentifier:@"AppSetting_MainPage" sender:self];
            
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:[dictResponse valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];

            
        }
        else
        {
            NSString *strErrCode=[NSString stringWithFormat:@"%@",[dictResponse valueForKey:@"error_code"]];
            
            if ([strErrCode isEqualToString:@"104"])
            {
                //  [self performSegueWithIdentifier:@"BinderHome_Login" sender:self];
                
                appDelegate.strIsLoggedOut=@"yes";
                
                appDelegate.strLoginStatus=@"LoggedOut";
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:appDelegate.strLoginStatus forKey:@"LoginStatus"];
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LogIn *ToLogin = (LogIn *)[sb instantiateViewControllerWithIdentifier:@"LogIn"];
                [self.navigationController pushViewController:ToLogin animated:YES];
                
            }
            
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:[dictResponse valueForKey:@"error"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
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
