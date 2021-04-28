//
//  ViewController.m
//  ChangeText
//
//  Created by reburn on 2021/4/28.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)showAlert:(id)sender{
    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                            message:@"The message is ..."
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
