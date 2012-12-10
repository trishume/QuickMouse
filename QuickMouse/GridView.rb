#
#  GridView.rb
#  QuickMouse
#
#  Created by Tristan Hume on 2012-12-09.
#  Copyright 2012 Tristan Hume. All rights reserved.
#

class GridView < NSView
  
  # This method is called at app launch time when this class is unpacked from the nib.
  # We get set up here.
  def awakeFromNib
    # tell ourselves that we need displaying (force redraw)
    setNeedsDisplay(true)
  end
  
  def draw_line(p1,p2)
    nsP1 = NSPoint.new(*p1)
    nsP2 = NSPoint.new(*p2)
    NSColor.redColor.set
    NSBezierPath.setDefaultLineWidth(1.0)
    NSBezierPath.strokeLineFromPoint(nsP1,toPoint: nsP2)
  end
  
  def draw_horiz_line(frac)
    x = frac * bounds.size.width
    draw_line([x,0],[x,bounds.size.height])
  end
  
  def draw_vert_line(frac)
    y = frac * bounds.size.height
    draw_line([0,y],[bounds.size.width,y])
  end
  
  # When it's time to draw, this method is called.
  # This view is inside the window, the window's opaqueness has been turned off,
  # and the window's styleMask has been set to NSBorderlessWindowMask on creation,
  # so what this view draws *is all the user sees of the window*. The first two lines below
  # then fill things with "clear" color, so that any images we draw are the custom shape of the window,
  # for all practical purposes. Furthermore, if the window's alphaValue is <1.0, drawing will use
  # transparency.
  def drawRect(rect)
    puts "drawing"
    # erase whatever graphics were there before with clear
    NSColor.clearColor.set
    NSRectFill(frame)
    # draw click point
    NSColor.greenColor.setFill
    s = bounds.size
    rect = NSMakeRect(0.5 * s.width - 1, 0.5 * s.height - 1, 2, 2);
    circlePath = NSBezierPath.bezierPath
    circlePath.appendBezierPathWithOvalInRect(rect)
    circlePath.fill
    # draw lines
    draw_horiz_line(1/3.0)
    draw_horiz_line(2/3.0)
    draw_vert_line(1/3.0)
    draw_vert_line(2/3.0)
  end
  
end
