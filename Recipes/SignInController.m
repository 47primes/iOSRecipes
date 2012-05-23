//
//  SignInController.m
//  Recipes
//
//  Created by Mike Bradford on 5/22/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import "SignInController.h"
#import "AppDelegate.h"
#import "Cook.h"
#import "Cookbook.h"

@implementation SignInController

@synthesize usernameTextField;
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)signIn:(id)sender
{
    RKClient *client = [RKClient sharedClient];
    client.username = usernameTextField.text;
    client.password = passwordTextField.text;

    usernameTextField.enabled = NO;
    passwordTextField.enabled = NO;
    
    [client get:@"/sessions.json" queryParameters:nil delegate:self];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse *)response {
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSError *error = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cook" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects) {
		for (int i=0; i<[fetchedObjects count]; i++) {
            Cook *cook = [fetchedObjects objectAtIndex:i];
            [context deleteObject:cook];
        }
    }
    [context save:&error];
    
    NSDictionary *responseDictionary = [response parsedBody:&error];
    
    Cook *cook = [NSEntityDescription insertNewObjectForEntityForName:@"Cook" inManagedObjectContext:context];
    cook.username = usernameTextField.text;
    cook.auth_key = [responseDictionary valueForKey:@"auth_key"];
    
    cook.location = response.location;
    
    [context save:&error];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
