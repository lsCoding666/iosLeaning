//
//  ViewController.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import "GameViewController.h"
#import "UITools.h"
@interface GameViewController (){
    int screenWidth;
    int screenHeight;
}
-(void)showAlert:(UISlider*)sender;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
    [self startNewRound];
    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)didChangeRotate:(NSNotification*)notice {
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
        NSLog(@"竖屏");
    } else {
        //横屏
        NSLog(@"横屏");
        }
   }


-(void)initData{
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
}

/**
 重新生成随机数
 */
-(void)getNewTargetNum{
    _targetValue = 1 + (arc4random()%100);
}

/**
 下一轮游戏
 */
-(void)startNewRound{
    //本轮尝试次数置0
    _countOfTry = 0;
    //获得新的随机数
    [self getNewTargetNum];
    //进度条归位
    _currentValue = 50;
    _slider.value =  _currentValue;
    
    _targetValueLabel.text = [NSString stringWithFormat:@"%d",_targetValue];
    
    [self showCountOfTry];
}

/**
 计算得分
 */
-(void)countScore{
    if (_countOfTry==1) {
        _score += 10;
    }else if (_countOfTry < 3){
        _score += 5;
    }else if (_countOfTry < 5){
        _score += 3;
    }else{
        _score += 1;
    }
    [_scoreLabel setText:[NSString stringWithFormat:@"%d", _score]];
}

-(void)initView{
    
    //游戏的提示 “拖动slider让结果最接近数字"
    //这里一开始就不要设置frame了 先计算出frame
    //UILabel *goalText = [[UILabel alloc]initWithFrame:CGRectMake(0, screenHeight/5, 50, 30)];
    UILabel *goalText = [UILabel new];
    [goalText setText:@"拖动slider让结果最接近数字"];
    goalText.textAlignment = NSTextAlignmentCenter;//默认是左对齐 这里改成居中
    //算宽度和高度
    CGSize size = [UITools getCGSizeFromText:goalText];
    goalText.frame = CGRectMake(0, screenHeight/5, screenWidth, size.height);
    goalText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    

    //slider
    UISlider *slider2  = [[UISlider alloc]initWithFrame:CGRectMake(screenWidth/4,screenHeight/2-15,screenWidth/2,size.height)];
    slider2.minimumValue = 1;
    slider2.maximumValue = 100;
    slider2.value = 50;
    self.slider = slider2;
    slider2.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
     
    
    //slider左边的最小值
    UILabel *minValueText = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/6, screenHeight/2-15, 50, size.height)];
    minValueText.text = @"1";
    self.minValueLabel = minValueText;
    minValueText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //slider右边的最大值
    UILabel *maxValueText = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/6*5-20, screenHeight/2-15, 50, size.height)];
    maxValueText.text = @"100";
    maxValueText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.maxValueLabel = maxValueText;
    
    
    
    
    //按钮 显示slider的当前值
    UIButton *showSliderValueButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/6*5, screenHeight/6*5, 100, size.height)];
    [showSliderValueButton setTitle:@"提交" forState:UIControlStateNormal];
    //设置点击事件
    [showSliderValueButton addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchDown];
    showSliderValueButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //再来一次按钮
    UIButton *tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/18, screenHeight/6*5, 150, size.height)];
    [tryAgainBtn setTitle:@"重置分数和回合数" forState:UIControlStateNormal];
    //设置点击事件
    [tryAgainBtn addTarget:self action:@selector(resetRounds:) forControlEvents:UIControlEventTouchDown];
    tryAgainBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //分数 提示“分数：”
    UILabel *scoreHintLabel = [[UILabel alloc]initWithFrame:CGRectMake(tryAgainBtn.frame.origin.x+tryAgainBtn.frame.size.width+20, screenHeight/6*5, 50, size.height)];
    [scoreHintLabel setText:@"分数:"];
    scoreHintLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //分数 真正的得分
    UILabel *scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(scoreHintLabel.frame.origin.x+scoreHintLabel.frame.size.width+5, screenHeight/6*5, 50, size.height)];
    [scoreLabel setText:@"0"];
    self.scoreLabel = scoreLabel;
    scoreLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //回合数提示
    UILabel *countOfRoundsHintLabel = [[UILabel alloc]init];
    countOfRoundsHintLabel.text = @"回合数：";
    CGSize size2 = [UITools getCGSizeFromText:countOfRoundsHintLabel];
    countOfRoundsHintLabel.frame = CGRectMake(screenWidth/15*8, screenHeight/6*5, size2.width, size2.height);
    countOfRoundsHintLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;

    
    //回合数
    UILabel *countOfRoundsLabel = [[UILabel alloc]init];
    [countOfRoundsLabel setText:@"0"];
    size2 = [UITools getCGSizeFromText:countOfRoundsLabel];
    countOfRoundsLabel.frame = CGRectMake(countOfRoundsHintLabel.frame.origin.x+countOfRoundsHintLabel.frame.size.width+5, screenHeight/6*5, size2.width, size2.height);
    countOfRoundsLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.numOfRoundsLabel = countOfRoundsLabel;
    
    
    //尝试次数展示
    UILabel *countOfTryLabel = [[UILabel alloc]initWithFrame:CGRectMake(countOfRoundsLabel.frame.origin.x+countOfRoundsLabel.frame.size.width+20, screenHeight/6*5, 170, size2.height)];
    [countOfTryLabel setText:@"尝试：0次"];
    countOfTryLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.numOfTryLabel = countOfTryLabel;
    
    //目标值
    UILabel *targetValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, goalText.frame.origin.y+35, screenWidth, size2.height)];
    targetValueLabel.textAlignment = NSTextAlignmentCenter;
    targetValueLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.targetValueLabel = targetValueLabel;
    
    [self.view addSubview:goalText];
    [self.view addSubview:maxValueText];
    [self.view addSubview:minValueText];
    [self.view addSubview:slider2];
    [self.view addSubview:showSliderValueButton];
    [self.view addSubview:tryAgainBtn];
    [self.view addSubview:scoreHintLabel];
    [self.view addSubview:scoreLabel];
    [self.view addSubview:countOfRoundsHintLabel];
    [self.view addSubview:countOfRoundsLabel];
    [self.view addSubview:targetValueLabel];
    [self.view addSubview:countOfTryLabel];
}

/**
 计算回合数量
 */
-(void)countRounds{
    [_numOfRoundsLabel setText:[NSString stringWithFormat:@"%d",_rounds]];
}

/**
 重制回合数和尝试次数
 */
-(IBAction)resetRounds:(id)sender{
    _rounds = 0;
    _score = 0;
    [_scoreLabel setText:@"0"];
    [self countRounds];
    [self startNewRound];
}

-(void)showCountOfTry{
    [_numOfTryLabel setText:[NSString stringWithFormat:@"尝试：%d次",_countOfTry]];
}


/**
 点击显示当前值按钮弹出对话框提示当前值
 */
-(void)showAlert:(id)sender{
    
    _currentValue = _slider.value;
    _countOfTry += 1;
    _rounds += 1;
    [self showCountOfTry];
    [self countRounds];
    NSString *message = [NSString stringWithFormat:@"滑动条的当前数值是: %d,我们的目标数值是：%d",_currentValue,_targetValue];
    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"直接下一轮" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
        if (self->_targetValue==self->_currentValue) {
            [self countScore];
        }
        [self startNewRound];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
        if (self->_targetValue==self->_currentValue) {
            [self countScore];
            [self startNewRound];
        }
    }];
    
    [alertController addAction:okAction];           // A
    [alertController addAction:cancelAction];       // B
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
