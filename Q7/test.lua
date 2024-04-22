testButton = nil
testWindow = nil


function init()
  -- Top left icon button
  testButton = modules.client_topmenu.addLeftToggleButton('testButton', tr('Test Button'),
    '/test/test/test', closing)
  testButton:setOn(false)

  testWindow = g_ui.displayUI('test') -- initiate the window ui
  testWindow:setVisible(false)        -- dont shoe the window ui yet

  allTabs = testWindow:recursiveGetChildById('allTabs')
  allTabs:setContentWidget(testWindow:getChildById('optionsTabContent'))
end

function terminate()
  testButton:destroy()
  testWindow:destroy()
end

function closing()
  if testButton:isOn() then
    testWindow:setVisible(false)
    testButton:setOn(false)
  else
    testWindow:setVisible(true)
    testButton:setOn(true)
  end
end


function move()
  testButton:setPositionX(1)    -- I'm lost here :)
end

function onMiniWindowClose()
  testButton:setOn(false)
end
