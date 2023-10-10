open Point

let hardcoded_points: point list ref = ref [
  create 0.0 0.0;
  create 100.0 50.0;
]

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
  field "points"
    ~doc: "List of points"
    ~typ:(non_null (list (non_null point)))
    ~args:Arg.[]
    ~resolve:(fun _info () -> !hardcoded_points)
]
~mutations: [
  field "add_point"
    ~doc: "Add a point to the list"
    ~typ:(non_null (list (non_null point)))
    ~args:Arg.[
      arg "x" ~typ:(non_null float);
      arg "y" ~typ:(non_null float);
    ]
    ~resolve:(fun _info () (x: float) (y: float) -> 
      let _ = hardcoded_points := (create x y)::(!hardcoded_points) in
       !hardcoded_points)
]
)

let start () =
  Dream.run
  @@ Dream.logger
  @@ Dream.origin_referrer_check
  @@ Dream.router [
    Dream.any "/graphql" (Dream.graphql Lwt.return schema);
    Dream.get "/graphiql" (Dream.graphiql "/graphql");
  ]