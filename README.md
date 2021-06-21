# Work logger

## Story

The company has just introduced a logging system.
As their administrator they asked you to deploy a script
which helps the accounting to summarize
the work hours for everyone for any given month.

## What are you going to learn?

- Using `cut` to process CSV files
- Using `for` and/or `while` loops for processing
- Using positional parameters
- Reusing and working with function parameters/arguments

## Tasks

1. Calculate how many hours Alice worked in January. Use the file `logs/alice/january.csv` in your script.
    - `alice.sh` script exists
    - Running the script it reads, and summarizes Alice's working hours from `january.csv`
    - `./check.sh` reports for the following:
``` OK ./alice.sh == 156 ```

2. Create a script called `bob.sh` similar to `alice.sh` ... but for Bob ... for February. :)
    - `bob.sh` script exists
    - Running the script it reads, and summarizes Bob's working hours from `february.csv`
    - `./check.sh` reports for the following:
``` OK ./bob.sh == 120 ```

3. Update the `alice.sh` and `bob.sh` scripts so that they could calculate how many hours Alice or Bob worked in a specific month.
    - `alice.sh` and `bob.sh` is updated so that they accepts a *month* parameter, e.g. `./alice.sh february`, `./bob.sh january`
    - When no month parameter is specified for the scripts they work as if they were called with `january` by default
    - `./check.sh` reports `OK` for the followings:

```
OK ./alice.sh == 156
OK ./alice.sh january == 156
OK ./alice.sh february == 126
OK ./alice.sh march == 127
OK ./alice.sh april == 124
OK ./bob.sh == 120
OK ./bob.sh january == 120
OK ./bob.sh february == 114
```

4. You might have noticed already that the `alice.sh` and `bob.sh` scripts are *veeery* similar.
Noticing such things should always raise your inner alarm that *there's a chance for reuse*.
To this end, create a function that can be *shared* by the two scripts.
    - `shared.sh` script exists, without a *shebang* line (signifying that it shouldn't be executed directly)
    - A function called `sum_work_hours` is defined in `shared.sh` that takes two parameters: `name` and `month`
    - `sum_work_hours` sums the work hours of the named employee for the given month
    - The `alice.sh` and `bob.sh` scripts source or *dot* the shared script (e.g. `. shared.sh`) and use the `sum_work_hours` function
    - The behavior of the `alice.sh` and `bob.sh` scripts shouldn't change, i.e. they should work as before the function reuse took place

5. Now it's time to go one step further and create a script that's universally useful.
Having a script for each employee is a waste of disk space, isn't that right?
So, let's create `report.sh` that'll do just that.
    - `reports.sh` script exists
    - The script should accept two parameters, `name` and `month`
    - The default value for `month` parameter if not specified should be `january`
    - `report.sh` should reuse the `sum_work_hours` function in its implementation
    - The script sums the given employee's work hours for the given month
    - `./check.sh` reports `OK` for everything.

## General requirements

- The interpreter in the *shebang* line of the scripts is `/bin/bash`
- The *executable bit* of each script is set, in other words they're runnable
- If a script is invoked with incorrect arguments (e.g. referincing a month for which there's no data) display an error message and exit with code 1

## Hints

- Make sure to omit the header line of the CSV files you process (using `tail` or some other method)
- Use `cut` to print/select one column from a CSV formatted file
- Use shell arithmetic to make calculations, there are a few alternatives, but use the POSIX portable way if possible: `$(( ... ))`
- Use Bash's variable/parameter substitution/expansion feature to work with *default values*
- Make sure to use the interpreter as `/bin/bash`
- Using a `while` loop is the best for parsing
- Focus only on simple positional parameter handling, no need for the fancy `case` or `for` loop kind of processing

## Background materials

- [Skipping the First Line of a File Using `tail`](https://stackoverflow.com/a/604871)
- <i class="far fa-exclamation"></i> [Parsing a CSV in Bash](https://www.shell-tips.com/bash/how-to-parse-csv-file/)
- <i class="far fa-book-open"></i> [Positional Parameters](https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script#positional-parameters)
- [Bash Default Parameter Values](https://shellmagic.xyz/#variable-operations)
- [`${model:-opel}` vs. `${model:=opel}`](https://stackoverflow.com/a/48218788)
