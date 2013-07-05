require 'rubygems'
require 'sinatra'

enable :sessions
size = 32

get '/' do
  game = Array.new
  size.times do
    inner = Array.new
    size.times do
      inner.push [0,1].sample
    end
    game.push inner
  end

  session[:game] = game
  erb :index, :locals => {:game => game}
end

get '/go' do
  game = tick session[:game], size
  session[:game] = game
  erb :index, :locals => {:game => game}
end

def tick(game, n)
  new = Array.new(n) { Array.new(n, 0) }
  n.times do |i|
    n.times do |j|
      new[i][j] = result(game, i, j, n)
    end
  end
  new
end

def result(board, x, y, n)
  sum = 0
  # N S E W
  if y - 1 >= 0
    sum += board[x][y-1]
  end
  if x - 1 >= 0
    sum += board[x-1][y]
  end
  if y + 1 < n
    sum += board[x][y+1]
  end
  if x + 1 < n
    sum += board[x+1][y]
  end

  # Diagon Alley
  if y - 1 >= 0 and x - 1 >= 0
    sum += board[x-1][y-1]
  end
  if y - 1 >= 0 and x + 1 < n
    sum += board[x+1][y-1]
  end
  if y + 1 < n and x - 1 >= 0
    sum += board[x-1][y+1]
  end
  if y + 1 < n and x + 1 < n
    sum += board[x+1][y+1]
  end

  (sum == 3 or (sum == 2 and board[x][y] == 1))? 1: 0
end
