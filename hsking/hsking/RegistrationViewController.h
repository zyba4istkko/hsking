//
//  RegistrationViewController.h
//  hsking
//
//  Created by Иван Труфанов on 23.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RegistrationStateUnknown,
    RegistrationStateRegister,
    RegistrationStateRegisterPassSent,
    RegistrationStateLogin
} RegistrationState;

@interface RegistrationViewController : UIViewController {
    IBOutlet UIView *loginView;
    IBOutlet UIView *passView;
    IBOutlet UIButton *mainButton;
    IBOutlet UIButton *alreadyRegisteredButton;
    
    IBOutlet UITextField *loginField;
    IBOutlet UITextField *passField;
}
@property (nonatomic) RegistrationState state;
- (IBAction)mainBtnClicked;
- (IBAction)alreadyRegisteredClicked;
- (IBAction)phoneChanged;
- (IBAction)passTypeClicked;
@end
