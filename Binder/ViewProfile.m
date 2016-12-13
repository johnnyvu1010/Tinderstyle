//
//  ViewProfile.m
//  Binder
//
//  Created by Admin on 02/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewProfile.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "MBProgressHUD.h"
#import "DiscoveryQuestionaries.h"
#import "EditProfile.h"
#import "LogIn.h"
#import "SWRevealViewController.h"

@interface ViewProfile ()
{
    AppDelegate *appDelegate;
    UIScrollView *imgScrlView;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSString *strid, *strToken;
    NSArray *arrSlider, *arrDropdown, *arrDrop_Ques, *arrSli_Ques;
    NSDictionary *dictUser, *dictDrop, *dictSlider;
     UIFont *fontname10, *fontname13,*fontname15,*fontname16, *fontname18, *fontname15_16;
    UIImage *newImage;
}
@end

@implementation ViewProfile

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
    lblNav.text=@"Profile";
    lblNav.textColor=[UIColor blackColor];
    lblNav.backgroundColor=[UIColor clearColor];
    [lblNav setFont:fontname18];

    self.navigationItem.titleView=lblNav;
    self.navigationController.navigationBar.translucent = NO;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    barBtn.tintColor=[UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:barBtn ];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];

    
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
     [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=1;
    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
    
    [service executeWebserviceWithMethod1:METHOD_GET_PROFILE withValues:strSend];

}

-(void)onPageLoad
{
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    
   
    
       int yPos=0;
    

    
     NSArray *arrImage=[dictUser valueForKey:@"images"];
    NSInteger pageCount=arrImage.count;
    
    
    imgScrlView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yPos, self.view.frame.size.width, (self.view.frame.size.height/2)+50)];
    imgScrlView.backgroundColor=[UIColor clearColor];
    imgScrlView.pagingEnabled=YES;
    imgScrlView.delegate=self;
    imgScrlView.contentSize=CGSizeMake(pageCount * imgScrlView.bounds.size.width , imgScrlView.bounds.size.height);
    [imgScrlView setShowsHorizontalScrollIndicator:NO];
    [imgScrlView setShowsVerticalScrollIndicator:NO];
    
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
        async.backgroundColor=[UIColor clearColor];
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
    
    NSString *strName=[dictUser valueForKey:@"username"];
    NSString *strAge=[dictUser valueForKey:@"age"];
    
    yPos+=(self.view.frame.size.height/2)+60;
    
    UILabel *lblNameAge=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30, 25)];
    lblNameAge.text=[NSString stringWithFormat:@"%@ , %@",strName,strAge];
    [lblNameAge setFont:fontname15_16];
    lblNameAge.textColor=[UIColor blackColor];
    [scrollView addSubview:lblNameAge];
    
    
    
    yPos+=30;
    
    UILabel *lblWork=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30, 25)];
    lblWork.text=[dictUser valueForKey:@"work"];
    [lblWork setFont:fontname15];
    lblWork.textColor=[UIColor grayColor];
    [scrollView addSubview:lblWork];
    
    
    yPos+=30;
    
//    UILabel *lblLine1=[[UILabel alloc]initWithFrame:CGRectMake(3, yPos, self.view.frame.size.width-6, 1)];
//    [[lblLine1 layer]setBorderWidth:1.0];
//    [[lblLine1 layer]setBorderColor:[UIColor grayColor].CGColor];
//    [scrollView addSubview:lblLine1];
//    
//    yPos+=5;

//    UILabel *lblHi=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
//    lblHi.text=[dictUser valueForKey:@"description"];
//    [lblHi setFont:fontname16];
//    lblHi.textColor=[UIColor grayColor];
////    [[lblHi layer]setBorderWidth:1.0];
////    [[lblHi layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
//    [scrollView addSubview:lblHi];
    
    UILabel *lblDescription=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30, 25)];
    lblDescription.text=[dictUser valueForKey:@"description"];
    [lblDescription setFont:fontname16];
    lblDescription.textColor=[UIColor grayColor];
    lblDescription.textAlignment=NSTextAlignmentLeft;
    lblDescription.numberOfLines=10;
    lblDescription.lineBreakMode=NSLineBreakByWordWrapping;
    [scrollView addSubview:lblDescription];
    
    [lblDescription sizeToFit];
    int h=lblDescription.frame.size.height;
    yPos+=h+10;


   // yPos+=35;
    
//    UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(3, yPos, self.view.frame.size.width-6, 1)];
//    [[lblLine layer]setBorderWidth:1.0];
//    [[lblLine layer]setBorderColor:[UIColor grayColor].CGColor];
//    [scrollView addSubview:lblLine];
//    
//    yPos+=5;



    UILabel *lblUserDetails=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
    lblUserDetails.text=@"User Details";
    [lblUserDetails setFont:fontname15_16];
    lblUserDetails.textColor=[UIColor blackColor];
    [scrollView addSubview:lblUserDetails];
    
    
    UIButton *btnEditQues=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, yPos, 50, 25)];
    [btnEditQues setTitle:@"Edit" forState:UIControlStateNormal];
    [btnEditQues setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnEditQues.titleLabel.font=fontname15;
    btnEditQues.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight ;
//    [[btnEditQues layer]setBorderWidth:1.0];
//    [[btnEditQues layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [btnEditQues addTarget:self action:@selector(onEditQues:) forControlEvents:UIControlEventTouchDown];
    [btnEditQues setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:btnEditQues];
    

    
    yPos+=35;
    
    int btnHeight=0;
    
    {
        
        

    int indexOfLeftmostButtonOnCurrentLine = 0;
    
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
    float runningWidth = 0.0f;
    
    float maxWidth =self.view.frame.size.width-30;
    
    float horizontalSpaceBetweenButtons = 15.0f;
    
    float verticalSpaceBetweenButtons = yPos;
    
    
    
    for (int i=0; i<arrDropdown.count; i++) {
        
       dictDrop=[arrDropdown objectAtIndex:i];
        
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
    
    yPos+=btnHeight+35;
    
    UILabel *lblInterests=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
    lblInterests.text=@"Interests";
    [lblInterests setFont:fontname15_16];
    lblInterests.textColor=[UIColor blackColor];
    [scrollView addSubview:lblInterests];
    
    yPos+=35;
    
    btnHeight=0;
    
    {
        
        int indexOfLeftmostButtonOnCurrentLine = 0;
        
        NSMutableArray *buttons = [[NSMutableArray alloc] init];
        
        float runningWidth = 0.0f;
        
        float maxWidth =self.view.frame.size.width-30;
        
        float horizontalSpaceBetweenButtons = 15.0f;
        
        float verticalSpaceBetweenButtons = yPos;
        
        
        
        for (int i=0; i<arrSlider.count; i++) {
            
            dictSlider=[arrSlider objectAtIndex:i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSString *strQues=[dictSlider valueForKey:@"question"];
            NSString *strAns=[dictSlider valueForKey:@"silder_value"];
            
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
    yPos+=btnHeight+25;
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, yPos+30);
    
}
-(void)onBack
{
    [self performSegueWithIdentifier:@"ViewProfile_Home" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - PageControl

- (void)scrollViewDidScroll:(UIScrollView *)scrollView1{
    
    CGFloat viewWidth = scrollView1.frame.size.width;
    // content offset - tells by how much the scroll view has scrolled.
    
    int pageNumber = floor((scrollView1.contentOffset.x - viewWidth/50) / viewWidth) +1;
    
    pageControl.currentPage=pageNumber;
    
}

- (void)pageChanged {
    
    NSInteger pageNumber = pageControl.currentPage;
    
    CGRect frame = imgScrlView.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [imgScrlView scrollRectToVisible:frame animated:YES];
}

#pragma mark -
#pragma mark - Actions

-(IBAction)onEditProfile:(id)sender
{
    appDelegate.strEidtBtnClicked=@"yes";
    [self performSegueWithIdentifier:@"ViewProfile_EditProfile" sender:self];
    
}

-(IBAction)onEditQues:(id)sender
{
    
     appDelegate.strEidtBtnClicked=@"yes";
    
    [self performSegueWithIdentifier:@"ViewProfile_DisQues" sender:self];
    
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
    
    if (webservice.tag==1)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
        arrSlider=[dictResponse valueForKey:@"slider"];
        arrDropdown=[dictResponse valueForKey:@"dropdown"];
         dictUser=[dictResponse valueForKey:@"user"];
        arrDrop_Ques=[dictResponse valueForKey:@"dropdown_question"];
            arrSli_Ques=[dictResponse valueForKey:@"slider_question"];
            appDelegate.strGender=[dictUser valueForKey:@"gender"];
            NSLog(@"%@",appDelegate.strGender);
            
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
    if (webservice.tag==2)
    {
        if ([[dictResponse valueForKey:@"success"] boolValue]==true)
        {
            
            appDelegate.strAppState=@"";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:appDelegate.strAppState forKey:@"AppStatus"];
            
            
            
            [self performSegueWithIdentifier:@"DisCoveryQues_Home" sender:self];
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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier]isEqualToString:@"ViewProfile_EditProfile"])
    {
        EditProfile *EditPro=[segue destinationViewController];
        EditPro.dictUser=dictUser;
    }
    
    else if ([[segue identifier]isEqualToString:@"ViewProfile_DisQues"])
    {
        
        DiscoveryQuestionaries *disQues=[segue destinationViewController];
        disQues.arrSli=arrSlider;
        disQues.arrDr=arrDropdown;
        disQues.arrDrop_Ques=arrDrop_Ques;
        disQues.arrSli_Ques=arrSli_Ques;
    }

    
}



@end
