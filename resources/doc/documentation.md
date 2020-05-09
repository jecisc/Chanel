# Documentation

This page will list the cleanings produced by Chanel and explain the possible cases where cleanings should not be applied.

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

## Logging changes

By default, *Chanel* uses [TinyLogger](https://github.com/jecisc/TinyLogger) to record every changes. 

The default logger output the logs on the Transcript, STDio and in a file named `Chanel.log`.

It is possible to update the logger to use:

```Smalltalk
Chanel logger: (TinyLogger new ensureTranscriptLogger; yourself)
```

It is also possible to disable the logging:

```Smalltalk
Chanel logger: TinyLogger new
```

For more info on the logger customization, read the documentation of `TinyLogger`.

## Cleaners descriptions

This section will go over every cleaners and explain their behavior.

### Tests equality

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
| `x assert: y equals: true` | `x assert: y` |
| `x deny y equals: true` | `x deny: y` |
| `x assert: y equals: false` | `x deny: y` |
| `x deny: y equals: false` | `x assert: y` |
| `x assert: y identicalTo: true` | `x assert: y` |
| `x deny: y identicalTo: true` | `x deny: y` |
| `x assert: y identicalTo: false` | `x deny: y` |
| `x deny: y identicalTo: false` | `x assert: y` |
| `x assert: y == true` | `x assert: y` |
| `x deny: y == true` | `x deny: y` |
| `x assert: y == false` | `x deny: y` |
| `x deny: y == false` | `x assert: y` |

*Conditions for the cleanings to by applied:*
- Only subclasses of TestCase are cleaned.
- Does not clean the traits in the packages.
- A pattern from the list above match.

*Warnings:*
The danger of this cleaning happens on projects working in Pharo < 7. Some of this new assertions were introduced in Pharo 7.
You can precise the minimal Pharo version on which the project should run to avoid the application of those rules.

### Clean protocols

Channel do multiple cleanings in protocols. 

**Channel ensures that some methods are in the right protocol. For example, `#initialize` should be in `#initialization`.**

*Conditions for the cleanings to by applied:*
- Cleaned methods should not be extensions.
- Can be applied on instance and class side of traits and classes.
- The method selector need to be present in  `ChanelProtocolsCleaner methodsInSpecificProtocolMap`.

**Channel ensures that some test case methods are in the right protocol. For example, `#setUp` should be in `#running`.**

*Conditions for the cleanings to by applied:*
- Cleaned methods needs to be in a subclass of TestCase.
- Cleaned methods should not be extensions.
- Can be applied on instance and class side.
- The method selector need to be present in  `ChanelProtocolsCleaner testMethodsInSpecificProtocolMap`.

**Chanel ensure that tests are in a protocol starting with `test`.**

*Conditions for the cleanings to by applied:*
- Cleaned methods needs to be in a subclass of TestCase.
- Cleaned methods should not be extensions.
- The method should have no argument and start with `test` or `should`.
- The protocol of the method does not start with `test`.

**Chanel updates some protocols to follow convensions. For examplee it updates `#initialize-release` to `#initialize`. Find more in `ChanelProtocolsCleaner protocolsToCleanMap`.**

*Conditions for the cleanings to by applied:*
- Cleaned methods should not be extensions.
- Can be applied on instance and class side of traits and classes.
- The method protocol need to be present in  `ChanelProtocolsCleaner protocolsToCleanMap`.

*Warnings:*
This cleaning should not have any counter indication.

### Nil conditional simplifications

Chanel simplifies conditionals. For example it will rewrite:

| Original | Transformation |
| ------------- | ------------- |
| `x isNil ifTrue: y` | `x ifNil: y` |
| `x isNil ifFalse: y` | `x ifNotNil: y` |
| `x isNotNil ifTrue: y` | `x ifNotNil: y` |
| `x isNotNil ifFalse: y` | `x ifNil: y` |
| `x isNil ifTrue: y ifFalse: z` | `x ifNil: y ifNotNil: z` |
| `x isNil ifFalse: y ifTrue: z` | `x ifNil: z ifNotNil: y` |
| `x isNotNil ifTrue: y ifFalse: z` | `x ifNil: z ifNotNil: y` |
| `x isNotNil ifFalse: y ifTrue: z` | `x ifNil: y ifNotNil: z` |

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.
- Does not apply if the application of the pattern would cause an infinit loop. For example it will **not** rewrite:

```Smalltalk
ifNotNil: aBlock
	^ self isNil ifFalse: aBlock
```

into:

```Smalltalk
ifNotNil: aBlock
	^ self ifNotNil: aBlock
```

*Warnings:*
The only danger of this cleaning happens for projects working on multiple Smalltalks

### Empty conditional simplifications

Chanel simplifies empty conditionals. For example it will rewrite:

| Original | Transformation |
| ------------- | ------------- |
| `x isEmpty ifTrue: y` | `x ifEmpty: y` |
| `x isEmpty ifFalse: y` | `x ifNotEmpty: y` |
| `x isEmpty ifTrue: y ifFalse: z` | `x ifEmpty: y ifNotEmpty: z` |
| `x isEmpty ifFalse: y ifTrue: z` | `x ifEmpty: z ifNotEmpty: y` |
| `x isNotEmpty ifTrue: y` | `x ifNotEmpty: y` |
| `x isNotEmpty ifFalse: y` | `x ifEmpty: y` |
| `x isNotEmpty ifTrue: y ifFalse: z` | `x ifEmpty: z ifNotEmpty: y` |
| `x isNotEmpty ifFalse: y ifTrue: z` | `x ifEmpty: y ifNotEmpty: z` |
| `x ifEmpty: [ true ] ifNotEmpty: [ false ]` | `x isEmpty` |
| `x ifEmpty: [ false ] ifNotEmpty: [ true ]` | `x isNotEmpty` |
| `x ifNotEmpty: [ false ] ifEmpty: [ true ]` | `x isEmpty` |
| `x ifNotEmpty: [ true ] ifEmpty: [ false ]` | `x isNotEmpty` |
| `x isEmpty ifTrue: [ true ] ifFalse: [ false ]` | `x isEmpty` |
| `x isEmpty ifTrue: [ false ] ifFalse: [ true ]` | `x isNotEmpty` |
| `x isEmpty ifFalse: [ false ] ifTrue: [ true ]` | `x isEmpty` |
| `x isEmpty ifFalse: [ true ] ifTrue: [ false ]` | `x isNotEmpty` |
| `x isNotEmpty ifTrue: [ true ] ifFalse: [ false ]` | `x isNotEmpty` |
| `x isNotEmpty ifTrue: [ false ] ifFalse: [ true ]` | `x isEmpty` |
| `x isNotEmpty ifFalse: [ false ] ifTrue: [ true ]` | `x isNotEmpty` |
| `x isNotEmpty ifFalse: [ true ] ifTrue: [ false ]` | `x isEmpty` |

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.
- Does not apply if the application of the pattern would cause an infinit loop. For example it will **not** rewrite:

```Smalltalk
ifEmpty:: aBlock
	^ self isEmpty ifTrue: aBlock
```

into:

```Smalltalk
ifEmpty: aBlock
	^ self ifEmpty: aBlock
```

*Warnings:*
This cleaner might introduce problems in two cases:
- You project works on multiple smalltalks with different APIs
- You have your own objects implementing #isEmpty or #isNotEmpty but not the conditionals. 

### Cut conditionals branches

Chanel simplifies some conditionals by cutting branches. For example it will rewrite:

| Original | Transformation |
| ------------- | ------------- |
| `x ifNil: [ nil ]` | `x` |
| `x ifNil: [ nil ] ifNotNil: y` | `x ifNotNil: y` |
| `x ifNotNil: y ifNil: [ nil ]` | `x ifNotNil: y` |
| `x ifNil: nil` | `x` |
| `x ifNil: nil ifNotNil: y` | `x ifNotNil: y` |
| `x ifNotNil: y ifNil: nil` | `x ifNotNil: y` |
| `x ifTrue: [ true ] ifFalse: [ false ]` | `x` |
| `x ifTrue: [ false ] ifFalse: [ true ]` | `x not` |
| `x ifFalse: [ false ] ifTrue: [ true ]` | `x` |
| `x ifFalse: [ true ] ifTrue: [ false ]` | `x not` |
| `x ifNotNil: [ x ]` | `x` |
| `x ifNotNil: [ x ] ifNil: y` | `x ifNil: y` |
| `x ifNil: y ifNotNil: [ x ]` | `x ifNil: y` |
| `x ifEmpty: [ y ] ifNotEmpty: [ x ]` | `x ifEmpty: [ y ]` |
| `x ifNotNil: [ :e | e ] ifNil: y` | `x ifNil: y` |
| `x ifNil: y ifNotNil: [ :e | e ]` | `x ifNil: y` |
| `x ifNotEmpty: [ x ] ifEmpty: y` | `x ifEmpty: y` |
| `x ifEmpty: y ifNotEmpty: [ :e | e ]` | `x ifEmpty: y` |
| `x ifNotEmpty: [ :e | e ] ifEmpty: y` | `x ifEmpty: y` |	
| `x detect: y ifFound: [ :e | e ] ifNone: z ` | `x detect: y ifNone: z` |
| `x at: y ifPresent: [ :e | e ] ifAbsent: z ` | `x at: y ifAbsent: z` |
| `x at: y ifPresent: [ x at: y ] ifAbsent: z ` | `x at: y ifAbsent: z` |
| `x at: y ifPresent: [ :e | x at: y ] ifAbsent: z ` | `x at: y ifAbsent: z` |

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.
- Does not apply if the application of the pattern would cause an infinit loop. For example it will **not** rewrite:

*Warnings:*
The only danger of this cleaning happens for projects working on multiple Smalltalks or if an object implements parts of common Pharo API but not all


### Methods with alias unification

Chanel unify the use of some methods with alias. Here is the list of rewrites:

| Original | Transformation | Reason |
| ------------- | ------------- | ------------- |
| `x notEmpty` | `x isNotEmpty` | To be coherent with `isEmpty` |
| `x notNil` | `x isNotNil` | To be coherent with `isNil` |
| `x includesAnyOf: y` | `x includesAny: y` | Previous might be deprecated |
| `x includesAllOf: y` | `x includesAll: y` | Previous is deprecated in P9 |
| `x ifNotNilDo: y` | `x ifNotNil: y` | Missleading. `Do:` is usually for iterations |
| `x ifNil: y ifNotNilDo: z` | `x ifNil: y ifNotNil: z` | Missleading. `Do:` is usually for iterations |
| `x ifNotNilDo: y ifNil: z` | `x ifNotNil: y ifNil: z` | Missleading. `Do:` is usually for iterations |

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.
- Does not apply if the application of the pattern would cause an infinit loop. For example it will **not** rewrite:

```Smalltalk
ifNotNil: aBlock
	^ self isNil ifFalse: aBlock
```

into:

```Smalltalk
ifNotNil: aBlock
	^ self ifNotNil: aBlock
```

*Warnings:*
The only danger of this cleaning happens for projects working on multiple Smalltalks or is a project implements ont of those methods and do something else than the ones present in Pharo.

### Test case names

Chanel rename each test case ending with `Tests` te end with `Test` since this is `a XXTestCase`.

*Conditions for the cleanings to by applied:*
- The class needs to be a subclass of TestCase.
- The class name needs to end with `Tests`.
- The system should not contain a class with the same name without the final `s`.

*Warnings:*
This cleaning should not have any counter indication.

### Ensure right super are call

**Ensure `#setUp` in TestCases always begins by `super setUp` (move it if not the first messand sent)**

*Conditions for the cleanings to by applied:*
- The class needs to be a subclass of `TestCase`.
- The method selector needs to be `setUp`.
- The method needs to send at least one message. We consider that an empty `#setUp` method was created to prevent the execution of the method it overrides.
- The first sent message needs to be different of `super setUp`.

**Ensure `#tearDown` in TestCases always ends by `super tearDown` (move it if not the last messand sent)**

*Conditions for the cleanings to by applied:*
- The class needs to be a subclass of `TestCase`.
- The method selector needs to be `tearDown`.
- The method needs to send at least one message. We consider that an empty `#tearDown` method was created to prevent the execution of the method it overrides.
- The last sent message needs to be different of `super tearDown`.

**Ensure `#initialize` on instance side always has `super initialize`**

*Conditions for the cleanings to by applied:*
- Works on any class or trait.
- The method selector needs to be `initialize`.
- The method needs to send at least one message. We consider that an empty `#initialize` method was created to prevent the execution of the method it overrides.
- None of the sent message should be `super initialize`.

*Warnings:*
A problem might happen if a super was deliberatly ignored.

### Remove nil assignments in initialization

Chanel removes all nil assignations in `initialize` methods because most of the time they are not needed. 

*Conditions for the cleanings to by applied:*
- The method selector needs to be `#initialize`.
- The method should contain nil assignations.

*Warnings:*
This might be a problem in some rare case where #initialize methods are called by teh user to reset an instance. In that case it is recommended to create a `#reset` method.

### Remove methods only calling super

Remove each methods only doing a super call. This does not remove methods with pragmas.

*Conditions for the cleanings to by applied:*
- The method should have only one message sent that is a call to the super of the same selector.
- The method should not have any pragma.

*Warnings:*
This might remove methods added just to add comments in a subclass.

### Remove unread temporaries

Remove all temporaries that are defined but not read.

*Conditions for the cleanings to by applied:*
- The method should have at least one temporary that is never read in its scope.

*Warnings:*
This might remove methods that were intentionally created with the flaw for testing purpose.

### Remove duplicated methods from traits 

If methods present on traits are duplicated in a classe or a trait using the trait, Chanel removes the duplicated version.

*Conditions for the cleanings to by applied:*
- The class or trait of the method needs to use at least on trait
- The method should have another method in the trait composition with the same name and the same AST.

*Warnings:*
This cleaning should not have any counter indication.

### Remove methods with equivalent in super classes.

If a methods has an equivalent method of the same name in a super class, Chanel remove the method.

*Conditions for the cleanings to by applied:*
- Work only on instances and class side of classes. Does not work on traits.
- The superclass of the method should not be nil.
- The method should override another method in the hierarchy.
- The overriden method as the same AST than the overriding method.

*Warnings:*
This cleaning should not have any counter indication.

### Categorize unclassified methods

Chanel try to use the system method categorizer to classify unclassified methods.

*Conditions for the cleanings to by applied:*
- Work on instances and class side of classes and traits.
- The protocol of the method needs to by `as yet unclassified`.

*Warnings:*
This cleaning should not have any counter indication.


### Empty assertions

Chanel iterates on all the tests of the packages and clean empty assertions. 
Here is the list of rewrites it will apply:

| Original | Transformation |
| ------------- | ------------- |
| `x assert: y isEmpty` | `x assertEmpty: y` |
| `x deny: y isEmpty` | `x denyEmpty: y` |
| `x assert: y isNotEmpty` | `x denyEmpty: y` |
| `x deny: y isNotEmpty` | `x assertEmpty: y` |

`#assertEmpty:` and `denyEmpty:` were added in Pharo 8 and gives better descriptions in case of failure than simple asserts.

*Conditions for the cleanings to by applied:*
- Only subclasses of TestCase are cleaned.
- Does not clean the traits in the packages.
- A pattern from the list above match.
- The minimal pharo version provided is supperior to 8.

*Warnings:*
The danger of this cleaning happens on projects working in Pharo < 8. Some of this new assertions were introduced in Pharo 8.
You can precise the minimal Pharo version on which the project should run to avoid the application of those rules.

### Remove useless nodes from AST

Chanel goes over all the methods in the system to remove some useless nodes.


*Conditions for the cleanings to by applied:*

A node can be useless if they are:
- A literal
- A block
- A global
- A temporary usage
- An instance variable usage
- An argument usage
- A literal array
- A dynamic array

And if none of its ancestor in the ast are:
- A return
- A message 
- A pragma
- A dynamic array
- A literal array
- An assigment

*Warnings:*
This cleaner has multiple warnings:
- This can remove literals that where here as a tag. They should be replaced by a pragma or a call to `Object>>#flag:`
- Read accesses to instance variables are removed if they are not used. In some edge cases, those accesses can be to a slot with behavior in the read access. It should be rare, but this can change the behavior of the code.
- Some dynamic arrays can be removed. In the array, message changing the state of the objects can be called. Removing them can change the behavior of the code. We still remove them because it is not a clean way to manage states changes.

### Remove unecessary assignments

Chanels removes assigments to itself. For example it will rewrite:

```Smalltalk
test
	| toto |
	toto := 2.
	toto := toto.
	^ toto
```

To

```Smalltalk
test
	| toto |
	toto := 2.
	^ toto
```

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.

*Warnings:*
This cleaning should not have any counter indication.

### Nil equality cleaner


Chanel replace of nil equality by #isNil or #isNotNil. Here is the list of rewrites:

| Original | Transformation | Reason |
| ------------- | ------------- | ------------- |
| `x = nil` | `x isNil` |
| `x == nil` | `x isNil` |
| `x ~= nil` | `x isNotNil` |
| `x ~~ nil` | `x isNotNil` |

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.
- Does not apply if the application of the pattern would cause an infinit loop. For example it will **not** rewrite:

```Smalltalk
isNil
  ^ self = nil
```

into:

```Smalltalk
isNil
  ^ self isNil
```

*Warnings:*
The only danger of this cleaning happens for projects working on multiple Smalltalks or is a project implements ont of those methods and do something else than the ones present in Pharo.

### Remove unecessary not

Chanel remove some unecessary call to `not` to make code easier to read. Here is the list of rewrites:

| Original | Transformation | Reason |
| ------------- | ------------- | ------------- |
| `true not` | `false` |
| `false not` | `true` |
| `x not not` | `x` |
| `x not ifTrue: y` | `x ifFalse: y` |
| `x not ifFalse: y` | `x ifTrue: y` |
| `x not ifTrue: y1 ifFalse: z` | `x ifTrue: z ifFalse: y1` |
| `x not ifFalse: y1 ifTrue: z` | `x ifTrue: y1 ifFalse: z` |
| `x isEmpty not` | `x isNotEmpty` |
| `x isNotEmpty not` | `x isEmpty` |
| `x isNil not` | `x isNotNil` |
| `x isNotNil not` | `x isNil` |
| `x select: [:temp \| a not]` | `x reject: [:temp \| a]` |
| `x reject: [:temp \| a not]` | `x select: [:temp \| a]` |
| `(x <= y) not` | `x > y` |
| `(x < y) not` | `x >= y` |
| `(x = y) not` | `x ~= y` |
| `(x == y) not` | `x ~~ y` |
| `(x ~= y) not` | `x = y` |
| `(x ~~ y) not` | `x == y` |
| `(x >= y) not` | `x < y` |
| `(x > y) not` | `x <= y` |
| `[ a not] whileTrue: y` | `[ a] whileFalse: y` |
| `[ a not] whileFalse: y` | `[ a] whileTrue: y` |
| `[ a not] whileTrue` | `[ a] whileFalse` |
| `[ a not] whileFalse` | `[ a] whileTrue` |

*Conditions for the cleanings to by applied:*
- Can be applied on any classes and traits.
- A pattern from the list above match.
- Does not apply if the application of the pattern would cause an infinit loop. For example it will **not** rewrite:

```Smalltalk
>= arg
  ^(self < arg) not
```

into:

```Smalltalk
>= arg
  ^self >= arg
```

*Warnings:*
This cleaner can be dangerous if you have classes implementing #`isEmpty` without #`isNotEmpty` for example.

### Extract return from conditionals

In case a conditional ends with a return in all its branches, `Chanel` tries to extract it.

List of supported conditionals:
- `#ifTrue:ifFalse:` 
- `#ifFalse:ifTrue:` 
- `#ifNil:ifNotNil:` 
- `#ifNotNil:ifNil:` 
- `#ifEmpty:ifNotEmpty:` 
- `#ifNotEmpty:ifEmpty:`
-  `#ifExists:ifAbsent:`

*Conditions for the cleanings to by applied:*
- The AST node is a message.
- The node is not in a cascade.
- The node is the last node of the parent (if not, it would not be possible to compile a return at this place).
- The node selector matches a selector above.
- All arguments are blocks (none should be symbol).
- All arguments should have a return as last statement.

*Warnings:*
This cleaning should not have any counter indication.

