//
//  ViewController.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "ViewController.h"
//12
#import "Student+CoreDataClass.h"
//14
#import "AppDelegate.h"
//33
#import "CoreDataManager.h"
//D
#import "DetailViewController.h"

                                //2                 //45                    //83                                //98
@interface ViewController ()    <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>

//1
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//8
@property (strong, nonatomic) NSMutableArray *students;
//19
@property (strong, nonatomic) NSManagedObjectContext *context;
//46
@property (assign, nonatomic) NSInteger selectedIndex;
//80
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
//97
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //10            //95
    [self setUpData:@"None"];
    [self setupUI];
    //40
   // [self fetchData];
    
    //99
    self.searchBar.delegate = self;
    
}

//3
#pragma mark - setup
-(void)setupUI {
    
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.dataSource = self;
    //47
    self.tableView.delegate = self;
    
}

//9             //93
-(void)setUpData : (NSString *) filter {
    
    self.students = [NSMutableArray array];
    
        //82 copy paste from fetchdata
        NSFetchRequest *fetchRequest = [Student fetchRequest];
    
            //93
            if ([filter isEqualToString:@"Male"]) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(teacher.name == %@) AND (gender == %@)", self.currentTeacher.name, @"Male"];
                [fetchRequest setPredicate:predicate];
            } else if ([filter isEqualToString:@"Female"]) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(teacher.name == %@) AND (gender == %@)", self.currentTeacher.name, @"Female"];
                [fetchRequest setPredicate:predicate];
            }
                //101
               // else if ([filter == ]])
                
           else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher.name == %@", self.currentTeacher.name];
        [fetchRequest setPredicate:predicate];
            }
    
    
        //to sort
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
        NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];

    
    //81
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:NULL cacheName:NULL];
    
    //84
    self.fetchedResultsController.delegate = self;
    NSError *fetchControllerError = NULL;
    [self.fetchedResultsController performFetch:&fetchControllerError];
    
    if (fetchControllerError) {
        
        NSLog(@"FetchController Error : %@", fetchControllerError);
    }
    //94
    [self.tableView reloadData];
}

//20
//32 comment this out
//-(void)configureManagedObjectContext:(NSManagedObjectContext *)context {
//    
//    self.context = context;
//}

//4
#pragma mark - action
-(void)buttonAddTapped:(UIButton *)sender {
        
//    //16
//    //34 comment this out
////    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    
//    //35
//    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
//    
//    //13 student is from StudentDirectory entity, add context from delegate.m
//    //create an object
//    Student *aStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
//    
//    // another way ~ Student *aStudent = [[Student alloc] initWithEntity:<#(nonnull NSEntityDescription *)#> insertIntoManagedObjectContext:<#(nullable NSManagedObjectContext *)#>]
//    
//    //38
//    aStudent.name = self.textField.text;
//    aStudent.gender = self.genderTextField.text;
//    aStudent.age = [self.ageTextField.text integerValue];
//    
//    //save it to core data, update tableview
//    NSError *saveError = NULL;
//    [context save:&saveError];
//    if (saveError) {
//        //save failed, show alert
//        return;
//    }
    
    //72
    [self createAStudent];
    
        //41
        //[self fetchData];
    
    [self.tableView reloadData];
}

//71 cut from above
-(void)createAStudent {

    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
    
    Student *aStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    
        //O
        NSArray *randomGenderArray = @[@"Male", @"Female"];
        int yea = arc4random_uniform(2);
    
    
    aStudent.name = self.textField.text.capitalizedString;
                    //P
    aStudent.gender = randomGenderArray[yea];
                    //Q
    aStudent.age = arc4random_uniform(99);
    
        //73
        aStudent.teacher = self.currentTeacher;
    
    //save it to core data, update tableview
    NSError *saveError = NULL;
    [context save:&saveError];
    if (saveError) {
        //save failed, show alert
        return;
    }
}

//39        //89 comment out self.fetchdata anywhere
//-(void) fetchData {
//    
//    NSFetchRequest *fetchRequest = [Student fetchRequest];
//    
//        //70
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher.name == %@", self.currentTeacher.name];
//        [fetchRequest setPredicate:predicate];
//    
////        to sort
////        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
////        [fetchRequest setD]
//    
//    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
//    
//    NSError *fetchError = NULL;
//    self.students = [[context executeFetchRequest:fetchRequest error:&fetchError] mutableCopy];
//    
//    if (fetchError) { //fetching failed, show alert
//        return;
//    }
//    //42
//    [self.tableView reloadData];
//}


//44 delete
-(void) removeStudents:(Student *)student {
    
    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
    [context deleteObject:student];
    
    NSError *saveError = NULL;
    [context save:&saveError];
    if (saveError) {
        //save failed, show alert
        return;
    }

    //[self fetchData];
}

//96
- (IBAction) segmentedControlAction:(UISegmentedControl *)segment {
   
    if(segment.selectedSegmentIndex == 2){
        //        self.tableView.tag = 2;
        [self setUpData:@"Female"];
    } else if (segment.selectedSegmentIndex == 1){
        //        self.tableView.tag = 1;
        [self setUpData:@"Male"];
    }else {
        //        self.tableView.tag = 0;
        [self setUpData:@"None"];
    }
    return;
}

//5
#pragma mark - UITableViewDataSource

//6
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //11
  //  return self.students.count;
    //87 comment out above and add this
    return self.fetchedResultsController.fetchedObjects.count;
}

//7
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
        //43
       // Student *student = self.students[indexPath.row];
    
            //88 comment above and add
            Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
        cell.textLabel.text = student.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Gender : %@" " " @"Age: %hd", student.gender, student.age];

    return cell;
}

//90
#pragma mark - UITableView delegate

//48 deleting and other things
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //self.selectedIndex = indexPath.row;
    
    //D                             //91
    Student *selectedStudent = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //69 and D
    DetailViewController *controller = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailViewController class])];
    
    controller.currentStudent = selectedStudent;
    [self.navigationController pushViewController:controller animated:YES];

    
}

//49
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
                                    //92
        Student *currentStudent = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self removeStudents:currentStudent];
    }
}

//85
#pragma mark - NSFetchedResultController delegate

//86
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView beginUpdates];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
        {
            
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
            break;
            
    }
    [self.tableView endUpdates];
}

//100
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    [self setUpData:text];
}

@end
