type point = float * float

let create (x: float) (y: float) = (x, y)

let get_x p = fst p

let get_y p = snd p