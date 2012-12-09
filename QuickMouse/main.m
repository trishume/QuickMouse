//
//  main.m
//  QuickMouse
//
//  Created by Tristan Hume on 2012-12-09.
//  Copyright (c) 2012 Tristan Hume. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
