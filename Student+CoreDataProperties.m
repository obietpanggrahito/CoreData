//
//  Student+CoreDataProperties.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic gender;
@dynamic age;

@end
