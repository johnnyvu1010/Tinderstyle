//
//  DiscoveryQuestionaries.m
//  Binder
//
//  Created by Admin on 27/05/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DiscoveryQuestionaries.h"
#import "PICircularProgressView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LogIn.h"
#import "SWRevealViewController.h"

@interface DiscoveryQuestionaries ()
{
    UIScrollView *scrollView;
    UITextField *currentTextView;
    UITextView *currentTextView1;
    bool keyboardIsShown;
    UITapGestureRecognizer *tapGesture;
    AppDelegate *appDelegate;
     UITableView *tableFavourite;
    int nBtnTag;
    NSArray *arrFavourite, *arrSlider, *arrDropdown;
    NSArray *arrQuesAns;
    UIView *viewContentTable;
    UIView *viewContentBtn;
    int nTag;
    NSString *strid, *strToken;
    UIFont *fontname15,*fontname16, *fontname18, *fontname15_16;

}
@end

@implementation DiscoveryQuestionaries
@synthesize updProfResp;
@synthesize arrDr;
@synthesize arrSli;
@synthesize arrDrop_Ques;
@synthesize arrSli_Ques;

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    // [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];

    fontname15 = [UIFont fontWithName:@"Roboto-Regular" size:15];
    fontname15_16 = [UIFont fontWithName:@"Roboto-Medium" size:16];
    fontname16 = [UIFont fontWithName:@"Roboto" size:16];
    fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
         [[self navigationController] setNavigationBarHidden:NO animated:YES];
        // self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
        // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
        
        UILabel *lblNav=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        lblNav.text=@"Discovery Questionaries";
        lblNav.textColor=[UIColor blackColor];
        lblNav.backgroundColor=[UIColor clearColor];
        [lblNav setFont:fontname18];
        
        self.navigationItem.titleView=lblNav;
        self.navigationController.navigationBar.translucent = NO;
        
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackButtonArrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
        barBtn.tintColor=[UIColor blackColor];
        [self.navigationItem setLeftBarButtonItem:barBtn ];


        [self onPageLoad];
    }
    else
    {

    [[self navigationController] setNavigationBarHidden:YES animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        strid=[defaults valueForKey:@"id"];
        strToken=[defaults valueForKey:@"token"];
        
//        strid=@"141";
//        strToken=@"2y10SImH72pvQamokRDdjfm3uFeJWZd70nLNNcOfiUo729fJA0lMBO6";
        
        
        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
        tapRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapRecognizer];
        
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        webservice *service=[[webservice alloc]init];
        service.delegate=self;
        service.tag=1;
        NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
        
        [service executeWebserviceWithMethod1:METHOD_GET_QUESTIONS withValues:strSend];

    }
    
    
    
   
    
}

-(void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onPageLoad
{
    int y=0;
    if (![appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
    UITextField *txtEP=[[UITextField alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
    txtEP.text=@" Discovery Questionaries";
    txtEP.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    txtEP.textAlignment=NSTextAlignmentCenter;
    txtEP.userInteractionEnabled=NO;
    [txtEP setFont:fontname18];
    txtEP.textColor=[UIColor blackColor];
        [[txtEP layer]setBorderWidth:1.0];
    [[txtEP layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [self.view addSubview:txtEP];
        y+=40;
        
    }
    
    [scrollView removeFromSuperview];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.view addSubview:scrollView];
    
    int yPos=0;
    
    UITextField *txtInterests=[[UITextField alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 30)];
    txtInterests.text=@"Interests";
   // [[txtInterests layer]setBorderWidth:1.0];
    txtInterests.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    txtInterests.userInteractionEnabled=NO;
    [txtInterests setFont:fontname15_16];
    //[[txtInterests layer]setBorderColor:[UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0].CGColor];
    [scrollView addSubview:txtInterests];
    
    yPos+=30;
    
    UILabel *lblLine1=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30, 1)];
    [[lblLine1 layer]setBorderWidth:1.0];
    [[lblLine1 layer]setBorderColor:[UIColor grayColor].CGColor];
    [scrollView addSubview:lblLine1];
    
    yPos+=5;

    
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        arrSlider=arrSli;
    }
   
    
    for (int i=1; i<=arrSlider.count; i++)
    {
         NSDictionary *dictSlider=[arrSlider objectAtIndex:i-1];
    
    {
        
        UILabel *lblQuesName=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
        lblQuesName.text=[dictSlider valueForKey:@"question"];
        [lblQuesName setFont:fontname15];
        lblQuesName.textColor=[UIColor blackColor];
        [scrollView addSubview:lblQuesName];
        
          NSInteger strValue=[[dictSlider valueForKey:@"silder_value"]integerValue];
        
       UILabel *lblValue=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, yPos, 50, 25)];
        [lblValue setFont:fontname15];
        lblValue.textAlignment=NSTextAlignmentRight;
        lblValue.textColor=[UIColor blackColor];
        lblValue.tag=i;
        //lblValue.text=[NSString stringWithFormat:@"%ld.00",(long)strValue];
        lblValue.text=[NSString stringWithFormat:@"%ld",(long)strValue];
        [scrollView addSubview:lblValue];
        
        yPos+=30;
        
        
        UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
        viewContent.backgroundColor = [UIColor whiteColor];
        viewContent.layer.shadowOpacity = 0.6f;
        viewContent.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
        viewContent.layer.shadowRadius = 2.0f;
        viewContent.layer.cornerRadius = 2.5f;
        viewContent.tag=123;
        [scrollView addSubview:viewContent];
        
        
        CGRect frame = CGRectMake(5, 7.5, viewContent.frame.size.width-10, 30);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 0.00;
        slider.maximumValue = 10.00;
        slider.continuous = YES;
        slider.value = strValue;
        slider.tag=500+i;
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
        
        yPos+=60;
    }

}

    
    UITextField *txtFavourites=[[UITextField alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 30)];
    txtFavourites.text=@"Favourites";
    // [[txtFavourites layer]setBorderWidth:1.0];
    txtFavourites.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    txtFavourites.userInteractionEnabled=NO;
    [txtFavourites setFont:fontname15_16];
    // [[txtFavourites layer]setBorderColor:[UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0].CGColor];
    [scrollView addSubview:txtFavourites];
    
    yPos+=30;
    
    UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30, 1)];
    [[lblLine layer]setBorderWidth:1.0];
    [[lblLine layer]setBorderColor:[UIColor grayColor].CGColor];
    [scrollView addSubview:lblLine];
    
    yPos+=5;
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        if (arrDr.count==0)
        {
            arrDropdown=arrDrop_Ques;
        }
        else
        {
        arrDropdown=arrDr;
        }
    }

    
    for (int j=1; j<=arrDropdown.count; j++)
    {
        
        NSDictionary *dictDrop=[arrDropdown objectAtIndex:j-1];
       
        
        {
            
            UILabel *lblQuesName=[[UILabel alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width, 25)];
            lblQuesName.text=[dictDrop valueForKey:@"question"];;
            [lblQuesName setFont:fontname15];
            lblQuesName.textColor=[UIColor blackColor];
            [scrollView addSubview:lblQuesName];
            
            yPos+=30;
            
            
            viewContentBtn = [[UIView alloc] initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30,45)];
            viewContentBtn.backgroundColor = [UIColor whiteColor];
            viewContentBtn.layer.shadowOpacity = 0.6f;
            viewContentBtn.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
            viewContentBtn.layer.shadowRadius = 2.0f;
            viewContentBtn.layer.cornerRadius = 2.5f;
            viewContentBtn.tag=j;
            [scrollView addSubview:viewContentBtn];
            
            UIButton *btnQuesAns=[UIButton buttonWithType:UIButtonTypeCustom];
            btnQuesAns.frame=CGRectMake(5, 7.5, viewContentBtn.frame.size.width-10, 30);
           // btnQuesAns.frame=CGRectMake(15, yPos, self.view.frame.size.width-30,45);
            UIImage *imgSelect=[UIImage imageNamed:@"ButtonSelect.png"];
            [btnQuesAns setBackgroundImage:imgSelect forState:UIControlStateNormal];
            [btnQuesAns setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnQuesAns.titleLabel.font=fontname16;
            btnQuesAns.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            btnQuesAns.tag=1000+j;
            [btnQuesAns addTarget:self action:@selector(onFavClick:forEvent:) forControlEvents:UIControlEventTouchDown];
            
            if (arrDr.count==0)
            {
                 [btnQuesAns setTitle:@"  Choose your option" forState:UIControlStateNormal];
            }
            else
            {
                if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
                {
                    NSString *strDisp=[NSString stringWithFormat:@"  %@",[dictDrop valueForKey:@"option"]];
                
                    [btnQuesAns setTitle:strDisp forState:UIControlStateNormal];
                }
                else
                {
                    [btnQuesAns setTitle:@"  Choose your option" forState:UIControlStateNormal];
                }
            }
            
            
            [viewContentBtn addSubview:btnQuesAns];
            
            yPos+=60;
        }
        
    }
    
    UIButton *btnMatch=[UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        btnMatch.frame=CGRectMake(0, self.view.frame.size.height-85, self.view.frame.size.width, 45);
    }
    else
    {
         btnMatch.frame=CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 45);
    }
    
   
    [btnMatch setTitle:@"Start Match!" forState:UIControlStateNormal];
    [btnMatch setTitleColor:[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnMatch.titleLabel.font=fontname18;
    [[btnMatch layer]setBorderWidth:1.0];
    [[btnMatch layer]setBorderColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor];
    [btnMatch addTarget:self action:@selector(onStartMatch:) forControlEvents:UIControlEventTouchDown];
    [btnMatch setBackgroundColor:[UIColor whiteColor]];
    
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        [btnMatch setTitle:@"Save" forState:UIControlStateNormal];
    }
    else
    {
      [btnMatch setTitle:@"Start Match!" forState:UIControlStateNormal];
    }
    
    [self.view addSubview:btnMatch];
    
    scrollView.contentSize=CGSizeMake(self.view.frame.size.width, yPos+170);
}
-(void)tapGes
{
    [viewContentTable removeFromSuperview];
}
-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    NSInteger value = lroundf(slider.value);
    
    NSInteger nValue=slider.tag;
    // NSString *strSliderVal=[NSString stringWithFormat:@"%ld.00",(long)value];
    
    NSString *strSliderVal=[NSString stringWithFormat:@"%ld",(long)value];
    
    UILabel *lblValue=(UILabel *)[scrollView viewWithTag:nValue-500];
    lblValue.text=strSliderVal;
    [slider setValue:value animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Actions
- (IBAction)onFavClick:(id)sender forEvent:(UIEvent*)event
{
    UIButton *btn=(UIButton *)sender;
    
       UIView *View = (UIView *)sender;
    UITouch *touch = [[event touchesForView:View] anyObject];
    CGPoint location = [touch locationInView:self.view];
    NSLog(@"Location in button: %f, %f", location.x, location.y);
    
    nBtnTag=btn.tag;
    
    [viewContentTable removeFromSuperview];
    
    viewContentTable = [[UIView alloc] initWithFrame:CGRectMake(20, location.y-75, self.view.frame.size.width-40, 150)];
    viewContentTable.backgroundColor = [UIColor whiteColor];
    viewContentTable.layer.shadowOpacity = 0.6f;
    viewContentTable.layer.shadowOffset = CGSizeMake(0.4f, 0.4f);
    viewContentTable.layer.shadowRadius = 2.0f;
    viewContentTable.layer.cornerRadius = 2.5f;
    viewContentTable.tag=123;
    [self.view addSubview:viewContentTable];
    
    tableFavourite=[[UITableView alloc]initWithFrame:CGRectMake(5, 10, viewContentTable.frame.size.width-10, viewContentTable.frame.size.height-20)];
    tableFavourite.delegate=self;
    tableFavourite.dataSource=self;
    tableFavourite.separatorStyle=UITableViewCellSeparatorStyleNone;
    [viewContentTable addSubview:tableFavourite];
    
    

}


-(IBAction)onStartMatch:(id)sender
{
    NSString *strSlider, *strDropDown;
    
    strSlider=@"";
    strDropDown=@"";
    
    for (int m=1; m<=arrSlider.count; m++)
    {
        NSDictionary *dictSli;
        
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
            dictSli=[arrSli_Ques objectAtIndex:m-1];
        }
        else
        {
          dictSli=[arrSlider objectAtIndex:m-1];
        }
        
        UISlider *slider=(UISlider *) [scrollView viewWithTag:m+500];
        NSString *strCode=[dictSli valueForKey:@"code"];
        int nSliVal=slider.value;
        
        if (nSliVal==0)
        {
             NSString *strQuestion=[dictSli valueForKey:@"question"];
            NSString *strMesg=[NSString stringWithFormat:@"Please give a value for %@",strQuestion];
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:strMesg preferredStyle:UIAlertControllerStyleAlert];
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
        NSString *strQuesId=[NSString stringWithFormat:@"%d",nSliVal];
       
       //  NSString *strLoopVal=[NSString stringWithFormat:@"{\"%@\":\"%@\"}",strCode,strQuesId];
        
         NSString *strLoopVal=[NSString stringWithFormat:@"\"%@\":\"%@\"",strCode,strQuesId];
        
        strSlider=[NSString stringWithFormat:@"%@,%@",strSlider,strLoopVal];
        
       //  NSLog(@"Request Slider: %@",strSlider);
        
    }
    
    
    for (int n=1; n<=arrDropdown.count; n++)
    {
        NSDictionary *dictDrop;
        
        if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
        {
           dictDrop=[arrDrop_Ques objectAtIndex:n-1];
        }
        else
        {
            
         dictDrop=[arrDropdown objectAtIndex:n-1];
        }
        
         NSString *strCode1=[dictDrop valueForKey:@"code"];
        
        UIButton *btnQuesAns=(UIButton *)[scrollView viewWithTag:1000+n];
        NSString *strBtnText=[btnQuesAns titleForState:UIControlStateNormal];
        
        if (![strBtnText isEqualToString:@"  Choose your option"])
        {
            NSString *strToTrim =strBtnText ;
            NSString *strAftTrim = [strToTrim stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSArray *arrOpt=[dictDrop valueForKey:@"option"];
            
            for (int o=1; o<=arrOpt.count; o++)
            {
                NSDictionary *dictOpt=[arrOpt objectAtIndex:o-1];
                if ([strAftTrim isEqualToString:[dictOpt valueForKey:@"option_name"]])
                {
                     NSString *strQuesId1=[dictOpt valueForKey:@"option_id"];
                    
                    NSString *strLoopVal1=[NSString stringWithFormat:@"\"%@\":\"%@\"",strCode1,strQuesId1];
                    
                    strDropDown=[NSString stringWithFormat:@"%@,%@",strDropDown,strLoopVal1];
                    
                    NSLog(@"Request Slider: %@",strDropDown);
                    
                }
                
                
            }
        }
        else
        {
            NSString *strQuestion=[dictDrop valueForKey:@"question"];
            NSString *strMesg=[NSString stringWithFormat:@"Please give answer for %@",strQuestion];
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Binder" message:strMesg preferredStyle:UIAlertControllerStyleAlert];
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
        
    }
 
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.tag=2;
    service.delegate=self;
    
  
    
    NSString *strValues=[NSString stringWithFormat:@"{\"id\":\"%@\",\"token\":\"%@\"%@%@}",strid,strToken,strSlider,strDropDown];
    
     NSLog(@"Request FINAL: %@",strValues);
    
   [service executeWebserviceWithMethod:METHOD_POST_ANSWERS withValues:strValues];


}


#pragma mark -
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
            
            if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
            {
                appDelegate.strEidtBtnClicked=@"no";
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
            appDelegate.strAppState=@"";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:appDelegate.strAppState forKey:@"AppStatus"];
                
                
                [defaults setValue:[dictResponse valueForKey:@"email"] forKey:@"email"];
                [defaults setValue:[dictResponse valueForKey:@"id"] forKey:@"id"];
                [defaults setValue:[dictResponse valueForKey:@"name"] forKey:@"name"];
                [defaults setValue:[dictResponse valueForKey:@"picture"] forKey:@"picture"];
                [defaults setValue:[dictResponse valueForKey:@"token"] forKey:@"token"];
                [defaults setValue:[dictResponse valueForKey:@"status"] forKey:@"status"];
                [defaults setValue:[dictResponse valueForKey:@"pro_user"] forKey:@"ProUser"];
                
                
                appDelegate.strEmail=[dictResponse valueForKey:@"email"];
                appDelegate.strID=[dictResponse valueForKey:@"id"];
                appDelegate.strName=[dictResponse valueForKey:@"name"];
                appDelegate.strPicture=[dictResponse valueForKey:@"picture"];
                appDelegate.strToken=[dictResponse valueForKey:@"token"];
                appDelegate.strSattus=[dictResponse valueForKey:@"status"];
                appDelegate.strProUser=[dictResponse valueForKey:@"pro_user"];
                appDelegate.strIsLoggedOut=@"no";
                
                appDelegate.strLoginStatus=@"LoggedIn";
                [defaults setValue:appDelegate.strLoginStatus forKey:@"LoginStatus"];
        
                [self performSegueWithIdentifier:@"DisCoveryQues_Home" sender:self];
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
#pragma mark - TableView Delagate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  35;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long retVal=0;
    if ([appDelegate.strEidtBtnClicked isEqualToString:@"yes"])
    {
        for (int k=1; k<=arrDrop_Ques.count; k++)
        {
            NSDictionary *dictDrop=[arrDrop_Ques objectAtIndex:k-1];
            
            if (nBtnTag==1000+k)
            {
                arrQuesAns=[dictDrop valueForKey:@"option"];
                retVal= arrQuesAns.count;
            }
        }

    }
    else
    {
    
        for (int k=1; k<=arrDropdown.count; k++)
        {
            NSDictionary *dictDrop=[arrDropdown objectAtIndex:k-1];
    
            if (nBtnTag==1000+k)
            {
                 arrQuesAns=[dictDrop valueForKey:@"option"];
                retVal= arrQuesAns.count;
            }
        }
    
    }

    return retVal;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        
    }
    
    NSString *strValue;
    NSDictionary *dictOptName;
    
    
    dictOptName=[arrQuesAns objectAtIndex:indexPath.row];
    strValue=[dictOptName valueForKey:@"option_name"];
    
    cell.textLabel.text=strValue;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=fontname16;
    cell.textLabel.textColor=[UIColor colorWithRed:3/255.0 green:126/255.0 blue:112/255.0 alpha:1.0];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [recognizer setNumberOfTapsRequired:1];
    //  scrollView.userInteractionEnabled = YES;
    [cell addGestureRecognizer:recognizer];

    
    return cell;
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UIButton *btnQuesAns=(UIButton *)[scrollView viewWithTag:nBtnTag];
//    
//    NSString *strPicked=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
//    
//    NSString *strValue=[NSString stringWithFormat:@"  %@",strPicked];
//    
//    [btnQuesAns setTitle:strValue forState:UIControlStateNormal];
//    
//    [viewContentTable removeFromSuperview];
//    tableFavourite.hidden=YES;
//}


-(void)gestureAction:(UITapGestureRecognizer *) sender
{
     UIButton *btnQuesAns=(UIButton *)[scrollView viewWithTag:nBtnTag];
    
    
    CGPoint touchLocation = [sender locationOfTouch:0 inView:tableFavourite];
    NSIndexPath *indexPath = [tableFavourite indexPathForRowAtPoint:touchLocation];
    
    NSString *strPicked=[tableFavourite cellForRowAtIndexPath:indexPath].textLabel.text;
      NSString *strValue=[NSString stringWithFormat:@"  %@",strPicked];
    
    [btnQuesAns setTitle:strValue forState:UIControlStateNormal];
    
     [viewContentTable removeFromSuperview];
    [tableFavourite removeFromSuperview];
    
    // NSDictionary *dictLocal=[arrListAllPub objectAtIndex:indexPath.row];
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


