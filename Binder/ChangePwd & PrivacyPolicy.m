//
//  ChangePwd & PrivacyPolicy.m
//  Binder
//
//  Created by Admin on 06/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangePwd & PrivacyPolicy.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LogIn.h"
#import "SWRevealViewController.h"

@interface ChangePwd___PrivacyPolicy ()
{
    AppDelegate *appDelegate;
    UIScrollView *scrollView;
     NSString *strid, *strToken;
    UITextField *currentTextView;
    UITextView *currentTextView1;
    bool keyboardIsShown;
     UITapGestureRecognizer *tapGesture;
    NSDictionary *dictPrivacy, *dictTerms;
    UIFont *fontname10, *fontname13,*fontname15,*fontname16, *fontname18, *fontname15_16;

    
}
@end

@implementation ChangePwd___PrivacyPolicy

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    fontname10 = [UIFont fontWithName:@"Roboto" size:10];
    fontname13 = [UIFont fontWithName:@"Roboto" size:13];
    fontname15 = [UIFont fontWithName:@"Roboto-Regular" size:15];
    fontname15_16 = [UIFont fontWithName:@"Roboto-Regular" size:16];
    fontname16 = [UIFont fontWithName:@"Roboto" size:16];
    fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
     UIView *viewLeft;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

    
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.view addSubview:scrollView];
    
    int yPos=30;
    
    if ([appDelegate.strWchAppSetting isEqualToString:@"Privacy"])
    {
        UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        lblNav.text=@"Privacy Policy";
        lblNav.textColor=[UIColor blackColor];
        lblNav.backgroundColor=[UIColor clearColor];
        [lblNav setFont:fontname18];
        
        self.navigationItem.titleView=lblNav;

        
         // self.navigationItem.title=@"Privacy Policy";
        
         [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        webservice *service=[[webservice alloc]init];
        service.tag=2;
        service.delegate=self;
        
        [service executeWebserviceWithMethod2:METHOD_PRIVACY];

        
    }
    else if ([appDelegate.strWchAppSetting isEqualToString:@"Terms"])
    {
        UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        lblNav.text=@"Terms of Service";
        lblNav.textColor=[UIColor blackColor];
        lblNav.backgroundColor=[UIColor clearColor];
        [lblNav setFont:fontname18];
        
        self.navigationItem.titleView=lblNav;
          //self.navigationItem.title=@"Terms of Service";
        
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        webservice *service=[[webservice alloc]init];
        service.tag=3;
        service.delegate=self;
        
        [service executeWebserviceWithMethod2:METHOD_TERMS];
        
    }

   else if ([appDelegate.strWchAppSetting isEqualToString:@"ChangePwd"])
    {
        UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        lblNav.text=@"Change Password";
        lblNav.textColor=[UIColor blackColor];
        lblNav.backgroundColor=[UIColor clearColor];
        [lblNav setFont:fontname18];
        
        self.navigationItem.titleView=lblNav;

        
       // self.navigationItem.title=@"Change Password";
        
        {
            
            UILabel *lbCurr=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
            lbCurr.text=@"Current Password";
            [lbCurr setFont:fontname15_16];
            lbCurr.textColor=[UIColor blackColor];
            [scrollView addSubview:lbCurr];
            
            yPos+=35;
            
            
            UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
            viewContent.backgroundColor = [UIColor whiteColor];
            viewContent.layer.shadowOpacity = 0.6f;
            viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
            viewContent.layer.shadowRadius = 2.0f;
            viewContent.layer.cornerRadius = 2.5f;
            viewContent.tag=123;
            [scrollView addSubview:viewContent];
            
            {
                viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
                
                UITextField *txtCurrPwd=[[UITextField alloc]initWithFrame:CGRectMake(0,0 , viewContent.frame.size.width, viewContent.frame.size.height)];
                txtCurrPwd.tag=TEXT_CURR_PASSWORD;
                txtCurrPwd.delegate=self;
                txtCurrPwd.textAlignment=NSTextAlignmentLeft;
                [txtCurrPwd setFont:fontname16];
                txtCurrPwd.textColor=[UIColor blackColor];
                txtCurrPwd.leftView=viewLeft;
                txtCurrPwd.leftViewMode=UITextFieldViewModeAlways;
                 txtCurrPwd.secureTextEntry=YES;
                [viewContent addSubview:txtCurrPwd];
                
                UIColor *color=[UIColor lightGrayColor];
                txtCurrPwd.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Current Password" attributes:@{NSForegroundColorAttributeName:color}];
                
                
                
                
            }
            
            
            
            yPos+=60;
        }
        
        {
            
            UILabel *lblNew=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
            lblNew.text=@"New Password";
            [lblNew setFont:fontname15_16];
            lblNew.textColor=[UIColor blackColor];
            [scrollView addSubview:lblNew];
            
            yPos+=35;
            
            
            UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
            viewContent.backgroundColor = [UIColor whiteColor];
            viewContent.layer.shadowOpacity = 0.6f;
            viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
            viewContent.layer.shadowRadius = 2.0f;
            viewContent.layer.cornerRadius = 2.5f;
            viewContent.tag=123;
            [scrollView addSubview:viewContent];
            
            {
                viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
                
                UITextField *txtNewPwd=[[UITextField alloc]initWithFrame:CGRectMake(0,0 , viewContent.frame.size.width, viewContent.frame.size.height)];
                txtNewPwd.tag=TEXT_NEW_PASSWORD;
                txtNewPwd.delegate=self;
                txtNewPwd.textAlignment=NSTextAlignmentLeft;
                [txtNewPwd setFont:fontname16];
                txtNewPwd.textColor=[UIColor blackColor];
                txtNewPwd.leftView=viewLeft;
                txtNewPwd.leftViewMode=UITextFieldViewModeAlways;
                 txtNewPwd.secureTextEntry=YES;
                [viewContent addSubview:txtNewPwd];
                
                UIColor *color=[UIColor lightGrayColor];
                txtNewPwd.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"New Password" attributes:@{NSForegroundColorAttributeName:color}];
               
                
            }
            
            
            
            yPos+=60;
        }
        {
            
            UILabel *lblConf=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
            lblConf.text=@"Confirm Password";
            [lblConf setFont:fontname15_16];
            lblConf.textColor=[UIColor blackColor];
            [scrollView addSubview:lblConf];
            
            yPos+=35;
            
            
            UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
            viewContent.backgroundColor = [UIColor whiteColor];
            viewContent.layer.shadowOpacity = 0.6f;
            viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
            viewContent.layer.shadowRadius = 2.0f;
            viewContent.layer.cornerRadius = 2.5f;
            viewContent.tag=123;
            [scrollView addSubview:viewContent];
            
            {
                viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
                
                UITextField *txtConfPwd=[[UITextField alloc]initWithFrame:CGRectMake(0,0 , viewContent.frame.size.width, viewContent.frame.size.height)];
                txtConfPwd.tag=TEXT_CONF_PASSWORD;
                txtConfPwd.delegate=self;
                txtConfPwd.textAlignment=NSTextAlignmentLeft;
                [txtConfPwd setFont:fontname16];
                txtConfPwd.textColor=[UIColor blackColor];
                txtConfPwd.leftView=viewLeft;
                txtConfPwd.leftViewMode=UITextFieldViewModeAlways;
                 txtConfPwd.secureTextEntry=YES;
                [viewContent addSubview:txtConfPwd];
                
                UIColor *color=[UIColor lightGrayColor];
                txtConfPwd.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName:color}];
            }
            
            
            
            yPos+=60;
        }
        
        UIButton *btnUpdate=[UIButton buttonWithType:UIButtonTypeCustom];
        btnUpdate.frame=CGRectMake(0, self.view.frame.size.height-90, self.view.frame.size.width, 50);
        [btnUpdate setTitle:@"Save" forState:UIControlStateNormal];
        [btnUpdate setTitleColor:[UIColor colorWithRed:208/255.0 green:81/255.0 blue:48/255.0 alpha:1.0] forState:UIControlStateNormal];
        btnUpdate.titleLabel.font=fontname18;
        [[btnUpdate layer]setBorderWidth:1.0];
        [[btnUpdate layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
        [btnUpdate addTarget:self action:@selector(onChngPassword:) forControlEvents:UIControlEventTouchDown];
        [btnUpdate setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:btnUpdate];
        
        scrollView.contentSize=CGSizeMake(self.view.frame.size.width, yPos+100);

    }

}
-(void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onPageLoadTerms
{
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    
    int yPos=20;
    
    
    //    UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
    //    viewContent.backgroundColor = [UIColor whiteColor];
    //    viewContent.layer.shadowOpacity = 0.6f;
    //    viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
    //    viewContent.layer.shadowRadius = 2.0f;
    //    viewContent.layer.cornerRadius = 2.5f;
    //    viewContent.tag=123;
    //    [scrollView addSubview:viewContent];
    //
    //    {
    //        UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewContent.frame.size.width, viewContent.frame.size.height)];
    //        lblHead.text=[dictTerms valueForKey:@"content"];
    //        [lblHead setFont:fontname16];
    //        lblHead.textColor=[UIColor blackColor];
    //        [viewContent addSubview:lblHead];
    
    //}
    
    //   NSString *htmlStringa =@"<p>Privacy</p> <p>Privacy</p> <p>Privacy</p> v v  <p>Privacy</p> <p>Privacy</p><p>Privacy</p>   <p>Privacy</p>v<p>Privacy</p> <p>Privacy</p><p>Privacy</p><p>Privacy</p>   <p>Privacy</p>vv  <p>Privacy</p>   <p>Privacy</p><p>Privacy</p><p>Privacy</p>   <p>Privacy</p>v<p>Privacy</p> <p>Privacy</p><p>Privacy</p>   <p>Privacy</p>";
    
    NSString *htmlStringa =[dictTerms valueForKey:@"content"];
    
    NSAttributedString *attributedStringb = [[NSAttributedString alloc]
                                             
                                             initWithData: [htmlStringa dataUsingEncoding:NSUnicodeStringEncoding]
                                             
                                             options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                             
                                             documentAttributes: nil
                                             
                                             error: nil
                                             
                                             ];
    
    //            UITextView *txtview= [[UITextView alloc]initWithFrame:CGRectMake(xPos+10,yPos, self.view.frame.size.width-20,1000000)];
    //
    //
    //            txtview.attributedText = attributedStringb;
    //
    
    UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.view.frame.size.width-30, 25)];
    lblHead.attributedText=attributedStringb;
    [lblHead setFont:fontname16];
    lblHead.textColor=[UIColor blackColor];
    lblHead.textAlignment=NSTextAlignmentLeft;
    lblHead.numberOfLines=10;
    lblHead.lineBreakMode=NSLineBreakByWordWrapping;
    [self.view addSubview:lblHead];
    
    [lblHead sizeToFit];
    //[viewContent sizeToFit];
    int h=lblHead.frame.size.height;
    yPos+=h+10;
    
    
    
    
    
    
    yPos+=60;
    
}

-(void)onPageLoadPrivacy
{
    
    
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    
    int yPos=20;
    
    
    //        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
    //        viewContent.backgroundColor = [UIColor whiteColor];
    //        viewContent.layer.shadowOpacity = 0.6f;
    //        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
    //        viewContent.layer.shadowRadius = 2.0f;
    //        viewContent.layer.cornerRadius = 2.5f;
    //        viewContent.tag=123;
    //        [scrollView addSubview:viewContent];
    
    {
        //            UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewContent.frame.size.width, viewContent.frame.size.height)];
        //            lblHead.text=[dictPrivacy valueForKey:@"content"];
        //            [lblHead setFont:fontname16];
        //            lblHead.textColor=[UIColor blackColor];
        //            [viewContent addSubview:lblHead];
        
        // NSString *htmlStringa =@"<p>Privacy</p> <p>Privacy</p> <p>Privacy</p> v v  <p>Privacy</p> <p>Privacy</p><p>Privacy</p>   <p>Privacy</p>v<p>Privacy</p> <p>Privacy</p><p>Privacy</p><p>Privacy</p>   <p>Privacy</p>vv  <p>Privacy</p>   <p>Privacy</p><p>Privacy</p><p>Privacy</p>   <p>Privacy</p>v<p>Privacy</p> <p>Privacy</p><p>Privacy</p>   <p>Privacy</p>";
        
        NSString *htmlStringa =[dictPrivacy valueForKey:@"content"];
        
        NSAttributedString *attributedStringb = [[NSAttributedString alloc]
                                                 
                                                 initWithData: [htmlStringa dataUsingEncoding:NSUnicodeStringEncoding]
                                                 
                                                 options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                 
                                                 documentAttributes: nil
                                                 
                                                 error: nil
                                                 
                                                 ];
        
        //            UITextView *txtview= [[UITextView alloc]initWithFrame:CGRectMake(xPos+10,yPos, self.view.frame.size.width-20,1000000)];
        //
        //
        //            txtview.attributedText = attributedStringb;
        //
        
        UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.view.frame.size.width-30, 25)];
        lblHead.attributedText=attributedStringb;
        [lblHead setFont:fontname16];
        lblHead.textColor=[UIColor blackColor];
        lblHead.textAlignment=NSTextAlignmentLeft;
        lblHead.numberOfLines=10;
        lblHead.lineBreakMode=NSLineBreakByWordWrapping;
        [self.view addSubview:lblHead];
        
        [lblHead sizeToFit];
        //[viewContent sizeToFit];
        int h=lblHead.frame.size.height;
        yPos+=h+10;
        
        
        
    }
    
    
    
    //  yPos+=60;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -
#pragma mark - Actions

-(IBAction)onChngPassword:(id)sender
{
   
    UITextField *txtNewPwd=(UITextField *)[scrollView viewWithTag:TEXT_NEW_PASSWORD];
    UITextField *txtConfPwd=(UITextField *)[scrollView viewWithTag:TEXT_CONF_PASSWORD];
    UITextField *txtCurrPed=(UITextField *)[scrollView viewWithTag:TEXT_CURR_PASSWORD];
    
    
    if ([txtCurrPed.text isEqualToString:@""])
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter your current password." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        

        txtCurrPed.text=@"";
        [txtCurrPed becomeFirstResponder];
        return;
    }
    if ([txtNewPwd.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter your new password." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];

        txtNewPwd.text=@"";
        [txtNewPwd becomeFirstResponder];
        return;
    }

    if ([txtConfPwd.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter confirm password." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];

        txtConfPwd.text=@"";
        [txtConfPwd becomeFirstResponder];
        return;
    }

     [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=1;
    service.delegate=self;
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"password\":\"%@\",\"password_confirmation\":\"%@\",\"old_password\":\"%@\"}",strid,strToken,txtNewPwd.text,txtConfPwd.text,txtCurrPed.text];
    
    [service executeWebserviceWithMethod:METHOD_CHANGE_PASSWORD withValues:strValues];

    
   }



#pragma mark -
#pragma mark - Webservice Delegates

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
            [self.navigationController popViewControllerAnimated:YES];
            
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
    else  if (webservice.tag==2)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            dictPrivacy=[dictResponse valueForKey:@"page"];
            [self onPageLoadPrivacy];
            
           
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
    else  if (webservice.tag==3)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            dictTerms=[dictResponse valueForKey:@"page"];
            [self onPageLoadTerms];
            
            
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


#pragma mark -
#pragma mark - converting html text to normal text



- (NSString *)ConvertHTML:(NSString *)html

{
    
    
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    
    
    while ([theScanner isAtEnd] == NO) {
        
        
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        
    }
    
    
    
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    return html;
    
    
    
}


#pragma mark -
#pragma mark - Keyboard

-(void)dismissKeyBoard
{
    // [tableTexture removeFromSuperview];
    
//    UITextField *txtpwd=(UITextField *)[scrollView viewWithTag:TEXT_CURR_PASSWORD];
//    UITextField *txtNewpwd=(UITextField *)[scrollView viewWithTag:TEXT_NEW_PASSWORD];
//    UITextField *txtCnfpwd=(UITextField *)[scrollView viewWithTag:TEXT_CONF_PASSWORD];
    
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
