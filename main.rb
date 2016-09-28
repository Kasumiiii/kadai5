# coding: utf-8
require 'dxruby'

require_relative 'player'
require_relative 'enemy'

font = Font.new(25)

Window.width  = 800
Window.height = 600

back_img = Image.load("background.png")

player_img = Image.load("space-shuttle.png")
player_img.setColorKey([0, 0, 0])

enemy_img = Image.load("ufo_4.png")
enemy_img.setColorKey([0, 0, 0])

count = 0
score = 0

player = Player.new(400, 500, player_img)

enemies = []
30.times do
  enemies << Enemy.new(rand(800), rand(600), enemy_img)
end

Window.loop do
  break if Input.keyPush?(K_ESCAPE)
  Window.draw(0, 0, back_img)
  if count % 30 == 0 && enemies.length < 50
    enemies << Enemy.new(rand(800), rand(1), enemy_img)
  end

  Sprite.update(enemies)
  Sprite.draw(enemies)

  player.update
  player.draw

  enemy_count = enemies.length

  # 当たり判定
  Sprite.check(player, enemies)
  Sprite.clean(enemies)
  score += enemy_count - enemies.length
  Window.draw_font(10, 10, "score : #{score}", font)

  count += 1
end
