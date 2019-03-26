#[macro_use] extern crate rustler;
// #[macro_use] extern crate rustler_codegen;
// #[macro_use] extern crate lazy_static;
extern crate jsonnet;

use rustler::{Env, Term, NifResult, Encoder};
use jsonnet::JsonnetVm;

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "Elixir.Jsonnet",
    [("parse_file", 1, parse_file)],
    None
}

fn parse_file<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
  let filename: String = args[0].decode()?;
  let mut vm = JsonnetVm::new();
  let output = vm.evaluate_file(filename);
  match output {
    Ok(result) => Ok((atoms::ok(), result.as_str()).encode(env)),
    _ => Ok((atoms::error(), "Could not read file").encode(env))
  }
}
