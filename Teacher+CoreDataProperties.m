//
//  Teacher+CoreDataProperties.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 29/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Teacher"];
}

@dynamic name;
@dynamic subject;
@dynamic student;

@end
