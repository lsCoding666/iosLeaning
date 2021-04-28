//
//  ViewController.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import "ViewController.h"

@interface ViewController (){
    int currentValue;
}
-(IBAction)showAlert:(UISlider*)sender;
- (IBAction)sliderMoved:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController
@synthesize slider;
- (void)viewDidLoad {
    [super viewDidLoad];
    currentValue = slider.value;
    // Do any additional setup after loading the view.
}

/**
 slider通知
 */
- (IBAction)sliderMoved:(UISlider*)sender {
    NSLog(@"滑动条当前的数值是:%f",sender.value);
    currentValue =(int) lroundf(sender.value);
}

/**
 点击显示当前值按钮弹出对话框提示当前值
 */
-(IBAction)showAlert:(id)sender{
    NSString *message = [NSString stringWithFormat:@"滑动条的当前数值是: %d",currentValue];
    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                            message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
        }];

        [alertController addAction:okAction];           // A
        [alertController addAction:cancelAction];       // B
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
