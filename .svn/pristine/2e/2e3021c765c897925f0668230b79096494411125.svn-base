//
//  WebViewController.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>{
    UIWebView* myWebView;
}

@property(nonatomic,strong) NSString* urlStr;

@end

@implementation WebViewController

-(instancetype)initWithUrl:(NSString*)urlStr{

    if (self = [super init]) {
        
        _urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH)];
    
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    myWebView.delegate = self;
    
    [myWebView loadRequest:request];
    
    [self.view addSubview:myWebView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    
}
-(void)leftDrawerButtonPress:(UIButton*)sender{
    
    if ([myWebView canGoBack]) {
        [myWebView goBack];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   
    NSString *url = request.URL.absoluteString;
    NSLog(@">>>%@",url);
    
    if ([url containsString:@"map.baidu.com"]||[url containsString:@"about:blank"]) {
        
        return YES;
    }
    else{
        if (self.needHeader) {
            return YES;
        }
        if ([url containsString:@"showTitle=false"]) {
            
        
//            [SVProgressHUD showWithStatus:@"加载中..."];
//            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

            return YES;
        
        }
        else{
            
            if ([url contains:@"http://v.12580.com"]||[url contains:@"http://112.4.27"]) {
                if ([url containsString:@"?"]) {
                    
                    url =  [url stringByAppendingString:@"&showTitle=false"];
                    
                }
                
                else{
                    url = [url stringByAppendingString:@"?showTitle=false"];
                }
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
                return NO;
            }
            

        }
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
   
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    
    self.title =title;
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败！"];
    [SVProgressHUD dismiss];
    
    
}





    
@end
