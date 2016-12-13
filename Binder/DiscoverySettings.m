//
//  DiscoverySettings.m
//  Binder
//
//  Created by Admin on 03/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DiscoverySettings.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PayPalMobile.h"
#import "CardIO.h"
#import "LogIn.h"
#import "SWRevealViewController.h"


@interface DiscoverySettings ()< GMSAutocompleteViewControllerDelegate, PayPalPaymentDelegate>
{
    AppDelegate *appDelegate;
    UIScrollView *scrollView;
        NSString *strid, *strToken, *strAddress, *strPlace, *strSelectedLat, *strSelectedLong;
    NSDictionary *dictGetPre;
    NSArray *arrLocs;
    UIFont *fontname10, *fontname13,*fontname15,*fontname16, *fontname18, *fontname15_16;
    int pageCount;
    int nCount;
    UIPageControl *pageControl;
    UIScrollView *imgScrlView;
    NSString *strProAmount;
    UIView *vwGetBinderPlus;
}
-(void)payWithPayPal;
@property (nonatomic, strong, readwrite) PayPalConfiguration *payPalConfiguration;


- (CustomizationState)nextCustomizationState:(CustomizationState)state;
- (NSString*)buttonTextForState:(CustomizationState)state;
- (void)customizeAccordingToState:(CustomizationState)state;



@end

@implementation DiscoverySettings
{
    CustomizationState _state;
}

#pragma mark -
#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _payPalConfiguration = [[PayPalConfiguration alloc] init];
        
        // See PayPalConfiguration.h for details and default values.
        // Should you wish to change any of the values, you can do so here.
        // For example, if you wish to accept PayPal but not payment card payments, then add:
        _payPalConfiguration.acceptCreditCards = YES;
        // Or if you wish to have the user choose a Shipping Address from those already
        // associated with the user's PayPal account, then add:
        _payPalConfiguration.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    }
    return self;
}

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
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblNav.text=@"Discovery Settings";
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
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
   
   }

-(void)viewWillAppear:(BOOL)animated
{

    
    if (![appDelegate.strAddNewLocClicked isEqualToString:@"yes"])
    {
         [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        webservice *service=[[webservice alloc]init];
        service.delegate=self;
        service.tag=1;
        NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
        
       [service executeWebserviceWithMethod1:METHOD_GET_PREFERENCE withValues:strSend];
        
       // [service executeWebserviceWithMethod1:METHOD_GET_ALL_LOCATIONS withValues:strSend];

   }
    appDelegate.strAddNewLocClicked=@"no";

}
-(void)onPageLoad
{
     [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // scrollView.backgroundColor=[UIColor colorWithRed:45/255.0 green:46/255.0 blue:46/255.0 alpha:1.0];
    [self.view addSubview:scrollView];
    
    int yPos=10;
    
    {
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        UILabel *lblDisCov=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 25)];
        lblDisCov.text=@"Discovery";
        [lblDisCov setFont:fontname15];
        lblDisCov.textColor=[UIColor blackColor];
        [viewContent addSubview:lblDisCov];
        
        UISwitch *swtDiscovery=[[UISwitch alloc]initWithFrame:CGRectMake(viewContent.frame.size.width-61, 7.5, 0, 0)];
        //swtDiscovery.transform = CGAffineTransformMakeScale(0.90, 1.00);
        [swtDiscovery addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged];
        [swtDiscovery setOnTintColor:[UIColor colorWithRed:253/255.0 green:187/255.0 blue:181/255.0 alpha:1.0]];
        [swtDiscovery setThumbTintColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
        //swtDiscovery.tintColor=[UIColor grayColor];
       //        [swtDiscovery setOnTintColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
//        [swtDiscovery setThumbTintColor:[UIColor whiteColor]];
       
        
        if ([[dictGetPre valueForKey:@"discovery"]isEqualToString:@"1"])
        {
            [swtDiscovery setOn:YES animated:YES];
        }
        else
        {
           [swtDiscovery setOn:NO animated:YES];
        }
        swtDiscovery.tag=SWT_DISCOV;
        [viewContent addSubview:swtDiscovery];
        
        yPos+=47;
        
        UILabel *lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,30)];
        lblInfo.text=@"Disabling discovery prevents opthers from seeing your card. this has no effects on your existing matches.";
        [lblInfo setFont:fontname10];
        lblInfo.textColor=[UIColor blackColor];
        lblInfo.lineBreakMode = NSLineBreakByWordWrapping;
        lblInfo.numberOfLines = 2;
        [scrollView addSubview:lblInfo];
        
    }
    yPos+=50;
    
    
    {
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=1234;
        [scrollView addSubview:viewContent];
        
        UILabel *lblDisCov=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 25)];
        lblDisCov.text=@"Swiping in";
        [lblDisCov setFont:fontname15];
        lblDisCov.textColor=[UIColor blackColor];
        [viewContent addSubview:lblDisCov];
        
        UIButton *btnMyLoc=[UIButton buttonWithType:UIButtonTypeCustom];
        btnMyLoc.frame=CGRectMake(viewContent.frame.size.width-155, 5, 145, 35);
        [btnMyLoc setTitle:appDelegate.strCityName forState:UIControlStateNormal];
        [btnMyLoc setTitleColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnMyLoc addTarget:self action:@selector(onMyCurLoc:) forControlEvents:UIControlEventTouchUpInside];
        [btnMyLoc setBackgroundColor:[UIColor clearColor]];
         btnMyLoc.titleLabel.font=fontname13;
        btnMyLoc.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        btnMyLoc.tag=8004;
//        [[btnMyLoc layer]setBorderWidth:1.0];
//        [[btnMyLoc layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
        [viewContent addSubview:btnMyLoc];

        
               
        yPos+=viewContent.frame.size.height+2;
        
        UILabel *lblInfoSwp=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,20)];
        lblInfoSwp.text=@"Change your swipe location to see Binder members in other cities.";
        [lblInfoSwp setFont:fontname10];
        lblInfoSwp.textColor=[UIColor blackColor];
        lblInfoSwp.lineBreakMode = NSLineBreakByWordWrapping;
        lblInfoSwp.numberOfLines = 2;
        lblInfoSwp.tag=7895;
        [scrollView addSubview:lblInfoSwp];
        
    }
    yPos+=30;
    
    
    {
        UILabel *lblShowMe=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblShowMe.text=@"Show Me";
        [lblShowMe setFont:fontname15_16];
        lblShowMe.textColor=[UIColor blackColor];
        lblShowMe.tag=7896;
        [scrollView addSubview:lblShowMe];
        
        yPos+=27;
        
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,90)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=7897;
        [scrollView addSubview:viewContent];
        
        UILabel *lblMen=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 25)];
        lblMen.text=@"Men";
        [lblMen setFont:fontname15];
        lblMen.textColor=[UIColor blackColor];
        [viewContent addSubview:lblMen];
        
        UISwitch *swtMen=[[UISwitch alloc]initWithFrame:CGRectMake(viewContent.frame.size.width-61, 7.5, 0, 0)];
        [swtMen addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged];
        [swtMen setOnTintColor:[UIColor colorWithRed:253/255.0 green:187/255.0 blue:181/255.0 alpha:1.0]];
        [swtMen setThumbTintColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
         //swtMen.transform = CGAffineTransformMakeScale(0.90, 0.75);
        if ([[dictGetPre valueForKey:@"gender"]isEqualToString:@"male"]||[[dictGetPre valueForKey:@"gender"]isEqualToString:@"others"])
        {
            [swtMen setOn:YES animated:YES];
        }
        else
        {
            [swtMen setOn:NO animated:YES];
        }
        swtMen.tag=SWT_MEN;
        [viewContent addSubview:swtMen];
        
        
        UILabel *lblWomen=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 25)];
        lblWomen.text=@"Women";
        [lblWomen setFont:fontname15];
        lblWomen.textColor=[UIColor blackColor];
        [viewContent addSubview:lblWomen];
        
        UISwitch *swtWomen=[[UISwitch alloc]initWithFrame:CGRectMake(viewContent.frame.size.width-61, 50, 0, 0)];
        [swtWomen addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged];
        [swtWomen setOnTintColor:[UIColor colorWithRed:253/255.0 green:187/255.0 blue:181/255.0 alpha:1.0]];
        [swtWomen setThumbTintColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
        // swtWomen.transform = CGAffineTransformMakeScale(0.90, 0.75);
        if ([[dictGetPre valueForKey:@"gender"]isEqualToString:@"female"]||[[dictGetPre valueForKey:@"gender"]isEqualToString:@"others"])
        {
            [swtWomen setOn:YES animated:YES];
        }
        else
        {
            [swtWomen setOn:NO animated:YES];
        }
        swtWomen.tag=SWT_WOMEN;
        [viewContent addSubview:swtWomen];
        
        yPos+=92;
        
        UILabel *lblInfo1=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,20)];
        lblInfo1.text=@"Please specify your sexual orientation";
        [lblInfo1 setFont:fontname10];
        lblInfo1.textColor=[UIColor blackColor];
        lblInfo1.lineBreakMode = NSLineBreakByWordWrapping;
        lblInfo1.numberOfLines = 1;
        lblInfo1.tag=7898;
        [scrollView addSubview:lblInfo1];
        
        
    }
    
    
    yPos+=30;
    
    {
        
        UILabel *lblShrchDist=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblShrchDist.text=@"Search Distance";
        [lblShrchDist setFont:fontname15_16];
        lblShrchDist.textColor=[UIColor blackColor];
        lblShrchDist.tag=7899;
        [scrollView addSubview:lblShrchDist];
        
        NSString *strDistance=[dictGetPre valueForKey:@"distance"];
        
        //NSInteger strValue=[[dictSlider valueForKey:@"question_id"]integerValue];
        
        UILabel *lblValue1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, yPos, 50, 25)];
        [lblValue1 setFont:fontname15];
        lblValue1.textAlignment=NSTextAlignmentRight;
        lblValue1.textColor=[UIColor blackColor];
        lblValue1.tag=564;
        lblValue1.text=[NSString stringWithFormat:@"%@km",[dictGetPre valueForKey:@"distance"]];
        //        [[lblValue layer]setBorderWidth:1.0];
        //        [[lblValue layer]setBorderColor:[UIColor grayColor].CGColor];
        
        [scrollView addSubview:lblValue1];
        
        yPos+=27;
        
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=8000;
        [scrollView addSubview:viewContent];
        
        
        
        CGRect frame = CGRectMake(5, 7.5, viewContent.frame.size.width-10, 30);
        UISlider *sliderDistance = [[UISlider alloc] initWithFrame:frame];
        [sliderDistance addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [sliderDistance setBackgroundColor:[UIColor clearColor]];
        sliderDistance.minimumValue = 0;
        sliderDistance.maximumValue = 161;
        sliderDistance.continuous = YES;
        sliderDistance.value = [strDistance integerValue];
        sliderDistance.tag=565;
        sliderDistance.minimumTrackTintColor = [UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
        //  slider.maximumTrackTintColor = [UIColor colorWithRed:193/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
        sliderDistance.thumbTintColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
        
        UIImage* sliderBarImage = [UIImage imageNamed:@"25 x 5.png"];
        sliderBarImage=[sliderBarImage stretchableImageWithLeftCapWidth:8.0 topCapHeight:10.0];
        [sliderDistance setMaximumTrackImage:sliderBarImage forState:UIControlStateNormal];
        
        UIImage *sliderThumb=[UIImage imageNamed:@"round24px.png"];
        // sliderThumb=[sliderThumb stretchableImageWithLeftCapWidth:8.0 topCapHeight:10.0];
        [sliderDistance setThumbImage:sliderThumb forState:UIControlStateNormal];

        
        [viewContent addSubview:sliderDistance];
        
//        yPos+=47;
//        
//        
//        UILabel *lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,26)];
//        lblInfo.text=@"Binder uses these preferences to suggest potential matches. some match suggetions may not fall within your desired parameters.";
//        [lblInfo setFont:fontname15];
//        lblInfo.textColor=[UIColor blackColor];
//        lblInfo.lineBreakMode = NSLineBreakByWordWrapping;
//        lblInfo.numberOfLines = 2;
//        [self.view addSubview:lblInfo];
        
    }

    
    yPos+=60;
    
    {
        
        UILabel *lblShowAge=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblShowAge.text=@"Show Age";
        [lblShowAge setFont:fontname15_16];
        lblShowAge.textColor=[UIColor blackColor];
        lblShowAge.tag=8001;
        [scrollView addSubview:lblShowAge];
        
         NSString *strAge=[dictGetPre valueForKey:@"age_limit"];
        
        //NSInteger strValue=[[dictSlider valueForKey:@"question_id"]integerValue];
        
        UILabel *lblValue=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, yPos, 50, 25)];
        [lblValue setFont:fontname15];
        lblValue.textAlignment=NSTextAlignmentRight;
        lblValue.textColor=[UIColor blackColor];
        lblValue.tag=566;
        lblValue.text=strAge;
//        [[lblValue layer]setBorderWidth:1.0];
//        [[lblValue layer]setBorderColor:[UIColor grayColor].CGColor];

        [scrollView addSubview:lblValue];
        
        yPos+=27;
        
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=8002;
        [scrollView addSubview:viewContent];
        
       
        
        CGRect frame = CGRectMake(5, 7.5, viewContent.frame.size.width-10, 30);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 18;
        slider.maximumValue = 65;
        slider.continuous = YES;
        slider.value = [strAge integerValue];
         slider.tag=567;
        slider.minimumTrackTintColor = [UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
        //  slider.maximumTrackTintColor = [UIColor colorWithRed:193/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
        slider.thumbTintColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
        
        UIImage* sliderBarImage = [UIImage imageNamed:@"25 x 5.png"];
        sliderBarImage=[sliderBarImage stretchableImageWithLeftCapWidth:8.0 topCapHeight:10.0];
        [slider setMaximumTrackImage:sliderBarImage forState:UIControlStateNormal];
        
         UIImage *sliderThumb=[UIImage imageNamed:@"round24px.png"];
       // sliderThumb=[sliderThumb stretchableImageWithLeftCapWidth:8.0 topCapHeight:10.0];
        [slider setThumbImage:sliderThumb forState:UIControlStateNormal];
        
        
        [viewContent addSubview:slider];
        
        yPos+=47;
        
        
        UILabel *lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,30)];
        lblInfo.text=@"Binder uses these preferences to suggest potential matches. some match suggetions may not fall within your desired parameters.";
        [lblInfo setFont:fontname10];
        lblInfo.textColor=[UIColor blackColor];
        lblInfo.lineBreakMode = NSLineBreakByWordWrapping;
        lblInfo.numberOfLines = 2;
        lblInfo.tag=8003;
        [scrollView addSubview:lblInfo];
        
    }
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, yPos+100);
    if ([appDelegate.strCityDeleted isEqualToString:@"yes"])
    {
        appDelegate.strCityDeleted=@"no";
        [self onMyCurLoc:nil];
    }

}


-(void)onMyCurLoc:(id)sender
{
    UIButton *btnAddLoc1=(UIButton *)[self.view viewWithTag:8006];
    [btnAddLoc1 removeFromSuperview];
    
    UIButton *btnMyLoc=(UIButton *)[self.view viewWithTag:8004];
    [btnMyLoc setHidden:YES];
    
    
     UIView *viewSwiping=(UIView *)[self.view viewWithTag:1234];
    UIView *viewShowMe=(UIView *)[self.view viewWithTag:7897];
    UIView *viewDist=(UIView *)[self.view viewWithTag:8000];
    UIView *viewAge=(UIView *)[self.view viewWithTag:8002];
    
    
    UILabel *lblSwp=(UILabel *)[self.view viewWithTag:7895];
    UILabel *lblShowMe=(UILabel *)[self.view viewWithTag:7896];
    UILabel *lblinfo1=(UILabel *)[self.view viewWithTag:7898];
    UILabel *lblSearch=(UILabel *)[self.view viewWithTag:7899];
    UILabel *lblVal1=(UILabel *)[self.view viewWithTag:564];
    UILabel *lblAge=(UILabel *)[self.view viewWithTag:8001];
    UILabel *lblVal=(UILabel *)[self.view viewWithTag:566];
    UILabel *lblInfo=(UILabel *)[self.view viewWithTag:8003];
    
    
    CGRect tempFrame=viewSwiping.frame;
   // tempFrame.size.width=200;//change acco. how much you want to expand
    tempFrame.size.height=120+(arrLocs.count*42.5);
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    viewSwiping.frame=tempFrame;
    [UIView commitAnimations];
    
    scrollView.autoresizesSubviews = YES;
    
    
    [UIView animateWithDuration:0.2 animations:^(void){
        [lblSwp setFrame:({
            CGRect frame = lblSwp.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        // If you want to move other views too, just add them in this block
        
        [lblShowMe setFrame:({
            CGRect frame = lblShowMe.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        [viewShowMe setFrame:({
            CGRect frame = viewShowMe.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        [lblinfo1 setFrame:({
            CGRect frame = lblinfo1.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        [lblSearch setFrame:({
            CGRect frame = lblSearch.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        [lblVal1 setFrame:({
            CGRect frame = lblVal1.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        
        
        [viewDist setFrame:({
            CGRect frame = viewDist.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        
        
        [lblAge setFrame:({
            CGRect frame = lblAge.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        [lblVal setFrame:({
            CGRect frame = lblVal.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        [viewAge setFrame:({
            CGRect frame = viewAge.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        [lblInfo setFrame:({
            CGRect frame = lblInfo.frame;
            frame.origin.y = frame.origin.y+tempFrame.size.height-45; // If you want it to start at x = 150
            frame;
        })];
        
        
    }];
    
    int newYpos=50;
    
    UIButton *btnLoct=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLoct.frame=CGRectMake(15, newYpos+2.5,16, 20);
    btnLoct.userInteractionEnabled=NO;
    [btnLoct setBackgroundColor:[UIColor clearColor]];
    btnLoct.tag=8008;
    UIImage *imgLc=[UIImage imageNamed:@"Location.png"];
    [btnLoct setImage:imgLc forState:UIControlStateNormal];
    [viewSwiping addSubview:btnLoct];

    
    UIButton *btnCurrLoc=[UIButton buttonWithType:UIButtonTypeCustom];
    btnCurrLoc.frame=CGRectMake(45, newYpos,viewSwiping.frame.size.width-120, 25);
    [btnCurrLoc setTitle:@"My Current Location" forState:UIControlStateNormal];
    [btnCurrLoc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // btnLogin.titleLabel.font=fontname1;
    btnCurrLoc.titleLabel.font=fontname13;
      [btnCurrLoc addTarget:self action:@selector(onPlaceSelection:) forControlEvents:UIControlEventTouchDown];
   // [btnCurrLoc setBackgroundColor:[UIColor colorWithRed:208/255.0 green:81/255.0 blue:48/255.0 alpha:1.0]];
    btnCurrLoc.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    btnCurrLoc.tag=8005;
    [viewSwiping addSubview:btnCurrLoc];
//    if ([appDelegate.strCityName isEqualToString:@"My Current Location"])
//    {
        UIImage *imgLocasss=[UIImage imageNamed:@"TickBtn.png"];
        [btnCurrLoc setBackgroundImage:imgLocasss forState:UIControlStateNormal];
    //}
    
    newYpos+=40;
    
    
    
            if (arrLocs.count!=0)
            {
                for (int i=0; i<arrLocs.count; i++)
                {
                    NSDictionary *dictLocs=[arrLocs objectAtIndex:i];
    
                    UIButton *btnFlight=[UIButton buttonWithType:UIButtonTypeCustom];
                    btnFlight.frame=CGRectMake(15, newYpos+2.5,16, 20);
                    btnFlight.userInteractionEnabled=NO;
                    [btnFlight setBackgroundColor:[UIColor clearColor]];
                    btnFlight.tag=i+4000;
                    UIImage *imgFli=[UIImage imageNamed:@"other-location.png"];
                    [btnFlight setImage:imgFli forState:UIControlStateNormal];
                    [viewSwiping addSubview:btnFlight];

                    
    
                    UIButton *btnUserLoc=[UIButton buttonWithType:UIButtonTypeCustom];
                    btnUserLoc.frame=CGRectMake(45, newYpos,viewSwiping.frame.size.width-120, 25);
                   btnUserLoc.titleEdgeInsets=UIEdgeInsetsMake(0, 0,0, 35);
                    [btnUserLoc setTitle:[dictLocs valueForKey:@"city"] forState:UIControlStateNormal];
                   // [btnUserLoc setTitleColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
                     [btnUserLoc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [btnUserLoc addTarget:self action:@selector(onPlaceSelection:) forControlEvents:UIControlEventTouchUpInside];
                    [btnUserLoc setBackgroundColor:[UIColor clearColor]];
                    btnUserLoc.titleLabel.font=fontname13;
                    btnUserLoc.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                   // btnUserLoc.tag=[[dictLocs valueForKey:@"id"]integerValue];
                    btnUserLoc.tag=i+2000;
//
                    if ([appDelegate.strCityName isEqualToString:[dictLocs valueForKey:@"city"]])
                    {
                        UIImage *imgLocasss=[UIImage imageNamed:@"TickBtn.png"];
                        [btnUserLoc setBackgroundImage:imgLocasss forState:UIControlStateNormal];
                        
                        UIButton *btnMy=(UIButton *)[self.view viewWithTag:8005];
                        //UIImage *imgLobtn123=[UIImage imageNamed:@"LocBtn.png"];
                        [btnMy setBackgroundImage:nil forState:UIControlStateNormal];
                        
                    }

                    [viewSwiping addSubview:btnUserLoc];
                    
                    
                    UIButton *btnDelete=[UIButton buttonWithType:UIButtonTypeCustom];
                    btnDelete.frame=CGRectMake(viewSwiping.frame.size.width-35, newYpos,20, 20);
                    [btnDelete addTarget:self action:@selector(onDeleteLocation:) forControlEvents:UIControlEventTouchUpInside];
                    [btnDelete setBackgroundColor:[UIColor clearColor]];
                    btnDelete.tag=i+3000;
                    UIImage *imgDel=[UIImage imageNamed:@"Delete.png"];
                    [btnDelete setImage:imgDel forState:UIControlStateNormal];
                    [viewSwiping addSubview:btnDelete];
                    
    
                    newYpos+=40;
                    
                }
            }

    
    UIButton *btnAddLoc=[UIButton buttonWithType:UIButtonTypeCustom];
    btnAddLoc.frame=CGRectMake(15, newYpos,200, 30);
    //    UIImage *imgLoca=[UIImage imageNamed:@"LocTickBtn.png"];
    //    [btnAddLoc setBackgroundImage:imgLoca forState:UIControlStateNormal];
    [btnAddLoc setTitle:@"Add a new location" forState:UIControlStateNormal];
    [btnAddLoc setTitleColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
    // btnLogin.titleLabel.font=fontname1;
    btnAddLoc.titleLabel.font=fontname13;
    [btnAddLoc addTarget:self action:@selector(onAddNewLoc:) forControlEvents:UIControlEventTouchDown];
    //[btnAddLoc setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:249/255.0 alpha:1.0]];
    btnAddLoc.tag=8006;
     btnAddLoc.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [viewSwiping addSubview:btnAddLoc];

    
    
    UIButton *btnViewClose=[UIButton buttonWithType:UIButtonTypeCustom];
    btnViewClose.frame=CGRectMake(viewSwiping.frame.size.width-35, newYpos,20, 20);
    UIImage *imgClse=[UIImage imageNamed:@"UPArrow.png"];
    [btnViewClose setImage:imgClse forState:UIControlStateNormal];
//    [btnViewClose setTitle:@"Close" forState:UIControlStateNormal];
//    [btnViewClose setTitleColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:249/255.0 alpha:1.0] forState:UIControlStateNormal];
    // btnLogin.titleLabel.font=fontname1;
//    btnViewClose.titleLabel.font=fontname13;
//    btnViewClose.backgroundColor=[UIColor whiteColor];
//    btnViewClose.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
   [btnViewClose addTarget:self action:@selector(onViewClose:) forControlEvents:UIControlEventTouchDown];
    btnViewClose.tag=8007;
    [viewSwiping addSubview:btnViewClose];

    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, lblInfo.frame.origin.y+100);
                                      
                                      
}


-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    NSInteger value = lroundf(slider.value);
    
    // NSInteger nValue=slider.tag;
    NSString *strSliderVal=[NSString stringWithFormat:@"%ld",(long)value];
    
    if (slider.tag==567)
    {
        UILabel *lblValue=(UILabel *)[scrollView viewWithTag:566];
        lblValue.text=strSliderVal;
        [slider setValue:value animated:YES];
    }
    if (slider.tag==565)
    {
        UILabel *lblValue=(UILabel *)[scrollView viewWithTag:564];
        lblValue.text=[NSString stringWithFormat:@"%@km",strSliderVal];
        [slider setValue:value animated:YES];
    }
    
    
    
}


- (void)onChangeSwitch:(id)sender
{
    UISwitch *swt=(UISwitch *)sender;
    
    
    UISwitch *swtMen=(UISwitch *)[scrollView viewWithTag:SWT_MEN];
    UISwitch *swtWomen=(UISwitch *)[scrollView viewWithTag:SWT_WOMEN];
    
    if(![swtMen isOn] && ![swtWomen isOn] )
    {
        if (swt.tag==02)
        {
            [swtWomen setOn:YES];
        }
        else
        {
            [swtMen setOn:YES];
        }
    }
    
    
}
-(void)onBack
{
    UISwitch *swtDiscov=(UISwitch *)[scrollView viewWithTag:SWT_DISCOV];
    UISwitch *swtMen=(UISwitch *)[scrollView viewWithTag:SWT_MEN];
    UISwitch *swtWomen=(UISwitch *)[scrollView viewWithTag:SWT_WOMEN];
    UISlider *sliderAge=(UISlider *)[scrollView viewWithTag:567];
    UISlider *sliderDista=(UISlider *)[scrollView viewWithTag:565];
    
    NSString *strDis, *strGen, *strAgeLimit, *strDistance;
    
    if ([swtDiscov isOn])
    {
        strDis=@"1";
    }
    else
    {
        strDis=@"0";
    }
    
    
    if ([swtMen isOn])
    {
        strGen=@"male";
    }
    if ([swtWomen isOn])
    {
        strGen=@"female";
    }
    if ([swtMen isOn] && [swtWomen isOn])
    {
        strGen=@"others";
    }
    int nAge=sliderAge.value;
    strAgeLimit=[NSString stringWithFormat:@"%d",nAge];
    
    int nDist=sliderDista.value;
    strDistance=[NSString stringWithFormat:@"%d",nDist];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=2;
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"gender\":\"%@\",\"age_limit\":\"%@\",\"distance\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"discovery\":\"%@\"}",strid,strToken,strGen,strAgeLimit,strDistance, appDelegate.strLatitude,appDelegate.strLongitude,strDis];
    
    [service executeWebserviceWithMethod:METHOD_SAVE_PREFERENCE withValues:strValues];
    
    [self performSegueWithIdentifier:@"DiscoverySettings_Home" sender:self];
}

-(void)GetBinderPlus
{
    vwGetBinderPlus=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    vwGetBinderPlus.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [self.view addSubview:vwGetBinderPlus];
    
    //    [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        vwSprLikDeny.frame = CGRectMake((self.view.frame.size.width/2)-105,self.view.frame.size.height-60, 50, 50);
    //    } completion:^(BOOL finished) {
    //        // your animation finished
    //    }];
    
    
    
    UIButton *btnClosePlus=[[UIButton alloc]initWithFrame:self.view.frame];
    btnClosePlus.backgroundColor=[UIColor clearColor];
    [btnClosePlus addTarget:self action:@selector(OnCloseView:) forControlEvents:UIControlEventTouchDown];
    [vwGetBinderPlus addSubview:btnClosePlus];
    
    
    UIView *viewPlusInfo=[[UIView alloc]initWithFrame:CGRectMake(10, (self.view.frame.size.height/2)-140, self.view.frame.size.width-20, 280)];
    viewPlusInfo.backgroundColor=[UIColor whiteColor];
    viewPlusInfo.layer.cornerRadius = 8;
    viewPlusInfo.clipsToBounds = YES;
    [vwGetBinderPlus addSubview:viewPlusInfo];
    
    
    int yP=10;
    
    
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, yP, viewPlusInfo.frame.size.width-20, 30)];
    lblName.text=[NSString stringWithFormat:@"Get Binder Plus"];
    [lblName setFont:fontname18];
    lblName.textAlignment=NSTextAlignmentCenter;
    lblName.textColor=[UIColor blackColor];
    [viewPlusInfo addSubview:lblName];
    
    yP+=30;
    
    
    
    pageCount=3;
    nCount=0;
    
    imgScrlView=[[UIScrollView alloc]initWithFrame:CGRectMake((viewPlusInfo.frame.size.width/2)-80, yP, 180, 150)];
    imgScrlView.backgroundColor=[UIColor clearColor];
    imgScrlView.pagingEnabled=YES;
    imgScrlView.delegate=self;
    imgScrlView.bounces=NO;
    imgScrlView.directionalLockEnabled=YES;
    imgScrlView.contentSize=CGSizeMake(pageCount * imgScrlView.bounds.size.width , imgScrlView.bounds.size.height);
    [imgScrlView setShowsHorizontalScrollIndicator:NO];
    [imgScrlView setShowsVerticalScrollIndicator:NO];
    [viewPlusInfo addSubview:imgScrlView];
    
    CGRect viewSize;
    {
        viewSize=imgScrlView.bounds;
        UIImageView *imgView1=[[UIImageView alloc] initWithFrame:viewSize];
        imgView1.image=[UIImage imageNamed:@"Rewind.png"];
        [imgScrlView addSubview:imgView1];
    }
    {
        viewSize=CGRectOffset(viewSize, imgScrlView.bounds.size.width, 0);
        UIImageView *imgView1=[[UIImageView alloc] initWithFrame:viewSize];
        imgView1.image=[UIImage imageNamed:@"LocationChange.png"];
        [imgScrlView addSubview:imgView1];
    }
    {
        viewSize=CGRectOffset(viewSize, imgScrlView.bounds.size.width, 0);
        UIImageView *imgView1=[[UIImageView alloc] initWithFrame:viewSize];
        imgView1.image=[UIImage imageNamed:@"MoreSuperLike.png"];
        [imgScrlView addSubview:imgView1];
    }
    //    {
    //        viewSize=CGRectOffset(viewSize, imgScrlView.bounds.size.width, 0);
    //        UIImageView *imgView1=[[UIImageView alloc] initWithFrame:viewSize];
    //        imgView1.image=[UIImage imageNamed:@"SlideInfo.png"];
    //        [imgScrlView addSubview:imgView1];
    //    }
    //    {
    //        viewSize=CGRectOffset(viewSize, imgScrlView.bounds.size.width, 0);
    //        UIImageView *imgView1=[[UIImageView alloc] initWithFrame:viewSize];
    //        imgView1.image=[UIImage imageNamed:@"SlideInfo.png"];
    //        [imgScrlView addSubview:imgView1];
    //    }
    
    // imgScrlView.contentSize = CGSizeMake(imgScrlView.contentSize.width,self.view.frame.size.height-40);
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(viewanimation) userInfo:nil repeats:YES];
    
    yP+=150;
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((viewPlusInfo.frame.size.width/2)-25,yP,50,20);
    pageControl.numberOfPages = pageCount;
    pageControl.currentPage = 0;
    pageControl.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:14/255.0 green:102/255.0 blue:255/255.0 alpha:1.0];
    pageControl.pageIndicatorTintColor=[UIColor colorWithRed:164/255.0 green:208/255.0 blue:255/255.0 alpha:1.0];
    [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    [viewPlusInfo addSubview:pageControl];
    
    
    
    UIButton *btnGetIt=[UIButton buttonWithType:UIButtonTypeCustom];
    btnGetIt.frame=CGRectMake(0, viewPlusInfo.frame.size.height-50, viewPlusInfo.frame.size.width, 50);
    //    UIImage *imgBack=[UIImage imageNamed:@"Back.png"];
    //    [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
    [btnGetIt setTitle:@"SUBSCRIBE" forState:UIControlStateNormal];
    btnGetIt.titleLabel.font=fontname15_16;
    [btnGetIt addTarget:self action:@selector(onGetAmount:) forControlEvents:UIControlEventTouchDown];
    btnGetIt.backgroundColor=[UIColor colorWithRed:14/255.0 green:102/255.0 blue:255/255.0 alpha:1.0];
    [btnGetIt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewPlusInfo addSubview:btnGetIt];
    
    
}

-(void)AddLocation
{
    CLLocationCoordinate2D center=[self getLocationFromAddressString:strAddress];
    
    strSelectedLat=[NSString stringWithFormat:@"%f",center.latitude];
    strSelectedLong=[NSString stringWithFormat:@"%f",center.longitude];
    
    
    //    loaderView=[[LoaderView alloc]initWithNibName:@"LoaderView" bundle:nil];
    //    [self.view addSubview:loaderView.view];
    
    webservice *service2=[[webservice alloc]init];
    service2.tag=3;
    service2.delegate=self;
    
    
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"address\":\"%@\",\"city\":\"%@\"}",strid,strToken,strSelectedLat,strSelectedLong,strAddress, strPlace];
    
    
    //  NSString *strValues=[NSString stringWithFormat:@"{\"provider_id\":\"%@\",\"token\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"address\":\"%@\",\"paypal_email\":\"%@\"}",strId,strToken,strLat,strLong,@"trichy",@"ramesh@wepopar.com"];
    
    [service2 executeWebserviceWithMethod:METHOD_ADD_USER_LOCATION withValues:strValues];
}

-(void)onGetAmount:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=6;
    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
    
    [service executeWebserviceWithMethod1:METHOD_GET_PRO_AMOUNT withValues:strSend];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - Action

-(IBAction)onViewClose:(id)sender
{
    UIButton *btnAddLoc1=(UIButton *)[self.view viewWithTag:8006];
    [btnAddLoc1 removeFromSuperview];
    
    UIButton *btnVwClose=(UIButton *)[self.view viewWithTag:8007];
    [btnVwClose removeFromSuperview];
    
    UIButton *btnLoct=(UIButton *)[self.view viewWithTag:8008];
    [btnLoct removeFromSuperview];

    UIButton *btnMyCurLo=(UIButton *)[self.view viewWithTag:8005];
    [btnMyCurLo removeFromSuperview];
    
    UIButton *btnMyLoc=(UIButton *)[self.view viewWithTag:8004];
    [btnMyLoc setHidden:NO];
    [btnMyLoc setTitle:appDelegate.strCityName forState:UIControlStateNormal];
    
    
    if (arrLocs.count!=0)
    {
        for (int i=0; i<arrLocs.count; i++)
        {
            UIButton *btnNewLoc=(UIButton *)[self.view viewWithTag:i+2000];
            [btnNewLoc removeFromSuperview];
            
            UIButton *btnDele=(UIButton *)[self.view viewWithTag:i+3000];
            [btnDele removeFromSuperview];
            
            UIButton *btnFli=(UIButton *)[self.view viewWithTag:i+4000];
            [btnFli removeFromSuperview];
            
        }
    }

    
    
    UIView *viewSwiping=(UIView *)[self.view viewWithTag:1234];
    
    UIView *viewShowMe=(UIView *)[self.view viewWithTag:7897];
    UIView *viewDist=(UIView *)[self.view viewWithTag:8000];
    UIView *viewAge=(UIView *)[self.view viewWithTag:8002];
    
    
    UILabel *lblSwp=(UILabel *)[self.view viewWithTag:7895];
    UILabel *lblShowMe=(UILabel *)[self.view viewWithTag:7896];
    UILabel *lblinfo1=(UILabel *)[self.view viewWithTag:7898];
    UILabel *lblSearch=(UILabel *)[self.view viewWithTag:7899];
    UILabel *lblVal1=(UILabel *)[self.view viewWithTag:564];
    UILabel *lblAge=(UILabel *)[self.view viewWithTag:8001];
    UILabel *lblVal=(UILabel *)[self.view viewWithTag:566];
    UILabel *lblInfo=(UILabel *)[self.view viewWithTag:8003];
    
    
    CGRect tempFrame=viewSwiping.frame;
    // tempFrame.size.width=200;//change acco. how much you want to expand
    tempFrame.size.height=45;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    viewSwiping.frame=tempFrame;
    [UIView commitAnimations];
    
    scrollView.autoresizesSubviews = YES;
    
    
    [UIView animateWithDuration:0.2 animations:^(void){
        [lblSwp setFrame:({
            CGRect frame = lblSwp.frame;
            frame.origin.y = tempFrame.origin.y+47; // If you want it to start at x = 150
            frame;
        })];
        
        // If you want to move other views too, just add them in this block
        
        [lblShowMe setFrame:({
            CGRect frame = lblShowMe.frame;
            frame.origin.y = tempFrame.origin.y+75; // If you want it to start at x = 150
            frame;
        })];
        
        [viewShowMe setFrame:({
            CGRect frame = viewShowMe.frame;
            frame.origin.y = tempFrame.origin.y+102; // If you want it to start at x = 150
            frame;
        })];
        
        [lblinfo1 setFrame:({
            CGRect frame = lblinfo1.frame;
            frame.origin.y = tempFrame.origin.y+194; // If you want it to start at x = 150
            frame;
        })];
        
        [lblSearch setFrame:({
            CGRect frame = lblSearch.frame;
            frame.origin.y = tempFrame.origin.y+222; // If you want it to start at x = 150
            frame;
        })];
        
        [lblVal1 setFrame:({
            CGRect frame = lblVal1.frame;
            frame.origin.y = tempFrame.origin.y+222; // If you want it to start at x = 150
            frame;
        })];
        
        
        
        [viewDist setFrame:({
            CGRect frame = viewDist.frame;
            frame.origin.y = tempFrame.origin.y+249; // If you want it to start at x = 150
            frame;
        })];
        
        
        
        [lblAge setFrame:({
            CGRect frame = lblAge.frame;
            frame.origin.y = tempFrame.origin.y+309; // If you want it to start at x = 150
            frame;
        })];
        [lblVal setFrame:({
            CGRect frame = lblVal.frame;
            frame.origin.y = tempFrame.origin.y+309; // If you want it to start at x = 150
            frame;
        })];
        [viewAge setFrame:({
            CGRect frame = viewAge.frame;
            frame.origin.y = tempFrame.origin.y+336; // If you want it to start at x = 150
            frame;
        })];
        [lblInfo setFrame:({
            CGRect frame = lblInfo.frame;
            frame.origin.y = tempFrame.origin.y+383; // If you want it to start at x = 150
            frame;
        })];
        
        
    }];
    

    
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, lblInfo.frame.origin.y+100);
    
    
}

-(IBAction)onDeleteLocation:(id)sender
{
    UIButton *btn1=(UIButton *)sender;
    NSLog(@"Btn Tag: %ld",(long)btn1.tag);
    
    int arrIndex1=btn1.tag-3000;
     NSDictionary *dictLocId=[arrLocs objectAtIndex:arrIndex1];
    
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=4;
    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@&location_id=%@",strid,strToken,[dictLocId valueForKey:@"id"]];
    
    [service executeWebserviceWithMethod1:METHOD_DELETE_LOCATION withValues:strSend];

}

//-(void)onAftDelete
//{
//    loaderView=[[LoaderView alloc]initWithNibName:@"LoaderView" bundle:nil];
//    [self.view addSubview:loaderView.view];
//    
//    webservice *service=[[webservice alloc]init];
//    service.delegate=self;
//    service.tag=5;
//    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
//    
//    [service executeWebserviceWithMethod1:METHOD_GET_ALL_LOCATIONS withValues:strSend];
//
//}

-(IBAction)onPlaceSelection:(id)sender
{
    
    UIButton *btnMy=(UIButton *)[self.view viewWithTag:8005];
    //UIImage *imgLobtn123=[UIImage imageNamed:@"LocBtn.png"];
    [btnMy setBackgroundImage:nil forState:UIControlStateNormal];
    
    for (int j=0; j<arrLocs.count; j++)
    {
        UIButton *btnPlace=(UIButton *)[self.view viewWithTag:j+2000];
        [btnPlace setBackgroundImage:nil forState:UIControlStateNormal];
    }
    UIButton *btn=(UIButton *)sender;
    NSLog(@"Btn Tag: %ld",(long)btn.tag);
    
    int arrIndex=btn.tag-2000;
    
    if (btn.tag!=8005)
    {

     NSDictionary *dictLatLong=[arrLocs objectAtIndex:arrIndex];
    appDelegate.strSwipeLat=[dictLatLong valueForKey:@"latitude"];
    appDelegate.strSwipeLong=[dictLatLong valueForKey:@"longitude"];
    appDelegate.strCityName=[dictLatLong valueForKey:@"city"];
    }
    UIButton *btnPlace=(UIButton *)[self.view viewWithTag:btn.tag];
    UIImage *imgbtn=[UIImage imageNamed:@"TickBtn.png"];
    [btnPlace setBackgroundImage:imgbtn forState:UIControlStateNormal];
   // btnPlace.transform = CGAffineTransformMakeScale(-1.0, 1.0);
   // btnPlace.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
   // btnPlace.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    
    if (btn.tag==8005)
    {
        appDelegate.strSwipeLat=appDelegate.strLatitude;
        appDelegate.strSwipeLong=appDelegate.strLongitude;
        appDelegate.strCityName=@"My Current Location";
        
        UIButton *btnMy=(UIButton *)[self.view viewWithTag:8005];
        UIImage *imgbtn=[UIImage imageNamed:@"TickBtn.png"];
        [btnMy setBackgroundImage:imgbtn forState:UIControlStateNormal];
        //btnMy.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        // btnMy.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
       // btnMy.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:appDelegate.strSwipeLat forKey:@"SwipeLat"];
    [defaults setValue:appDelegate.strSwipeLong forKey:@"SwipeLong"];
    [defaults setValue:appDelegate.strCityName forKey:@"CityName"];
    
    
    NSLog(@"Lat: %@",appDelegate.strSwipeLat);
    NSLog(@"Long: %@",appDelegate.strSwipeLong);
    NSLog(@"City: %@",appDelegate.strCityName);
    

    
}
-(IBAction)onAddNewLoc:(id)sender
{
    //[self performSegueWithIdentifier:@"DisCovSet_MapView" sender:self];
//    if ([appDelegate.strProUser isEqualToString:@"1"])
//    {
        appDelegate.strAddNewLocClicked=@"yes";
        GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
        acController.delegate = self;
        [self presentViewController:acController animated:YES completion:nil];
//    }
//    else
//    {
//        [self GetBinderPlus];
//    }
}


-(IBAction)OnCloseView:(id)sender
{
    [vwGetBinderPlus removeFromSuperview];
}

#pragma mark -
#pragma mark - Page Controll
-(void)viewanimation
{
    if (nCount<3)
    {
        nCount++;
        int pageNumber = nCount;
        
        CGRect frame = imgScrlView.frame;
        frame.origin.x = frame.size.width*pageNumber;
        frame.origin.y=0;
        
        [imgScrlView scrollRectToVisible:frame animated:YES];
    }
    else
    {
        nCount=0;
        int pageNumber = nCount;
        
        CGRect frame = imgScrlView.frame;
        frame.origin.x = frame.size.width*pageNumber;
        frame.origin.y=0;
        
        [imgScrlView scrollRectToVisible:frame animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat viewWidth = scrollView.frame.size.width;
    // content offset - tells by how much the scroll view has scrolled.
    
    int pageNumber = floor((scrollView.contentOffset.x - viewWidth/50) / viewWidth) +1;
    
    pageControl.currentPage=pageNumber;
    nCount=pageNumber;
    
}

- (void)pageChanged {
    
    int pageNumber = pageControl.currentPage;
    
    CGRect frame = imgScrlView.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [imgScrlView scrollRectToVisible:frame animated:YES];
}



#pragma mark -
#pragma mark - PayPalPayment
-(void)onPayPal:(id)sender
{
    // NSDictionary *dictValue=[arrList objectAtIndex:btn.tag];
    
    [vwGetBinderPlus removeFromSuperview];
    
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    // Amount, currency, and description
    // payment.amount = [[NSDecimalNumber alloc] initWithString:[dictValue valueForKey:@"price"]];
    
    //    payment.amount = [[NSDecimalNumber alloc] initWithString:[dictRes valueForKey:@"Price"]];
    //    payment.currencyCode = @"USD";
    //    payment.shortDescription =[NSString stringWithFormat:@"Beat Payment For: %@", [dictRes valueForKey:@"Categoryname"]];
    
    payment.amount = [[NSDecimalNumber alloc] initWithString:strProAmount];
    payment.currencyCode = @"USD";
    payment.shortDescription =[NSString stringWithFormat:@"Payment For Binder Pro"];
    
    
    //payment.description =[dictValue valueForKey:@"description"];
    
    // Use the intent property to indicate that this is a "sale" payment,
    // meaning combined Authorization + Capture.
    // To perform Authorization only, and defer Capture to your server,
    // use PayPalPaymentIntentAuthorize.
    // To place an Order, and defer both Authorization and Capture to
    // your server, use PayPalPaymentIntentOrder.
    // (PayPalPaymentIntentOrder is valid only for PayPal payments, not credit card payments.)
    payment.intent = PayPalPaymentIntentSale;
    
    // If your app collects Shipping Address information from the customer,
    // or already stores that information on your server, you may provide it here.
    // payment.shippingAddress = @"132,sfsdf"; // a previously-created PayPalShippingAddress object
    
    // Several other optional fields that you can set here are documented in PayPalPayment.h,
    // including paymentDetails, items, invoiceNumber, custom, softDescriptor, etc.
    
    // Check whether payment is processable.
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
        
    }else
    {
        PayPalPaymentViewController *paymentViewController;
        paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                       configuration:self.payPalConfiguration
                                                                            delegate:self];
        
        // Present the PayPalPaymentViewController.
        
        [self presentViewController:paymentViewController animated:YES completion:nil];
        
        
        
        
    }
    
}



#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@",completedPayment.confirmation);
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    
    NSDictionary *values = [NSJSONSerialization JSONObjectWithData:confirmation options:0 error:nil];
    
    NSDictionary *dictPayPal=[values valueForKey:@"response"];
    
    if ([[dictPayPal valueForKey:@"state"] isEqualToString:@"approved"])
        
    {
        NSString *strpaypalid=[dictPayPal valueForKey:@"id"];
        
//        loaderView=[[LoaderView alloc] initWithNibName:@"LoaderView" bundle:nil];
//        [self.view addSubview:loaderView.view];
        
        webservice *service=[[webservice alloc]init];
        service.tag=7;
        service.delegate=self;
        
        NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"paid_status\":\"%@\",\"paypal_id\":\"%@\"}",strid, strToken, @"1", strpaypalid ];
        
        [service executeWebserviceWithMethod:METHOD_PAYPAL_PAYMENT_SUCCESS withValues:strValues];
        
    }
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}



#pragma mark - Webservice Delegate
-(void) receivedErrorWithMessage:(NSString *)message
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
-(void) receivedResponse:(NSDictionary *)dictResponse fromWebservice:(webservice *)webservice
{
    NSLog(@"%@",dictResponse);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
  //  [MBProgressHUD removeFromParentViewController];
    
    if (webservice.tag==1)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
//            arrSlider=[dictResponse valueForKey:@"slider"];
//            arrDropdown=[dictResponse valueForKey:@"dropdown"];
//            dictUser=[dictResponse valueForKey:@"user"];
            
            dictGetPre=[dictResponse valueForKey:@"preference"];
             arrLocs=[dictGetPre valueForKey:@"locations"];
            [self onPageLoad];
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
    else if (webservice.tag==2)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            
            
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
    else if (webservice.tag==3)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
          //  [loaderView removeFromParentViewController];
            
            appDelegate.strSwipeLong=strSelectedLong;
            appDelegate.strSwipeLat=strSelectedLat;
            appDelegate.strCityName=strPlace;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setValue:appDelegate.strSwipeLat forKey:@"SwipeLat"];
            [defaults setValue:appDelegate.strSwipeLong forKey:@"SwipeLong"];
            [defaults setValue:appDelegate.strCityName forKey:@"CityName"];

            appDelegate.strAddNewLocClicked=@"no";
            
            [self viewWillAppear:YES];
            
            
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
    else if (webservice.tag==4)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
         //   [loaderView removeFromParentViewController];
            
            appDelegate.strCityDeleted=@"yes";
            
            [self viewWillAppear:YES];
            
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
    else if (webservice.tag==5)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
      //      [loaderView removeFromParentViewController];
            
            // arrLocs=[dictResponse valueForKey:@"data"];
            
          //  [self onMyCurLoc:nil];
            
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
    else  if (webservice.tag==6)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            strProAmount=[dictResponse valueForKey:@"amount"];
            [self onPayPal:nil];
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
    else  if (webservice.tag==7)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            appDelegate.strProUser=@"1";
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:@"1" forKey:@"ProUser"];
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:@"Thank you for Purchasing Binder Plus" preferredStyle:UIAlertControllerStyleAlert];
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
            
        }    }

    


}




#pragma mark -
#pragma mark - Google Place Handler

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    
    strAddress=place.formattedAddress;
    strPlace=place.name;
    
    [self AddLocation];
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



#pragma mark -  Convert Address To Lat Long

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
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
