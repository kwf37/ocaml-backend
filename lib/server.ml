open Point
open Lwt.Syntax

let point =
  Graphql_lwt.Schema.(obj "point"
    ~fields:[
      field "x"
        ~doc: "X coordinate"
        ~typ: (non_null float)
        ~args: Arg.[]
        ~resolve: (fun _info (p: point) -> get_x p)
        ;
      field "y"
        ~doc: "Y coordinate"
        ~typ: (non_null float)
        ~args: Arg.[]
        ~resolve: (fun _info (p: point) -> get_y p)
        ;
    ]
  )

let schema = Graphql_lwt.Schema.(schema [
  io_field "points"
    ~doc: "List of points"
    ~typ:(non_null (list (non_null point)))
    ~args:Arg.[]
    ~resolve:(fun info () -> 
        let* points = Dream.sql info.ctx Db.get_points in
        Lwt.return_ok (Result.get_ok points)
    )
]
~mutations: [
  io_field "add_point"
    ~doc: "Add a point to the list"
    ~typ:(non_null (list (non_null point)))
    ~args:Arg.[
      arg "x" ~typ:(non_null float);
      arg "y" ~typ:(non_null float);
    ]
    ~resolve:(fun info () (x: float) (y: float) -> 
        let* _ = Dream.sql info.ctx (Db.insert_point (x, y)) in
        let* points = Dream.sql info.ctx Db.get_points in
        Lwt.return_ok (Result.get_ok points)
      )
]
)

let start () =
  Dream.run
  @@ Dream.logger
  @@ Dream.origin_referrer_check
  @@ Dream.sql_pool Db.url
  @@ Dream.router [
    Dream.any "/graphql" (Dream.graphql Lwt.return schema);
    Dream.get "/graphiql" (Dream.graphiql "/graphql");
  ]