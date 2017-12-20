//
//  MyWeiZhanCell.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MyWeiZhanCell.h"
#import "JMButton.h"
#import "WeiZhanModel.h"

#import "UIView+UIViewController.h"
#import "WebViewController.h"
#import "UIView+UIViewController.h"
@implementation MyWeiZhanCell

-(void)awakeFromNib{

    [super awakeFromNib];
    self.pageWeb.scrollView.scrollEnabled = NO;
    self.pageWeb.scalesPageToFit = YES;
    self.pageWeb.delegate = self;
    
    self.buttomBackView.backgroundColor = [UIColor whiteColor];
    self.buttomBackView.layer.cornerRadius = 1;
    self.buttomBackView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self creatBottomSenders];
    [self towBtnAction];
    
   
    
}

-(void)towBtnAction{

    _tijiaoBtn.backgroundColor=[UIColor colorWithHexString:@"#f9f9f9"];
    _tijiaoBtn.layer.cornerRadius=5;
    [_tijiaoBtn addTarget:self action:@selector(tijiaoAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _xiugaiBtn.backgroundColor=[UIColor colorWithHexString:@"#f9f9f9"];
    [_xiugaiBtn addTarget:self action:@selector(xiugaiNi) forControlEvents:UIControlEventTouchUpInside];
    _xiugaiBtn.layer.cornerRadius=5;
}
#pragma mark - 修改昵称
-(void)xiugaiNi{
    if (self.delegate && [self.delegate respondsToSelector:@selector(xiugaiAction:)]) {
        
        [self.delegate xiugaiAction:_model];
    }


}
#pragma mark - 提交审核
-(void)tijiaoAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tijiaoAction:)]) {
        
        [self.delegate tijiaoAction:_model];
    }

}


#pragma mark - SubView
-(void)creatBottomSenders{

    NSArray* btnNames = @[@"编辑",@"预览",@"更多"];
    NSArray* icons = @[@"bianji",@"yulan",@"sangedian"];
    
    CGFloat width = KScreenWidth/3;
    CGFloat height = self.buttomBackView.height;
    CGFloat imageW = 19;
    CGFloat titleW = 27;
    
    
    
    [btnNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JMButton* sender = [JMButton creatButton:CGRectMake(width*idx, 1, width, height-2)];
        sender.tag = idx + 998;
        sender.layer.borderWidth = .5;
        sender.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        sender.ImagePrams(icons[idx],0).TitlePrams(btnNames[idx],13,[UIColor grayColor])
        .ImageEdgInsets((width-imageW-titleW - 2)/2,(height - imageW)/2,imageW,imageW)
        .TitleEdgInsets((width-imageW-titleW)/2 + imageW + 2,(height - imageW)/2,titleW,imageW)
        .ClickAction(self,@selector(bottomSenderAction:));
        [self.buttomBackView addSubview:sender];
    }];
}

#pragma mark - SetModel
-(void)setModel:(MyWeiZhanModel *)model{

    
    _model = model;

    [self.pageWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.frontPageUrl]]];
    [self.dimensionImagev sd_setImageWithURL:[NSURL URLWithString:model.qrcImagePath] placeholderImage:[UIImage imageNamed:@""]];
    
    self.weiZhanName.text = [NSString stringWithFormat:@"微站名称:%@", NoNullStr(model.shopName,@"")];
   
    [self.adressBtn setTitle:[NSString stringWithFormat:@"http://v.12580.com/%@", model.shortIdentification] forState:UIControlStateNormal];
    [self.adressBtn addTarget:self action:@selector(urlAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.templateNo isEqualToString:@"ws_base"]) {
        self.iconImageView.image=[UIImage imageNamed:@"tongyong_icon"];
    }
    else if ([model.templateNo isEqualToString:@"ws001"]){
        self.iconImageView.image=[UIImage imageNamed:@"dianshang_icon"];

    }
    else if ([model.templateNo isEqualToString:@"ws002"]){
        self.iconImageView.image=[UIImage imageNamed:@"4s-模板"];
        
    }
    else if ([model.templateNo isEqualToString:@"ws003"]){
        self.iconImageView.image=[UIImage imageNamed:@"canyin_icon"];
        
    }
    else if ([model.templateNo isEqualToString:@"ws004"]){
        self.iconImageView.image=[UIImage imageNamed:@"jiazhuang_icon"];
        
    }
    else if ([model.templateNo isEqualToString:@"ws005"]){
        self.iconImageView.image=[UIImage imageNamed:@"fangchanImage_icon"];
        
    }
    else if ([model.templateNo isEqualToString:@"ws_flower"]){
        self.iconImageView.image=[UIImage imageNamed:@"flowerPage_icon"];
        
    }
    else if ([model.templateNo isEqualToString:@"ws_fruit"]){
        self.iconImageView.image=[UIImage imageNamed:@"fruitPage_icon"];
        
    }
    else if ([model.templateNo isEqualToString:@"ws_bread"]){
        self.iconImageView.image=[UIImage imageNamed:@"breadPage_icon"];
        
    }    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   

}


-(void)urlAction:(UIButton *)sender {
    
    WebViewController *vc=[[WebViewController alloc]initWithUrl:[NSString stringWithFormat:@"http://v.12580.com/%@", _model.shortIdentification]];
    [self.viewController.navigationController pushViewController:vc animated:YES];


}

#pragma mark - Action
-(void)bottomSenderAction:(UITapGestureRecognizer*)tap{

    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedBottomSender:model:)]) {
        
        [self.delegate selectedBottomSender:tap.view.tag - 998 model:_model];
    }
    
}

@end
