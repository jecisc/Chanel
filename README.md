# Chanel

Chanel is a code cleaner for Pharo. 

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
| 1.x.x       	| Pharo 70, 80				|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.me 
