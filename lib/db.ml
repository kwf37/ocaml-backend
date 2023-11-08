(** This file written using https://github.com/paurkedal/caqti-study/blob/main/study/hello-caqti-lwt/lib/repo/exec.ml as a reference. *)

let url = "postgresql://ocaml:password@localhost"


(* This is the connection pool we will use for executing DB operations. *)
let connect () =
  Caqti_lwt.connect (Uri.of_string url)

(** For `utop` interactions interactions. See `README.md`.
 *)
let connect_exn () =
  let conn_promise = connect () in
  match Lwt_main.run conn_promise with
  | Error err ->
      let msg =
        Printf.sprintf "Abort! We could not get a connection. (err=%s)\n"
          (Caqti_error.show err)
      in
      failwith msg
  | Ok module_ -> module_

module Q = struct
  open Caqti_request.Infix

  (*
    Caqti infix operators

    ->! decodes a single row
    ->? decodes zero or one row
    ->* decodes many rows
    ->. expects no row
  *)

  let get_all_points =
    Caqti_type.(unit ->* tup2 float float)
    "SELECT x, y FROM app.point"

  let insert_point =
    Caqti_type.(tup2 float float ->. unit)
    "INSERT INTO app.point(x, y) VALUES(?, ?)"
end

let get_points (module Conn : Caqti_lwt.CONNECTION) =
  Conn.fold Q.get_all_points (fun (x, y) acc -> (Point.create x y)::acc) () []

let insert_point (x, y) (module Conn : Caqti_lwt.CONNECTION) =
  Conn.exec Q.insert_point (x, y)
