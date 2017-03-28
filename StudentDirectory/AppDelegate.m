//
//  AppDelegate.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "AppDelegate.h"
//21
#import "ViewController.h"
//36
#import "CoreDataManager.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

//8 nothing

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //22 pass ManagedObjectContext directly from AppDelegate to ViewController
    //30 comment this out
//    ViewController *controller = (ViewController *)self.window.rootViewController;
//    [controller configureManagedObjectContext:self.managedObjectContext];
    
    //37
    [CoreDataManager shared];
    return YES;
    
   }


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


//6 copy paste from app delegate ... .m
#pragma mark - Core Data stack

//3 delete syntetic

//4 remove persistant container

//5
-(void) setupCoreData {
    
    
    
}


/*
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */





#pragma mark - Core Data Saving support

- (void)saveContext {
    //2remove save context body
    
    

}

@end
