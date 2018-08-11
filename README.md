# xcode_build_timings2csv

`xcode_build_timings2csv` converts to CSV from records in `/tmp/xcode_build_timings`.

## What is `/tmp/xcode_build_timings` ?

If `/tmp/xcode_build_timings` exists, Xcode save build timing profiles to the directory.   
(I haven't been able to find the reference about the function in Apple's official documents.)   

The profile is plain-text and have recorded times taken to complete per step like the following.   

```
         TIME:     REAL      USER       SYS   PAGEIN /    OUT   COMMAND STRING
         TIME:     ----      ----       ---   ------ /    ---   --------------
000000 | TIME:     3.20r     5.06u     1.34s      31 /      0   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler
.
.
.
000014 | TIME:     0.03r     0.01u     0.01s       0 /      0   LinkStoryboards
.
.
.
                   ----      ----       ---   ------ /    ---   --------------
         TIME:     0.30r     0.21u     0.05s       0 /      0   TOTAL FOR BUILD RULE NAME CodeSign
         TIME:     2.82r     0.01u     0.01s       0 /      0   TOTAL FOR BUILD RULE NAME CompileAssetCatalog
         TIME:     1.48r     0.02u     0.01s       0 /      0   TOTAL FOR BUILD RULE NAME CompileStoryboard
         TIME:     3.20r     5.06u     1.34s      31 /      0   TOTAL FOR BUILD RULE NAME CompileSwiftSources
         TIME:     9.78r     0.00u     0.00s      27 /      0   TOTAL FOR BUILD RULE NAME CopySwiftLibs
.
.
.
         TIME:     0.01r     0.01u     0.00s       0 /      0   TOTAL FOR BUILD RULE NAME Touch
         TIME:     0.00r     0.00u     0.00s       0 /      0   TOTAL FOR BUILD RULE NAME Validate
                   ----      ----       ---   ------ /    ---   --------------
         TIME:    16.83r     5.54u     1.94s      58 /      0   TOTAL BUILD TIME
```

The file is hard to read by other programs, isn't it?   
Using `xcode_build_timings2csv`, your program can use the profile as csv.


## Requirement

- Apple Swift version 4.1.2 later

## Install

```bash
$ git clone https://github.com/thara/xcode_build_timings2csv.git
$ cd xcode_build_timings2csv
$ swift build -c release
```

Then, the executable binary `xcode_build_timings2csv` is generated in `./build/{your architecture}/release`

## Usage

```
Usage:

    $ xcode_build_timings2csv

Commands:

    + dump - Dump record lines
    + rank - Dump record lines as ranking
```

```
Usage:

    $ xcode_build_timings2csv dump <filename>

Arguments:

    filename

Options:
    --key [default: No] - Record field as sort key
    --reverse [default: false] - Reverse sort in order
```

```
Usage:

    $ xcode_build_timings2csv rank <filename>

Arguments:

    filename

Options:
    --key [default: User] - Record field as rankinig key
    --reverse [default: false] - Reverse ranking order
```

## Licence

[MIT](/LICENSE)

## Author

[Tomochika Hara](https://github.com/thara)
