"
Description
--------------------


I am a cleaner that will fix the equality assertions of a project's test cases.  I'll replace those cases:


x assert: y = z 					==> x assert: y equals: z

x deny: y = z 						==> x deny: y equals: z

x assert: y == z 					==> x assert: y identicalTo: z

x deny: y == z 						==> x deny: y identicalTo: z

x assert: y = true 				==> x assert: y

x deny y = true 					==> x deny: y

x assert: y = false 				==> x deny: y

x deny: y = false 					==> x assert: y

x assert: y equals: true 		==> x assert: y

x deny y equals: true 			==> x deny: y

x assert: y equals: false 		==> x deny: y

x deny: y equals: false 			==> x assert: y
"
Class {
	#name : #ChanelTestEqualityCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelTestEqualityCleaner class >> priority [
	^ 1000
]

{ #category : #cleaning }
ChanelTestEqualityCleaner >> clean [
	self rewriteMethodsOf: self configuration definedTestCases with: self equalityRewriter
]

{ #category : #cleaning }
ChanelTestEqualityCleaner >> equalityRewriter [
	^ RBParseTreeRewriter new
		replace: '`@receiver assert: `@arg = true' with: '`@receiver assert: `@arg';
		replace: '`@receiver deny: `@arg = true' with: '`@receiver deny: `@arg';
		replace: '`@receiver assert: `@arg = false' with: '`@receiver deny: `@arg';
		replace: '`@receiver deny: `@arg = false' with: '`@receiver assert: `@arg';
		replace: '`@receiver assert: `@arg equals: true' with: '`@receiver assert: `@arg';
		replace: '`@receiver deny: `@arg equals: true' with: '`@receiver deny: `@arg';
		replace: '`@receiver assert: `@arg equals: false' with: '`@receiver deny: `@arg';
		replace: '`@receiver deny: `@arg equals: false' with: '`@receiver assert: `@arg';
		replace: '`@receiver assert: `@arg = `@arg2' with: '`@receiver assert: `@arg equals: `@arg2';
		replace: '`@receiver deny: `@arg = `@arg2' with: '`@receiver deny: `@arg equals: `@arg2';
		replace: '`@receiver assert: `@arg == `@arg2' with: '`@receiver assert: `@arg identicalTo: `@arg2';
		replace: '`@receiver deny: `@arg == `@arg2' with: '`@receiver deny: `@arg identicalTo: `@arg2';
		replace: '`@receiver assert: `@arg = true' with: '`@receiver assert: `@arg';
		yourself
]
