"
Description
--------------------

I am a cleaner simplifying conditionals. For example I'll rewrite:

x isNil ifTrue: y 							==> x ifNil: y

x isNil ifFalse: y 						==> x ifNotNil: y

x isNotNil ifTrue: y 						==> x ifNotNil: y

x isNotNil ifFalse: y 					==> x ifNil: y

x isNil ifTrue: y ifFalse: z 			==> x ifNil: y ifNotNil: z

x isNil ifFalse: y ifTrue: z 			==> x ifNil: z ifNotNil: y

x isNotNil ifTrue: y ifFalse: z 		==> x ifNil: z ifNotNil: y

x isNotNil ifFalse: y ifTrue: z 		==> x ifNil: y ifNotNil: z

"
Class {
	#name : 'ChanelNilConditionalSimplifierCleaner',
	#superclass : 'ChanelMethodRewriterCleaner',
	#category : 'Chanel',
	#package : 'Chanel'
}

{ #category : 'accessing' }
ChanelNilConditionalSimplifierCleaner class >> requirements [
	^ { ChanelMethodAliasesCleaner . ChanelRemoveUnecesaryNotCleaner . ChanelNilEqualitySimplifierCleaner }
]

{ #category : 'cleaning' }
ChanelNilConditionalSimplifierCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`@receiver isNil ifTrue: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver isNil ifFalse: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifTrue: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifFalse: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver isNil ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		replace: '`@receiver isNil ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifNil: `@arg2 ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifNil: `@arg2 ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		yourself
]
