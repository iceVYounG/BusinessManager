//
//  SolveProblemVC.m
//  BusinessManager
//
//  Created by 朕  on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "SolveProblemVC.h"

@interface SolveProblemVC ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SolveProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    

    [self.webView loadRequest:request];


}

-(void)leftDrawerButtonPress:(UIButton*)sender{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
}
<<<<<<< .mine
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
=======
- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error{
>>>>>>> .r279070
    [SVProgressHUD dismiss];
    [SVProgressHUD showWithStatus:@"加载失败!"];
}

@end