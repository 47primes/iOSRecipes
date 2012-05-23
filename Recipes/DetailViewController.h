//
//  DetailViewController.h
//  Recipes
//
//  Created by Mike Bradford on 5/21/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@class Cookbook;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate, RKRequestDelegate>

@property (strong, nonatomic) Cookbook *detailItem;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *summaryTextField;
@property (nonatomic, retain) RKRequest *createRequest;
@property (nonatomic, retain) RKRequest *updateRequest;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
