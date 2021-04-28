//
//  ViewController.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import "ViewController.h"

@interface ViewController (){
    int currentValue;
    int screenWidth;
    int screenHeight;
    int targetValue;
    int countOfTry;
    int score;
    int rounds;
}
-(IBAction)showAlert:(UISlider*)sender;
- (IBAction)sliderMoved:(id)sender;
@end

@implementation ViewController
@synthesize slider = _slider;
@synthesize minTextField = _minTextField;
@synthesize targetValueTextField = _targetValueTextField;
@synthesize scoreTextField =_scoreTextField;
@synthesize numOfRoundsTextField = _numOfRoundsTextField;
@synthesize numOfTryTextField = _numOfTryTextField;
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
    targetValue = 1 + (arc4random()%100);
}

/**
 下一轮游戏
 */
-(void)startNewRound{
    //本轮尝试次数置0
    countOfTry = 0;
    [self getNewTargetNum];
    currentValue = 50;
    _slider.value = currentValue;
    [self textAlignCenterhorizontal:[NSString stringWithFormat:@"%d", targetValue] :_targetValueTextField];
    [self showCountOfTry];
    //[_targetValueTextField setText:[NSString stringWithFormat:@"%d", targetValue]];
}

/**
 计算得分
 */
-(void)countScore{
    if (countOfTry==1) {
        score += 10;
    }else if (countOfTry < 3){
        score += 5;
    }else if (countOfTry < 5){
        score += 3;
    }else{
        score += 1;
    }
    [_scoreTextField setText:[NSString stringWithFormat:@"%d", score]];
}



/**
 text:需要居中的文本
 textField：需要居中的textField
 */
-(void)textAlignCenterhorizontal:(NSString *)text: (UITextField*) textField{
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
    UISlider *slider2  = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4,self.view.frame.size.height/2-15,self.view.frame.size.width/2,30)];
    slider2.minimumValue = 1;
    slider2.maximumValue = 100;
    slider2.value = 50;
    self.slider = slider2;
    
    
    //slider左边的最小值
    UITextField *minValueText = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.height/2-15, 50, 30)];
    minValueText.text = @"1";
    self.minTextField = minValueText;
   
    
    //slider右边的最大值
    UITextField *maxValueText = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/6*5-20, self.view.frame.size.height/2-15, 50, 30)];
    maxValueText.text = @"100";
    self.maxTextField = maxValueText;
    
    
    //游戏的提示 “拖动slider让结果最接近数字"
    UITextField *goalText = [[UITextField alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/5, self.view.frame.size.width, 30)];
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
    UITextField *targetValueTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, goalText.frame.origin.y+35, screenWidth, 30)];
    self.targetValueTextField = targetValueTextField;
    
    
    
    
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
    [_numOfRoundsTextField setText:[NSString stringWithFormat:@"%d",rounds]];
}

/**
 重制回合数和尝试次数
 */
-(IBAction)resetRounds:(id)sender{
    rounds = 0;
    score = 0;
    [_scoreTextField setText:@"0"];
    [self countRounds];
    [self startNewRound];
}

-(void)showCountOfTry{
    [_numOfTryTextField setText:[NSString stringWithFormat:@"尝试：%d次",countOfTry]];
}


/**
 点击显示当前值按钮弹出对话框提示当前值
 */
-(IBAction)showAlert:(id)sender{
    currentValue = _slider.value;
    countOfTry += 1;
    rounds += 1;
    [self showCountOfTry];
    [self countRounds];
    NSString *message = [NSString stringWithFormat:@"滑动条的当前数值是: %d,我们的目标数值是：%d",currentValue,targetValue];
    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                            message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"直接下一轮" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
            if (targetValue==currentValue) {
                [self countScore];
            }
                [self startNewRound];

        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
            if (targetValue==currentValue) {
                [self countScore];
                [self startNewRound];
            }
        }];

        [alertController addAction:okAction];           // A
        [alertController addAction:cancelAction];       // B
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
