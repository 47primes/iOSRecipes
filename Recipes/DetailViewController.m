//
//  DetailViewController.m
//  Recipes
//
//  Created by Mike Bradford on 5/21/12.
//  Copyright (c) 2012 Crossraods Systems. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "Cook.h"
#import "Cookbook.h"


@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
- (void)save;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize nameTextField = _nameTextField;
@synthesize summaryTextField = _summaryTextField;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize createRequest;
@synthesize updateRequest;
@synthesize managedObjectContext;

- (void)save 
{
    NSPredicate *fullPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\A\\s*\\Z"];
	if ([fullPredicate evaluateWithObject:self.nameTextField.text]) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a name for this cookbook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
		[alertView show];
		return;
	}

	BOOL isNewObject = [[self.detailItem objectID] isTemporaryID];
    
    self.detailItem.name = self.nameTextField.text;
    self.detailItem.summary = self.summaryTextField.text;
    
	NSError *error = nil;
	if (![self.detailItem.managedObjectContext save:&error]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"There was a problem saving this cookbook." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
	}
    
    Cook *cook = [Cook cook];
    RKClient *client = [RKClient sharedClient];
    
    NSDictionary *paramsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.detailItem.name, @"cookbook[name]", self.detailItem.summary, @"cookbook[description]", cook.auth_key, @"auth_key", nil];
    
    if (isNewObject) {
        createRequest = [client post:[cook.location stringByReplacingOccurrencesOfString:@".json" withString:@"cookbooks.json"] params:paramsDictionary delegate:self];
    } else {
        updateRequest = [client post:[cook.location stringByReplacingOccurrencesOfString:@".json" withString:@"cookbooks.json"] params:paramsDictionary delegate:self];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse *)response 
{
    RKClient *client = [RKClient sharedClient];
    
    if (request == createRequest) {
        self.detailItem.location = [response.location stringByReplacingOccurrencesOfString:client.baseURL withString:@""];
        NSError *error;
        [self.detailItem.managedObjectContext save:&error];
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    } else {
        
    }
    // TODO: Handle error response
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    if (self.detailItem) {
        self.nameTextField.text = [self.detailItem name];
        self.summaryTextField.text = [self.detailItem summary];
        self.title = self.detailItem.name;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.nameTextField = nil;
    self.summaryTextField = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Cookbook", @"Cookbook");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Cookbooks", @"Cookbooks");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
