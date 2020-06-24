# Makefile

## Summary

`make` is a program, which reads a **makefile**, or **Makefile** in that order, to do the compile-link automatically and selectively.

## A make file consists of a set of

* **Target**: It is usually a file to be created or updated, but it may also be a directive to, or a label to be referenced by, the make program.
* **Dependency List**: Describe the target dependencies (source files, object files or even other targets).
* **Rules**: Are the necessary commands to build the target by using the Dependency List.

## The make Program

When the make program reads a makefile, it determines which targets to build by comparing the timestamps of source files in the Dependency List. If any dependency has a newer timestamp since last build, make will execute the rule associated with the target.

## Steps

1. Create a makefile (without extension)
2. Run make:

    ```bash
    make <-f make_file>
    ```

    * `-f` It tells make to use a specific file, otherwise, it will use the `makefile`/`Makefile` from the current directory.
    * `-k` Continue as much as possible after an error.  While the target that failed, and those that depend on it, cannot be remade, the other dependencies of these targets can be processed all the same.

3. The command execution will be:

    * `gcc ...` # If `make` executed the rule command
    * `make: 'xxx' is up to date.` # If `make` doesn't build the target again since none of the files has changed since last build

## Macros

In a makefile, macro defined symbols are replaced with their values by `$(symbol)`

* Definition: `MACRO_NAME = value`
* Use: `$(MACRO_NAME)`

For example `$(MACRO_NAME)` is replaced with `value`

## Variables

In a makefile, `%` is a wildcard variable similar to * in sh.

## Automatic variables

Are set by make after a rule is matched. They provide access to elements from the target and dependency lists so that the user does not have to explicitly specify any filenames. They are very useful for defining general pattern rules:

* `$@` Name of current target
* `$<` Name of first file in the dependency list
* `$^` Names of all the files in the dependency list
* `$*` Name of current dependency without extension
* `$?` List of dependencies changed more recently than current target

## Calls to the makefile

1. `make output_file -f makefile_name`
    * Compile the `*.c` file and generate the `*.o` files
    * Compile the `*.o` files and generate the `output_file`
2. `make -f makefile_name` or `make all -f makefile_name` or `make install -f makefile_name`
    * Run **"1"**
    * Install the `output_file` in a specific folder
3. `make run -f makefile_name`
    * Run **"2"**
    * Run the `output_file`
4. `make clean -f makefile_name`
    * Remove all `*.o` files
    * Remove the `output_file`

## Makfiles in Subdirectories

From inside the makefile, it is easy to go into a subdirectory and to execute another local makefile in that directory by the command:

```bash
cd directory_name && $(MAKE)
```

After executing the local makefile in a subdirectory, control returns to the current directory form where make continues.

## How can you help

Test it, comment on it, modify it, improve it, and share it!

## References

* *Systems Programming in Unix/Linux - K.C. Wang - Springer*
