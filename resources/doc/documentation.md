# Documentation

This page will list the cleanings produced by Chanel and explain the possible cases where cleanings should not be applied.

## Quick start

It is possible to clean a collection of packages using the #perfume: method.

```Smalltalk
packages := ((IceRepository registry select: [ :e | e name includesSubstring: 'Moose' ])
	flatCollect: [ :e | e workingCopy packageNames collect: [ :s | s asPackageIfAbsent: [ nil ] ] ]) reject: #isNil.

Chanel perfume: packages
```

## Tests equality

Chanel iterates on all the tests of the packages and clean equality assertions. 
Here is the list of rewrites it will apply:

| Original | Transformation |
| ------------- | ------------- |
| `x assert: y = z` | `x assert: y equals: z` |
| `x deny: y = z` | `x deny: y equals: z` |
| `x assert: y == z` | `x assert: y identicalTo: z` |
| `x deny: y == z` | `x deny: y identicalTo: z` |
| `x assert: y = true` | `x assert: y` |
| `x deny y = true` | `x deny: y` |
| `x assert: y = false` | `x deny: y` |
| `x deny: y = false` | `x assert: y` |
| `x assert: y equals: true` ==> `x assert: y` |
| `x deny y equals: true` | `x deny: y` |
| `x assert: y equals: false` | `x deny: y` |
| `x deny: y equals: false` | `x assert: y` |


> The danger of this cleaning happens on projects working in Pharo < 7. Some of this new assertions were introduced in Pharo 7.

## Clean protocols

Channel do multiple cleanings in protocols. 

* Channel ensures that some methods are in the right protocol. For example, `#initialize` should be in `#initialization`. Find more in `Chanel methodsInSpecificProtocolMap` and `Chanel testMethodsInSpecificProtocolMap`.
* Chanel updates some protocols to follow convensions. For examplee it updates `#initialize-release` to `#initialize`. Find more in `Chanel protocolsToCleanMap`.

> This cleaning should not have any counter indication.

## Conditional simplifications

Chanel simplifies conditionals. For example it will rewrite:

| Original | Transformation |
| ------------- | ------------- |
| `x isNil ifTrue: y | x ifNil: y` |
| `x isNil ifFalse: y | x ifNotNil: y` |
| `x isNotNil ifTrue: y | x ifNotNil: y` |
| `x isNotNil ifFalse: y | x ifNil: y` |
| `x isNil ifTrue: y ifFalse: z | x ifNil: y ifNotNil: z` |
| `x isNil ifFalse: y ifTrue: z | x ifNil: z ifNotNil: y` |
| `x isNotNil ifTrue: y ifFalse: z | x ifNil: z ifNotNil: y` |
| `x isNotNil ifFalse: y ifTrue: z | x ifNil: y ifNotNil: z` |

> The only danger of this cleaning happens for projects working on multiple Smalltalks

## Test case names

Chanel rename each test case ending with `Tests` te end with `Test` since this is `a XXTestCase`.

> This might cause trouble if you have a test case end with `Test` and another class with the same name ending with `Tests`.

## Ensure right super are call

- Ensure `#setUp` in TestCases always begins by `super setUp` (move it if not the first messand sent)
- Ensure `#tearDown` in TestCases always ends by `super tearDown` (move it if not the last messand sent)
- Ensure `#initialize` on instance side always has `super initialize`

> A problem might happen if a super was deliberatly ignored.

## Remove nil assignments in initialization

Chanel removes all nil assignations in `initialize` methods because most of the time they are not needed. 

> This might be a problem in some rare case where #initialize methods are called by teh user to reset an instance. In that case it is recommended to create a `#reset` method.

## Remove methods only calling super

Remove each methods only doing a super call. This does not remove methods with pragmas.

> This might remove methods added just to add comments in a subclass.

## Remove unread temporaries

Remove all temporaries that are defined but not read.

## Remove duplicated methods from traits 

If methods present on traits are duplicated in a classe using the trait, Chanel removes the duplicated version.