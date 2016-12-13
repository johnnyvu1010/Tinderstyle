//
//  SignUp.m
//  Binder
//
//  Created by Admin on 23/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SignUp.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "EditProfile.h"
#import "SWRevealViewController.h"

@interface SignUp ()
{
     UIScrollView *scrollView;
    UITextField *currentTextView;
    UITextView *currentTextView1;
     bool keyboardIsShown;
    UITapGestureRecognizer *tapGesture;
    AppDelegate *appDelegate;
    NSString *strGender;
    NSDictionary *dictRes;
    UIAlertController *alertController;
    NSString *strDOb;
    UIFont *fontname15,*fontname16, *fontname18, *fontname12;
    UIDatePicker *picker;
    NSDictionary *dictTerms;
    UIView *ViewPicker;
    UIView *viewPrivacy;
}
@end

@implementation SignUp

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int xPos=20;
    int yPos=15;
    UIView *viewLeft;
    int w=self.view.frame.size.width;
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
//    appDelegate.strAppState=@"SignUpDone";
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:appDelegate.strAppState forKey:@"AppStatus"];
    
    // Do any additional setup after loading the view.
    fontname15 = [UIFont fontWithName:@"Roboto-Regular" size:15];
    fontname16 = [UIFont fontWithName:@"Roboto" size:16];
    fontname12 = [UIFont fontWithName:@"Roboto" size:12];
    fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];

    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
   // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
   // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblNav.text=@"Sign Up With Email";
    lblNav.textColor=[UIColor blackColor];
    lblNav.backgroundColor=[UIColor clearColor];
    [lblNav setFont:fontname18];

    self.navigationItem.titleView=lblNav;
    self.navigationController.navigationBar.translucent = NO;

    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    barBtn.tintColor=[UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:barBtn ];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

    
    
    
//    UIButton *btnBG=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnBG.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    UIImage *imgBG=[UIImage imageNamed:@"Home BG.jpg"];
//    [btnBG setImage:imgBG forState:UIControlStateNormal];
//    [self.view addSubview:btnBG];
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home BG.jpg"]];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.delaysContentTouches=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    
    
    
    
    UIButton *btnLogIn=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLogIn.frame=CGRectMake(w-90, yPos, 75, 35);
    [btnLogIn setTitle:@"Login" forState:UIControlStateNormal];
    [btnLogIn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     btnLogIn.titleLabel.font=fontname15;
   // btnLogIn.titleLabel.font=[UIFont boldSystemFontOfSize:11];
    btnLogIn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnLogIn addTarget:self action:@selector(ToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [btnLogIn setTintColor:[UIColor whiteColor]];
    [scrollView addSubview:btnLogIn];
    
    yPos+=50;
    
    {
        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        UITextField *txtName=[[UITextField alloc]initWithFrame:CGRectMake(xPos,yPos , w-40, 35)];
        // txtEmail.placeholder=@" Email";
        txtName.tag=TEXT_NAME;
        txtName.textAlignment=NSTextAlignmentLeft;
        txtName.delegate=self;
        [txtName setFont:fontname16];
        txtName.textColor=[UIColor blackColor];
        txtName.leftView=viewLeft;
        txtName.leftViewMode=UITextFieldViewModeAlways;
        txtName.keyboardType=UIKeyboardTypeEmailAddress;
        // txtName.text=strUserName;
        [txtName setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:txtName];
        
        UIColor *color=[UIColor grayColor];
        txtName.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:color}];
        
        UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(xPos, yPos+35, w-40, 1)];
        [[lblLine layer]setBorderWidth:1.0];
        [[lblLine layer]setBorderColor:[UIColor grayColor].CGColor];
        [scrollView addSubview:lblLine];
        
        yPos+=50;
    }

    
    {
        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        UITextField *txtEmail=[[UITextField alloc]initWithFrame:CGRectMake(xPos,yPos , w-40, 35)];
        // txtEmail.placeholder=@" Email";
        txtEmail.tag=TEXT_EMAIL;
        txtEmail.textAlignment=NSTextAlignmentLeft;
        txtEmail.delegate=self;
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
        
        yPos+=50;
    }
    
    {
        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        UITextField *txtPassword=[[UITextField alloc]initWithFrame:CGRectMake(xPos,yPos , w-40, 35)];
        //txtPassword.placeholder=@" Password";
        txtPassword.tag=TEXT_PASSWORD;
        txtPassword.delegate=self;
        txtPassword.textAlignment=NSTextAlignmentLeft;
        txtPassword.textColor=[UIColor blackColor];
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
        
        
                yPos+=45;
    }
    
        UILabel *lblGender=[[UILabel alloc]initWithFrame:CGRectMake(xPos, yPos, w-60, 35)];
        lblGender.text=@"Gender";
        [lblGender setFont:fontname15];
        lblGender.textColor=[UIColor blackColor];
        lblGender.textAlignment=NSTextAlignmentLeft;
        [scrollView addSubview:lblGender];
    
        yPos+=45;
    
    UIButton *btnMale=[UIButton buttonWithType:UIButtonTypeCustom];
    btnMale.frame=CGRectMake(xPos, yPos, 80, 25);
    [btnMale setImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
    [btnMale setImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
    [btnMale setTitle: @"  Male" forState: UIControlStateNormal];
    [btnMale setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // btnMale.titleLabel.font=fontname1;
    btnMale.titleLabel.font=fontname16;
   btnMale.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnMale addTarget:self action:@selector(onGender:) forControlEvents:UIControlEventTouchUpInside];
    btnMale.selected=YES;
    btnMale.tag=05;
    strGender=@"male";
    [scrollView addSubview:btnMale];
    
    yPos+=45;
    
    UIButton *btnFeMale=[UIButton buttonWithType:UIButtonTypeCustom];
    btnFeMale.frame=CGRectMake(xPos, yPos, 100, 25);
    [btnFeMale setImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
    [btnFeMale setImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
    [btnFeMale setTitle: @"  Female" forState: UIControlStateNormal];
    [btnFeMale setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // btnFeMale.titleLabel.font=fontname1;
   btnFeMale.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnFeMale.titleLabel.font=fontname16;
    [btnFeMale addTarget:self action:@selector(onGender:) forControlEvents:UIControlEventTouchUpInside];
    btnFeMale.tag=06;
    [scrollView addSubview:btnFeMale];

    
    yPos+=45;
    
    {
        
        UIButton *btnDOB=[UIButton buttonWithType:UIButtonTypeCustom];
        btnDOB.frame=CGRectMake(xPos,yPos , w-40, 35);
        [btnDOB setTitle:@" Date Of Birth" forState:UIControlStateNormal];
        [btnDOB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btnDOB.tag=BTN_DOB;
        [btnDOB.titleLabel setFont:fontname16];
       // [btnDOB setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
        btnDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnDOB addTarget:self action:@selector(onDOB:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnDOB];
       

        
//        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
//        UITextField *txtDOB=[[UITextField alloc]initWithFrame:CGRectMake(xPos,yPos , w-40, 35)];
//        // txtDOB.placeholder=@" Email";
//        txtDOB.tag=TEXT_DOB;
//        txtDOB.textAlignment=NSTextAlignmentLeft;
//        txtDOB.delegate=self;
//        [txtDOB setFont:[UIFont boldSystemFontOfSize:12]];
//        txtDOB.textColor=[UIColor blackColor];
//        txtDOB.leftView=viewLeft;
//        txtDOB.leftViewMode=UITextFieldViewModeAlways;
//        txtDOB.keyboardType=UIKeyboardTypeEmailAddress;
//        // txtDOB.text=strUserName;
//        [txtDOB setBackgroundColor:[UIColor clearColor]];
//        [scrollView addSubview:txtDOB];
//        
//        UIColor *color=[UIColor grayColor];
//        txtDOB.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"DOB" attributes:@{NSForegroundColorAttributeName:color}];
//        
        UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(xPos, yPos+35, w-40, 1)];
        [[lblLine layer]setBorderWidth:1.0];
        [[lblLine layer]setBorderColor:[UIColor grayColor].CGColor];
        [scrollView addSubview:lblLine];
        
        yPos+=50;
    }

    
    
    yPos+=40;
    
    
    UIButton *btnCheckTerms=[UIButton buttonWithType:UIButtonTypeCustom];
    btnCheckTerms.frame=CGRectMake(20, yPos, 25, 25);
    UIImage *imgsignup=[UIImage imageNamed:@"check_box_unclick_24px.png"];
    [btnCheckTerms setImage:imgsignup forState:UIControlStateNormal];
    UIImage *imgsignup1=[UIImage imageNamed:@"check_box_click_24px.png"];
    [btnCheckTerms setImage:imgsignup1 forState:UIControlStateSelected];
    btnCheckTerms.tag=101;
//    [btnCheckTerms setTitle:@" I accept" forState:UIControlStateNormal];
//    [btnCheckTerms setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btnCheckTerms.titleLabel.font=fontname12;
   // btnCheckTerms.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnCheckTerms addTarget:self action:@selector(onTermsCheck:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnCheckTerms];
    
//    NSDictionary *redAttribs=@{NSForegroundColorAttributeName:[UIColor redColor]};
//    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:@"terms of service"];
//    [astring setAttributes:redAttribs range:NSMakeRange(30,16)];
//    // [astring setAttributes:redAttribs1 range:NSMakeRange(56,15)];
    
    UIButton *btnType=[[UIButton alloc]initWithFrame:CGRectMake(45,yPos,140,25)];
   // [btnType setAttributedTitle:astring forState:UIControlStateNormal];
   // [[btnType titleLabel] setNumberOfLines:0];
   // btnType.titleLabel.textColor=[UIColor whiteColor];
    [btnType setTitle:@"I accept terms of service" forState:UIControlStateNormal];
    [btnType setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnType addTarget:self action:@selector(onShowPrivacy) forControlEvents:UIControlEventTouchDown];
    btnType.titleLabel.textAlignment=NSTextAlignmentLeft;
    btnType.titleLabel.font=fontname12;
    //[btnType.titleLabel setFont:[UIFont systemFontOfSize:13]];
   // [btnType setBackgroundColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
    [scrollView addSubview:btnType];
    
    
//    NSDictionary *redAttribs2=@{NSForegroundColorAttributeName:[UIColor redColor]};
//    NSMutableAttributedString *astring1=[[NSMutableAttributedString alloc]initWithString:@"and our Privacy Policy"];
//    [astring1 setAttributes:redAttribs2 range:NSMakeRange(8,15)];
//    
//    UIButton *btnType1=[[UIButton alloc]initWithFrame:CGRectMake(15,self.view.frame.size.height-70,self.view.frame.size.width-30,20)];
//    [btnType1 setAttributedTitle:astring1 forState:UIControlStateNormal];
//    [[btnType1 titleLabel] setNumberOfLines:0];
//    btnType1.titleLabel.textColor=[UIColor whiteColor];
//    [btnType1 addTarget:self action:@selector(onShowPrivacy) forControlEvents:UIControlEventTouchDown];
//    btnType1.titleLabel.textAlignment=NSTextAlignmentCenter;
//    [btnType1.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [self.view addSubview:btnType1];
    
    yPos+=45;

    UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame=CGRectMake(xPos, yPos, w-40, 40);
    //    UIImage *imgLogin=[UIImage imageNamed:@"Sign in button.png"];
    //    [btnLogin setBackgroundImage:imgLogin forState:UIControlStateNormal];
    [btnLogin setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // btnLogin.titleLabel.font=fontname1;
    btnLogin.titleLabel.font=fontname18;
    btnLogIn.tag=100;
    [btnLogin addTarget:self action:@selector(onSignup:) forControlEvents:UIControlEventTouchDown];
    [btnLogin setBackgroundColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
    //    [[btnLogin layer]setBorderWidth:1.0];
    //    [[btnLogin layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [scrollView addSubview:btnLogin];
    
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, yPos+130);


}

-(void)viewWillAppear:(BOOL)animated
{
  //  [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=2;
    service.delegate=self;
    
    [service executeWebserviceWithMethod2:METHOD_TERMS];
}

-(void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)onShowPrivacy
{
    [viewPrivacy removeFromSuperview];
    viewPrivacy=[[UIView alloc]initWithFrame:CGRectMake(15, 20, self.view.frame.size.width-30, self.view.frame.size.height-40)];
    viewPrivacy.backgroundColor=[UIColor whiteColor];
    viewPrivacy.layer.borderWidth = 1.0f;
        viewPrivacy.layer.cornerRadius =2.0f;
    [self.view addSubview:viewPrivacy];
    
    UIScrollView *scrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, viewPrivacy.frame.size.width, viewPrivacy.frame.size.height-50)];
    scrollView1.showsVerticalScrollIndicator=NO;
    [viewPrivacy addSubview:scrollView1];
    
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, viewPrivacy.frame.size.width-20, 25)];
    lblTitle.textAlignment=NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor lightGrayColor];
    [lblTitle setText:@"Terms And Conditions"];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:20]];
    [viewPrivacy addSubview:lblTitle];
    
    UIButton *btnClose=[[UIButton alloc]initWithFrame:CGRectMake(viewPrivacy.frame.size.width-32, 2, 30, 30)];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"closeView.png"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchDown];
    [viewPrivacy addSubview:btnClose];
    
//    {
//        UITextView *txtView=[[UITextView alloc]initWithFrame:CGRectMake(5, 40, viewPrivacy.frame.size.width-10, viewPrivacy.frame.size.height-50)];
//        txtView.layer.borderWidth = 1.0f;
//        txtView.layer.cornerRadius =2.0f;
//        txtView.clipsToBounds = YES;
//        txtView.backgroundColor=[UIColor clearColor];
//        txtView.userInteractionEnabled=NO;
//        [scrollView1 addSubview:txtView];
//    }
    
    
    
//    UITextView *txtView=[[UITextView alloc]initWithFrame:CGRectMake(5, 20, viewPrivacy.frame.size.width-10, viewPrivacy.frame.size.height-50)];
//    txtView.backgroundColor=[UIColor clearColor];
//    // [txtView sizeToFit];
//    txtView.userInteractionEnabled=NO;
//    txtView.text=@"Please read these Terms and Conditions carefully before using the Cuft. App.\n\n Your access to and use of the App is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the App. By accessing or using the App you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the App. \n\n Cuft. assumes no responsibility nor can be held liable by users, hosts or renters for any damage or loss to any of the following but not limited to: personal , non personal belongings, commercial goods (items stored), personal property (spaces) .Renters and hosts \n\n You further acknowledge and agree that: \n\n  Cuft. shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any or services available on or through the Cuft. app including but not limited to personal , non personal belongings, commercial goods (items stored),personal property (spaces) . \n\n Users of Cuft., Renters and hosts , respectively agree to conduct a business deal between them and therefore release Cuft. from any and all responsibility. \n\n If you wish to purchase service made available through the App , you may be asked to supply certain information relevant to your Purchase including, but not limited to, your credit card information and or paypal email account. \n \n Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material. You are responsible and may be held liable for the content you post on the App. \n\n For optional 3 rd party services that are not owned or controlled by Cuft., Cuft. assumes no responsibility for the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that Cuft. shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services. \n\n We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 days&#39; notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion. Please contact us If you have any questions about these Terms, please contact us.";
//    // txtView.textColor=[UIColor blackColor];
//    txtView.textAlignment=NSTextAlignmentJustified;
//    [txtView setFont:[UIFont fontWithName:@"Helvetica" size:13]];
//    //    txtView.layer.borderWidth = 1.0f;
//    //    txtView.layer.cornerRadius =2.0f;
//    //    txtView.clipsToBounds = YES;
//    //    txtView.layer.borderColor = [[UIColor grayColor] CGColor];
//    [txtView sizeToFit];
//    [txtView layoutIfNeeded];
//    [scrollView addSubview:txtView];
//    int nHeight=txtView.frame.size.height;
    
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
    
    UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(5, 20, viewPrivacy.frame.size.width-10, viewPrivacy.frame.size.height-50)];
    lblHead.attributedText=attributedStringb;
    [lblHead setFont:fontname16];
    lblHead.textColor=[UIColor blackColor];
    lblHead.textAlignment=NSTextAlignmentLeft;
    lblHead.numberOfLines=10;
    lblHead.lineBreakMode=NSLineBreakByWordWrapping;
    [scrollView1 addSubview:lblHead];
    
    [lblHead sizeToFit];
    //[viewContent sizeToFit];
    int h=lblHead.frame.size.height;
    
    
    
    
    
    
  //  yPos+=60;

    
    scrollView1.contentSize=CGSizeMake(viewPrivacy.frame.size.width,h+35);
    
    
    
}
-(void)onClose
{
    [viewPrivacy removeFromSuperview];
}


#pragma mark -
#pragma mark - Actions

- (IBAction)onTermsCheck:(id)sender
{
    UIButton *btnSignUp=(UIButton *)[self.view viewWithTag:100];
    
    UIButton *check=(UIButton *)sender;
    
    check.selected=!check.selected;
    
    if([check isSelected])
    {
       // btnSignUp.userInteractionEnabled=YES;
    }else
    {
       // btnSignUp.userInteractionEnabled=NO;
        
        
    }
    
}
-(IBAction)onDOB:(id)sender
{
    
    ViewPicker = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 250)];
    [self.view addSubview:ViewPicker];
    
    picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40, self.view.frame.size.width, 210)];
    picker.datePickerMode=UIDatePickerModeDate;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    
    NSDate *dateMin=nil;
    NSDate *dateMax=nil;
    NSDate *date=[NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:-18];
    dateMax=[calendar dateByAddingComponents:comps toDate:date options:0];
    [comps setYear:-100];
    dateMin=[calendar dateByAddingComponents:comps toDate:date options:0];
    picker.date=date;
    picker.backgroundColor=[UIColor whiteColor];
    
    picker.minimumDate=dateMin;
    picker.maximumDate=dateMax;
   picker.tag=DATEPICKER_DOB;
    
    [ViewPicker addSubview:picker];
    
   UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    tools.tintColor=[UIColor colorWithRed:167/255.0 green:7/255.0 blue:20/255.0 alpha:1.0];
    
    
   UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(onActionDone:)];
    [[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0f, 5.0f) forBarMetrics:UIBarMetricsDefault];

   UIBarButtonItem *CancelButton=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(onActionCancelled:)];
    
   UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    doneButton.tintColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
     CancelButton.tintColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
       NSArray *array = [[NSArray alloc]initWithObjects:flexSpace,CancelButton,doneButton,nil];
     [tools setItems:array];
    [ViewPicker addSubview:tools];
    
   

}

//-(IBAction)onAlertClose:(id)sender
//{
//   [alertController dismissViewControllerAnimated:YES completion:nil];
//}


-(IBAction)onGender:(id)sender
{
    UIButton *btnMale=(UIButton *)[scrollView viewWithTag:05];
    UIButton *btnFemale=(UIButton *)[scrollView viewWithTag:06];
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    
    if (btn.tag==05)
    {
        strGender=@"male";
        btnMale.selected=YES;
        btnFemale.selected=NO;
        
    }
    else if (btn.tag==06)
    {
        strGender=@"female";
        btnFemale.selected=YES;
        btnMale.selected=NO;
    }
    NSLog(@"Gender: %@",strGender);
}
-(IBAction)ToLogin:(id)sender
{
    [self performSegueWithIdentifier:@"SignUp_Login" sender:self];
}

//-(IBAction)onSignup:(id)sender
//{
//    
//   [self performSegueWithIdentifier:@"SignUp_EditProfile" sender:self];
//}

-(IBAction)onSignup:(id)sender
{
  

    
    UITextField *txtName=(UITextField *)[scrollView viewWithTag:TEXT_NAME];
  //  NSString *strName=txtName.text;
    
    if ([txtName.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please enter name." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [txtName becomeFirstResponder];
        txtName.text=@"";
        return;

    }
    
    
    UITextField *txtEmail=(UITextField *)[scrollView viewWithTag:TEXT_EMAIL];
 //   NSString *strEmail=txtEmail.text;
    
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
    
    
    UITextField *txtPassword=(UITextField *)[scrollView viewWithTag:TEXT_PASSWORD];
  //  NSString *strPassword=txtPassword.text;
    
    if ([txtPassword.text isEqualToString:@""])
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
    
    UIButton *btnDOB=(UIButton *)[scrollView viewWithTag:BTN_DOB];
  //  NSString *strDOB=txtDOB.text;
    
    if ([[btnDOB titleForState:UIControlStateNormal]isEqualToString:@" Date Of Birth"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please Choose DOB." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
                return;
    }

    UIButton *btnCheck=(UIButton *)[scrollView viewWithTag:101];
    
    if (btnCheck.isSelected==NO)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please accept terms and conditions." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
      [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=1;
    service.delegate=self;
    
   
    appDelegate.strDeviceToken=@"b945758c487a26ade4069d74a8eda42eb5c3cc7fe26dcfa3f05cf3c7d6ebcec3";
    
    
    // NSString *strValues=[NSString stringWithFormat:@"{\"emailid\":\"%@\",\"password\":\"%@\",\"devicetoken\":\"%@\",\"devicetype\":\"%@\"}", txtEmail.text, txtPassword.text, @"8c03a41c795f3dc430f950db4394be225f8d9b2c373d99cc07407dc83431234c", appDelegate.strdevice_type];
    
    
    NSString *strValues=[NSString stringWithFormat:@"{\"username\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"login_by\":\"%@\",\"picture\":\"%@\",\"gender\":\"%@\",\"dob\":\"%@\",\"device_type\":\"%@\",\"device_token\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\"}",txtName.text, txtEmail.text,txtPassword.text,@"manual",@"",strGender, strDOb,@"ios", appDelegate.strDeviceToken,appDelegate.strLatitude,appDelegate.strLongitude];
    
    [service executeWebserviceWithMethod:METHOD_SIGNUP withValues:strValues];
    
}

#pragma mark -
#pragma mark - TextField Delegate

-(bool)textFieldShouldBeginEditing:(UITextField *)textField
{
     UITextField *txtDOB=(UITextField *)[scrollView viewWithTag:TEXT_PASSWORD];
    
    if(txtDOB.tag==04)
    {
        
    }
    return YES;
}





#pragma mark -
#pragma mark - WebService Delegate

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
            dictRes=dictResponse;
            
            appDelegate.strAppState=@"SignUpDone";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:appDelegate.strAppState forKey:@"AppStatus"];
            appDelegate.strGender=[dictResponse valueForKey:@"gender"];
            
            [defaults setValue:[dictResponse valueForKey:@"gender"] forKey:@"gender"];
             [defaults setValue:[dictResponse valueForKey:@"id"] forKey:@"id"];
             [defaults setValue:[dictResponse valueForKey:@"token"] forKey:@"token"];
             [defaults setValue:[dictResponse valueForKey:@"username"] forKey:@"name"];
             [defaults setValue:[dictResponse valueForKey:@"email"] forKey:@"email"];
            [defaults setValue:[dictResponse valueForKey:@"gender"] forKey:@"gender"];
            
            [self performSegueWithIdentifier:@"SignUp_EditProfile" sender:self];
            
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Account created successfully." preferredStyle:UIAlertControllerStyleAlert];
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
    if (webservice.tag==2)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            dictTerms=[dictResponse valueForKey:@"page"];
           
            
            
        }

    }
    
}


#pragma mark -
#pragma mark - Keyboard 

-(void)dismissKeyBoard
{
    // [tableTexture removeFromSuperview];
   // [ViewPicker removeFromSuperview];
   
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

#pragma mark - Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    //    if (pickerView.tag==PICKER_EVENT_TYPE)
    //        return [arrEventype count];
    //    else if (pickerView.tag==PICKER_STATE_NAME1)
    //        return [appDelegate.arrStateList count];
    //    else if (pickerView.tag==PICKER_CITY_NAME1)
    //        return [appDelegate.arrCityList count];
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    
    return [NSString stringWithFormat:@"%ld",(long)row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    
    NSString *strTitle = @"";
    
    
    
    label.text=strTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = fontname16;
    
    return label;
}
- (IBAction)onActionDone:(id)sender
{
    //UIDatePicker *datePicker = (UIDatePicker *)[alertController.view viewWithTag:DATEPICKER_DOB];
    NSDate *date = picker.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    
    strDOb=[df stringFromDate:date];
    
    NSString *strTitle=[NSString stringWithFormat:@" %@",strDOb];
    
    UIButton *btn=(UIButton *)[self.view viewWithTag:BTN_DOB];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSLog(@"start Date %@",strTitle);
   // [self alertcontrol:0];
   [ViewPicker removeFromSuperview];}

- (IBAction)onActionCancelled:(id)sender
{
  [ViewPicker removeFromSuperview];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier]isEqualToString:@"SignUp_EditProfile"])
    {
        EditProfile *signupResp=[segue destinationViewController];
        signupResp.signupRes=dictRes;
    }
}


@end
