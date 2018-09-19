//
//  AppDelegate.m
//  Airdrop Hack
//
//  Created by Derek Selander on 10/28/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "AppDelegate.h"
#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>

@interface AppDelegate ()

@end


int woot(char *directory) {
  DIR *dp;
  struct dirent *ep;
  
  dp = opendir (directory);
  if (dp != NULL)
  {
    while ((ep = readdir (dp)))
      puts (ep->d_name);
    (void) closedir (dp);
  } else {
    return errno;
  }
  
  return 0;
}

void boot(int fd) {
  DIR *dp;
  struct dirent *ep;
  
  dp = fdopendir(fd);
  if (dp != NULL)
  {
    while ((ep = readdir (dp)))
      puts (ep->d_name);
    (void) closedir (dp);
  }
}

void toot(char * filename) {
  char * buffer = 0;
  long length;
  FILE * f = fopen (filename, "r");
  
  if (f)
  {
    fseek (f, 0, SEEK_END);
    length = ftell (f);
    fseek (f, 0, SEEK_SET);
    buffer = malloc (length);
    if (buffer)
    {
      fread (buffer, 1, length, f);
    }
    fclose (f);
  }
  
  if (buffer)
  {
    
    
    // start to process your data / extract strings here...
  }
}

@implementation AppDelegate


- (void)setupUIComponents {
  [[UIPickerView appearance] setTintColor:[UIColor whiteColor]];
  UIColor *blueColor = [UIColor colorWithRed:40./250. green:170./250. blue:250./255. alpha:1.0];
  [[UINavigationBar appearance] setBarTintColor:blueColor];
  [[UIToolbar appearance] setBarTintColor:blueColor];
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  
  [self setupUIComponents];
//  [[UIPickerView appearance] settin
  // Override point for customization after application launch.
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
