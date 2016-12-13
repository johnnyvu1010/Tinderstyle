//
//  BinderHome.m
//  Binder
//
//  Created by Admin on 27/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BinderHome.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "FLAnimatedImage.h"
#import "PayPalMobile.h"
#import "CardIO.h"
#import "LogIn.h"

@interface BinderHome ()<PayPalPaymentDelegate>
{
    CardView *viewCard;
    int nViewCardCount, nSlideCount, nWebTag;
    NSString *strid, *strToken, *strSattus;
    AppDelegate *appDelegate;
    NSArray *arrFrndsList;
    NSString *strUserId, *strPaypalOpen;
    UIView *viewSingle, *viewMatch, *vwSprLikDeny, *vwGetBinderPlus, *viewMessage;
    UIScrollView *scrollView;
    NSDictionary *dictLike, *dictSnglFrnd;
    UIImageView *imgSprLkDny;
    UIButton *btnSpLk;
    UIPageControl *pageControl;
    UIScrollView *imgScrlView;
    int nCount;
    int pageCount;
    NSString *strProAmount, *strReport;
     UIFont *fontname13,*fontname15,*fontname16, *fontname18, *fontname15_16;
    int webServTag;
    UIView *viewNavBar;
    UIView *viewReport;
}
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
-(void)payWithPayPal;
@property (nonatomic, strong, readwrite) PayPalConfiguration *payPalConfiguration;


- (CustomizationState)nextCustomizationState:(CustomizationState)state;
- (NSString*)buttonTextForState:(CustomizationState)state;
- (void)customizeAccordingToState:(CustomizationState)state;

@end

@implementation BinderHome
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
   // self.navigationController.toolbarHidden = YES;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
   // self.navigationController.navigationBar.translucent = NO;
    
    fontname13 = [UIFont fontWithName:@"Roboto" size:13];
    fontname15 = [UIFont fontWithName:@"Roboto-Regular" size:15];
    fontname15_16 = [UIFont fontWithName:@"Roboto-Regular" size:16];
    fontname16 = [UIFont fontWithName:@"Roboto" size:16];
    fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];

    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];
    strSattus=[defaults valueForKey:@"status"];
    
   
    
  
   
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    self.tapGestureRecognizer.enabled = NO;
    self.revealViewController.delegate = self;
    
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [self.view addGestureRecognizer:revealController.tapGestureRecognizer];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.SideBarButton setTarget: self.revealViewController];
        [self.SideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //    SWRevealViewController *reveal = self.revealViewController;
    //    reveal.panGestureRecognizer.enabled = NO;
    
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    FLAnimatedImageView  *imageView1=(FLAnimatedImageView *)[self.view viewWithTag:4001];
    imageView1.hidden=YES;
    
    UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
    lblFinding.text=@"";
    
    viewNavBar=[[UIView alloc]initWithFrame:CGRectMake(50, 5, 250, 35)];
    viewNavBar.backgroundColor=[UIColor clearColor];
    [self.navigationController.view addSubview:viewNavBar];
    
    UIButton *btnBinder=[UIButton buttonWithType:UIButtonTypeCustom];
    btnBinder.frame=CGRectMake(15, 5, 75, 25);
    UIImage *imgBindGray=[UIImage imageNamed:@"Logo26pxGray.png"];
    [btnBinder setImage:imgBindGray forState:UIControlStateNormal];
    UIImage *imgBind=[UIImage imageNamed:@"Logo26px.png"];
    [btnBinder setImage:imgBind forState:UIControlStateSelected];
    [btnBinder addTarget:self action:@selector(onBinder:) forControlEvents:UIControlEventTouchDown];
    btnBinder.selected=YES;
    btnBinder.tag=10000;
    [viewNavBar addSubview:btnBinder];
    
    UIButton *btnMessage=[UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.frame=CGRectMake(100, 2.5, 50, 30);
    UIImage *imgMsgGray=[UIImage imageNamed:@"MessageGray.png"];
    [btnMessage setImage:imgMsgGray forState:UIControlStateNormal];
    UIImage *imgMsg=[UIImage imageNamed:@"Message.png"];
    [btnMessage setImage:imgMsg forState:UIControlStateSelected];
    [btnMessage addTarget:self action:@selector(onMessage:) forControlEvents:UIControlEventTouchDown];
    btnMessage.tag=10001;
    [viewNavBar addSubview:btnMessage];

    if ([appDelegate.strIsFrmChat isEqualToString:@"yes"])
    {
        UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
        lblFinding.text=@"There's no one new around you.";
        
        [self onMessage:nil];
        appDelegate.strIsFrmChat=@"";
        
    }
    else if (![strPaypalOpen isEqualToString:@"yes"])
    {

    
    strUserId=@"0";
    
    // Start out working with the test environment! When you are ready, switch to PayPalEnvironmentProduction.
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];

    if ([appDelegate.strisFrmBindPlus isEqualToString:@"yes"])
    {
        [self onGetAmount:nil];
        appDelegate.strisFrmBindPlus=@"no";
    }

    else
    {
    
    [viewSingle removeFromSuperview];
    
        nViewCardCount=0;
        nSlideCount=0;
        nWebTag=5000;
    
    FLAnimatedImageView  *imageView1=[[FLAnimatedImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-150,(self.view.frame.size.height/2)-150, 300, 300)];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"Gif" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    imageView1.animatedImage=animatedImage1;
    imageView1.tag=4001;
    [self.view addSubview:imageView1];
    
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-40,(self.view.frame.size.height/2)-40, 80, 80)];
    
    imgView.image=[UIImage imageNamed:@"user.png"];
    
    
    if ([appDelegate.strPicture isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
    {
        imgView.image=[UIImage imageNamed:@"user.png"];
    }
    else
    {
        AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
        [async loadImageFromURL:[NSURL URLWithString:appDelegate.strPicture]];
        async.backgroundColor=[UIColor clearColor];
        [imgView addSubview:async];
    }
    imgView.layer.cornerRadius = 40;
    imgView.clipsToBounds = YES;
    [self.view addSubview:imgView];
    
    
    
    UILabel *lblFinding=[[UILabel alloc]initWithFrame:CGRectMake(15, (self.view.frame.size.height/2)+140, self.view.frame.size.width-30, 25)];
    lblFinding.text=@"Finding People...";
    lblFinding.textAlignment=NSTextAlignmentCenter;
    [lblFinding setFont:fontname16];
    lblFinding.textColor=[UIColor blackColor];
    lblFinding.tag=4002;
    [self.view addSubview:lblFinding];
    
    
        
        UIButton *btnRefresh=[UIButton buttonWithType:UIButtonTypeCustom];
        btnRefresh.frame=CGRectMake((self.view.frame.size.width/2)-125, self.view.frame.size.height-70, 50, 50);
        UIImage *imgRF=[UIImage imageNamed:@"Refresh.png"];
        [btnRefresh setBackgroundImage:imgRF forState:UIControlStateNormal];
        [btnRefresh addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventTouchDown];
//        [[btnRefresh layer]setBorderWidth:1.5];
//        [[btnRefresh layer]setBorderColor:[UIColor grayColor].CGColor];
        btnRefresh.layer.cornerRadius=25;
        btnRefresh.clipsToBounds=YES;
        [self.view addSubview:btnRefresh];
        
        UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeCustom];
        btnClose.frame=CGRectMake((self.view.frame.size.width/2)-65, self.view.frame.size.height-75, 60, 60);
        UIImage *imgCL=[UIImage imageNamed:@"CloseDisa.png"];
        [btnClose setBackgroundImage:imgCL forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(onNope:) forControlEvents:UIControlEventTouchDown];
//        [[btnClose layer]setBorderWidth:1.5];
//        [[btnClose layer]setBorderColor:[UIColor grayColor].CGColor];
        btnClose.layer.cornerRadius=30;
        btnClose.clipsToBounds=YES;
        btnClose.tag=6001;
        btnClose.userInteractionEnabled=NO;
        [self.view addSubview:btnClose];
        
        
        UIButton *btnLove=[UIButton buttonWithType:UIButtonTypeCustom];
        btnLove.frame=CGRectMake((self.view.frame.size.width/2)+5, self.view.frame.size.height-75, 60, 60);
        UIImage *imgLV=[UIImage imageNamed:@"HeartDisa.png"];
        [btnLove setBackgroundImage:imgLV forState:UIControlStateNormal];
        [btnLove addTarget:self action:@selector(onLike:) forControlEvents:UIControlEventTouchDown];
//        [[btnLove layer]setBorderWidth:1.5];
//        [[btnLove layer]setBorderColor:[UIColor grayColor].CGColor];
        btnLove.layer.cornerRadius=30;
        btnLove.clipsToBounds=YES;
        btnLove.tag=6002;
        btnLove.userInteractionEnabled=NO;
        [self.view addSubview:btnLove];
        
        
        UIButton *btnStar=[UIButton buttonWithType:UIButtonTypeCustom];
        btnStar.frame=CGRectMake((self.view.frame.size.width/2)+75, self.view.frame.size.height-70, 50, 50);
        UIImage *imgST=[UIImage imageNamed:@"StarDisa.png"];
        [btnStar setBackgroundImage:imgST forState:UIControlStateNormal];
        [btnStar addTarget:self action:@selector(onSuperLike:) forControlEvents:UIControlEventTouchDown];
//        [[btnStar layer]setBorderWidth:1.5];
//        [[btnStar layer]setBorderColor:[UIColor grayColor].CGColor];
        btnStar.layer.cornerRadius=25;
        btnStar.clipsToBounds=YES;
        btnStar.tag=6003;
        btnStar.userInteractionEnabled=NO;
        [self.view addSubview:btnStar];

        
//    loaderView=[[LoaderView alloc] initWithNibName:@"LoaderView" bundle:nil];
//    [self.view addSubview:loaderView.view];
//    
    webservice *service=[[webservice alloc]init];
    service.tag=1;
    service.delegate=self;
        webServTag=1;
        
        
        NSLog(@"%@",appDelegate.strSwipeLat);
        NSLog(@"%@",appDelegate.strSwipeLong);
        
        if ([appDelegate.strSwipeLat length]==0 || [appDelegate.strSwipeLong length]==0)
        {
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            appDelegate.strSwipeLong=[defaults valueForKey:@"SwipeLong"];
            appDelegate.strSwipeLat=[defaults valueForKey:@"SwipeLat"];
        }

        NSLog(@"%@",appDelegate.strSwipeLat);
        NSLog(@"%@",appDelegate.strSwipeLong);
        
        
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"status\":\"%@\",\"last_id\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\"}",strid,strToken,strSattus,@"1",appDelegate.strSwipeLat,appDelegate.strSwipeLong];
    
    [service executeWebserviceWithMethod:METHOD_SEARCH_FRIENDS withValues:strValues];
        
       // NSLog(@"Request : %@",strValues);
    }
        
    }
    strPaypalOpen=@"no";
}
-(void)viewWillDisappear:(BOOL)animated
{
    [viewNavBar removeFromSuperview];
    
}
- (void)viewDidLayoutSubviews
{

    
        [self.swipeableView loadViewsIfNeeded];
    
}

-(void)onMakeViewCards
{
    nViewCardCount=0;
    nSlideCount=0;

    [self popZoomOut];
    
   // [viewCard removeFromSuperview];
    
    {
        
        FLAnimatedImageView  *imageView1=(FLAnimatedImageView *)[self.view viewWithTag:4001];
        imageView1.hidden=YES;
        
        UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
        lblFinding.text=@"";

        
       
    }
    self.colorIndex = 0;
//    self.colors = @[
//                    @"Silver",
//                    @"Concrete",
//                    @"Asbestos"
//                    ];
    
    self.colors=arrFrndsList;
    
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    // swipeableView.allowedDirection=ZLSwipeableViewDirectionHorizontal;
    [self.view addSubview:self.swipeableView];
    //swipeableView.tag=;
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [[swipeableView layer]setBorderWidth:2.5];
//    [[swipeableView layer]setBorderColor:[UIColor grayColor].CGColor];
    
    NSDictionary *metrics = @{};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-120-[swipeableView]-100-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    

    
    if ([appDelegate.strUserCount intValue]!=0)
    {
   
    UIButton *btnClose=(UIButton *)[self.view viewWithTag:6001];
    UIButton *btnHeart=(UIButton *)[self.view viewWithTag:6002];
    UIButton *btnStar=(UIButton *)[self.view viewWithTag:6003];
    
    btnStar.userInteractionEnabled=YES;
    btnClose.userInteractionEnabled=YES;
    btnHeart.userInteractionEnabled=YES;
    
    UIImage *imgCL=[UIImage imageNamed:@"Close.png"];
    [btnClose setBackgroundImage:imgCL forState:UIControlStateNormal];
    
    UIImage *imgLV=[UIImage imageNamed:@"Heart.png"];
    [btnHeart setBackgroundImage:imgLV forState:UIControlStateNormal];
    
    UIImage *imgST=[UIImage imageNamed:@"Star.png"];
    [btnStar setBackgroundImage:imgST forState:UIControlStateNormal];

    }
    
   // NSLog(@"%f",self.view.frame.size.height);
}

-(void)onNope:(id)sender
{
    // [viewSingle removeFromSuperview];
    
    UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
    UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
    UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    
    [btnNope setHidden:NO];
    [btnLike setHidden:YES];
    [btnSupeLike setHidden:YES];
    
    
    [self.swipeableView swipeTopViewToLeft];
    
    
}

-(void)onLike:(id)sender
{
    // [viewSingle removeFromSuperview];
    
    UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
    UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
    UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    
    [btnNope setHidden:YES];
    [btnLike setHidden:NO];
    [btnSupeLike setHidden:YES];
    
    
    [self.swipeableView swipeTopViewToRight];
}



-(void)onSuperLike:(id)sender
{
    // [viewSingle removeFromSuperview];
    
    UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
    UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
    UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    
    [btnNope setHidden:YES];
    [btnLike setHidden:YES];
    [btnSupeLike setHidden:NO];
    
    
    [self.swipeableView swipeTopViewToUp];
}

-(void)DispSingle
{
    viewSingle=[[UIView alloc]initWithFrame:self.view.frame];
    viewSingle.backgroundColor=[UIColor whiteColor];
    //[self.view addSubview:viewSingle];
    
    viewSingle.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:viewSingle];
    
    [UIView animateWithDuration:0.40 animations:^{
        viewSingle.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        //   }
        //    completion:^(BOOL finished) {
        //        [UIView animateWithDuration:0.30 animations:^{
        //            viewSingle.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        //        } completion:^(BOOL finished) {
        //            [UIView animateWithDuration:0.30 animations:^{
        //                viewSingle.transform = CGAffineTransformIdentity;
        //            }];
        //       }];
    }];
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    scrollView.showsVerticalScrollIndicator=NO;
    [viewSingle addSubview:scrollView];
    
    
    NSDictionary *dictUsrData=[dictSnglFrnd valueForKey:@"user_data"];
    NSArray *arrSlidData=[dictSnglFrnd valueForKey:@"slider_data"];
    NSArray *arrDropData=[dictSnglFrnd valueForKey:@"drop_data"];
    
    
    
    int y=0;
    
    NSArray *arrImage=[dictUsrData valueForKey:@"images"];
    NSInteger pageCount=arrImage.count;
    
    
    imgScrlView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, (self.view.frame.size.height/2)+50)];
    imgScrlView.backgroundColor=[UIColor clearColor];
    imgScrlView.pagingEnabled=YES;
    imgScrlView.delegate=self;
    imgScrlView.contentSize=CGSizeMake(pageCount * imgScrlView.bounds.size.width , imgScrlView.bounds.size.height);
    [imgScrlView setShowsHorizontalScrollIndicator:NO];
    [imgScrlView setShowsVerticalScrollIndicator:NO];
    
    imgScrlView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleRemove:)];
    [imgScrlView addGestureRecognizer:singleTap];
    
    CGRect viewSize;//=imgScrlView.bounds;
    
    for (int nCountImg=0; nCountImg<arrImage.count; nCountImg++)
    {
        NSString *strImageURL=[arrImage objectAtIndex:nCountImg];
        
        if (nCountImg==0)
            viewSize=imgScrlView.bounds;
        else
            viewSize=CGRectOffset(viewSize, imgScrlView.bounds.size.width, 0);
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:viewSize];
        
        if ([strImageURL isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
        {
            imgView.image=[UIImage imageNamed:@"user.png"];
        }
        else
        {
            AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
            [async loadImageFromURL:[NSURL URLWithString:strImageURL]];
            [imgView addSubview:async];
        }
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgScrlView addSubview:imgView];
    }
    [scrollView addSubview:imgScrlView];
    
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((self.view.frame.size.width/2)-55,(self.view.frame.size.height/2)+30,110,20);
    pageControl.numberOfPages = pageCount;
    pageControl.currentPage = 0;
    pageControl.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:pageControl];
    
    
    y+=(self.view.frame.size.height/2)+70;
    
    NSString *strName=[dictUsrData valueForKey:@"name"];
    NSString *strAge=[dictUsrData valueForKey:@"age"];
    
    // yPos+=210;
    
    UILabel *lblNameAge=[[UILabel alloc]initWithFrame:CGRectMake(10, y, self.view.frame.size.width-70, 25 )];
    lblNameAge.text=[NSString stringWithFormat:@"%@ , %@",strName,strAge];
    [lblNameAge setFont:fontname18];
    lblNameAge.textColor=[UIColor blackColor];
    [scrollView addSubview:lblNameAge];
    
    
    UIButton *btnReportMenu=[UIButton buttonWithType:UIButtonTypeCustom];
    btnReportMenu.frame=CGRectMake(self.view.frame.size.width-50, y, 35, 35);
    UIImage *imgRM=[UIImage imageNamed:@"ReportMenu.png"];
    [btnReportMenu setBackgroundImage:imgRM forState:UIControlStateNormal];
    [btnReportMenu addTarget:self action:@selector(onReportMenu:) forControlEvents:UIControlEventTouchDown];
    btnReportMenu.layer.cornerRadius=25;
    btnReportMenu.clipsToBounds=YES;
    btnReportMenu.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:btnReportMenu];

    y+=30;
    
    if (![[dictUsrData valueForKey:@"company"] isEqualToString:@""])
    {
        
        UILabel *lblCompany=[[UILabel alloc]initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 25 )];
        lblCompany.text=[dictUsrData valueForKey:@"company"];
        [lblCompany setFont:fontname15];
        lblCompany.textColor=[UIColor blackColor];
        [scrollView addSubview:lblCompany];
        
        y+=30;
    }
    
    if (![[dictUsrData valueForKey:@"work"] isEqualToString:@""])
    {
        
        UILabel *lblWork=[[UILabel alloc]initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 25 )];
        lblWork.text=[dictUsrData valueForKey:@"work"];
        [lblWork setFont:fontname16];
        lblWork.textColor=[UIColor blackColor];
        [scrollView addSubview:lblWork];
        
        y+=30;
    }
    
    if (![[dictUsrData valueForKey:@"description"] isEqualToString:@""])
    {
        
        //            UILabel *lblDesc=[[UILabel alloc]initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 25 )];
        //            lblDesc.text=[dictUsrData valueForKey:@"description"];
        //            [lblDesc setFont:fontname16];
        //            lblDesc.textColor=[UIColor blackColor];
        //            lblDesc.numberOfLines=2;
        //            lblDesc.lineBreakMode=NSLineBreakByWordWrapping;
        //            [scrollView addSubview:lblDesc];
        //            y+=30;
        
        UILabel *lblDescription=[[UILabel alloc]initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 25 )];
        lblDescription.text=[dictUsrData valueForKey:@"description"];
        [lblDescription setFont:fontname16];
        lblDescription.textColor=[UIColor blackColor];
        lblDescription.textAlignment=NSTextAlignmentLeft;
        lblDescription.numberOfLines=10;
        lblDescription.lineBreakMode=NSLineBreakByWordWrapping;
        [scrollView addSubview:lblDescription];
        
        [lblDescription sizeToFit];
        int h=lblDescription.frame.size.height;
        y+=h+5;
        
        
    }
    //        if (![[dictSing valueForKey:@"distance"] isEqualToString:@""])
    //        {
    
    UILabel *lblDesc=[[UILabel alloc]initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 25 )];
    lblDesc.text=[NSString stringWithFormat:@"%@ km away",[dictUsrData valueForKey:@"distance"]];
    [lblDesc setFont:fontname16];
    lblDesc.textColor=[UIColor grayColor];
    [scrollView addSubview:lblDesc];
    y+=35;
    // }
    
    int btnHeight=0;
    
    if (arrDropData.count!=0)
    {
        
        
        UILabel *lblUserDetails=[[UILabel alloc]initWithFrame:CGRectMake(15, y, self.view.frame.size.width, 25)];
        lblUserDetails.text=@"User Details";
        [lblUserDetails setFont:fontname15_16];
        lblUserDetails.textColor=[UIColor blackColor];
        [scrollView addSubview:lblUserDetails];
        
        
        
        y+=35;
        
        
        
        {
            
            
            
            int indexOfLeftmostButtonOnCurrentLine = 0;
            
            NSMutableArray *buttons = [[NSMutableArray alloc] init];
            
            float runningWidth = 0.0f;
            
            float maxWidth =self.view.frame.size.width-30;
            
            float horizontalSpaceBetweenButtons = 15.0f;
            
            float verticalSpaceBetweenButtons = y;
            
            
            
            for (int i=0; i<arrDropData.count; i++) {
                
                NSDictionary *dictDrop=[arrDropData objectAtIndex:i];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                NSString *strQues=[dictDrop valueForKey:@"question"];
                NSString *strAns=[dictDrop valueForKey:@"option"];
                
                NSString *strQuesAns=[NSString stringWithFormat:@"   %@ : %@   ",strQues,strAns];
                
                [button setTitle:strQuesAns forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0] forState:UIControlStateNormal];
                
                
                // button.tag=[[dictLoc valueForKey:@"id"] intValue];
                
                //[button addTarget:self action:@selector(onOffer:) forControlEvents:UIControlEventTouchDownRepeat];
                
                //        [button setBackgroundImage:[UIImage imageNamed:@"b1.png"] forState:UIControlStateNormal];
                
                //        [button setBackgroundImage:[UIImage imageNamed:@"b2.png"] forState:UIControlStateSelected];
                
                //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
                
                //        button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                
                
                
                [button.layer setBorderWidth:1.0];
                
                button.layer.borderColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0].CGColor;
                
                //[button.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
                
                button.layer.cornerRadius = 3.0f;
                
                button.clipsToBounds = YES;
                
                [button.titleLabel setFont:fontname13];
                
                
                
                
                
                
                
                //        [layer setBorderWidth:1.0];
                
                //        [layer setBorderColor:[[UIColor grayColor] CGColor]];
                
                
                
                
                
                
                
                button.translatesAutoresizingMaskIntoConstraints = NO;
                
                [button sizeToFit];
                
                [scrollView addSubview:button];
                
                
                
                // check if first button or button would exceed maxWidth
                
                if ((i == 0) || (runningWidth + button.frame.size.width > maxWidth)) {
                    
                    // wrap around into next line
                    
                    runningWidth = button.frame.size.width;
                    
                    
                    
                    if (i== 0) {
                        
                        // first button (top left)
                        
                        // horizontal position: same as previous leftmost button (on line above)
                        
                        NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:horizontalSpaceBetweenButtons];
                        
                        [scrollView addConstraint:horizontalConstraint];
                        
                        
                        
                        // vertical position:
                        
                        NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop              multiplier:1.0f constant:verticalSpaceBetweenButtons];
                        
                        [scrollView addConstraint:verticalConstraint];
                        
                        
                        btnHeight=btnHeight+button.frame.size.height;
                        
                        
                    }
                    
                    else
                    {
                        
                        // put it in new line
                        
                        UIButton *previousLeftmostButton = [buttons objectAtIndex:indexOfLeftmostButtonOnCurrentLine];
                        
                        
                        
                        // horizontal position: same as previous leftmost button (on line above)
                        
                        NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousLeftmostButton attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
                        
                        [scrollView addConstraint:horizontalConstraint];
                        
                        
                        
                        // vertical position:
                        
                        NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousLeftmostButton attribute:NSLayoutAttributeBottom multiplier:1.0f constant:verticalSpaceBetweenButtons];
                        
                        [scrollView addConstraint:verticalConstraint];
                        
                        
                        
                        indexOfLeftmostButtonOnCurrentLine = i;
                        
                        btnHeight=btnHeight+button.frame.size.height;
                        
                    }
                    
                } else {
                    
                    // put it right from previous buttom
                    
                    runningWidth += button.frame.size.width + horizontalSpaceBetweenButtons;
                    
                    
                    
                    UIButton *previousButton = [buttons objectAtIndex:(i-1)];
                    
                    
                    
                    // horizontal position: right from previous button
                    
                    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousButton attribute:NSLayoutAttributeRight multiplier:1.0f constant:horizontalSpaceBetweenButtons];
                    
                    [scrollView addConstraint:horizontalConstraint];
                    
                    
                    
                    // vertical position same as previous button
                    
                    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousButton attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
                    
                    [scrollView addConstraint:verticalConstraint];
                    
                }
                
                
                
                [buttons addObject:button];
                
                verticalSpaceBetweenButtons = 10.0f;
                horizontalSpaceBetweenButtons = 10.0f;
                
            }
            
        }
        
        y+=btnHeight+35;
    }
    
    if (arrSlidData.count!=0)
    {
        
        UILabel *lblInterests=[[UILabel alloc]initWithFrame:CGRectMake(15, y, self.view.frame.size.width, 25)];
        lblInterests.text=@"Interests";
        [lblInterests setFont:fontname15_16];
        lblInterests.textColor=[UIColor blackColor];
        [scrollView addSubview:lblInterests];
        
        y+=35;
        
        btnHeight=0;
        
        {
            
            int indexOfLeftmostButtonOnCurrentLine = 0;
            
            NSMutableArray *buttons = [[NSMutableArray alloc] init];
            
            float runningWidth = 0.0f;
            
            float maxWidth =self.view.frame.size.width-30;
            
            float horizontalSpaceBetweenButtons = 15.0f;
            
            float verticalSpaceBetweenButtons = y;
            
            
            
            for (int i=0; i<arrSlidData.count; i++) {
                
                NSDictionary *dictSlider=[arrSlidData objectAtIndex:i];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                NSString *strQues=[dictSlider valueForKey:@"question"];
                NSString *strAns=[dictSlider valueForKey:@"slider_value"];
                
                NSString *strQuesAns=[NSString stringWithFormat:@"   %@ : %@   ",strQues,strAns];
                
                [button setTitle:strQuesAns forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0] forState:UIControlStateNormal];
                
                
                // button.tag=[[dictLoc valueForKey:@"id"] intValue];
                
                //[button addTarget:self action:@selector(onOffer:) forControlEvents:UIControlEventTouchDownRepeat];
                
                //        [button setBackgroundImage:[UIImage imageNamed:@"b1.png"] forState:UIControlStateNormal];
                
                //        [button setBackgroundImage:[UIImage imageNamed:@"b2.png"] forState:UIControlStateSelected];
                
                //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
                
                //        button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                
                
                
                [button.layer setBorderWidth:1.0];
                
                button.layer.borderColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0].CGColor;
                
                //[button.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
                
                button.layer.cornerRadius = 3.0f;
                
                button.clipsToBounds = YES;
                
                [button.titleLabel setFont:fontname13];
                
                
                
                
                
                
                
                //        [layer setBorderWidth:1.0];
                
                //        [layer setBorderColor:[[UIColor grayColor] CGColor]];
                
                
                
                
                
                
                
                button.translatesAutoresizingMaskIntoConstraints = NO;
                
                [button sizeToFit];
                
                [scrollView addSubview:button];
                
                
                
                // check if first button or button would exceed maxWidth
                
                if ((i == 0) || (runningWidth + button.frame.size.width > maxWidth)) {
                    
                    // wrap around into next line
                    
                    runningWidth = button.frame.size.width;
                    
                    
                    
                    if (i== 0) {
                        
                        // first button (top left)
                        
                        // horizontal position: same as previous leftmost button (on line above)
                        
                        NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:horizontalSpaceBetweenButtons];
                        
                        [scrollView addConstraint:horizontalConstraint];
                        
                        
                        
                        // vertical position:
                        
                        NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop              multiplier:1.0f constant:verticalSpaceBetweenButtons];
                        
                        [scrollView addConstraint:verticalConstraint];
                        
                        btnHeight=btnHeight+button.frame.size.height;
                        
                        
                        
                    } else {
                        
                        // put it in new line
                        
                        UIButton *previousLeftmostButton = [buttons objectAtIndex:indexOfLeftmostButtonOnCurrentLine];
                        
                        
                        
                        // horizontal position: same as previous leftmost button (on line above)
                        
                        NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousLeftmostButton attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
                        
                        [scrollView addConstraint:horizontalConstraint];
                        
                        
                        
                        // vertical position:
                        
                        NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousLeftmostButton attribute:NSLayoutAttributeBottom multiplier:1.0f constant:verticalSpaceBetweenButtons];
                        
                        [scrollView addConstraint:verticalConstraint];
                        
                        
                        
                        indexOfLeftmostButtonOnCurrentLine = i;
                        
                        btnHeight=btnHeight+button.frame.size.height;
                        
                    }
                    
                } else {
                    
                    // put it right from previous buttom
                    
                    runningWidth += button.frame.size.width + horizontalSpaceBetweenButtons;
                    
                    
                    
                    UIButton *previousButton = [buttons objectAtIndex:(i-1)];
                    
                    
                    
                    // horizontal position: right from previous button
                    
                    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousButton attribute:NSLayoutAttributeRight multiplier:1.0f constant:horizontalSpaceBetweenButtons];
                    
                    [scrollView addConstraint:horizontalConstraint];
                    
                    
                    
                    // vertical position same as previous button
                    
                    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousButton attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
                    
                    [scrollView addConstraint:verticalConstraint];
                    
                }
                
                
                
                [buttons addObject:button];
                
                verticalSpaceBetweenButtons = 10.0f;
                horizontalSpaceBetweenButtons = 10.0f;
                
            }
            
        }
        y+=btnHeight+25;
    }
    
    
    UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClose.frame=CGRectMake(0, self.view.frame.size.height-75, 60, 60);
    UIImage *imgCL=[UIImage imageNamed:@"white-dislike-icon.png"];
    [btnClose setBackgroundImage:imgCL forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(onSingleNope:) forControlEvents:UIControlEventTouchDown];
    //        [[btnClose layer]setBorderWidth:2.5];
    //        [[btnClose layer]setBorderColor:[UIColor grayColor].CGColor];
    btnClose.layer.cornerRadius=25;
    btnClose.clipsToBounds=YES;
    // btnClose.tag=[[dictSing valueForKey:@"user_id"]integerValue];
    btnClose.backgroundColor=[UIColor clearColor];
    [viewSingle addSubview:btnClose];
    
    [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        btnClose.frame = CGRectMake((self.view.frame.size.width/2)-105,self.view.frame.size.height-75, 60, 60);
    } completion:^(BOOL finished) {
        // your animation finished
    }];
    
    
    UIButton *btnLove=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLove.frame=CGRectMake((self.view.frame.size.width/2)-25, self.view.frame.size.height-75, 60, 60);
    UIImage *imgLV=[UIImage imageNamed:@"white-like-icon.png"];
    [btnLove setBackgroundImage:imgLV forState:UIControlStateNormal];
    [btnLove addTarget:self action:@selector(onSingleLike:) forControlEvents:UIControlEventTouchDown];
    //        [[btnLove layer]setBorderWidth:2.5];
    //        [[btnLove layer]setBorderColor:[UIColor grayColor].CGColor];
    btnLove.layer.cornerRadius=25;
    btnLove.clipsToBounds=YES;
    // btnLove.tag=[[dictSing valueForKey:@"user_id"]integerValue];
    btnLove.backgroundColor=[UIColor clearColor];
    [viewSingle addSubview:btnLove];
    
    
    UIButton *btnStar=[UIButton buttonWithType:UIButtonTypeCustom];
    btnStar.frame=CGRectMake(self.view.frame.size.width, self.view.frame.size.height-75, 60, 60);
    UIImage *imgST=[UIImage imageNamed:@"white-super-like-icon.png"];
    [btnStar setBackgroundImage:imgST forState:UIControlStateNormal];
    [btnStar addTarget:self action:@selector(onSingleSuperLike:) forControlEvents:UIControlEventTouchDown];
    //        [[btnStar layer]setBorderWidth:2.5];
    //        [[btnStar layer]setBorderColor:[UIColor grayColor].CGColor];
    btnStar.layer.cornerRadius=25;
    btnStar.clipsToBounds=YES;
    // btnStar.tag=[[dictSing valueForKey:@"user_id"]integerValue];
    btnStar.backgroundColor=[UIColor clearColor];
    [viewSingle addSubview:btnStar];
    
    [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        btnStar.frame = CGRectMake((self.view.frame.size.width/2)+55,self.view.frame.size.height-75, 60, 60);
    } completion:^(BOOL finished) {
        // your animation finished
    }];
    
    
    //        UIButton *btnSinRemove=[[UIButton alloc]initWithFrame:imgScrlView.frame];
    //        btnSinRemove.backgroundColor=[UIColor clearColor];
    //        [btnSinRemove addTarget:self action:@selector(onSingleRemove:) forControlEvents:UIControlEventTouchUpInside];
    //        [scrollView addSubview:btnSinRemove];
    
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, y+100);
    
}


-(void)onMessage:(id)sender
{
    //  [self performSegueWithIdentifier:@"BinderHome_Message" sender:self];
    
//        SWRevealViewController *reveal = self.revealViewController;
//        reveal.panGestureRecognizer.enabled = YES;
    
//    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
//    [self.view addGestureRecognizer:self.tapGestureRecognizer];
//    self.tapGestureRecognizer.enabled = NO;
//    self.revealViewController.delegate = self;
//    
//    SWRevealViewController *revealController = [self revealViewController];
//    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
//    [self.view addGestureRecognizer:revealController.tapGestureRecognizer];
 
    UIButton *btnBinder=(UIButton *)[viewNavBar viewWithTag:10000];
    UIButton *btnMessgae=(UIButton *)[viewNavBar viewWithTag:10001];
    
    btnBinder.selected=NO;
    btnMessgae.selected=YES;
    
    [self popZoomOut];
    
    UIViewController *vc1 = [self.childViewControllers lastObject];
    [vc1.view removeFromSuperview];
    [vc1 removeFromParentViewController];
    
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    BinderHome * vc = [storyboard instantiateViewControllerWithIdentifier:@"MessageView"];
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    
    //    viewMessage=[[UIView alloc]initWithFrame:self.view.frame];
    //    viewMessage.backgroundColor=[UIColor whiteColor];
    //
    //
    //    viewMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    //
    //    [self.view addSubview:viewMessage];
    //
    //    [UIView animateWithDuration:0.40 animations:^{
    //        viewMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    //        //   }
    //        //    completion:^(BOOL finished) {
    //        //        [UIView animateWithDuration:0.30 animations:^{
    //        //            viewMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    //        //        } completion:^(BOOL finished) {
    //        //            [UIView animateWithDuration:0.30 animations:^{
    //        //                viewMessage.transform = CGAffineTransformIdentity;
    //        //            }];
    //        //       }];
    //    }];
    //
    //    [scrollView removeFromSuperview];
    //    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height)];
    //    scrollView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //    [viewMessage addSubview:scrollView];
    
    
}





- (void)popZoomOut{
    [UIView animateWithDuration:0.5
                     animations:^{
                         viewSingle.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                         viewMatch.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                     } completion:^(BOOL finished) {
                         //viewSingle.hidden = TRUE;
                         [viewSingle removeFromSuperview];
                         [viewMatch removeFromSuperview];
                         
                         [vwSprLikDeny removeFromSuperview];
                         [imgSprLkDny removeFromSuperview];
                         [btnSpLk removeFromSuperview];
                         
                         [vwGetBinderPlus removeFromSuperview];
                         
                         [viewMessage removeFromSuperview];
                     }];
}

-(void)onMatch
{
    viewMatch=[[UIView alloc]initWithFrame:self.view.frame];
    //viewMatch.backgroundColor=[UIColor whiteColor];
    viewMatch.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    //[self.view addSubview:viewSingle];
    
    viewMatch.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:viewMatch];
    
    [UIView animateWithDuration:0.30 animations:^{
        viewMatch.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        //   }
        //    completion:^(BOOL finished) {
        //        [UIView animateWithDuration:0.30 animations:^{
        //            viewMatch.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        //        } completion:^(BOOL finished) {
        //            [UIView animateWithDuration:0.30 animations:^{
        //                viewMatch.transform = CGAffineTransformIdentity;
        //            }];
        //       }];
    }];
    
    int yP=(self.view.frame.size.height/2)-150;
    
    UIButton *btnItsMatch=[UIButton buttonWithType:UIButtonTypeCustom];
    btnItsMatch.frame=CGRectMake((self.view.frame.size.width/2)-100, yP, 200, 75);
    UIImage *imgItsMatch=[UIImage imageNamed:@"It’s a Match!.png"];
    [btnItsMatch setBackgroundImage:imgItsMatch forState:UIControlStateNormal];
    btnItsMatch.userInteractionEnabled=NO;
    [viewMatch addSubview:btnItsMatch];
    
    yP=(self.view.frame.size.height/2)-80;
    
    NSString *strName=[dictLike valueForKey:@"name"];
    
    UILabel *lblMsg=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-150, yP, 300, 25)];
    lblMsg.text=[NSString stringWithFormat:@"You and %@ have liked each other",strName];
    [lblMsg setFont:fontname13];
    lblMsg.textAlignment=NSTextAlignmentCenter;
    lblMsg.textColor=[UIColor whiteColor];
    [viewMatch addSubview:lblMsg];
    
    
    yP=(self.view.frame.size.height/2)-50;
    
    NSString *strImgMine=appDelegate.strPicture;
    UIImageView *imgMine=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-90, yP, 80, 80)];
    
    imgMine.image=[UIImage imageNamed:@"user.png"];
    
    if ([strImgMine isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
    {
        imgMine.image=[UIImage imageNamed:@"user.png"];
    }
    else
    {
        AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgMine.frame.size.width, imgMine.frame.size.height)];
        async.backgroundColor=[UIColor clearColor];
        [async loadImageFromURL:[NSURL URLWithString:strImgMine]];
        [imgMine addSubview:async];
    }
    imgMine.layer.cornerRadius = 40;
    imgMine.clipsToBounds = YES;
    
    [viewMatch addSubview:imgMine];
    
    // yP+=30;
    
    NSString *strImgFrnd=[dictLike valueForKey:@"picture"];
    UIImageView *imgFrnd=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)+10, yP, 80, 80)];
    
    imgFrnd.image=[UIImage imageNamed:@"user.png"];
    
    if ([strImgFrnd isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
    {
        imgFrnd.image=[UIImage imageNamed:@"user.png"];
    }
    else
    {
        AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgFrnd.frame.size.width, imgFrnd.frame.size.height)];
        async.backgroundColor=[UIColor clearColor];
        [async loadImageFromURL:[NSURL URLWithString:strImgFrnd]];
        [imgFrnd addSubview:async];
    }
    
    imgFrnd.layer.cornerRadius = 40;
    imgFrnd.clipsToBounds = YES;
    
    [viewMatch addSubview:imgFrnd];
    
    yP=self.view.frame.size.height/2+60;
    
    UIButton *btnSndMsg=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSndMsg.frame=CGRectMake((self.view.frame.size.width/2)-75, yP, 150, 40);
    UIImage *imgSndMsg=[UIImage imageNamed:@"Send message.png"];
    [btnSndMsg setBackgroundImage:imgSndMsg forState:UIControlStateNormal];
    [btnSndMsg addTarget:self action:@selector(onMessage:) forControlEvents:UIControlEventTouchDown];
    [viewMatch addSubview:btnSndMsg];
    
    yP+=60;
    
    UIButton *btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame=CGRectMake((self.view.frame.size.width/2)-37.5, yP, 75, 35);
    UIImage *imgBack=[UIImage imageNamed:@"Back.png"];
    [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onSingleRemove:) forControlEvents:UIControlEventTouchDown];
    [viewMatch addSubview:btnBack];
    
    
}


-(void)SuperLikeDeny
{
    vwSprLikDeny=[[UIView alloc]initWithFrame:self.view.frame];
    vwSprLikDeny.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    // vwSprLikDeny.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:vwSprLikDeny];
    
    //    [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        vwSprLikDeny.frame = CGRectMake((self.view.frame.size.width/2)-105,self.view.frame.size.height-60, 50, 50);
    //    } completion:^(BOOL finished) {
    //        // your animation finished
    //    }];
    
    // int yP=100;
    
    UIButton *btnClosePlus=[[UIButton alloc]initWithFrame:self.view.frame];
    btnClosePlus.backgroundColor=[UIColor clearColor];
    [btnClosePlus addTarget:self action:@selector(onSingleRemove:) forControlEvents:UIControlEventTouchDown];
    [vwSprLikDeny addSubview:btnClosePlus];
    
    
    UIView *viewDetails=[[UIView alloc]initWithFrame:CGRectMake(10, (self.view.frame.size.height/2)-125, self.view.frame.size.width-20, 250)];
    viewDetails.backgroundColor=[UIColor whiteColor];
    viewDetails.layer.cornerRadius = 8;
    viewDetails.clipsToBounds = YES;
    [vwSprLikDeny addSubview:viewDetails];
    
    
    NSString *strImgMine=[dictLike valueForKey:@"picture"];
    imgSprLkDny=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-60, 90, 120, 120)];
    
    imgSprLkDny.image=[UIImage imageNamed:@"user.png"];
    
    if ([strImgMine isEqualToString:@"http://api.datesauce.com/flamerui/img/user.png"])
    {
        imgSprLkDny.image=[UIImage imageNamed:@"user.png"];
    }
    else
    {
        AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgSprLkDny.frame.size.width, imgSprLkDny.frame.size.height)];
        async.backgroundColor=[UIColor clearColor];
        [async loadImageFromURL:[NSURL URLWithString:strImgMine]];
        [imgSprLkDny addSubview:async];
    }
    imgSprLkDny.layer.cornerRadius = 60;
    imgSprLkDny.clipsToBounds = YES;
    
    [self.view addSubview:imgSprLkDny];
    
    
    btnSpLk=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSpLk.frame=CGRectMake(self.view.frame.size.width/2-20, (self.view.frame.size.height/2)-145, 40, 40);
    UIImage *imgItsMatch=[UIImage imageNamed:@"SpLike.png"];
    [btnSpLk setBackgroundImage:imgItsMatch forState:UIControlStateNormal];
    btnSpLk.userInteractionEnabled=NO;
    btnSpLk.layer.cornerRadius = 20;
    btnSpLk.clipsToBounds = YES;
    [self.view addSubview:btnSpLk];
    
    
    int yP=85;
    
    UILabel *lblOut=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-150, yP, 300, 25)];
    lblOut.text=[NSString stringWithFormat:@"Out of Super Likes"];
    [lblOut setFont:fontname15];
    lblOut.textAlignment=NSTextAlignmentCenter;
    lblOut.textColor=[UIColor blackColor];
    [viewDetails addSubview:lblOut];
    
    yP+=25;
    
    UILabel *lbTime=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-150, yP, 300, 25)];
    lbTime.text=[NSString stringWithFormat:@"Until you get more Super Likes"];
    [lbTime setFont:fontname16];
    lbTime.textAlignment=NSTextAlignmentCenter;
    lbTime.textColor=[UIColor grayColor];
    [viewDetails addSubview:lbTime];
    
    
    
    
    yP+=40;
    
    NSString *strName=[dictLike valueForKey:@"name"];
    
    UILabel *lblMsg=[[UILabel alloc]initWithFrame:CGRectMake(10, yP, viewDetails.frame.size.width-20, 35)];
    lblMsg.text=[NSString stringWithFormat:@"Don't lose %@! Upgrade To Binder Plus to get more Super Likes now.",strName];
    [lblMsg setFont:fontname13];
    lblMsg.textAlignment=NSTextAlignmentCenter;
    lblMsg.textColor=[UIColor grayColor];
    lblMsg.numberOfLines=2;
    lblMsg.lineBreakMode=NSLineBreakByWordWrapping;
    [viewDetails addSubview:lblMsg];
    
    
    yP+=30;
    
    
    // yP+=30;
    
    
    
    UIButton *btnLLWait=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLLWait.frame=CGRectMake(0, viewDetails.frame.size.height-50, viewDetails.frame.size.width/2, 50);
    //    UIImage *imgSndMsg=[UIImage imageNamed:@"Send message.png"];
    //    [btnSndMsg setBackgroundImage:imgSndMsg forState:UIControlStateNormal];
    [btnLLWait setTitle:@"I'LL WAIT" forState:UIControlStateNormal];
    [btnLLWait setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnLLWait.backgroundColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    //[btnLLWait contentVerticalAlignment=[UIControlContentVerticalAlignmen]]
    [btnLLWait addTarget:self action:@selector(onSingleRemove:) forControlEvents:UIControlEventTouchDown];
    btnLLWait.titleLabel.font=fontname15_16;
    [viewDetails addSubview:btnLLWait];
    
    
    
    UIButton *btnGetPlus=[UIButton buttonWithType:UIButtonTypeCustom];
    btnGetPlus.frame=CGRectMake(viewDetails.frame.size.width/2, viewDetails.frame.size.height-50, viewDetails.frame.size.width/2, 50);
    //    UIImage *imgBack=[UIImage imageNamed:@"Back.png"];
    //    [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
    [btnGetPlus setTitle:@"GET PLUS" forState:UIControlStateNormal];
    btnGetPlus.titleLabel.font=fontname15_16;
    [btnGetPlus addTarget:self action:@selector(onGetAmount:) forControlEvents:UIControlEventTouchDown];
    btnGetPlus.backgroundColor=[UIColor colorWithRed:208/255.0 green:81/255.0 blue:48/255.0 alpha:1.0];
    [btnGetPlus setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
    [viewDetails addSubview:btnGetPlus];
    
    
}


-(void)GetBinderPlus
{
    vwGetBinderPlus=[[UIView alloc]initWithFrame:self.view.frame];
    vwGetBinderPlus.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [self.view addSubview:vwGetBinderPlus];
    
    //    [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        vwSprLikDeny.frame = CGRectMake((self.view.frame.size.width/2)-105,self.view.frame.size.height-60, 50, 50);
    //    } completion:^(BOOL finished) {
    //        // your animation finished
    //    }];
    
    
    
    UIButton *btnClosePlus=[[UIButton alloc]initWithFrame:self.view.frame];
    btnClosePlus.backgroundColor=[UIColor clearColor];
    [btnClosePlus addTarget:self action:@selector(onSingleRemove:) forControlEvents:UIControlEventTouchDown];
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
    [btnGetIt setTitle:@"Get It Now" forState:UIControlStateNormal];
    btnGetIt.titleLabel.font=fontname15_16;
    [btnGetIt addTarget:self action:@selector(onGetAmount:) forControlEvents:UIControlEventTouchDown];
    btnGetIt.backgroundColor=[UIColor colorWithRed:14/255.0 green:102/255.0 blue:255/255.0 alpha:1.0];
    [btnGetIt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewPlusInfo addSubview:btnGetIt];
    
    
}
-(void)onGetAmount:(id)sender
{
    strPaypalOpen=@"yes";
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=2;
    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
    
    [service executeWebserviceWithMethod1:METHOD_GET_PRO_AMOUNT withValues:strSend];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Action

-(IBAction)onReportMenu:(id)sender
{
    UIButton *btnCloseRptMenu=[[UIButton alloc]initWithFrame:self.view.frame];
   // [btnCloseRptMenu setBackgroundColor:[UIColor clearColor]];
    UIImage *imgBground=[UIImage imageNamed:@"btnReportBG.png"];
    [btnCloseRptMenu setBackgroundImage:imgBground forState:UIControlStateNormal];
    [btnCloseRptMenu addTarget:self action:@selector(onCloseRptMenu:) forControlEvents:UIControlEventTouchUpInside];
    btnCloseRptMenu.tag=13000;
    [self.view addSubview:btnCloseRptMenu];
    

    viewReport=[[UIView alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, 100)];
    viewReport.backgroundColor=[UIColor clearColor];
    [self.view addSubview:viewReport];
    
    [UIView animateWithDuration:0.45 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        viewReport.frame = CGRectMake(10, self.view.frame.size.height-95, self.view.frame.size.width-20, 95);
    } completion:^(BOOL finished) {
        // your animation finished
    }];
    
    
    
    UIButton *btnReport=[UIButton buttonWithType:UIButtonTypeCustom];
    btnReport.frame=CGRectMake(5, 5, viewReport.frame.size.width-10, 40);
    [btnReport setTitle:@"Report" forState:UIControlStateNormal];
    [btnReport setTitleColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnReport.titleLabel.font=fontname18;
    btnReport.layer.cornerRadius = 4;
    btnReport.clipsToBounds = YES;
    [btnReport addTarget:self action:@selector(onReport:) forControlEvents:UIControlEventTouchDown];
    [btnReport setBackgroundColor:[UIColor whiteColor]];
    [viewReport addSubview:btnReport];
    
    
    UIButton *btnCancelView=[UIButton buttonWithType:UIButtonTypeCustom];
    btnCancelView.frame=CGRectMake(5, 50,viewReport.frame.size.width-10, 40 );
    [btnCancelView setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancelView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnCancelView.titleLabel.font=fontname18;
    btnCancelView.layer.cornerRadius = 4;
    btnCancelView.clipsToBounds = YES;
    [btnCancelView addTarget:self action:@selector(onCloseRptMenu:) forControlEvents:UIControlEventTouchDown];
    [btnCancelView setBackgroundColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0]];
    [viewReport addSubview:btnCancelView];

}
-(IBAction)onCloseRptMenu:(id)sender
{
    UIButton *btnCloseRptMenu=(UIButton *)[self.view viewWithTag:13000];
    [btnCloseRptMenu removeFromSuperview];
    
    [viewReport removeFromSuperview];
}
-(IBAction)onReport:(id)sender
{
  
    NSString *strIdSing;
    if (nSlideCount<[appDelegate.strUserCount intValue])
    {
        NSDictionary *dictSing=[arrFrndsList objectAtIndex:nSlideCount];
        
        strIdSing=[dictSing valueForKey:@"user_id"];
    }
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=5;
    service.delegate=self;
    
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"block_id\":\"%@\"}",strid,strToken,strIdSing];
    
    [service executeWebserviceWithMethod:METHOD_BLOCK withValues:strValues];
}

-(IBAction)onRefresh:(id)sender
{
//    if ([appDelegate.strProUser boolValue]==true)
//    {
        nViewCardCount=0;
        webservice *service=[[webservice alloc]init];
        service.tag=1;
        service.delegate=self;
        

        
        NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"status\":\"%@\",\"last_id\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\"}",strid,strToken,@"reload",strUserId,appDelegate.strSwipeLat, appDelegate.strSwipeLong];
        
        [service executeWebserviceWithMethod:METHOD_SEARCH_FRIENDS withValues:strValues];
 
//    }
//    else
//    {
//        [self GetBinderPlus];
//        
//    }
    
    
}
-(IBAction)onSingle:(id)sender
{
    NSString *strIdSing;
    if (nSlideCount<[appDelegate.strUserCount intValue])
    {
        NSDictionary *dictSing=[arrFrndsList objectAtIndex:nSlideCount];
        
        strIdSing=[dictSing valueForKey:@"user_id"];
    }
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=4;
    service.delegate=self;
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"suggestion_id\":\"%@\"}",strid,strToken,strIdSing];
    
    [service executeWebserviceWithMethod:METHOD_SINGLE_FRIEND withValues:strValues];
}
-(IBAction)onSingleNope:(id)sender
{
    [viewSingle removeFromSuperview];
    
    NSLog(@"%d",nSlideCount);
    
    int nUsCnt=[appDelegate.strUserCount intValue];
    
    if (nSlideCount+1==nUsCnt)
    {
        [self.swipeableView discardAllViews];
    }
    [self onNope:nil];
}
-(IBAction)onSingleLike:(id)sender
{
    [viewSingle removeFromSuperview];
    [self onLike:nil];
}
-(IBAction)onSingleSuperLike:(id)sender
{
    [viewSingle removeFromSuperview];
    [self onSuperLike:nil];
}

-(IBAction)onSingleRemove:(id)sender
{
    [self popZoomOut];
    
    
}

-(IBAction)onBinder:(id)sender
{
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    self.tapGestureRecognizer.enabled = NO;
    self.revealViewController.delegate = self;
    
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [self.view addGestureRecognizer:revealController.tapGestureRecognizer];
    
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.SideBarButton setTarget: self.revealViewController];
//        [self.SideBarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    
    //    SWRevealViewController *reveal = self.revealViewController;
    //    reveal.panGestureRecognizer.enabled = NO;
    
    UIButton *btnBinder=(UIButton *)[viewNavBar viewWithTag:10000];
    UIButton *btnMessgae=(UIButton *)[viewNavBar viewWithTag:10001];
    
    btnBinder.selected=YES;
    btnMessgae.selected=NO;
    
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    
    if([appDelegate.is_from_push isEqualToString:@"yes"])
    {
            appDelegate.is_from_push=@"";
            [self viewWillAppear:YES];
       
        
    }

    
    
    
    
    
}


#pragma mark -
#pragma mark - WebSerivce Delegate

-(void)receivedErrorWithMessage:(NSString *)message
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    if (webServTag==1)
    {
    FLAnimatedImageView  *imageView1=(FLAnimatedImageView *)[self.view viewWithTag:4001];
    imageView1.hidden=YES;
    
        UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
        lblFinding.text=@"There's no one new around you.";
       
    
    }

    webServTag=0;
    
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
    
     webServTag=0;
    FLAnimatedImageView  *imageView1=(FLAnimatedImageView *)[self.view viewWithTag:4001];
    imageView1.hidden=YES;
    
//    UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
//    lblFinding.text=@"";
    
    if (webservice.tag==1)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
           

            
            [self.swipeableView discardAllViews];
            appDelegate.strUserCount=[dictResponse valueForKey:@"user_count"];
            arrFrndsList=[dictResponse valueForKey:@"user_data"];
            NSString *strCountUser=[NSString stringWithFormat:@"%@",appDelegate.strUserCount];
            if ([strCountUser isEqualToString:@"0"])
            {
                FLAnimatedImageView  *imageView1=(FLAnimatedImageView *)[self.view viewWithTag:4001];
                imageView1.hidden=YES;
                
                UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
                lblFinding.text=@"There's no one new around you.";

            }
            else
            {
                 [self onMakeViewCards];
            }
            
        }
        else
        {
            NSString *strErrCode=[NSString stringWithFormat:@"%@",[dictResponse valueForKey:@"error_code"]];
            
            if ([strErrCode isEqualToString:@"104"])
            {
                [self performSegueWithIdentifier:@"BinderHome_Login" sender:self];
                
                appDelegate.strIsLoggedOut=@"yes";
                
                appDelegate.strLoginStatus=@"LoggedOut";
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:appDelegate.strLoginStatus forKey:@"LoginStatus"];

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
            else  if ([strErrCode isEqualToString:@"301"])
            {
                FLAnimatedImageView  *imageView1=(FLAnimatedImageView *)[self.view viewWithTag:4001];
                imageView1.hidden=YES;
                
                UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
                lblFinding.text=@"There's no one new around you.";

                
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
    
    else  if (webservice.tag==2)
    {
         if ([[dictResponse valueForKey:@"success"] boolValue]==true)
         {
             strProAmount=[dictResponse valueForKey:@"amount"];
             [self onPayPal:nil];
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
            
        }
    }
    else  if (webservice.tag==4)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            dictSnglFrnd=dictResponse;
            [self DispSingle];
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

    else  if (webservice.tag==5)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            strReport=@"yes";
            
            UIButton *btnCloseRptMenu=(UIButton *)[self.view viewWithTag:13000];
            [btnCloseRptMenu removeFromSuperview];
            
            [viewReport removeFromSuperview];
            
            [self onSingleRemove:nil];
            
            [self.swipeableView swipeTopViewToLeft];
            
            // [self viewWillAppear:YES];
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
   else
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            
           dictLike=[dictResponse valueForKey:@"like"];
            
            if ([[dictLike valueForKey:@"match"] boolValue]==true)
            {
                [self onMatch];
            }
        }
        else
        {
            NSString *strErrNo=[NSString stringWithFormat:@"%@",[dictResponse valueForKey:@"error_code"]];
            
            if ([strErrNo isEqualToString:@"407"])
            {
                
                nSlideCount--;
                
                UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
                UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
                UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
                
                [btnNope setHidden:YES];
                [btnLike setHidden:YES];
                [btnSupeLike setHidden:YES];
                
                 [self.swipeableView rewind];
                [self SuperLikeDeny];
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
    

    
    
}


#pragma mark -
#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction
{
    NSLog(@"did swipe in direction: %zd", direction);
    NSLog(@"Slide Count: %d",nSlideCount);
     NSLog(@"View Count: %d",nViewCardCount);
  
    UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
    UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
   // UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    
    [btnNope setHidden:YES];
    [btnLike setHidden:YES];
    [btnSupeLike setHidden:YES];

    
    strUserId=[btnNope titleForState:UIControlStateNormal];
    
    NSString *strDir=[NSString stringWithFormat:@"%zd",direction];
    
    NSString *strLikeStatus;
    
    // 1.Like
    // 2.Nope
    // 3.Super Like
    
    
    if ([strDir isEqualToString:@"1"])
    {
        strLikeStatus=@"2";
    }
    else if ([strDir isEqualToString:@"2"])
    {
        strLikeStatus=@"1";
    }
    else if ([strDir isEqualToString:@"4"])
    {
        strLikeStatus=@"3";
    }
    webservice *service=[[webservice alloc]init];
    service.tag=nWebTag;
    service.delegate=self;
    
    
   NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"suggestion_id\":\"%@\",\"status\":\"%@\"}",strid,strToken,strUserId,strLikeStatus];
    
    if (![strReport isEqualToString:@"yes"])
    {
        [service executeWebserviceWithMethod:METHOD_LIKE withValues:strValues];
    }
    
    strReport=@"no";
    
    nWebTag++;
      nSlideCount++;
    
    int nUsCnt=[appDelegate.strUserCount intValue];
    
    if (nSlideCount==nUsCnt)
    {
        
        UIButton *btnClose=(UIButton *)[self.view viewWithTag:6001];
        UIButton *btnHeart=(UIButton *)[self.view viewWithTag:6002];
        UIButton *btnStar=(UIButton *)[self.view viewWithTag:6003];
        
        btnStar.userInteractionEnabled=NO;
        btnClose.userInteractionEnabled=NO;
        btnHeart.userInteractionEnabled=NO;
        
        UIImage *imgCL=[UIImage imageNamed:@"CloseDisa.png"];
        [btnClose setBackgroundImage:imgCL forState:UIControlStateNormal];
        
        UIImage *imgLV=[UIImage imageNamed:@"HeartDisa.png"];
        [btnHeart setBackgroundImage:imgLV forState:UIControlStateNormal];
        
        UIImage *imgST=[UIImage imageNamed:@"StarDisa.png"];
        [btnStar setBackgroundImage:imgST forState:UIControlStateNormal];
        
        UILabel *lblFinding=(UILabel *)[self.view viewWithTag:4002];
        lblFinding.text=@"";
        lblFinding.text=@"There's no one new around you.";
        
        // [self.swipeableView discardAllViews];
        
        UIView *viwCard=(CardView *)[swipeableView viewWithTag:nViewCardCount+11000];
        [viwCard removeFromSuperview];
        

    }
    
  
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
    
    UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
    UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
    UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    
    [btnNope setHidden:YES];
    [btnLike setHidden:YES];
    [btnSupeLike setHidden:YES];

    
}
//
//- (void)swipeableView:(ZLSwipeableView *)swipeableView
//  didStartSwipingView:(UIView *)view
//           atLocation:(CGPoint)location {
//   
//    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
//}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    
//   NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
    
    
  //  NSLog(@"Trans X: %f",translation.x);
//     NSLog(@"Trans Y: %f",translation.y);
    
 
    
    UIButton *btnLike=(UIButton *)[self.view viewWithTag:1000+nSlideCount];
    UIButton *btnSupeLike=(UIButton *)[self.view viewWithTag:2000+nSlideCount];
    UIButton *btnNope=(UIButton *)[self.view viewWithTag:3000+nSlideCount];
    
  //  strUserId=[btnNope titleForState:UIControlStateNormal];
    
    [btnNope setHidden:YES];
    [btnLike setHidden:YES];
    [btnSupeLike setHidden:YES];

    
    int nXTrans=translation.x;
    int nYTrans=translation.y;
    
    if (nXTrans<0)
    {
        nXTrans=-(nXTrans);
    }
    if (nYTrans<0)
    {
         nYTrans=-(nYTrans);
    }
    
    // NSLog(@"Trans Y: %d",nYTrans);
    
   
    
    if (nXTrans > nYTrans)
    {
  
        if (translation.x < 0)
        {
           
           
            NSLog(@"Swipe Left");
            
            [btnNope setHidden:NO];
            [btnLike setHidden:YES];
            [btnSupeLike setHidden:YES];
            
            
        }
        else if (translation.x > 0)
        {
            NSLog(@"Swipe Right");
            [btnNope setHidden:YES];
            [btnLike setHidden:NO];
            [btnSupeLike setHidden:YES];
            
        }
    }
    else
    {
         if (translation.y < 0)
        {
            NSLog(@"Swipe Top");
            [btnNope setHidden:YES];
            [btnLike setHidden:YES];
            [btnSupeLike setHidden:NO];
        }
    }
    
}

//- (void)swipeableView:(ZLSwipeableView *)swipeableView
//    didEndSwipingView:(UIView *)view
//           atLocation:(CGPoint)location {
//    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
//}

#pragma mark -
#pragma mark - ZLSwipeableViewDataSource

- (UIView *)previousViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    UIView *view = [self nextViewForSwipeableView:swipeableView];
    [self applyRandomTransform:view];
    return view;
}

- (void)applyRandomTransform:(UIView *)view {
    CGFloat width = self.swipeableView.bounds.size.width;
    CGFloat height = self.swipeableView.bounds.size.height;
    CGFloat distance = MAX(width, height);
    
    CGAffineTransform transform = CGAffineTransformMakeRotation([self randomRadian]);
    transform = CGAffineTransformTranslate(transform, distance, 0);
    transform = CGAffineTransformRotate(transform, [self randomRadian]);
    view.transform = transform;
}

- (CGFloat)randomRadian {
    return (random() % 360) * (M_PI / 180.0);
}

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView
{
    if (nViewCardCount<[appDelegate.strUserCount intValue])
    {
        NSDictionary *dictSingle=[arrFrndsList objectAtIndex:nViewCardCount];
        
        
        viewCard = [[CardView alloc] initWithFrame:CGRectMake(10, 10,self.view.frame.size.width-20, self.view.frame.size.height-230)];
        // viewCard.backgroundColor = [self colorForName:self.colors[self.colorIndex]];
        viewCard.backgroundColor = [UIColor whiteColor];
        //self.colorIndex++;
        viewCard.tag=nViewCardCount+11001;
//        [[viewCard layer]setBorderWidth:2.5];
//        [[viewCard layer]setBorderColor:[UIColor grayColor].CGColor];

        
        [swipeableView addSubview:viewCard];
        
        NSString *strImageURL=[dictSingle valueForKey:@"picture"];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, viewCard.frame.size.width-10, viewCard.frame.size.height-60)];
        
        imgView.image=[UIImage imageNamed:@"user.png"];
    
            if ([strImageURL isEqualToString:@""])
            {
                imgView.image=[UIImage imageNamed:@"user.png"];
            }
            else
            {
                AsyncImageView *async = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
                async.backgroundColor=[UIColor clearColor];
                [async loadImageFromURL:[NSURL URLWithString:strImageURL]];
                [imgView addSubview:async];
            }
       
        [viewCard addSubview:imgView];
        

        
        NSString *strName=[dictSingle valueForKey:@"name"];
        NSString *strAge=[dictSingle valueForKey:@"age"];
        
       // yPos+=210;
        
        UILabel *lblNameAge=[[UILabel alloc]initWithFrame:CGRectMake(10, viewCard.frame.size.height-55, viewCard.frame.size.width-20, 25 )];
        lblNameAge.text=[NSString stringWithFormat:@"%@, %@",strName,strAge];
        [lblNameAge setFont:fontname15_16];
        lblNameAge.textColor=[UIColor blackColor];
        [viewCard addSubview:lblNameAge];
        
        UILabel *lblWork=[[UILabel alloc]initWithFrame:CGRectMake(10, viewCard.frame.size.height-30, viewCard.frame.size.width-20, 25 )];
        lblWork.text=[dictSingle valueForKey:@"work"];
        [lblWork setFont:fontname16];
        lblWork.textColor=[UIColor blackColor];
        [viewCard addSubview:lblWork];
        
        
        UIButton *btnLIKE=[UIButton buttonWithType:UIButtonTypeCustom];
        btnLIKE.frame=CGRectMake(10, 20, 80, 50);
        UIImage *imgCL=[UIImage imageNamed:@"Like.png"];
        [btnLIKE setImage:imgCL forState:UIControlStateNormal];
        btnLIKE.userInteractionEnabled=NO;
        btnLIKE.hidden=YES;
        btnLIKE.tag=1000+nViewCardCount;
        [viewCard addSubview:btnLIKE];
        
        
        UIButton *btnSUPLIKE=[UIButton buttonWithType:UIButtonTypeCustom];
        btnSUPLIKE.frame=CGRectMake((viewCard.frame.size.width/2)-55, viewCard.frame.size.height-130, 110, 65);
        UIImage *imgLV=[UIImage imageNamed:@"SuperLike.png"];
        [btnSUPLIKE setImage:imgLV forState:UIControlStateNormal];
         btnSUPLIKE.userInteractionEnabled=NO;
        btnSUPLIKE.hidden=YES;
        btnSUPLIKE.tag=2000+nViewCardCount;
        [viewCard addSubview:btnSUPLIKE];
        
        
        UIButton *btnNOPE=[UIButton buttonWithType:UIButtonTypeCustom];
        btnNOPE.frame=CGRectMake(viewCard.frame.size.width-90, 20, 80, 50);
        UIImage *imgST=[UIImage imageNamed:@"Nope.png"];
        [btnNOPE setImage:imgST forState:UIControlStateNormal];
         btnNOPE.userInteractionEnabled=NO;
        btnNOPE.hidden=YES;
        btnNOPE.tag=3000+nViewCardCount;
        [btnNOPE setTitle:[dictSingle valueForKey:@"user_id"]  forState:UIControlStateNormal];
        [btnNOPE setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [viewCard addSubview:btnNOPE];

        
        UIButton *btnSingle=[[UIButton alloc]initWithFrame:viewCard.frame];
        btnSingle.backgroundColor=[UIColor clearColor];
        [btnSingle addTarget:self action:@selector(onSingle:) forControlEvents:UIControlEventTouchUpInside];
        [viewCard addSubview:btnSingle];

        nViewCardCount++;
    }

       return viewCard;
}


#pragma mark -
#pragma mark - PageControl Delegate

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
    
    [self popZoomOut];
    
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



#pragma mark -
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
    
    [self.navigationController popViewControllerAnimated:YES];
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
        
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        webservice *service=[[webservice alloc]init];
        service.tag=3;
        service.delegate=self;
        
        NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\",\"paid_status\":\"%@\",\"paypal_id\":\"%@\"}",strid, strToken, @"1", strpaypalid ];
        
        [service executeWebserviceWithMethod:METHOD_PAYPAL_PAYMENT_SUCCESS withValues:strValues];
        
    }
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}



#pragma mark - ()

//- (UIColor *)colorForName:(NSString *)name {
//    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
//    Class colorClass = [UIColor class];
//    return [colorClass performSelector:NSSelectorFromString(selectorString)];
//}

#pragma mark - SWRevealViewController Delegate Methods
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft)
    {
        self.view.userInteractionEnabled = YES;
    }
    else
    {
        self.view.userInteractionEnabled = NO;
        
        SWRevealViewController *revealController = self.revealViewController;
        [revealController.view addGestureRecognizer:revealController.panGestureRecognizer];
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft)
    {
        self.view.userInteractionEnabled = YES;
    }
    else
    {
        self.view.userInteractionEnabled = NO;
        
        SWRevealViewController *revealController = self.revealViewController;
        [revealController.view addGestureRecognizer:revealController.panGestureRecognizer];
    }
}



@end

