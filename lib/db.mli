val url : string

val connect :
  unit ->
  ( Caqti_lwt.connection,
    [> Caqti_error.load_or_connect ] )
  result
  Lwt.t

val connect_exn : unit -> Caqti_lwt.connection

val get_points :
  (module Caqti_lwt.CONNECTION) ->
  (Point.point list, [> Caqti_error.call_or_retrieve ]) result
  Lwt.t

val insert_point :
  (module Caqti_lwt.CONNECTION) ->
  float * float ->
  (unit, [> Caqti_error.call_or_retrieve ]) result Lwt.t
