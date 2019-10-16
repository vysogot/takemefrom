# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.connection.truncate(User.table_name)
Game.connection.truncate(Game.table_name)

user = User.find_or_create_by(email: 'admin@takemefrom.com') do |u|
  u.password = 'foobar'
  u.password_confirmation = 'foobar'
end

game = Game.create!(name: 'Tutorial', user: user)
game.update(beginning_id: 1, elements: [{
  'data' => {
    'id' => '1', 'content' => 'The new beginning'
  },
  'position' => {
    'x' => 267, 'y' => 48
  }
}, {
  'data' => {
    'id' => '2', 'content' => 'You are in the temple'
  },
  'position' => {
    'x' => 505, 'y' => 78
  }
}, {
  'data' => {
    'id' => '3', 'content' => 'You are in the cowshed!!!'
  },
  'position' => {
    'x' => 436, 'y' => 183
  }
}, {
  'data' => {
    'id' => '87', 'content' => 'Dupa'
  },
  'position' => {
    'x' => 183, 'y' => 285
  }
}, {
  'data' => {
    'id' => '4', 'content' => 'Siema Michał'
  },
  'position' => {
    'x' => 114, 'y' => 128
  }
}, {
  'data' => {
    'id' => '39', 'content' => 'Finally you see a cow'
  },
  'position' => {
    'x' => 316, 'y' => 193
  }
}, {
  'data' => {
    'id' => 'edge-1', 'source' => '1', 'target' => '2', 'content' => 'Turn left'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}, {
  'data' => {
    'id' => 'edge-2', 'source' => '1', 'target' => '3', 'content' => 'Turn right'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}, {
  'data' => {
    'id' => 'edge-70', 'source' => '2', 'target' => '3', 'content' => 'Something'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}, {
  'data' => {
    'id' => 'edge-82', 'source' => '1', 'target' => '2', 'content' => 'Something'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}, {
  'data' => {
    'id' => 'edge-7', 'source' => '1', 'target' => '87', 'content' => 'Something'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}, {
  'data' => {
    'id' => 'edge-62', 'source' => '39', 'target' => '4', 'content' => 'Something'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}, {
  'data' => {
    'id' => 'edge-60', 'source' => '3', 'target' => '39', 'content' => 'Something'
  },
  'position' => {
    'x' => 0, 'y' => 0
  }
}])
