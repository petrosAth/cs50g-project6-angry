--[[
    GD50
    Angry Birds

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()
    self.levelTranslateX = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    -- update camera
    if love.keyboard.isDown('left') then
        self.levelTranslateX = self.levelTranslateX + MAP_SCROLL_X_SPEED * dt
        
        if self.levelTranslateX > VIRTUAL_WIDTH then
            self.levelTranslateX = VIRTUAL_WIDTH
        else
            
            -- only update background if we were able to scroll the level
            self.level.background:update(dt)
        end
    elseif love.keyboard.isDown('right') then
        self.levelTranslateX = self.levelTranslateX - MAP_SCROLL_X_SPEED * dt

        if self.levelTranslateX < -VIRTUAL_WIDTH then
            self.levelTranslateX = -VIRTUAL_WIDTH
        else
            
            -- only update background if we were able to scroll the level
            self.level.background:update(dt)
        end
    end

    if love.keyboard.wasPressed('space') then
        if self.level.launchMarker.launched then
            self.level.threesCompany = true
        end
    end

    self.level:update(dt)
end

function PlayState:render()
    -- render background separate from level rendering
    self.level.background:render()

    -- love.graphics.setColor(0, 0, 0, 255/255)
    -- love.graphics.setFont(gFonts['medium'])
    -- love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()))
    -- love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    love.graphics.translate(math.floor(self.levelTranslateX), 0)
    self.level:render()
end