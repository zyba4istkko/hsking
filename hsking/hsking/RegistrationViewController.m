//
//  RegistrationViewController.m
//  hsking
//
//  Created by Иван Труфанов on 23.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "RegistrationViewController.h"
#import "HSAuthManager.h"

@interface RegistrationViewController () <UITextFieldDelegate>

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.state = RegistrationStateRegister;
    
    [loginField becomeFirstResponder];
    
    loginField.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}
- (IBAction)mainBtnClicked {
    mainButton.enabled = NO;
    
    if (self.state == RegistrationStateRegister) {
        [HSAuthManager makePasswordForPhone:loginField.text resBlock:^(BOOL success, NSError *err){
            mainButton.enabled = YES;
            
            if (success) {
                self.state = RegistrationStateRegisterPassSent;
                [passField becomeFirstResponder];
            } else {
                [[UIAlertView alertFromError:err] show];
            }
        }];
    } else {
        [HSAuthManager makePasswordForPhone:loginField.text resBlock:^(BOOL success, NSError *err){
            mainButton.enabled = YES;
            
            if (success) {
//                [self dismissViewControllerAnimated:YES completion:nil];
                [[[[UIApplication sharedApplication] delegate] window].rootViewController dismissViewControllerAnimated:YES completion:nil];
            } else {
                [[UIAlertView alertFromError:err] show];
            }
        }];
    }
}
- (IBAction)alreadyRegisteredClicked {
    if (self.state == RegistrationStateLogin) {
        self.state = RegistrationStateRegister;
    } else {
        self.state = RegistrationStateLogin;

    }
}
- (IBAction)passTypeClicked {
    passField.secureTextEntry = !passField.secureTextEntry;
}
- (void)setState:(RegistrationState)state {
    BOOL update = (_state != state);
    _state = state;
    
    if (update) {
        NSString *passFieldPlaceholder = nil;
        NSString *mainButtonTitle = nil;
        CGFloat passAlpha = 1;
        
        if (_state == RegistrationStateLogin) {
            mainButtonTitle = @"Войти";
            self.navigationItem.title = @"Вход";
        } else {
            self.navigationItem.title = @"Регистрация";
            if (_state == RegistrationStateRegister) {
                passAlpha = 0;
            }
            
            mainButtonTitle = @"Зарегистрироваться";
        }
        
        if (passView.alpha == 0) {
            passField.placeholder = passFieldPlaceholder;
        }
        
        if (![[mainButton titleForState:UIControlStateNormal] isEqualToString:mainButtonTitle]) {
            [mainButton setTitle:mainButtonTitle forState:UIControlStateNormal];
        }
        
        [UIView animateWithDuration:0.3 animations:^(){
            passView.alpha = passAlpha;
        } completion:^(BOOL finished){
            passField.placeholder = passFieldPlaceholder;
        }];
    }
}
- (IBAction)phoneChanged {
    if ([loginField.text rangeOfString:@"+"].location == NSNotFound && loginField.text.length > 0) {
        loginField.text = [NSString stringWithFormat:@"+%@",loginField.text];
    } else if (loginField.text.length == 1 && [loginField.text isEqualToString:@"+"]) {
        loginField.text = @"";
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
