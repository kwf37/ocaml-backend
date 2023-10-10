open OUnit2
open Sum_test

let start_docker_db  = fun () ->
  let status = Sys.command "docker compose up" in
  if status = 0 then Ok(())
  else Error("Error running Docker compose")


let stop_docker_db  = fun () ->
  let status = Sys.command "docker compose down" in
  if status = 0 then Ok(())
  else Error("Error running Docker compose")


let _ = 
  let _ = start_docker_db () in
  let _ = run_test_tt_main sum_tests in
  stop_docker_db
