//
//  Help.m
//  Binder
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Admin. Ltd. All rights reserved.
//

#import "Help.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import "SWRevealViewController.h"

@interface Help ()<MFMailComposeViewControllerDelegate>
{
    AppDelegate *appDelegate;
    
}
@end

@implementation Help

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
     appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIFont *fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblNav.text=@"Help";
    lblNav.textColor=[UIColor blackColor];
    lblNav.backgroundColor=[UIColor clearColor];
    [lblNav setFont:fontname18];
    
    self.navigationItem.titleView=lblNav;
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
    barBtn.tintColor=[UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:barBtn ];

   

    
}

-(void)viewWillAppear:(BOOL)animated
{
   // UIFont *fontname20 = [UIFont fontWithName:@"Roboto" size:20];
    UIFont *fontname15 = [UIFont fontWithName:@"Roboto" size:15];
    
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scrollView];
    
//    UIImageView *imgAbouts=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 190)];
//    [imgAbouts setImage:[UIImage imageNamed:@"AboutUs.png"]];
    //    NSURL * imageURL = [NSURL URLWithString:@"http://wepopar.com/wepopusers/beat/parlour1.png"];
    //    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    //    UIImage * image = [UIImage imageWithData:imageData];
    //    imgAbouts.image=image;
   // [scrollView addSubview:imgAbouts];
    
    
//    UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, self.view.frame.size.width-70, 35)];
//    lblHead.text=@"About Us";
//    [lblHead setFont:fontname];
//    lblHead.textColor=[UIColor whiteColor];
//    lblHead.textAlignment=NSTextAlignmentLeft;
//    [scrollView addSubview:lblHead];
    
//    Roboto
//    Roboto-Thin
//    Roboto-Light
//    Roboto-Black
//    Roboto-Bold
//    Roboto-Regular
//    Roboto-Medium
    
    
    UITextView *textView1=[[UITextView alloc]initWithFrame:CGRectMake(10, 10,self.view.frame.size.width-20, 10)];
    [textView1 setFont:fontname15];
    textView1.backgroundColor=[UIColor clearColor];
    textView1.editable=false;
    textView1.userInteractionEnabled=NO;
    textView1.textColor=[UIColor blackColor];
    textView1.text=@"We'd like to thank you for deciding to use the Binder script. We enjoyed creating it and hope you enjoy using it to achieve your goals :)";
    textView1.textAlignment=NSTextAlignmentJustified;
    [textView1 sizeToFit]; //added
    [textView1 layoutIfNeeded]; //added
    
    [scrollView addSubview:textView1];
    
    
    int n=10+textView1.frame.size.height;
    
    
    UITextView *textView2=[[UITextView alloc]initWithFrame:CGRectMake(10, n,self.view.frame.size.width-20, 10)];
    [textView2 setFont:fontname15];
    textView2.backgroundColor=[UIColor clearColor];
    textView2.textColor=[UIColor blackColor];
    textView2.editable=false;
    textView2.userInteractionEnabled=NO;
    textView2.text=@"If you want something changed to suit your venture's needs better, drop us a line:";
    textView2.textAlignment=NSTextAlignmentJustified;
    [textView2 sizeToFit]; //added
    [textView2 layoutIfNeeded]; //added
    
    [scrollView addSubview:textView2];
    
    int n1=n+textView2.frame.size.height;
    
    
    UIButton *btnFB=[UIButton buttonWithType:UIButtonTypeCustom];
    btnFB.frame=CGRectMake((self.view.frame.size.width/2)-135, n1+10, 60, 60);
    UIImage *imgFB=[UIImage imageNamed:@"Facebook.png"];
    [btnFB setBackgroundImage:imgFB forState:UIControlStateNormal];
    [btnFB addTarget:self action:@selector(onFacebook:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnFB];
    
    UIButton *btnTwitter=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTwitter.frame=CGRectMake((self.view.frame.size.width/2)-65, n1+10, 60, 60);
    UIImage *imgTwitter=[UIImage imageNamed:@"Twitter.png"];
    [btnTwitter setBackgroundImage:imgTwitter forState:UIControlStateNormal];
    [btnTwitter addTarget:self action:@selector(onTwitter:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:btnTwitter];
    
    
    UIButton *btnSkype=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSkype.frame=CGRectMake((self.view.frame.size.width/2)+5, n1+10, 60, 60);
    UIImage *imgSkype=[UIImage imageNamed:@"skype.png"];
    [btnSkype setBackgroundImage:imgSkype forState:UIControlStateNormal];
    [btnSkype addTarget:self action:@selector(onSkype:) forControlEvents:UIControlEventTouchDown];
    //        [[btnLove layer]setBorderWidth:1.5];
    //        [[btnLove layer]setBorderColor:[UIColor grayColor].CGColor];
    btnSkype.layer.cornerRadius=27.5;
    btnSkype.clipsToBounds=YES;
    btnSkype.tag=6002;
    [scrollView addSubview:btnSkype];
    
    
    UIButton *btnMail=[UIButton buttonWithType:UIButtonTypeCustom];
    btnMail.frame=CGRectMake((self.view.frame.size.width/2)+75, n1+10, 60, 60);
    UIImage *imgMail=[UIImage imageNamed:@"mail.png"];
    [btnMail setBackgroundImage:imgMail forState:UIControlStateNormal];
    [btnMail addTarget:self action:@selector(onMail:) forControlEvents:UIControlEventTouchDown];
    //        [[btnStar layer]setBorderWidth:1.5];
    //        [[btnStar layer]setBorderColor:[UIColor grayColor].CGColor];
    btnMail.layer.cornerRadius=25;
    btnMail.clipsToBounds=YES;
    btnMail.tag=6003;
    [scrollView addSubview:btnMail];

    n1=n1+75;
    
    UITextView *textView3=[[UITextView alloc]initWithFrame:CGRectMake(10, n1,self.view.frame.size.width-20, 10)];
    [textView3 setFont:fontname15];
    textView3.backgroundColor=[UIColor clearColor];
    textView3.textColor=[UIColor blackColor];
    textView3.editable=false;
    textView3.userInteractionEnabled=NO;
    textView3.text=@"As you know, we at APPOETS believe in the honorware system. We share our products with anyone who asks for it without any commitments what-so-ever. But, if you think our product has added value to your venture, please consider paying us the price of the product. It will help us buy more Redbulls, create more features and launch the next version of Binder for you to upgrade :)";
    textView3.textAlignment=NSTextAlignmentJustified;
    [textView3 sizeToFit]; //added
    [textView3 layoutIfNeeded]; //added
    
    [scrollView addSubview:textView3];
    
    int n2=n1+textView3.frame.size.height;
    
   
    
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width,n2+30);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Actions

-(IBAction)onTwitter:(id)sender
{
   appDelegate.StrSocialType =@"Twitter";
    [self performSegueWithIdentifier:@"Social" sender:self];
}
-(IBAction)onSkype:(id)sender
{
//    appDelegate.StrSocialType=@"Skype";
//    [self performSegueWithIdentifier:@"Social" sender:self];
    
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
    
    if(installed){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"skype:appoets?add"]];
    }
    else
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/skype/id304878510?mt=8"]];
    }

    
}
-(IBAction)onFacebook:(id)sender
{
    appDelegate.StrSocialType=@"Facebook";
    [self performSegueWithIdentifier:@"Social" sender:self];
}
-(IBAction)onMail:(id)sender
{
//    appDelegate.StrSocialType=@"Mail";
//    [self performSegueWithIdentifier:@"Social" sender:self];
    
    self.navigationItem.title=@"Mail";
    
    MFMailComposeViewController* composeVC = [[MFMailComposeViewController alloc] init];
    composeVC.mailComposeDelegate = self;
    
    // Configure the fields of the interface.
    [composeVC setToRecipients:@[@"info@appoets.com"]];
    [composeVC setSubject:@"Hello!"];
    [composeVC setMessageBody:@"Hello from California!" isHTML:NO];
    
    // Present the view controller modally.
    [self presentViewController:composeVC animated:YES completion:nil];
    
}
-(IBAction)onBack:(id)sender
{
    [self performSegueWithIdentifier:@"Help_Home" sender:self];
    
}



#pragma mark -
#pragma mark - Mail Composer

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Check the result or perform other tasks.
    
    // Dismiss the mail compose view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
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
