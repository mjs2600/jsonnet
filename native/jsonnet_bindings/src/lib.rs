#[macro_use]
extern crate rustler;
extern crate jsonnet;

use jsonnet::JsonnetVm;
use rustler::{Encoder, Env, NifResult, Term};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
    }
}

rustler_export_nifs! {
    "Elixir.Jsonnet",
    [
        ("parse_file", 1, parse_file, rustler::SchedulerFlags::DirtyCpu),
        ("parse", 1, parse, rustler::SchedulerFlags::DirtyCpu)
    ],
    None
}

fn parse_file<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let filename: String = args[0].decode()?;
    let mut vm = JsonnetVm::new();
    let output = vm.evaluate_file(filename);
    match output {
        Ok(result) => Ok((atoms::ok(), result.as_str()).encode(env)),
        _ => Ok((atoms::error(), "Could not read file").encode(env)),
    }
}

fn parse<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let jsonnet: String = args[0].decode()?;
    let mut vm = JsonnetVm::new();
    let output = vm.evaluate_snippet("temp.jsonnet", &jsonnet);
    match output {
        Ok(result) => Ok((atoms::ok(), result.as_str()).encode(env)),
        _ => Ok((atoms::error(), "Could not read string").encode(env)),
    }
}
