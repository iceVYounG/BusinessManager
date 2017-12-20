//
//  WZ_LookRoomVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/8/12.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_LookRoomVC.h"

@interface WZ_LookRoomVC ()<deleteBtnDelegate>{

    NSInteger addNum;
    NSInteger addViewTag;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArr;
@property (strong,nonatomic) WZ_AddItemView *addView;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addBtnConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewConstant;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property(nonatomic,strong) NSMutableArray *addViews;
@end

@implementation WZ_LookRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.leftTitle=@"预约看房";
    [self requestWeiZhanDetail];
    
    // Do any additional setup after loading the view from its nib.
}

-(instancetype)initWithBlock:(LookRoomBlock)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

-(void)initView{
    for (UIButton *btn in _btnArr) {
        
        btn.layer.cornerRadius=3;
        
    }
   
    addViewTag=10;
    
    

}



- (IBAction)addAction:(id)sender {
    
    _addView=[[WZ_AddItemView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_downBtn.frame)+15+addNum*59, SCREEN_SIZE.width-30, 44)];
     _addView.delegate=self;
    _addView.tag=addViewTag;
    [self.myScrollView addSubview:_addView];
    
    
    
    [_addViews addObject:_addView];
    _addBtnConstant.constant+=59;
    NSLog(@">>>>%f",CGRectGetMaxY(_addBtn.frame));
    
    
    if (CGRectGetMaxY(_addBtn.frame)+180>SCREEN_SIZE.height) {
        _viewConstant.constant=CGRectGetMaxY(_addBtn.frame)+200-SCREEN_SIZE.height;
    }
    
    addNum++;
    addViewTag++;
    
    NSLog(@"%ld",(long)_addView.tag);
    
}


#pragma mark  ---deleteBtnDelegate---
-(void)clickdeleteBtn:(UIButton *)index{
    
    NSLog(@">>>%ld",(long)_addViews.count);
    
    [index.superview removeFromSuperview];
    addNum--;
   
   
   
    
  
    
    NSInteger xxx= index.superview.tag;
    NSLog(@"xxx=%ld---tag=%ld",(long)xxx,(long)addViewTag);
    
    for (NSInteger i=xxx; i>=10; i++) {
        
        
        if (i>addViewTag) {
            break;
        }
        CGRect frame= [_myScrollView viewWithTag:i+1].frame;
        
        frame.origin.y-=59;
        [_myScrollView viewWithTag:i+1].frame=frame;
    }
//     addViewTag--;
     _addBtnConstant.constant-=59;
    if (CGRectGetMaxY(_addBtn.frame)+180>SCREEN_SIZE.height) {
        _viewConstant.constant=CGRectGetMaxY(_addBtn.frame)+82-SCREEN_SIZE.height;
    }

}


- (IBAction)baocunAction:(id)sender {
    
    
    [self requestWeiZhanDetail];
    
    
}


- (void)requestWeiZhanDetail{
    
    [self saveTemplte:nil succeed:^(id responseObject) {
        NSLog(@">>---%@",responseObject);
                
    }
    error:^(NSError *error) {
        
        
        
    }];


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end





@implementation WZ_AddItemView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        
        [self addSubview:self.addTextFiled];
        [self addSubview:self.deleteBtn];
    }
    
    return self;
}



-(UITextField *)addTextFiled{
    if (!_addTextFiled) {
        _addTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width-30, 44)];
        _addTextFiled.placeholder=@"请输入需要消费者填的项目名称";
        
        _addTextFiled.backgroundColor=[UIColor redColor];
    
    }

    return _addTextFiled;
}



-(UIButton *)deleteBtn{

    if (!_deleteBtn) {
        _deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width-18-30, 0, 18, 18)];
        [_deleteBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        _deleteBtn.tag=_btnTag++;
        [_deleteBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteBtn;
}

-(void)addAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(clickdeleteBtn:)]) {
        [self.delegate clickdeleteBtn:sender];
    }



}













@end