//
//  EditProfile.m
//  Binder
//
//  Created by Admin on 26/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "EditProfile.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ZCImagePickerController.h"
#import "DiscoveryQuestionaries.h"
#import "AsyncImageView.h"
#import "LogIn.h"
#import "SWRevealViewController.h"

@interface EditProfile ()<ZCImagePickerControllerDelegate>
{
    UIScrollView *scrollView;
    UITextField *currentTextView;
    UITextView *currentTextView1;
    NSString *strGender;
    bool keyboardIsShown;
     UITapGestureRecognizer *tapGesture;
    AppDelegate *appDelegate;
    NSMutableArray *arrImagesList;
    UIPopoverController *popoverController;
    NSString *strDirPath;
    int btnTag;
    UIImage *chosenImage;
    NSDictionary *dictRes;



}
@end

@implementation EditProfile
@synthesize  signupRes;
@synthesize dictUser;

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIFont *fontname15 = [UIFont fontWithName:@"Roboto-Regular" size:15];
    UIFont *fontname16 = [UIFont fontWithName:@"Roboto" size:16];
    UIFont *fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    
    
   // [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    UIImage *imgUser1, *imgUser2, *imgUser3, *imgUser4, *imgUser5;
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@",dictUser);
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        
        // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
        // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
        
        UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        lblNav.text=@"Edit Profile";
        lblNav.textColor=[UIColor blackColor];
        lblNav.backgroundColor=[UIColor clearColor];
        [lblNav setFont:fontname18];
        
        self.navigationItem.titleView=lblNav;
        self.navigationController.navigationBar.translucent = NO;
        
        
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
        barBtn.tintColor=[UIColor blackColor];
        [self.navigationItem setLeftBarButtonItem:barBtn ];
        
        //appDelegate.strEidtBtnClicked=@"no";
        strGender=[dictUser valueForKey:@"gender"];
        
        
        
    }
    else
    {
        
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        strGender=[defaults valueForKey:@"gender"];
        
         imgUser1=[UIImage imageNamed:@"user.png"];
         imgUser2=[UIImage imageNamed:@"user.png"];
         imgUser3=[UIImage imageNamed:@"user.png"];
         imgUser4=[UIImage imageNamed:@"user.png"];
         imgUser5=[UIImage imageNamed:@"user.png"];

    }
    
    
     UIView *viewLeft;
   
    int y=0;
    if (![appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
    UITextField *txtEP=[[UITextField alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 45)];
    txtEP.text=@"Create Profile";
    [[txtEP layer]setBorderWidth:1.0];
    txtEP.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    txtEP.textAlignment=NSTextAlignmentCenter;
    txtEP.userInteractionEnabled=NO;
    [txtEP setFont:fontname18];
    [[txtEP layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [self.view addSubview:txtEP];
        y+=45;
    }
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height)];
    // scrollView.backgroundColor=[UIColor colorWithRed:45/255.0 green:46/255.0 blue:46/255.0 alpha:1.0];
    [self.view addSubview:scrollView];
    
    int yPos=10;

    NSArray *arrImage=[dictUser valueForKey:@"images"];
    
    {
    NSString *strImageURL0=[arrImage objectAtIndex:0];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, yPos, 200, 200)];
    
        imgView.image=[UIImage imageNamed:@"user.png"];
      
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
    if ([strImageURL0 isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
    {
        imgView.image=[UIImage imageNamed:@"user.png"];
    }
    else
    {
    AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
    [async loadImageFromURL:[NSURL URLWithString:strImageURL0]];
        async.backgroundColor=[UIColor clearColor];
    [imgView addSubview:async];
    }
        }
    imgView.tag=IMG_PHOTO1;
    [scrollView addSubview:imgView];
    
    
    UIButton *btnPhoto1=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPhoto1.frame=CGRectMake((self.view.frame.size.width/2)-100, yPos, 200, 200);
    //[btnPhoto1 setImage:imgUser1 forState:UIControlStateNormal];
    btnPhoto1.tag=BTN_PHOTO1;
    [btnPhoto1 setBackgroundColor:[UIColor clearColor]];
    [btnPhoto1 addTarget:self action:@selector(onPhoto:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnPhoto1];
    
    yPos+=215;
    }
    {
    
    NSString *strImageURL1=[arrImage objectAtIndex:1];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-120, yPos, 50, 50)];
    
        imgView.image=[UIImage imageNamed:@"user.png"];
       
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
    if ([strImageURL1 isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
    {
        imgView.image=[UIImage imageNamed:@"user.png"];
    }
    else
    {
        AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
        [async loadImageFromURL:[NSURL URLWithString:strImageURL1]];
        async.backgroundColor=[UIColor clearColor];
        [imgView addSubview:async];
    }
        }
    imgView.tag=IMG_PHOTO2;
    [scrollView addSubview:imgView];

    
    UIButton *btnPhoto2=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPhoto2.frame=CGRectMake((self.view.frame.size.width/2)-120, yPos, 50, 50);
    //[btnPhoto2 setImage:imgUser2 forState:UIControlStateNormal];
    btnPhoto2.tag=BTN_PHOTO2;
    [btnPhoto2 setBackgroundColor:[UIColor clearColor]];
    [btnPhoto2 addTarget:self action:@selector(onPhoto:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnPhoto2];
    }
    
    {
        
        NSString *strImageURL2=[arrImage objectAtIndex:2];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-60, yPos, 50, 50)];
        
        imgView.image=[UIImage imageNamed:@"user.png"];
        
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
            
        if ([strImageURL2 isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
        {
            imgView.image=[UIImage imageNamed:@"user.png"];
        }
        else
        {
            AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
            [async loadImageFromURL:[NSURL URLWithString:strImageURL2]];
            async.backgroundColor=[UIColor clearColor];
            [imgView addSubview:async];
        }
        }
        imgView.tag=IMG_PHOTO3;
        [scrollView addSubview:imgView];

        
    UIButton *btnPhoto3=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPhoto3.frame=CGRectMake((self.view.frame.size.width/2)-60, yPos, 50, 50);
   // [btnPhoto3 setImage:imgUser3 forState:UIControlStateNormal];
    btnPhoto3.tag=BTN_PHOTO3;
    [btnPhoto3 setBackgroundColor:[UIColor clearColor]];
    [btnPhoto3 addTarget:self action:@selector(onPhoto:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnPhoto3];
    }
    
    {
        
        NSString *strImageURL3=[arrImage objectAtIndex:3];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)+10, yPos, 50, 50)];
        
        imgView.image=[UIImage imageNamed:@"user.png"];
        
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
        if ([strImageURL3 isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
        {
            imgView.image=[UIImage imageNamed:@"user.png"];
        }
        else
        {
            AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
            [async loadImageFromURL:[NSURL URLWithString:strImageURL3]];
            async.backgroundColor=[UIColor clearColor];
            [imgView addSubview:async];
        }
        }
        imgView.tag=IMG_PHOTO4;
        [scrollView addSubview:imgView];

        
    UIButton *btnPhoto4=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPhoto4.frame=CGRectMake((self.view.frame.size.width/2)+10, yPos, 50, 50);
   // [btnPhoto4 setImage:imgUser4 forState:UIControlStateNormal];
    btnPhoto4.tag=BTN_PHOTO4;
    [btnPhoto4 setBackgroundColor:[UIColor clearColor]];
    [btnPhoto4 addTarget:self action:@selector(onPhoto:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnPhoto4];
    }
    
    {
        
        NSString *strImageURL4=[arrImage objectAtIndex:4];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)+70, yPos, 50, 50)];
        
        imgView.image=[UIImage imageNamed:@"user.png"];
        
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
        if ([strImageURL4 isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
        {
            imgView.image=[UIImage imageNamed:@"user.png"];
        }
        else
        {
            AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
            [async loadImageFromURL:[NSURL URLWithString:strImageURL4]];
            async.backgroundColor=[UIColor clearColor];
            [imgView addSubview:async];
        }
        }
        imgView.tag=IMG_PHOTO5;
        [scrollView addSubview:imgView];

        
    UIButton *btnPhoto5=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPhoto5.frame=CGRectMake((self.view.frame.size.width/2)+70, yPos, 50, 50);
   // [btnPhoto5 setImage:imgUser5 forState:UIControlStateNormal];
    btnPhoto5.tag=BTN_PHOTO5;
    [btnPhoto5 setBackgroundColor:[UIColor clearColor]];
    [btnPhoto5 addTarget:self action:@selector(onPhoto:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnPhoto5];
    }

    yPos+=65;
    
   
    {
        
        UILabel *lbAbout=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lbAbout.text=@"About";
        [lbAbout setFont:fontname15];
        lbAbout.textColor=[UIColor blackColor];
        [scrollView addSubview:lbAbout];
        
        yPos+=30;

        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        {
            viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
            
            UITextField *txtAbt=[[UITextField alloc]initWithFrame:CGRectMake(0,0 , viewContent.frame.size.width, viewContent.frame.size.height)];
            txtAbt.tag=TEXT_ABOUT;
            txtAbt.delegate=self;
            txtAbt.textAlignment=NSTextAlignmentLeft;
            [txtAbt setFont:fontname16];
            txtAbt.textColor=[UIColor blackColor];
            txtAbt.leftView=viewLeft;
            txtAbt.leftViewMode=UITextFieldViewModeAlways;
            [viewContent addSubview:txtAbt];
            
            UIColor *color=[UIColor lightGrayColor];
            txtAbt.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"about yourself..." attributes:@{NSForegroundColorAttributeName:color}];
            
            if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
            {
                txtAbt.text=[dictUser valueForKey:@"description"];
            }

           
        }
        
        
        
        yPos+=60;
    }
    
    {
        
        UILabel *lblWork=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblWork.text=@"Current Work";
        [lblWork setFont:fontname15];
        lblWork.textColor=[UIColor blackColor];
        [scrollView addSubview:lblWork];
        
        yPos+=30;

        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        {
            viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
            
            UITextField *txtWork=[[UITextField alloc]initWithFrame:CGRectMake(0,0 , viewContent.frame.size.width, viewContent.frame.size.height)];
            txtWork.tag=TEXT_WORK;
            txtWork.delegate=self;
            txtWork.textAlignment=NSTextAlignmentLeft;
            [txtWork setFont:fontname16];
            txtWork.textColor=[UIColor blackColor];
            txtWork.leftView=viewLeft;
            txtWork.leftViewMode=UITextFieldViewModeAlways;
            [viewContent addSubview:txtWork];
            
            UIColor *color=[UIColor lightGrayColor];
            txtWork.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"what you do..." attributes:@{NSForegroundColorAttributeName:color}];
            
            if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
            {
                txtWork.text=[dictUser valueForKey:@"work"];
            }
            
        }
        
        
        
        yPos+=60;
    }
    {
        
        UILabel *lblSchool=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblSchool.text=@"School";
        [lblSchool setFont:fontname15];
        lblSchool.textColor=[UIColor blackColor];
        [scrollView addSubview:lblSchool];
        
        yPos+=30;

        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        {
            viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
            
            UITextField *txtSchool=[[UITextField alloc]initWithFrame:CGRectMake(0,0 , viewContent.frame.size.width, viewContent.frame.size.height)];
            txtSchool.tag=TEXT_SCHOOL;
            txtSchool.delegate=self;
            txtSchool.textAlignment=NSTextAlignmentLeft;
            [txtSchool setFont:fontname16];
            txtSchool.textColor=[UIColor blackColor];
            txtSchool.leftView=viewLeft;
            txtSchool.leftViewMode=UITextFieldViewModeAlways;
            [viewContent addSubview:txtSchool];
            
            UIColor *color=[UIColor lightGrayColor];
            txtSchool.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"your school" attributes:@{NSForegroundColorAttributeName:color}];
            
            
            if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
            {
                txtSchool.text=[dictUser valueForKey:@"school"];
            }
            
        }
        
        
        
        yPos+=60;
    }
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    
    {
        UILabel *lblGender=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblGender.text=@"Gender";
        [lblGender setFont:fontname15];
        lblGender.textColor=[UIColor blackColor];
        [scrollView addSubview:lblGender];
        
        yPos+=30;

        
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,60)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        UIButton *btnMale=[UIButton buttonWithType:UIButtonTypeCustom];
        btnMale.frame=CGRectMake(05, 05, 80, 25);
        [btnMale setImage:[UIImage imageNamed:@"radioblackoff.png"] forState:UIControlStateNormal];
        [btnMale setImage:[UIImage imageNamed:@"radioblackon.png"] forState:UIControlStateSelected];
        [btnMale setTitle: @"  Male" forState: UIControlStateNormal];
        [btnMale setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btnMale setTitleColor:[UIColor colorWithRed:208/255.0 green:81/255.0 blue:48/255.0 alpha:1.0] forState:UIControlStateSelected];
        // btnMale.titleLabel.font=fontname1;
        btnMale.titleLabel.font=fontname16;
        btnMale.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnMale addTarget:self action:@selector(onGender:) forControlEvents:UIControlEventTouchUpInside];
        btnMale.tag=BTN_MALE;
        [viewContent addSubview:btnMale];
        
        yPos+=45;
        
        UIButton *btnFeMale=[UIButton buttonWithType:UIButtonTypeCustom];
        btnFeMale.frame=CGRectMake(05, 35, 80, 25);
        [btnFeMale setImage:[UIImage imageNamed:@"radioblackoff.png"] forState:UIControlStateNormal];
        [btnFeMale setImage:[UIImage imageNamed:@"radioblackon.png"] forState:UIControlStateSelected];
        [btnFeMale setTitle: @"  Female" forState: UIControlStateNormal];
        [btnFeMale setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         [btnFeMale setTitleColor:[UIColor colorWithRed:208/255.0 green:81/255.0 blue:48/255.0 alpha:1.0] forState:UIControlStateSelected];
        // btnFeMale.titleLabel.font=fontname1;
        btnFeMale.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnFeMale.titleLabel.font=fontname16;
        [btnFeMale addTarget:self action:@selector(onGender:) forControlEvents:UIControlEventTouchUpInside];
        btnFeMale.tag=BTN_FEMALE;
        [viewContent addSubview:btnFeMale];

        if ([strGender isEqualToString:@"male"])
        {
            btnMale.selected=YES;
            strGender=@"male";
            btnFeMale.selected=NO;
        }
        else
        {
            btnFeMale.selected=YES;
            strGender=@"female";
            btnMale.selected=NO;
        }
        
        
        yPos+=60;
    }
    
    yPos+=60;
    UIButton *btnUpdate=[UIButton buttonWithType:UIButtonTypeCustom];
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        btnUpdate.frame=CGRectMake(0, self.view.frame.size.height-90, self.view.frame.size.width, 45);
    }
    else
    {
       btnUpdate.frame=CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 45);
    }
    
    //btnUpdate.frame=CGRectMake(0, self.view.frame.size.height-35, self.view.frame.size.width, 35);
   // [btnUpdate setTitle:@"Update" forState:UIControlStateNormal];
    [btnUpdate setTitleColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnUpdate.titleLabel.font=fontname18;
    [[btnUpdate layer]setBorderWidth:1.0];
    [[btnUpdate layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [btnUpdate addTarget:self action:@selector(onUpdate:) forControlEvents:UIControlEventTouchDown];
    [btnUpdate setBackgroundColor:[UIColor whiteColor]];
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        [btnUpdate setTitle:@"Save" forState:UIControlStateNormal];
    }
    else
    {
         [btnUpdate setTitle:@"Update" forState:UIControlStateNormal];
    }

    
    [self.view addSubview:btnUpdate];

    
  scrollView.contentSize=CGSizeMake(self.view.frame.size.width, yPos+100);
    
}
-(void)onBack
{
    appDelegate.strEidtBtnClicked=@"no";
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Actions

-(IBAction)onGender:(id)sender
{
    UIButton *btnMale=(UIButton *)[scrollView viewWithTag:BTN_MALE];
    UIButton *btnFemale=(UIButton *)[scrollView viewWithTag:BTN_FEMALE];
    
    UIButton *btn=(UIButton *)sender;
    
    if (btn.tag==06)
    {
        strGender=@"male";
        btnMale.selected=YES;
        btnFemale.selected=NO;
        
    }
    else if (btn.tag==07)
    {
        strGender=@"female";
        btnFemale.selected=YES;
        btnMale.selected=NO;
    }
    NSLog(@"Gender: %@",strGender);
}

-(IBAction)onPhoto:(id)sender
{
    UIButton *btnBinderPhoto=(UIButton * )sender;
    btnTag=btnBinderPhoto.tag;
    
    ZCImagePickerController *imagePickerController = [[ZCImagePickerController alloc] init];
    imagePickerController.imagePickerDelegate = self;
    imagePickerController.maximumAllowsSelectionCount = 1;
    imagePickerController.mediaType = ZCMediaAllAssets;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        //                                  You should present the image picker in a popover on iPad.
        [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:NULL];
        
    }
    else {
        // Full screen on iPhone and iPod Touch.
        
        [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:NULL];
    }
}

//-(IBAction)onPhoto:(id)sender
//{
//
//
//    UIButton *btnBinderPhoto=(UIButton * )sender;
//    btnTag=btnBinderPhoto.tag;
//
//    NSLog(@"%ld",(long)btnBinderPhoto.tag);
//
//    UIAlertController * alert=   [UIAlertController
//                                  alertControllerWithTitle:@"Binder"
//                                  message:@""
//                                  preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction* Camera = [UIAlertAction
//                             actionWithTitle:@"Take Picture"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//
//                                 //Use camera if device has one otherwise use photo library
//                                 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//                                 {
//                                     [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
//                                 }
//                                 else
//                                 {
//                                     [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//                                 }
//
//                                 [imagePicker setDelegate:self];
//
//                                 //Show image picker
//                                 [self presentModalViewController:imagePicker animated:YES];
//                                 // [alert dismissViewControllerAnimated:YES completion:nil];
//
//                             }];
//
//
//    UIAlertAction* ok = [UIAlertAction
//                         actionWithTitle:@"Choose From Camera Roll"
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//
//                             ZCImagePickerController *imagePickerController = [[ZCImagePickerController alloc] init];
//                             imagePickerController.imagePickerDelegate = self;
//                             imagePickerController.maximumAllowsSelectionCount = 1;
//                             imagePickerController.mediaType = ZCMediaAllAssets;
//
//                             if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//
//                                 //                                  You should present the image picker in a popover on iPad.
//                                 [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:NULL];
//
//                             }
//                             else {
//                                 // Full screen on iPhone and iPod Touch.
//
//                                 [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:NULL];
//                             }
//
//
//                         }];
//
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleCancel
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//
//                             }];
//
//    [alert addAction:Camera];
//    [alert addAction:ok];
//    [alert addAction:cancel];
//
//
//    UIPopoverPresentationController *popPresenter1 = [alert
//                                                      popoverPresentationController];
//    popPresenter1.sourceView=btnBinderPhoto;
//    popPresenter1.sourceRect=btnBinderPhoto.bounds;
//    [alert setModalPresentationStyle:UIModalPresentationPopover];
//
//    [self presentViewController:alert animated:YES completion:nil];
//
//}


-(void)PhotoUpdate
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strid=[defaults valueForKey:@"id"];
    NSString *strToken=[defaults valueForKey:@"token"];
    NSString *strBtnTag=[NSString stringWithFormat:@"%d",btnTag];
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=2;
    service.delegate=self;
    
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:strid forKey:@"id"];
    [_params setObject:strToken forKey:@"token"];
    [_params setObject:strBtnTag forKey:@"position"];
    
    
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"picture";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    
    
    // create request
    NSString *strURL = [SERVICE_URL stringByAppendingString:METHOD_UPDATE_PROFILE_IMAGE];
    NSURL *requestURL = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    
    //  UIImage *image1 = chosenImage;
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    df.dateFormat=@"MMddHHmmss";
    NSString *strImageName1=[NSString stringWithFormat:@"IMG_%@",[df stringFromDate:[NSDate date]]];
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n", FileParamConstant,strImageName1] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    
    [service executeWebserviceWithMethodinImage:METHOD_UPDATE_PROFILE_IMAGE withValues:request];
    
    
}


- (IBAction)onActionDone:(id)sender
{
    // [self alertcontrol:0];
    [alertController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onActionCancelled:(id)sender
{
    [alertController dismissViewControllerAnimated:YES completion:nil];
}



-(IBAction)onUpdate:(id)sender
{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strid=[defaults valueForKey:@"id"];
    NSString *strToken=[defaults valueForKey:@"token"];
    NSString *strUserName=[defaults valueForKey:@"name"];
    NSString *strEmail=[defaults valueForKey:@"email"];
   
    
   

    UITextField *txtAbout=(UITextField *)[scrollView viewWithTag:TEXT_ABOUT];
   
    if ([txtAbout.text isEqualToString:@""])
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please say about yourself." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [txtAbout becomeFirstResponder];
        txtAbout.text=@"";
        return;
}


    

    UITextField *txtWork=(UITextField *)[scrollView viewWithTag:TEXT_WORK];
  

    if ([txtWork.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please say about your work." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [txtWork becomeFirstResponder];
        txtWork.text=@"";
        return;

    }

    UITextField *txtSchool=(UITextField *)[scrollView viewWithTag:TEXT_SCHOOL];
   
    if ([txtSchool.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Please say about your school." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [txtSchool becomeFirstResponder];
        txtSchool.text=@"";
        return;
    }
    NSString *strGen1;
    
    if ([appDelegate.strAppState isEqualToString:@"SignUpDone"])
    {
        strGen1=@"";
    }
    else
    {
        strGen1=strGender;
    }
    
    

    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    webservice *service=[[webservice alloc]init];
    service.tag=1;
    service.delegate=self;

   // appDelegate.strDeviceToken=@"b945758c487a26ade4069d74a8eda42eb5c3cc7fe26dcfa3f05cf3c7d6ebcec3";
   
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"username\":\"%@\",\"email\":\"%@\",\"gender\":\"%@\",\"description\":\"%@\",\"work\":\"%@\",\"school\":\"%@\",\"device_token\":\"%@\"}",strid, strToken, strUserName,strEmail,strGen1, txtAbout.text,txtWork.text,txtSchool.text,appDelegate.strDeviceToken];

    [service executeWebserviceWithMethod:METHOD_UPDATE_PROFILE withValues:strValues];

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
    
    http://api.datesauce.com/flamerui/img/user.png
    if (webservice.tag==1)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
           
            
           //  NSLog(@"%@",appDelegate.strAppState);
            
            dictRes=dictResponse;
            strGender=[dictResponse valueForKey:@"gender"];
            
            if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
            {
                appDelegate.strEidtBtnClicked=@"no";
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                appDelegate.strAppState=@"EditProfileDone";
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:appDelegate.strAppState forKey:@"AppStatus"];
                
            [self performSegueWithIdentifier:@"EditProfile_Discovery" sender:self];
            }
            
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Profile successfully Updated." preferredStyle:UIAlertControllerStyleAlert];
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
    
    if (webservice.tag==2)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            UIButton *btnPhoto1=(UIButton *)[scrollView viewWithTag:BTN_PHOTO1];
            
            UIButton *btnPhoto2=(UIButton *)[scrollView viewWithTag:BTN_PHOTO2];
            
            UIButton *btnPhoto3=(UIButton *)[scrollView viewWithTag:BTN_PHOTO3];
            
            UIButton *btnPhoto4=(UIButton *)[scrollView viewWithTag:BTN_PHOTO4];
            
            UIButton *btnPhoto5=(UIButton *)[scrollView viewWithTag:BTN_PHOTO5];
            
           // UIImage *imgView=(UIImage )
            
            if (btnTag==01)
            {
                [btnPhoto1 setImage:chosenImage forState:UIControlStateNormal];
                
                NSDictionary *dictImage=[dictResponse valueForKey:@"image"];
                appDelegate.strPicture=[dictImage valueForKey:@"image"];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:[dictImage valueForKey:@"image"] forKey:@"picture"];
                
            }
            else if (btnTag==02)
            {
                [btnPhoto2 setImage:chosenImage forState:UIControlStateNormal];
            }
            else if (btnTag==03)
            {
                [btnPhoto3 setImage:chosenImage forState:UIControlStateNormal];
            }
            else if (btnTag==04)
            {
                [btnPhoto4 setImage:chosenImage forState:UIControlStateNormal];
            }
            else if (btnTag==05)
            {
                [btnPhoto5 setImage:chosenImage forState:UIControlStateNormal];
            }

            
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

#pragma mark - ZCImagePickerControllerDelegate

- (void)zcImagePickerController:(ZCImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(NSArray *)info
{
    arrImagesList=[NSMutableArray arrayWithArray:info];
    
    NSDictionary *dictLocal=[arrImagesList lastObject];
   chosenImage = [dictLocal objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self PhotoUpdate];
    
    
    [self dismissPickerView];
    
}
- (void)dismissPickerView {
    if (popoverController) {
        [popoverController dismissPopoverAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [arrImagesList addObject:info];
    
     chosenImage = info[UIImagePickerControllerOriginalImage];
    
    [self PhotoUpdate];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier]isEqualToString:@"EditProfile_Discovery"])
    {
        DiscoveryQuestionaries *UpProResp=[segue destinationViewController];
        UpProResp.updProfResp=dictRes;
    }
}


@end
