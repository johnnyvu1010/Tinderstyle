//
//  LogIn.m
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "LogIn.h"
#import "AppDelegate.h"
#import "EditProfile.h"
#import "DiscoveryQuestionaries.h"
#import "SWRevealViewController.h"
#import "MBProgressHUD.h"
#import "SingleViewInChatting.h"
#import "ChatView.h"

@interface LogIn ()
{
    UIScrollView *scrollView;
    AppDelegate *appDelegate;
    UITextField *currentTextView;
    UITextView *currentTextView1;
    bool keyboardIsShown;
    UITapGestureRecognizer *tapGesture;
    
}
@end

@implementation LogIn

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    int xPos=20;
    int yPos=15;
     UIView *viewLeft;
    int w=self.view.frame.size.width;

     UIFont *fontname15 = [UIFont fontWithName:@"Roboto-Regular" size:15];
    UIFont *fontname16 = [UIFont fontWithName:@"Roboto" size:16];
     UIFont *fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
   
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    //self.navigationItem.title=@"Log In With Email";
    
    UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblNav.text=@"Log In With Email";
    lblNav.textColor=[UIColor blackColor];
    lblNav.backgroundColor=[UIColor clearColor];
    [lblNav setFont:fontname18];
    
    self.navigationItem.titleView=lblNav;
    self.navigationController.navigationBar.translucent = NO;
    
   // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    barBtn.tintColor=[UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:barBtn ];
      
    
//    UIButton *btnBG=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnBG.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    UIImage *imgBG=[UIImage imageNamed:@"Home BG.jpg"];
//    [btnBG setImage:imgBG forState:UIControlStateNormal];
//    [self.view addSubview:btnBG];
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home BG.jpg"]];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.delaysContentTouches=NO;
    [self.view addSubview:scrollView];

    
   
    UIButton *btnForgot=[UIButton buttonWithType:UIButtonTypeCustom];
    btnForgot.frame=CGRectMake(xPos, yPos, 140, 35);
    [btnForgot setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [btnForgot setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     btnForgot.titleLabel.font=fontname15;
    //btnForgot.titleLabel.font=[UIFont boldSystemFontOfSize:11];
    btnForgot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnForgot setTintColor:[UIColor whiteColor]];
    [btnForgot addTarget:self action:@selector(onForgot:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btnForgot];
    
    
    UIButton *btnSignUp=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSignUp.frame=CGRectMake(w-90, yPos, 75, 35);
    [btnSignUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    [btnSignUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     btnSignUp.titleLabel.font=fontname15;
   // btnSignUp.titleLabel.font=[UIFont boldSystemFontOfSize:11];
    btnSignUp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     [btnSignUp addTarget:self action:@selector(ToSignup:) forControlEvents:UIControlEventTouchUpInside];
    [btnSignUp setTintColor:[UIColor whiteColor]];
    [scrollView addSubview:btnSignUp];

     yPos+=55;
    
    {
        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        UITextField *txtEmail=[[UITextField alloc]initWithFrame:CGRectMake(xPos,yPos , w-40, 35)];
        // txtEmail.placeholder=@" Email";
        txtEmail.tag=TEXT_EMAIL;
        txtEmail.textAlignment=NSTextAlignmentLeft;
        txtEmail.delegate=self;
        //[txtEmail setFont:[UIFont boldSystemFontOfSize:12]];
        [txtEmail setFont:fontname16];
        txtEmail.textColor=[UIColor blackColor];
        txtEmail.leftView=viewLeft;
        txtEmail.leftViewMode=UITextFieldViewModeAlways;
        txtEmail.keyboardType=UIKeyboardTypeEmailAddress;
       // txtEmail.text=strUserName;
        [txtEmail setBackgroundColor:[UIColor clearColor]];
        txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [txtEmail setAutocorrectionType:UITextAutocorrectionTypeNo];
        [scrollView addSubview:txtEmail];
        
        UIColor *color=[UIColor grayColor];
        txtEmail.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName:color}];
        
        UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(xPos, yPos+35, w-40, 1)];
        [[lblLine layer]setBorderWidth:1.0];
        [[lblLine layer]setBorderColor:[UIColor grayColor].CGColor];
        [scrollView addSubview:lblLine];
        
      //  txtEmail.text=@"gopal@wepop.in";
      
        yPos+=55;
    }
    
    {
        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        UITextField *txtPassword=[[UITextField alloc]initWithFrame:CGRectMake(xPos,yPos , w-40, 35)];
        //txtPassword.placeholder=@" Password";
        txtPassword.tag=TEXT_PASSWORD;
        txtPassword.delegate=self;
        txtPassword.textAlignment=NSTextAlignmentLeft;
        txtPassword.textColor=[UIColor blackColor];
       //[txtPassword setFont:[UIFont boldSystemFontOfSize:12]];
        [txtPassword setFont:fontname16];
        txtPassword.leftView=viewLeft;
        txtPassword.leftViewMode=UITextFieldViewModeAlways;
        txtPassword.secureTextEntry=YES;
       // txtPassword.text=strpwd;
        [scrollView addSubview:txtPassword];
        
        UIColor *color=[UIColor grayColor];
        txtPassword.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:color}];
        
        UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(xPos, yPos+35, w-40, 1)];
        [[lblLine layer]setBorderWidth:1.0];
        [[lblLine layer]setBorderColor:[UIColor grayColor].CGColor];
        [scrollView addSubview:lblLine];

     // txtPassword.text=@"gopal";
//        yPos+=45;
    }
    
//    UIButton *btnShowPwd=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnShowPwd.frame=CGRectMake(xPos, yPos, 120, 25);
//    UIImage *imgsignup=[UIImage imageNamed:@"check_box_unclick24px.png"];
//    [btnShowPwd setImage:imgsignup forState:UIControlStateNormal];
//    UIImage *imgsignup1=[UIImage imageNamed:@"check_box_click24px.png"];
//    [btnShowPwd setImage:imgsignup1 forState:UIControlStateSelected];
//    [btnShowPwd setTitle:@" Show Password" forState:UIControlStateNormal];
//    [btnShowPwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnShowPwd.titleLabel.font=fontname2;
//    btnShowPwd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [btnShowPwd addTarget:self action:@selector(onShowPassword:) forControlEvents:UIControlEventTouchDown];
//    [scrollView addSubview:btnShowPwd];
//    
//    UIButton *btnRemember=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnRemember.frame=CGRectMake(xPos+135, yPos, w-195, 25);
//    UIImage *imgsignup2=[UIImage imageNamed:@"check_box_unclick24px.png"];
//    [btnRemember setImage:imgsignup2 forState:UIControlStateNormal];
//    UIImage *imgsignup3=[UIImage imageNamed:@"check_box_click24px.png"];
//    [btnRemember setImage:imgsignup3 forState:UIControlStateSelected];
//    [btnRemember setTitle:@" Remember Me" forState:UIControlStateNormal];
//    [btnRemember setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnRemember.titleLabel.font=fontname2;
//    btnRemember.tag=BTN_REMEMBER;
//    if ([strRemember isEqualToString:@"YES"])
//    {
//        btnRemember.selected=YES;
//    }
//    else
//    {
//        btnRemember.selected=NO;
//    }
//    
//    btnRemember.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [btnRemember setTintColor:[UIColor whiteColor]];
//    [btnRemember addTarget:self action:@selector(onRemember:) forControlEvents:UIControlEventTouchDown];
//    [scrollView addSubview:btnRemember];
//    
    
    
    yPos+=70;
    UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame=CGRectMake(xPos, yPos, w-40, 40);
    //    UIImage *imgLogin=[UIImage imageNamed:@"Sign in button.png"];
    //    [btnLogin setBackgroundImage:imgLogin forState:UIControlStateNormal];
    [btnLogin setTitle:@"LOG IN" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnLogin.titleLabel.font=fontname18;
   // btnSignUp.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    [btnLogin addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchDown];
    [btnLogin setBackgroundColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
//    [[btnLogin layer]setBorderWidth:1.0];
//    [[btnLogin layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [scrollView addSubview:btnLogin];

    
}

-(void)onBack
{
    if ([appDelegate.strIsLoggedOut isEqualToString:@"yes"])
    {
        [self performSegueWithIdentifier:@"Login_MainPage" sender:self];
        appDelegate.strIsLoggedOut=@"no";
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Actions

-(IBAction)onLogin:(id)sender
{
    
           UITextField *txtEmail=(UITextField *)[scrollView viewWithTag:TEXT_EMAIL];
        UITextField *txtPassword=(UITextField *)[scrollView viewWithTag:TEXT_PASSWORD];
        
        NSString *emailRegEx =@"[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([txtEmail.text isEqualToString:@""])
        {
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter email_id" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];

            [txtEmail becomeFirstResponder];
            return;
        }
        else if([emailTest evaluateWithObject:txtEmail.text] == NO)
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter valid email id." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            [txtEmail becomeFirstResponder];
            txtEmail.text=@"";
            return;
        }
        else if ([txtPassword.text isEqualToString:@""])
        {
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter password." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            [txtPassword becomeFirstResponder];
            txtPassword.text=@"";
            return;
        }
        

    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
        webservice *service=[[webservice alloc]init];
        service.tag=1;
        service.delegate=self;
        
        //        if ([appDelegate.strDeviceToken isEqual:[NSNull null]])
        //        {
      //  appDelegate.strDeviceToken=@"b945758c487a26ade4069d74a8eda42eb5c3cc7fe26dcfa3f05cf3c7d6ebcec3";
        //        }
        
        
        // NSString *strValues=[NSString stringWithFormat:@"{\"emailid\":\"%@\",\"password\":\"%@\",\"devicetoken\":\"%@\",\"devicetype\":\"%@\"}", txtEmail.text, txtPassword.text, @"8c03a41c795f3dc430f950db4394be225f8d9b2c373d99cc07407dc83431234c", appDelegate.strdevice_type];
        
        
       NSString *strValues=[NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\",\"login_by\":\"%@\",\"device_type\":\"%@\",\"device_token\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\"}",txtEmail.text,txtPassword.text,@"manual",@"ios",appDelegate.strDeviceToken,appDelegate.strLatitude,appDelegate.strLongitude];
    
    
    // NSString *strValues=[NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\",\"login_by\":\"%@\",\"device_type\":\"%@\",\"device_token\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\"}",txtEmail.text,txtPassword.text,@"manual",@"ios",appDelegate.strDeviceToken,@"11.8500483",@"79.7841415"];
    
    
        [service executeWebserviceWithMethod:METHOD_LOGIN withValues:strValues];
        
        // [self performSegueWithIdentifier:@"Login_Home" sender:self];
    
    NSLog(@"Lat: %@", appDelegate.strLatitude);
    NSLog(@"Long: %@", appDelegate.strLongitude);
   }

-(IBAction)ToSignup:(id)sender
{
    [self performSegueWithIdentifier:@"Login_SignUp" sender:self];
}
-(IBAction)onForgot:(id)sender
{
    [self performSegueWithIdentifier:@"Login_ForgotPassword" sender:self];
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
            
            [defaults setValue:[dictResponse valueForKey:@"email"] forKey:@"email"];
            [defaults setValue:[dictResponse valueForKey:@"id"] forKey:@"id"];
            [defaults setValue:[dictResponse valueForKey:@"name"] forKey:@"name"];
            [defaults setValue:[dictResponse valueForKey:@"picture"] forKey:@"picture"];
            [defaults setValue:[dictResponse valueForKey:@"token"] forKey:@"token"];
            [defaults setValue:[dictResponse valueForKey:@"status"] forKey:@"status"];
            [defaults setValue:[dictResponse valueForKey:@"pro_user"] forKey:@"ProUser"];
            [defaults setValue:[dictResponse valueForKey:@"pro_user"] forKey:@"ProUser"];
            [defaults setValue:[dictResponse valueForKey:@"gender"] forKey:@"gender"];
            
             appDelegate.strGender=[dictResponse valueForKey:@"gender"];
            appDelegate.strEmail=[dictResponse valueForKey:@"email"];
            appDelegate.strID=[dictResponse valueForKey:@"id"];
            appDelegate.strName=[dictResponse valueForKey:@"name"];
            appDelegate.strPicture=[dictResponse valueForKey:@"picture"];
            appDelegate.strToken=[dictResponse valueForKey:@"token"];
            appDelegate.strSattus=[dictResponse valueForKey:@"status"];
            appDelegate.strProUser=[dictResponse valueForKey:@"pro_user"];
            appDelegate.strIsLoggedOut=@"no";
            
            if ([[dictResponse valueForKey:@"profile_status"] boolValue]==false)
            {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                EditProfile *Edit_Profile = (EditProfile *)[sb instantiateViewControllerWithIdentifier:@"EditProfile"];
                [self.navigationController pushViewController:Edit_Profile animated:YES];

            }
            else if ([[dictResponse valueForKey:@"question_status"] boolValue]==false)
            {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                DiscoveryQuestionaries *DisQues = (DiscoveryQuestionaries *)[sb instantiateViewControllerWithIdentifier:@"DiscoveryQuestionaries"];
                [self.navigationController pushViewController:DisQues animated:YES];

            }
            else
            {
                
            appDelegate.strLoginStatus=@"LoggedIn";
            [defaults setValue:appDelegate.strLoginStatus forKey:@"LoginStatus"];
            
                if ([appDelegate.is_from_push isEqualToString:@"yes"])
                {
                     NSString *strIdLoged=[NSString stringWithFormat:@"%@",appDelegate.strID];
                    
                    if ([appDelegate.strNotiType isEqualToString:@"2"])
                    {
                       NSString *strNotifId=[appDelegate.dictNotiDetails valueForKey:@"Req_Receiver_id"];
                        
                        if ([strNotifId isEqualToString:strIdLoged])
                        {
                            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            SingleViewInChatting *Single_vc = (SingleViewInChatting *)[sb instantiateViewControllerWithIdentifier:@"SingleViewInChatting"];
                            [self.navigationController pushViewController:Single_vc animated:YES];
                        }
                        else
                        {
                            
                            appDelegate.is_from_push=@"";
                            [self performSegueWithIdentifier:@"Login_BinderHome" sender:self];
                            
                            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"You are LoggedIn with different user id. So we cant open the page as per notification received " preferredStyle:UIAlertControllerStyleAlert];
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
                    else if ([appDelegate.strNotiType isEqualToString:@"3"])
                    {
                        
                         NSString *strNotifId=[appDelegate.dictNotiDetails valueForKey:@"Msg_Receiver_id"];
                        
                        if ([strNotifId isEqualToString:strIdLoged])
                        {
                        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        ChatView *Chat_vc = (ChatView *)[sb instantiateViewControllerWithIdentifier:@"ChatView"];
                        [self.navigationController pushViewController:Chat_vc animated:YES];
                        }
                        else
                        {
                            
                            appDelegate.is_from_push=@"";
                            [self performSegueWithIdentifier:@"Login_BinderHome" sender:self];
                            
                            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"You are LoggedIn with different user id. So we cant open the page as per notification received " preferredStyle:UIAlertControllerStyleAlert];
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
                    else
                    {
                        appDelegate.is_from_push=@"";
                        [self performSegueWithIdentifier:@"Login_BinderHome" sender:self];
                    }

                }
                else
                {
                    [self performSegueWithIdentifier:@"Login_BinderHome" sender:self];
                }
            }
        }
        else
        {
            
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





#pragma mark -
#pragma mark - Keyboard

-(void)dismissKeyBoard
{
    // [tableTexture removeFromSuperview];
    
    for(UIView *subView in scrollView.subviews)
    {
        if([subView isKindOfClass:[UITextField class]])
        {
            if([subView isFirstResponder])
            {
                [subView resignFirstResponder];
                break;
            }
        }
        else if([subView isKindOfClass:[UITextView class]])
        {
            if([subView isFirstResponder])
            {
                [subView resignFirstResponder];
                break;
            }
        }
        
    }
    
    
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    
    currentTextView=textField;
    [self moveScrollView:textField.frame];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    currentTextView1=textView;
    [self moveScrollView:textView.frame];
}
- (void)keyboardDidHide:(NSNotification *)n
{
    keyboardIsShown = NO;
    [self.view removeGestureRecognizer:tapGesture];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardDidShow:(NSNotification *)n
{
    if (keyboardIsShown) {
        return;
    }
    
    keyboardIsShown = YES;
    [scrollView addGestureRecognizer:tapGesture];
}

- (void) moveScrollView:(CGRect) rect
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    CGSize kbSize = CGSizeMake(32, 260); // keyboard height
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = scrollView.frame;
    aRect.size.height -= (kbSize.height+55);
    if (!CGRectContainsPoint(aRect, rect.origin) )
    {
        CGPoint scrollPoint = CGPointMake(0.0, rect.origin.y-kbSize.height+100);
        
        if(screenHeight==480)
            scrollPoint = CGPointMake(0.0, rect.origin.y-kbSize.height+100+90);
        
        if(scrollPoint.y>0)
            [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) hideKeyBoard
{
    
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
