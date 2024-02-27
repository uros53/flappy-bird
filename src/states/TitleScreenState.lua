TitleScreenState = Class{__includes = BaseState}

local highlighted = 1

function TitleScreenState:enter(params)
    self.highScores = params.highScores
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        gSounds['score']:stop()
        gSounds['score']:play()
        highlighted = highlighted == 1 and 2 or 1
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if highlighted == 1 then
            gStateMachine:change('countdown', {
                highScores = self.highScores
            })
        else
            gStateMachine:change('high-scores', {
                highScores = self.highScores
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function TitleScreenState:render()
    love.graphics.setFont(gFonts['flappy'])
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('by Uros', 0, 64 + 35, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf('START', 0, VIRTUAL_HEIGHT - 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf('HIGH SCORES', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end