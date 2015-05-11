//
//  HSAuthManager.m
//  hsking
//
//  Created by Иван Труфанов on 24.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSAuthManager.h"

#import "VMConnection.h"
#import "SSKeychain.h"


@implementation HSAuthManager
+ (void)showAuthScreen {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Auth" bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    [[UIViewController currentViewController] presentViewController:viewController animated:YES completion:nil];
}
+ (void) makePasswordForPhone:(NSString *)phone resBlock:(ActionBlock)resBlock {
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"+1234567890"] invertedSet];
    phone = [[phone componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    
    [VMConnection sendRequestToPath:@"Account/Register" withParameters:@{@"phone":phone} reqType:RequestTypeJSONPOST resBlock:^(BOOL success, NSHTTPURLResponse *resp, id respObj, NSError *err){
        if (respObj[@"ErrorMessage"] && ![respObj[@"ErrorMessage"] isKindOfClass:[NSNull class]]) {
            NSInteger code = [respObj[@"ErrorCode"] integerValue];
            if (code == 12) { //Юзер уже есть
                [self resetPasswordForPhone:phone resBlock:resBlock];
            } else {
                resBlock(NO,[NSError errorWithDescription:respObj[@"ErrorMessage"]]);
            }
        } else {
            resBlock(YES,nil);
        }
    }];
}
+ (void) resetPasswordForPhone:(NSString *)phone resBlock:(ActionBlock)resBlock {
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"+1234567890"] invertedSet];
    phone = [[phone componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    
    [VMConnection sendRequestToPath:@"Account/RecoverPassword" withParameters:@{@"phone":phone} reqType:RequestTypeJSONPOST resBlock:^(BOOL success, NSHTTPURLResponse *resp, id respObj, NSError *err){
        if (respObj[@"ErrorMessage"] && ![respObj[@"ErrorMessage"] isKindOfClass:[NSNull class]]) {
            resBlock(NO,[NSError errorWithDescription:respObj[@"ErrorMessage"]]);
        } else {
            resBlock(YES,nil);
        }
    }];
}
+ (void) checkPasswordForPhone:(NSString *)phone pass:(NSString *)pass resBlock:(ActionBlock)resBlock {
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"+1234567890"] invertedSet];
    phone = [[phone componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    
    [VMConnection sendRequestToPath:@"token" withParameters:@{@"grant_type":@"password",@"username":phone,@"password":pass} reqType:RequestTypePOST resBlock:^(BOOL success, NSHTTPURLResponse *resp, id respObj, NSError *err){
        if (respObj[@"ErrorMessage"] && ![respObj[@"ErrorMessage"] isKindOfClass:[NSNull class]]) {
            resBlock(NO,[NSError errorWithDescription:respObj[@"ErrorMessage"]]);
        } else {
            [SSKeychain setPassword:respObj[@"access_token"] forService:@"token" account:@"default"];
            [SSKeychain setPassword:phone forService:@"phone" account:@"default"];
            [SSKeychain setPassword:pass forService:@"password" account:@"default"];
            
            resBlock(YES,nil);
        }
    }];
}
+ (BOOL) isAuthenticated {
    return YES;
    NSString *token = [self authToken];
    if (token) {
        return YES;
    }
    return NO;
}
+ (NSString *) authToken {
    return @"SSS";
    return [SSKeychain passwordForService:@"token" account:@"default"];
}
@end
