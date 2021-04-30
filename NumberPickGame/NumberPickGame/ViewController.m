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
    [self getNewTargetNum];
    _currentValue = 50;
    _slider.value =  _currentValue;
    [self textAlignCenterhorizontal:[NSString stringWithFormat:@"%d", _targetValue] :_targetValueTextField];
    [self showCountOfTry];
    //[__targetValueTextField setText:[NSString stringWithFormat:@"%d", _targetValue]];
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
    [_scoreTextField setText:[NSString stringWithFormat:@"%d", _score]];
}



/**
 text:需要居中的文本
 textField：需要居中的textField
 */
-(void)textAlignCenterhorizontal:(NSString *)text : (UITextField*) textField{
    // 让文字居中和设置字体大小
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    //文字居中
    paragraph.alignment = NSTextAlignmentCenter;
    //字体大小
    UIFont *font =[UIFont systemFontOfSize:15];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    //添加属性 居中
    [attr addAttribute:NSParagraphStyleAttributeName
                 value:paragraph
                 range:NSMakeRange(0, [attr length])];
    //添加属性 大小
    [attr addAttribute:NSFontAttributeName
                 value:font
                 range:NSMakeRange(0, [attr length])];
    //替换掉原来的属性
    textField.attributedText = attr;
    //删去背景颜色
    textField.backgroundColor = NULL;
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
    
    
    //slider左边的最小值
    UITextField *minValueText = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/6, screenHeight/2-15, 50, 30)];
    minValueText.text = @"1";
    self.minTextField = minValueText;
    
    
    //slider右边的最大值
    UITextField *maxValueText = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/6*5-20, screenHeight/2-15, 50, 30)];
    maxValueText.text = @"100";
    self.maxTextField = maxValueText;
    
    
    //游戏的提示 “拖动slider让结果最接近数字"
    UITextField *goalText = [[UITextField alloc]initWithFrame:CGRectMake(0, screenHeight/5, screenWidth, 30)];
    [self textAlignCenterhorizontal:@"拖动slider让结果最接近数字" :goalText];
    
    
    //按钮 显示slider的当前值
    UIButton *showSliderValueButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/6*5, screenHeight/6*5, 100, 30)];
    [showSliderValueButton setTitle:@"提交" forState:UIControlStateNormal];
    //设置点击事件
    [showSliderValueButton addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchDown];
    
    
    //再来一次按钮
    UIButton *tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/18, screenHeight/6*5, 150, 30)];
    [tryAgainBtn setTitle:@"重置分数和回合数" forState:UIControlStateNormal];
    //设置点击事件
    [tryAgainBtn addTarget:self action:@selector(resetRounds:) forControlEvents:UIControlEventTouchDown];
    
    
    //分数 提示“分数：”
    UITextField *scoreHintTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*4, screenHeight/6*5, 50, 30)];
    [scoreHintTextField setText:@"分数:"];
    
    
    //分数 真正的得分
    UITextField *scoreTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*5, screenHeight/6*5, 50, 30)];
    [scoreTextField setText:@"0"];
    self.scoreTextField = scoreTextField;
    
    
    //回合数提示
    UITextField *countOfRoundsHintTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*8, screenHeight/6*5, 70, 30)];
    [countOfRoundsHintTextField setText:@"回合数:"];
    
    
    //回合数
    UITextField *countOfRoundsTextField = [[UITextField alloc]initWithFrame:CGRectMake(countOfRoundsHintTextField.frame.origin.x+countOfRoundsHintTextField.frame.size.width+5, screenHeight/6*5, 100, 30)];
    [countOfRoundsTextField setText:@"0"];
    self.numOfRoundsTextField = countOfRoundsTextField;
    
    
    //尝试次数展示
    UITextField *countOfTryTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*10, screenHeight/6*5, 170, 30)];
    [countOfTryTextField setText:@"尝试：0次"];
    self.numOfTryTextField = countOfTryTextField;
    
    //目标值
    UITextField *_targetValueTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, goalText.frame.origin.y+35, screenWidth, 30)];
    self.targetValueTextField = _targetValueTextField;
    
    
    
    
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
    [self.view addSubview:_targetValueTextField];
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
    [_scoreTextField setText:@"0"];
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
