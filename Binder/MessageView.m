//
//  MessageView.m
//  Binder
//
//  Created by Admin on 22/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MessageView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "AsyncImageView.h"
#import "LogIn.h"
#import "SWRevealViewController.h"
#import "ChatView.h"


@interface MessageView ()
{
    UIView *viewMessage, *viewNoMsgsMatches;
    UIScrollView *sclVwMatches;
    UITableView *tableMessgaes;
     NSString *strid, *strToken, *strSattus;
     AppDelegate *appDelegate;
    NSArray *arrNewMatches, *arrMessages;
     UIFont *fontname13, *fontname14,*fontname15,*fontname17, *fontname18, *fontname15_16;
    
    NSString *strReciverID,*strReciverName,*strRecivePic, *strMsgCnt;
    
}
@end

@implementation MessageView

#pragma mark -
#pragma mark - Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    fontname13 = [UIFont fontWithName:@"Roboto" size:13];
    fontname14 = [UIFont fontWithName:@"Roboto-Medium" size:14];
    fontname15 = [UIFont fontWithName:@"Roboto" size:15];
    fontname15_16 = [UIFont fontWithName:@"Roboto-Regular" size:16];
    fontname17 = [UIFont fontWithName:@"Roboto-Medium" size:17];
    fontname18 = [UIFont fontWithName:@"Roboto-Medium" size:18];
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    strid=[defaults valueForKey:@"id"];
    strToken=[defaults valueForKey:@"token"];
    strSattus=[defaults valueForKey:@"status"];


    
}
-(void)viewWillAppear:(BOOL)animated
{
     [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    webservice *service=[[webservice alloc]init];
    service.delegate=self;
    service.tag=1;
    NSString *strSend=[NSString stringWithFormat:@"?id=%@&token=%@",strid,strToken];
    
    [service executeWebserviceWithMethod1:METHOD_MESSAGES withValues:strSend];
}
-(void)onPageLoad
{
    [viewMessage removeFromSuperview];
    [viewNoMsgsMatches removeFromSuperview];
    
    viewMessage=[[UIView alloc]initWithFrame:self.view.frame];
    viewMessage.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewMessage];
    //
    //        viewMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    //
    //
    //
    //        [UIView animateWithDuration:0.40 animations:^{
    //            viewMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    //            //   }
    //            //    completion:^(BOOL finished) {
    //            //        [UIView animateWithDuration:0.30 animations:^{
    //            //            viewMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    //            //        } completion:^(BOOL finished) {
    //            //            [UIView animateWithDuration:0.30 animations:^{
    //            //                viewMessage.transform = CGAffineTransformIdentity;
    //            //            }];
    //            //       }];
    //        }];
    
    int yPos=46;
    
    UILabel *lblNewMatches=[[UILabel alloc]initWithFrame:CGRectMake(10,yPos, self.view.frame.size.width-20, 20)];
    lblNewMatches.text=@"New Matches";
    lblNewMatches.textAlignment=NSTextAlignmentLeft;
    [lblNewMatches setFont:fontname15_16];
    lblNewMatches.textColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
    [viewMessage addSubview:lblNewMatches];
    
    yPos+=19;
    [sclVwMatches removeFromSuperview];
    sclVwMatches=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yPos, self.view.frame.size.width, 130)];
    //sclVwMatches.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    sclVwMatches.backgroundColor=[UIColor clearColor];
    [viewMessage addSubview:sclVwMatches];
    
    int xPosScrl=15;
    
    if (arrNewMatches.count!=0)
    {
        for (int i=0; i<arrNewMatches.count; i++)
        {
            NSDictionary *dictMatch=[arrNewMatches objectAtIndex:i];
            
               UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(xPosScrl,10,  80, 80)];
    NSString *strImageURL=[dictMatch valueForKey:@"image"];
    imageview.image=[UIImage imageNamed:@"PersonMsg.png"];
    if (![strImageURL isEqualToString:@""])
    {
        AsyncImageView *async=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imageview.frame.size.width, imageview.frame.size.height)];
        [async loadImageFromURL:[NSURL URLWithString:strImageURL]];
        async.backgroundColor=[UIColor clearColor];
        [imageview addSubview:async];
    }
    
    imageview.layer.cornerRadius=40;
    imageview.clipsToBounds=YES;
    [sclVwMatches addSubview:imageview];
    
    
    UIButton *btnPhotoEdit=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPhotoEdit.frame=CGRectMake(xPosScrl,10,  80, 80);
    //    UIImage *imgPlus=[UIImage imageNamed:@"Plus.png"];
    //    [btnPhotoEdit setImage:imgPlus forState:UIControlStateNormal];
    //    [btnPhotoEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    btnPhotoEdit.titleLabel.font=[UIFont systemFontOfSize:16];
   // btnPhotoEdit.tag=BTN_PHOTO_EDIT;
    [btnPhotoEdit setBackgroundColor:[UIColor clearColor]];
    [btnPhotoEdit addTarget:self action:@selector(onMatchClick:) forControlEvents:UIControlEventTouchDown];
    btnPhotoEdit.layer.cornerRadius=40;
            btnPhotoEdit.tag=i;
    btnPhotoEdit.clipsToBounds=YES;
    [sclVwMatches addSubview:btnPhotoEdit];
            
            
            NSString * strName = [dictMatch valueForKey:@"name"];
            NSArray * arrName = [strName componentsSeparatedByString:@" "];
           // NSLog(@"Array values are : %@",arrName);
            
            UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(xPosScrl,90,  80, 20)];
            lblName.text=[arrName objectAtIndex:0];
            lblName.textAlignment=NSTextAlignmentCenter;
            [lblName setFont:fontname14];
            lblName.textColor=[UIColor blackColor];
            [sclVwMatches addSubview:lblName];
            
            xPosScrl+=100;
            
        }
    }
    else
    {
        UITextView *TxtVDescription=[[UITextView alloc]initWithFrame:CGRectMake(15, 10, self.view.frame.size.width-30, 50 )];
        TxtVDescription.text=@"“There is no new matches”.";
        [TxtVDescription setFont:fontname15];
        TxtVDescription.userInteractionEnabled=NO;
        TxtVDescription.textColor=[UIColor grayColor];
        TxtVDescription.textAlignment=NSTextAlignmentCenter;
        [sclVwMatches addSubview:TxtVDescription];
    }
    
      sclVwMatches.contentSize=CGSizeMake(xPosScrl+25, 130);
    
    yPos+=130;
    UILabel *lblLine=[[UILabel alloc]initWithFrame:CGRectMake(0, yPos, self.view.frame.size.width, 1)];
    [[lblLine layer]setBorderWidth:0.3];
    [[lblLine layer]setBorderColor:[UIColor lightGrayColor].CGColor];
    [viewMessage addSubview:lblLine];
    
    yPos+=5;
    
    UILabel *lblMessages=[[UILabel alloc]initWithFrame:CGRectMake(10,yPos, self.view.frame.size.width-20, 20)];
    lblMessages.text=@"Messages";
    lblMessages.textAlignment=NSTextAlignmentLeft;
    [lblMessages setFont:fontname15_16];
    lblMessages.textColor=[UIColor colorWithRed:252/255.0 green:89/255.0 blue:77/255.0 alpha:1.0];
    [viewMessage addSubview:lblMessages];
    
    yPos+=25;
    
    if (arrMessages.count!=0)
    {
    
    tableMessgaes=[[UITableView alloc]initWithFrame:CGRectMake(5, yPos, self.view.frame.size.width-10, self.view.frame.size.height-yPos)];
    tableMessgaes.delegate=self;
    tableMessgaes.dataSource=self;
    tableMessgaes.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [viewMessage addSubview:tableMessgaes];
    }
    else
    {
        UITextView *TxtVDescription=[[UITextView alloc]initWithFrame:CGRectMake(15, yPos, self.view.frame.size.width-30, 50 )];
        TxtVDescription.text=@"“They swiped right for a reason. Start talking to your matches”.";
        [TxtVDescription setFont:fontname15];
        TxtVDescription.userInteractionEnabled=NO;
        TxtVDescription.textColor=[UIColor grayColor];
        TxtVDescription.textAlignment=NSTextAlignmentCenter;
        [viewMessage addSubview:TxtVDescription];
    }
    
}
-(IBAction)onMatchClick:(id)sender
{
    UIButton *btn=(UIButton *) sender;
    NSDictionary *dictLocal=[arrNewMatches objectAtIndex:btn.tag];
    strReciverID=[dictLocal valueForKey:@"id"];
    strReciverName=[dictLocal valueForKey:@"name"];
    strRecivePic=[dictLocal valueForKey:@"picture"];
    
    strMsgCnt=@"0";
     [self performSegueWithIdentifier:@"Chat_View" sender:self];
}

-(void)NoMsgsMatches
{
    [viewMessage removeFromSuperview];
    [viewNoMsgsMatches removeFromSuperview];
    
    viewNoMsgsMatches=[[UIView alloc]initWithFrame:self.view.frame];
    viewNoMsgsMatches.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewNoMsgsMatches];
    
    UIButton *btnLike=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLike.frame=CGRectMake((self.view.frame.size.width/2)-100, (self.view.frame.size.height/2)-140, 200, 200);
    UIImage *imgLogo=[UIImage imageNamed:@"LikeMessage.png"];
    [btnLike setImage:imgLogo forState:UIControlStateNormal];
    btnLike.userInteractionEnabled=NO;
    [viewNoMsgsMatches addSubview:btnLike];

    UILabel *lblHead=[[UILabel alloc]initWithFrame:CGRectMake(15, (self.view.frame.size.height/2)+70, self.view.frame.size.width-30, 30 )];
    lblHead.text=@"Get Swiping";
    [lblHead setFont:fontname17];
    lblHead.textColor=[UIColor blackColor];
    lblHead.textAlignment=NSTextAlignmentCenter;
    [viewNoMsgsMatches addSubview:lblHead];

    
    
    UILabel *lblDescription=[[UILabel alloc]initWithFrame:CGRectMake(15, (self.view.frame.size.height/2)+105, viewNoMsgsMatches.frame.size.width-30, 25 )];
    lblDescription.text=@"“Start swiping to get more matches!”";
    [lblDescription setFont:fontname15];
    lblDescription.textColor=[UIColor grayColor];
    lblDescription.textAlignment=NSTextAlignmentCenter;
   // [lblDescription sizeToFit];
    [viewNoMsgsMatches addSubview:lblDescription];
    
    
   
    
  //  int h=lblDescription.frame.size.height;
   

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrMessages.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        
    }
    
   
    NSDictionary *dictMsg=[arrMessages objectAtIndex:indexPath.row];
    
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,  50, 50)];
    NSString *strImageURL=[dictMsg valueForKey:@"picture"];
    imageview.image=[UIImage imageNamed:@"PersonMsg.png"];
    if (![strImageURL isEqualToString:@""])
    {
        AsyncImageView *async=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, imageview.frame.size.width, imageview.frame.size.height)];
        [async loadImageFromURL:[NSURL URLWithString:strImageURL]];
        async.backgroundColor=[UIColor clearColor];
        [imageview addSubview:async];
    }
    
    imageview.layer.cornerRadius=25;
    imageview.clipsToBounds=YES;
    [cell addSubview:imageview];

    
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(70,5,  150, 25)];
    lblName.text=[dictMsg valueForKey:@"name"];
    lblName.textAlignment=NSTextAlignmentLeft;
    [lblName setFont:fontname17];
    lblName.textColor=[UIColor blackColor];
    [cell addSubview:lblName];
    
    UILabel *lblMssg=[[UILabel alloc]initWithFrame:CGRectMake(70,30,  150, 25)];
    lblMssg.text=[dictMsg valueForKey:@"message"];
    lblMssg.textAlignment=NSTextAlignmentLeft;
    [lblMssg setFont:fontname15];
    lblMssg.textColor=[UIColor blackColor];
    [cell addSubview:lblMssg];


    
    
//    cell.textLabel.text=strName;
//    cell.textLabel.textAlignment=NSTextAlignmentCenter;
//    cell.textLabel.font=fontname16;
//    cell.textLabel.textColor=[UIColor colorWithRed:3/255.0 green:126/255.0 blue:112/255.0 alpha:1.0];
    
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
//    [recognizer setNumberOfTapsRequired:1];
//    //  scrollView.userInteractionEnabled = YES;
//    [cell addGestureRecognizer:recognizer];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *dictLocal=[arrMessages objectAtIndex:indexPath.row];
    strReciverID=[dictLocal valueForKey:@"id"];
    strReciverName=[dictLocal valueForKey:@"name"];
    strRecivePic=[dictLocal valueForKey:@"picture"];
    strMsgCnt=[dictLocal valueForKey:@"total_message"];
    [self performSegueWithIdentifier:@"Chat_View" sender:self];

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
           
            arrMessages=[dictResponse valueForKey:@"messages"];
            arrNewMatches=[dictResponse valueForKey:@"new_matches"];
            if (arrNewMatches.count!=0 || arrMessages.count!=0)
            {
                 [self onPageLoad];
            }
            else
            {
                [self NoMsgsMatches];
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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"Chat_View"])
    {
        appDelegate.isFrmMessage=@"yes";
        ChatView *chat=[segue destinationViewController];
        chat.strReciverID=strReciverID;
        chat.strReciverName=strReciverName;
        chat.strReciverPic=strRecivePic;
        chat.strTotalMsg=strMsgCnt;
    }
}


@end
