# Chanel <img src="https://raw.githubusercontent.com/jecisc/Chanel/master/resources/perfume.png" width="35">

[![CI](https://github.com/jecisc/Chanel/actions/workflows/continuous.yml/badge.svg)](https://github.com/jecisc/Chanel/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/jecisc/Chanel/badge.svg?branch=master)](https://coveralls.io/github/jecisc/Chanel?branch=master)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)

Chanel is a code cleaner for Pharo. 

- [Chanel ](#chanel-)
	- [Installation](#installation)
	- [Quick start](#quick-start)
	- [Documentation](#documentation)
	- [Version management](#version-management)
	- [Smalltalk versions compatibility](#smalltalk-versions-compatibility)
	- [Contact](#contact)

## Installation

To install the project in your Pharo image execute:

```Smalltalk
    Metacello new
    	githubUser: 'jecisc' project: 'Chanel' commitish: 'v1.x.x' path: 'src';
    	baseline: 'Chanel';
    	load
```

To add it to your baseline:

```Smalltalk
    spec
    	baseline: 'Chanel'
    	with: [ spec repository: 'github://jecisc/Chanel:v1.x.x/src' ]
```

Note that you can replace the #v1.x.x by another branch such as #development or a tag such as #v1.0.0, #v1.? or #v1.1.?.

## Quick start

It is possible to clean a collection of packages using the #perfume: method.

```Smalltalk
packages := ((IceRepository registry select: [ :e | e name includesSubstring: 'Moose' ])
	flatCollect: [ :e | e workingCopy packageNames collect: [ :s | s asPackageIfAbsent: [ nil ] ] ]) reject: #isNil.

Chanel perfume: packages
```

It is also possible to run only some cleaners selecting them manually.

```Smalltalk
Chanel perfume: packages using: { ChanelTestEqualityCleaner . ChanelProtocolsCleaner  }.
```

You can find the full list of cleaners running `ChanelAbstractCleaner cleaners asArray`.

A last parameter interesting to configure is the minimal Pharo version on which the project should work.
*Chanel* contains cleaners that are using methods introduced only recent versions of Pharo. 
Thus, to avoid to break projects running on older version of Pharo it is possible to define the minimal Pharo version on which the project should run.

```Smalltalk
Chanel perfume: packages forPharo: 6.

Chanel perfume: packages using: { ChanelTestEqualityCleaner . ChanelProtocolsCleaner  } forPharo: 6.
```

> You can open playgrounds containing those snippets via the world menu once the project is installed.

> **WARNING**: Some cleaning are making sense in most cases but might cause troubles in some edge cases. Please, read the documentation to see the list of possible problems it might introduce.

## Documentation

Find the full documentation [Here](resources/doc/documentation.md).

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions 		|
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 70, 80, 90, 10, 11, 12		|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.fr
