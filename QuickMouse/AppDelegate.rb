#
#  AppDelegate.rb
#  QuickMouse
#
#  Created by Tristan Hume on 2012-12-09.
#  Copyright 2012 Tristan Hume. All rights reserved.
#
require 'rubygems'
require 'hotkeys'

class AppDelegate
  attr_accessor :window
  def applicationDidFinishLaunching(a_notification)
    hide_window
    @area = screen_dimensions
    # Insert code here to initialize your application
    @hotkeys = HotKeys.new
    
    # Special Bindings
    @hotkeys.addHotString("Keypad0") do
      puts "started"
      start
    end
    @hotkeys.addHotString("KeypadEnter") do
      hide_window
      click(*area_center)
      reset_area
    end
    @hotkeys.addHotString("KeypadPlus") do
      hide_window
      right_click(*area_center)
      reset_area
    end
    @hotkeys.addHotString("KeypadDecimal") do
      hide_window
      reset_area
    end
    
      
    
    # Normal bindings
    num_mappings = {
      '1' => scale_proc(1/3.0,0,0),
      '2' => scale_proc(1/3.0,1,0),
      '3' => scale_proc(1/3.0,2,0),
      '4' => scale_proc(1/3.0,0,1),
      '5' => scale_proc(1/3.0,1,1),
      '6' => scale_proc(1/3.0,2,1),
      '7' => scale_proc(1/3.0,0,2),
      '8' => scale_proc(1/3.0,1,2),
      '9' => scale_proc(1/3.0,2,2)
    }
    
    num_mappings.each do |key,p|
      @hotkeys.addHotString("Keypad" + key,&p)
    end
  end
  
  def move_mouse(x,y)
    screenFrame = NSScreen.mainScreen.frame
    point = NSPoint.new(x,screenFrame.size.height - y)
    CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
    point = CGPointMake(point.x, point.y + 0.71)
    CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
    point
  end
  def click(x,y,wait = 0)
    point = move_mouse(x,y)
    sleep(wait)
    kCGMouseButtonLeft = 0
    kCGEventLeftMouseDown = 1
    kCGEventLeftMouseUp = 2
    postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseDown, point);
    postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseUp, point);
    point
  end
  def right_click(x,y,wait = 0)
    point = move_mouse(x,y)
    sleep(wait)
    kCGMouseButtonRight = 1
    kCGEventRightMouseDown = 3
    kCGEventRightMouseUp = 4
    postMouseEvent(kCGMouseButtonRight, kCGEventRightMouseDown, point);
    postMouseEvent(kCGMouseButtonRight, kCGEventRightMouseUp, point);
    point
  end
  
  def postMouseEvent(button, type, point)
    theEvent = CGEventCreateMouseEvent(nil, type, point, button);
    CGEventSetType(theEvent, type);
    kCGHIDEventTap = 0
    CGEventPost(kCGHIDEventTap, theEvent);
    CFRelease(theEvent);
  end
  
  def reset_area
    set_area(screen_dimensions)
  end
  
  def start
    reset_area
    move_mouse(*area_center)
    show_window
  end
  
  def scale(factor,x,y)
    @area.size.width *= factor
    @area.size.height *= factor
    
    @area.origin.x += @area.size.width * x
    @area.origin.y += @area.size.height * y
    puts "scaling: " + @area.inspect
    resize_window
    move_mouse(*area_center)
  end
  
  def scale_proc(factor,x,y)
    proc { show_window; scale(factor,x,y) }
  end
  
  def set_area(rect)
    @area = rect
    resize_window
  end
  
  def area_center
    [@area.origin.x + @area.size.width * 0.5, @area.origin.y + @area.size.height * 0.5]
  end
  
  def resize_window
    window.setFrame(@area,display:true)
  end
    
  def show_window
    window.orderFront(self)
  end
    
  def hide_window
    window.orderOut(self)
  end
  
  def screen_dimensions
    screen = NSScreen.mainScreen
    screen.frame
  end
end

