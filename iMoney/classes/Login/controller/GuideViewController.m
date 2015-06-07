//
//  GuideViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "GuideViewController.h"
#import "SCGIFImageView.h"

@interface GuideViewController ()
{
    UIButton *btn;
    UIButton *btn1;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSMutableArray *slideImages;
}
@end

@implementation GuideViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:scrollView];
        
        
        if (IPHONE5)
        {
            //slideImages = [[NSMutableArray alloc] initWithObjects:@"yin1_1136.png",@"yin2_1136.png",@"yin3_1136.png",@"yin4_1136.png", nil];
            slideImages = [[NSMutableArray alloc] initWithObjects:@"slogan1.gif",@"slogan2.gif",@"slogan3.gif", nil];
        }
        else
        {
            //slideImages = [[NSMutableArray alloc] initWithObjects:@"yin1_960.png",@"yin2_960.png",@"yin3_960.png",@"yin4_960.png", nil];
            
            slideImages = [[NSMutableArray alloc] initWithObjects:@"slogan1mini.gif",@"slogan2mini.gif",@"slogan3mini.gif", nil];
        }
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(146,Screenheight-20,30,18)];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        pageControl.numberOfPages = [slideImages count];
        pageControl.currentPage = 0;
        pageControl.enabled=NO;
        //[pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:pageControl];
        for (int i = 0;i<[slideImages count];i++)
        {
            //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
            //
            //            NSString* filePath = [[NSBundle mainBundle] pathForResource:[slideImages objectAtIndex:i] ofType:nil];
            //            SCGIFImageView* imageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
            //
            //            imageView.frame = CGRectMake((Screenwidth * i), 0, Screenwidth, Screenheight);
            //            [scrollView addSubview:imageView];
            // 读取gif图片数据
            NSString *path=[[NSBundle mainBundle] pathForResource:[slideImages objectAtIndex:i] ofType:nil];
            NSData *gif = [NSData dataWithContentsOfFile: path];
            // view生成
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(Screenwidth * i, 0, Screenwidth, Screenheight)];
            [scrollView addSubview:webView];
            webView.scalesPageToFit = YES;
            webView.userInteractionEnabled = NO;//用户不可交互
            [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
            if (i==(slideImages.count-1)) {
                // UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat imgToBottom;
                if (IPHONE5)
                {
                    imgToBottom = 79;
                }
                else
                {
                    imgToBottom = 67;
                }
                btn.frame = CGRectMake(Screenwidth * i+33, Screenheight-imgToBottom, 120, 32);
                [btn setTitle:@"注册" forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleColor:[UIColor colorWithRed:225.0f/255.0f green:163.0f/255.0f blue:75.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
                //                [btn setImage:[UIImage imageNamed:@"immediatelyUse.png"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(handleSingleFingerEvent:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag=1;
                btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
                [btn.layer setMasksToBounds:YES];
                [btn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
                //imageView.userInteractionEnabled=YES;
                [scrollView addSubview:btn];
                
                btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = CGRectMake(Screenwidth * i+167, Screenheight-imgToBottom, 120, 32);
                [btn1 setTitle:@"登录" forState:UIControlStateNormal];
                [btn1 setBackgroundColor:[UIColor whiteColor]];
                [btn1 setTitleColor:[UIColor colorWithRed:225.0f/255.0f green:163.0f/255.0f blue:75.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
                //                [btn setImage:[UIImage imageNamed:@"immediatelyUse.png"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(handleSingleFingerEvent:) forControlEvents:UIControlEventTouchUpInside];
                btn1.tag=2;
                btn1.titleLabel.font=[UIFont boldSystemFontOfSize:15];
                [btn1.layer setMasksToBounds:YES];
                [btn1.layer setCornerRadius:8.0];//设置矩形四个圆角半径
                [scrollView addSubview:btn1];
            }
        }
        
        [scrollView setContentSize:CGSizeMake(Screenwidth * ([slideImages count]), 0)];
        [scrollView setContentOffset:CGPointMake(0, 0)];
        [scrollView scrollRectToVisible:CGRectMake(Screenwidth,0,Screenwidth,Screenheight-60) animated:NO];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)scrollViewDidScroll:(UIScrollView *)scroll {
    CGFloat pagewidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+2;
    page --;
    if (page==2) {
        pageControl.hidden=YES;
        //[self performSelector:@selector(fire) withObject:nil afterDelay:3];
    }
    else{
        pageControl.hidden=NO;
    }
    pageControl.currentPage = page;
    if (scrollView.contentOffset.x>(slideImages.count-1)*Screenwidth) {
        //[self.delegate entryMainPage];
        //[self handleSingleFingerEvent:nil];
    }
}
-(void)fire{
    btn.hidden=NO;
    btn1.hidden=NO;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scroll
{
    
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [scrollView scrollRectToVisible:CGRectMake(Screenwidth,0,Screenwidth,Screenheight-40) animated:NO];
    }
    else if (currentPage==([slideImages count]+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(Screenwidth * [slideImages count],0,Screenwidth,Screenheight-40) animated:NO];
    }
    NSLog(@"%f",scrollView.contentOffset.x);
}
- (void)handleSingleFingerEvent:(UIButton *)sender{
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    [user setBool:YES forKey:@"firstUserApp"];
//    [user synchronize];

    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (sender.tag==1) {
        [app userReg];
    }
    else{
        [app userLogin];
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

