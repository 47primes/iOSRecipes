//
//  Cook.m
//  Recipes
//
//  Created by Mike Bradford on 5/21/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import "Cook.h"
#import "AppDelegate.h"

@implementation Cook

@dynamic username;
@dynamic email;
@dynamic auth_key;
@dynamic location;
@dynamic cookbooks;
@dynamic recipes;

+ (Cook *)cook
{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSError *error = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cook" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	return [[context executeFetchRequest:fetchRequest error:&error] objectAtIndex:0];
}

@end
