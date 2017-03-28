//
//  AppDelegate.h
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//15
//- (NSManagedObjectContext *) managedObjectContext; //same name to the prop and return same datatype

//1 remove persistancontainer

- (void)saveContext;


@end

