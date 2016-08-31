% shen_run(1)
% Ramil Farkhshatov
% June 20, 2012


# NAME

**shen_run** -- Shen REPL trampoline


# SYNOPSIS

**shen_run** [**-nc**] [**-ne**] [*script*] [*args...*]

# DESCRIPTION

**shen_run** starts **shen** and loads *~/.shen.shen* if the file exists and
**-nc** is not set. If a *script* file is given then **shen_run** loads it and
calls the **main** function defined, there discarding all diagnostic messages.
Only output strings and error messages are printed to **stdout** and **stderr**,
respectively. The **main** function receives a list of command line arguments
(**args...**) and must return a boolean status of success.

The flags are as follows:

|         |                                              |
|---------|----------------------------------------------|
| **-nc** | Don't load config file (*~./shen.shen*).     |
| **-ne** | Don't exit on end-of-file in standard input. |

## Example script contents

```shen
(define main
  [] -> (do (output "no arguments~%")
            false)
  ["-error" | _] -> (error "Oops.")
  Args -> (do (output "~A arguments~%" (length Args))
              true))
```
