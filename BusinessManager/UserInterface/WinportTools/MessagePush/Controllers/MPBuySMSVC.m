//
//  MPBuySMSVC.m
//  BusinessManager
//
//  Created by KL on 16/8/1.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MPBuySMSVC.h"

@interface MPBuySMSVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *buyWebView;

@end

@implementation MPBuySMSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    
    [self.buyWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)setUpViews {
    [self.buyWebView setUserInteractionEnabled:YES];
    self.buyWebView.delegate = self;
    [self.buyWebView setScalesPageToFit:YES];
    
    self.title = @"收银台";
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //通知上一页面刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MP_BUYMSGVC_REFRESHDATAS" object:nil];
}

#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD showWithStatus:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
//    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
//    [SVProgressHUD showErrorWithStatus:@"页面加载失败！"];
//    [SVProgressHUD dismiss];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end