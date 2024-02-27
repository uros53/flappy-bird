ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('w') then
        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        -- check if score in top 10
        local highScore = false

        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex
            })
        else
            gStateMachine:change('title', {
                highScores = self.highScores
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ScoreState:render()
    love.graphics.setFont(gFonts['flappy'])
    love.graphics.printf('Off! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end