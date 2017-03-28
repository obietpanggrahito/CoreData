//
//  CoreDataManager.h
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import <Foundation/Foundation.h>
//28
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

//23
+(instancetype)shared;

//29 and remove from appdelegate.h 
- (NSManagedObjectContext *) managedObjectContext; //same name to the prop and return same datatype

@end
