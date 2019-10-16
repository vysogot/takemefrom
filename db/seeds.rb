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
game.update(beginning_id: 1, max_element_counter: 100, elements: [{
  "data" => {
    "id" => "1", "content" => "Welcome to the takemefrom app. It is a simple and powerful engine for creating walkable graphs."
  },
  "position" => {
    "x" => 341, "y" => 122
  }
}, {
  "data" => {
    "id" => "2", "content" => "Takemefrom allows you to create games that others can play. You are playing on of them now, it is called Tutorial."
  },
  "position" => {
    "x" => 505, "y" => 78
  }
}, {
  "data" => {
    "id" => "3", "content" => "Then it is surely not for you. Thanks for a short play anyway!"
  },
  "position" => {
    "x" => 389, "y" => 7
  }
}, {
  "data" => {
    "id" => "16", "content" => "I created this game to tell you about it! You can also create on after you log in and maybe I'll play yours."
  },
  "position" => {
    "x" => 462, "y" => 169
  }
}, {
  "data" => {
    "id" => "93", "content" => "Public games can be browsed but not copied. You also can make private games and make them accessible only to your audience!"
  },
  "position" => {
    "x" => 282, "y" => 203
  }
}, {
  "data" => {
    "id" => "28", "content" => "You can do a lot of it while having fun."
  },
  "position" => {
    "x" => 621, "y" => 152
  }
}, {
  "data" => {
    "id" => "63", "content" => "You can, for example, make your knowledge explorable and facilitate learning processes. Or guide your customers to the best fitting product. Or have an interactive FAQ."
  },
  "position" => {
    "x" => 536, "y" => 275
  }
}, {
  "data" => {
    "id" => "62", "content" => "When you register and log in, you will see a Create link on the welcome page. Give your game a name, set it to public or private and hit \"Create game\" button."
  },
  "position" => {
    "x" => 190, "y" => 132
  }
}, {
  "data" => {
    "id" => "69", "content" => "Then you will see a Game Editor. There, you can add places and create connections between. For example, the words you read now are the content of a place. And the choices you have below are the connections. In this way, the whole game is built. "
  },
  "position" => {
    "x" => 176, "y" => 31
  }
}, {
  "data" => {
    "id" => "14", "content" => "Yes, you can see the map (places and connections) of this game by pasting this in your browser: https://i.ibb.co/LNbHFFj/tutorial-map.png\n\nThat's it! The end of the tutorial. Try to make your own game and share it with friends, or contact me for more business or education-oriented solutions."
  },
  "position" => {
    "x" => 66, "y" => 71
  }
}, {
  "data" => {
    "id" => "edge-59", "source" => "28", "target" => "63", "content" => "Like what? Come on, tell me!"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-82", "source" => "1", "target" => "2", "content" => "Hmm... interesting!"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-15", "source" => "3", "target" => "2", "content" => "Okay, okay, I was just kidding."
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-1", "source" => "1", "target" => "2", "content" => "What does it mean?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-71", "source" => "2", "target" => "16", "content" => "So how does it work?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-27", "source" => "16", "target" => "93", "content" => "How will you know I made a game?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-86", "source" => "16", "target" => "28", "content" => "What's the use of these games? Is it just for fun?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-24", "source" => "63", "target" => "93", "content" => "But then, if I make such a map, others may copy it!"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-33", "source" => "1", "target" => "3", "content" => "I don't like simplicity and power, sorry."
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-80", "source" => "93", "target" => "62", "content" => "Okay, so I want to create a game. How do I do it?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-67", "source" => "62", "target" => "69", "content" => "Okay... and then?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-5", "source" => "69", "target" => "3", "content" => "It sounds super boring."
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}, {
  "data" => {
    "id" => "edge-48", "source" => "69", "target" => "14", "content" => "So all this was a game?"
  },
  "position" => {
    "x" => 0, "y" => 0
  }
}])
