#
#  TransparentWindow.rb
#  QuickMouse
#
#  Created by Tristan Hume on 2012-12-09.
#  Copyright 2012 Tristan Hume. All rights reserved.
#

class TransparentWindow < NSWindow
  attr_accessor :initialLocation
  
  # In Interface Builder we set CustomWindow to be the class for our window, so our own initializer is called here.
  # the original method is being extended but still called thanks to the `super` call
  def initWithContentRect(contentRect, styleMask:aStyle, backing:bufferingType, defer:flag)
    # Call NSWindow's version of this function, but pass in the all-important value of NSBorderlessWindowMask
    #for the styleMask so that the window doesn't have a title bar
    result = super(contentRect, NSBorderlessWindowMask, NSBackingStoreBuffered, false)
    # Set the background color to clear so that (along with the setOpaque call below) we can see through the parts
    # of the window that we're not drawing into
    result.setBackgroundColor(NSColor.clearColor)
    # This next line pulls the window up to the front on top of other system windows. This is how the Clock app behaves;
    # generally you wouldn't do this for windows unless you really wanted them to float above everything.
    result.setLevel(NSStatusWindowLevel)
    # Let's start with no transparency for all drawing into the window
    result.setAlphaValue(1.0)
    # but let's turn off opaqueness so that we can see through the parts of the window that we're not drawing into
    result.setOpaque(false)
    result
  end
  
  # Custom windows that use the NSBorderlessWindowMask can't become key by default. Therefore, controls in such windows
  # won't ever be enabled by default. Thus, we override this method to change that.
  def canBecomeKeyWindow
    false
  end
  
  
end

