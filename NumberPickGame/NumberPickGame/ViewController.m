//
//  ViewController.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import "ViewController.h"

@interface ViewController (){
    int screenWidth;
    int screenHeight;
}
-(void)showAlert:(UISlider*)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self startNewRound];
    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    _slider.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    _scoreLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
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



-(CGSize)getCGSizeFromText:(NSString *)text : (nullable NSDictionary<NSAttributedStringKey, id> *)attrs API_AVAILABLE(macos(10.0), ios(7.0)){
    CGSize size = [text sizeWithAttributes:attrs];
    return size;
}

-(CGSize)getCGSizeFromText:(UILabel *)label{
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    return size;
}

-(void)initView{
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    //slider
    UISlider *slider2  = [[UISlider alloc]initWithFrame:CGRectMake(screenWidth/4,screenHeight/2-15,screenWidth/2,30)];
    slider2.minimumValue = 1;
    slider2.maximumValue = 100;
    slider2.value = 50;
    self.slider = slider2;
    slider2.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    
    //slider左边的最小值
    UILabel *minValueText = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/6, screenHeight/2-15, 50, 30)];
    minValueText.text = @"1";
    self.minValueLabel = minValueText;
    minValueText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //slider右边的最大值
    UILabel *maxValueText = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/6*5-20, screenHeight/2-15, 50, 30)];
    maxValueText.text = @"100";
    maxValueText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.maxValueLabel = maxValueText;
    
    
    //游戏的提示 “拖动slider让结果最接近数字"
    //这里一开始就不要设置frame了 先计算出frame
    //UILabel *goalText = [[UILabel alloc]initWithFrame:CGRectMake(0, screenHeight/5, 50, 30)];
    UILabel *goalText = [UILabel new];
    [goalText setText:@"拖动slider让结果最接近数字"];
    goalText.textAlignment = NSTextAlignmentCenter;//默认是左对齐 这里改成居中
    //算宽度和高度
    CGSize size = [self getCGSizeFromText:goalText];
    goalText.frame = CGRectMake(0, screenHeight/5, screenWidth, size.height);
    goalText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //按钮 显示slider的当前值
    UIButton *showSliderValueButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/6*5, screenHeight/6*5, 100, 30)];
    [showSliderValueButton setTitle:@"提交" forState:UIControlStateNormal];
    //设置点击事件
    [showSliderValueButton addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchDown];
    showSliderValueButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //再来一次按钮
    UIButton *tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/18, screenHeight/6*5, 150, 30)];
    [tryAgainBtn setTitle:@"重置分数和回合数" forState:UIControlStateNormal];
    //设置点击事件
    [tryAgainBtn addTarget:self action:@selector(resetRounds:) forControlEvents:UIControlEventTouchDown];
    tryAgainBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //分数 提示“分数：”
    UILabel *scoreHintTextField = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/15*4, screenHeight/6*5, 50, 30)];
    [scoreHintTextField setText:@"分数:"];
    scoreHintTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //分数 真正的得分
    UILabel *scoreTextField = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/15*5, screenHeight/6*5, 50, 30)];
    [scoreTextField setText:@"0"];
    self.scoreLabel = scoreTextField;
    scoreHintTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //回合数提示
    UILabel *countOfRoundsHintTextField = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/15*8, screenHeight/6*5, 70, 30)];
    countOfRoundsHintTextField.text = @"回合数：";
    countOfRoundsHintTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //UILabel *countOfRoundsHintTextField = [UILabel new];
    //countOfRoundsHintTextField.textAlignment = NSTextAlignmentCenter;//默认是左对齐 这里改成居中
    //算宽度和高度
    //CGSize size2 = [self getCGSizeFromText:countOfRoundsHintTextField];
    //countOfRoundsHintTextField.frame = CGRectMake(0, screenHeight/5, size2.width, size2.height);
    
    
    //回合数
    UILabel *countOfRoundsTextField = [[UILabel alloc]initWithFrame:CGRectMake(countOfRoundsHintTextField.frame.origin.x+countOfRoundsHintTextField.frame.size.width+5, screenHeight/6*5, 100, 30)];
    [countOfRoundsTextField setText:@"0"];
    countOfRoundsTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.numOfRoundsTextField = countOfRoundsTextField;
    
    
    //尝试次数展示
    UILabel *countOfTryTextField = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/15*10, screenHeight/6*5, 170, 30)];
    [countOfTryTextField setText:@"尝试：0次"];
    countOfTryTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.numOfTryTextField = countOfTryTextField;
    
    //目标值
    UILabel *targetValueTextField = [[UILabel alloc]initWithFrame:CGRectMake(0, goalText.frame.origin.y+35, screenWidth, 30)];
    targetValueTextField.textAlignment = NSTextAlignmentCenter;
    targetValueTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.targetValueLabel = targetValueTextField;
    
    
    
    [self.view addSubview:goalText];
    [self.view addSubview:maxValueText];
    [self.view addSubview:minValueText];
    [self.view addSubview:slider2];
    [self.view addSubview:showSliderValueButton];
    [self.view addSubview:tryAgainBtn];
    [self.view addSubview:scoreHintTextField];
    [self.view addSubview:scoreTextField];
    [self.view addSubview:countOfRoundsHintTextField];
    [self.view addSubview:countOfRoundsTextField];
    [self.view addSubview:targetValueTextField];
    [self.view addSubview:countOfTryTextField];
}

/**
 计算回合数量
 */
-(void)countRounds{
    [_numOfRoundsTextField setText:[NSString stringWithFormat:@"%d",_rounds]];
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
    [_numOfTryTextField setText:[NSString stringWithFormat:@"尝试：%d次",_countOfTry]];
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
