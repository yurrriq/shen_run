# shen_run

*Shen REPL trampoline.*

It loads a `~/.shen.shen` initialization file, which is convenient for modulesys
users. It can execute Shen scripts, allowing them to access command line
arguments. Error output is written to `stderr`.

## Installing

For each Shen implementation, you can build separate version of `shen_run`. If
you want to build `shen_run` for `shen-sbcl` then

```fish
mkdir include/sbcl
cp include/config.def.h include/sbcl/config.h.
```

Edit `include/sbcl/config.h` to match your configuration. Then type

```fish
make impl=sbcl
```

to build `shen_run_sbcl`.

N.B. The default `impl` is `sbcl`.

## Using

Your script must have an entry function `main`, which accepts command line
parameters in one argument of type `(list string)` and returns a boolean
indicating success status. You can run that script either by typing

```fish
shen_run_[impl] your_script.shen argument1 argument2 ...
```

Or you can add a line

```fish
#!/usr/bin/env shen_run
```

at the first line of your script and make file executable

```fish
chmod +x your_script.shen
```

Then you can run it as any other program:

```
./your_script.shen argument1 argument2 ...
```

### Example

Located at [src/example.shen](src/example.shen)

```shen
#!/usr/bin/env shen_run_sbcl

(define show-args
  [] _ -> _
  [X | R] I -> (let - (output "  ~A: ~S~%" I X)
                 (show-args R (+ I 1))))

(define main
  [] -> (error "Not enough arguments.")
  ["-preved" | _] -> false
  Args -> (let - (output "Arguments~%")
               - (show-args Args 0)
               - (output "End~%")
               true))
```
