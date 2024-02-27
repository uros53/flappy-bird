EnterHighScoreState = Class{__includes = BaseState}

local chars = {
    [1] = 65,
    [2] = 65,
    [3] = 65
}

local highlightedChar = 1

function EnterHighScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:update(dt)

    -- change selected char
    if love.keyboard.wasPressed('left') and highlightedChar > 1 then
        gSounds['score']:stop()
        gSounds['score']:play()
        highlightedChar = highlightedChar - 1
    elseif love.keyboard.wasPressed('right') and highlightedChar < 3 then
        gSounds['score']:stop()
        gSounds['score']:play()
        highlightedChar = highlightedChar + 1
    end

    -- change char
    if love.keyboard.wasPressed('up') then
        gSounds['score']:stop()
        gSounds['score']:play()
        chars[highlightedChar] = chars[highlightedChar] + 1
        if chars[highlightedChar] > 90 then
            chars[highlightedChar] = 65
        end
    elseif love.keyboard.wasPressed('down') then
        gSounds['score']:stop()
        gSounds['score']:play()
        chars[highlightedChar] = chars[highlightedChar] - 1
        if chars[highlightedChar] < 65 then
            chars[highlightedChar] = 90
        end
    end

    -- save
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3])

        for i = 10, self.scoreIndex, -1 do
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end

        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score

        local scoresStr = ''

        for i = 1, 10 do
            scoresStr = scoresStr .. self.highScores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
        end

        love.filesystem.write('flappy-bird.lst', scoresStr)

        gStateMachine:change('high-scores', {
            highScores = self.highScores
        })
    end
end

function EnterHighScoreState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your score: ' .. tostring(self.score), 0, 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['huge'])

    -- first char
    if highlightedChar == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[1]), VIRTUAL_WIDTH / 2 - 60, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    -- second char
    if highlightedChar == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[2]), VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    -- third char
    if highlightedChar == 3 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[3]), VIRTUAL_WIDTH / 2 + 40, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to confirm!', 0, VIRTUAL_HEIGHT - 30,
        VIRTUAL_WIDTH, 'center')
end