//
//  SignInController.h
//  Recipes
//
//  Created by Mike Bradford on 5/22/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface SignInController : UIViewController <RKRequestDelegate>

@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;

- (IBAction)signIn:(id)sender;

@end
