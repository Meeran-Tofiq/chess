# Chess
This is a classical game of chess written in the Ruby programming language. It was made as part of the coursework provided in the Ruby section of The Odin Project.

## Challenges
I faced many trials while trying to code this program.

At first it was extremely difficult to think up of a good way to structure the classes. It is a difficult hurdle for programmers who have just started out, and as it was the first time where the coursework left us to our own devices, it was hard to come up with something meaningful. However, I eventually figured out a way that was neat and made the classes all complimentary and work together well, and because of that finished the project with less headaches than otherwise.

Later, I faced a lot of difficulties trying to serialize and unserialize the objects of the game, to save and later load games. I tried many different serializers and many different people's codes. But ultimately, I took the module BasicSerializable written by Dhaivat Pandya, and reworked some methods to fit my needs. This was a success and saving and loading was finally complete.

## Features to Implement in the Future
I hope to be able to implement a playback feature, where if you save a finished game, it saves the sequence of moves. Then, later when you load it, it plays the sequence of moves that's been saved like an animation.

And if that was successful, I'd like to extend it to normal saves and loads as well. Meaning that when you load a save file, it animates all the moves that's been done until then.

# How to Run
Just simply take the code, and run it in any application or area that lets you run Ruby code.

# How to Use
To make a normal move, you write down the piece you want to move {(leave empty for pawn) => Pawn, R => Rook, K => King, N => Knight, Q => Queen, B => Bishop}. Like so:
e4
e5
Nf3

If you try to take a piece, you have to write \"x\" within it. Like so:
xd5
Rxf7
Kxa3

And if you want to castle, you write {king's side => O-O, queen's side => O-O-O}. Like so:
O-O
O-O-O

If you want to save the game, draw it, or resign, you just type exactly that. Like so:
save
draw
resign

Drawing offer the opponent to draw, but they can just decline. You win when the opponent resigns.

# Credits
The code within serializable.rb was originally written by Dhaivat Pandya, on https://www.sitepoint.com/choosing-right-serialization-format

# Thank You for Reading