"
Description
--------------------

I am a cleaner that will remove some useless conditional branches.
"
Class {
	#name : #ChanelCutConditionalBranchesCleaner,
	#superclass : #ChanelMethodRewriterCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelCutConditionalBranchesCleaner class >> requirements [
	^ { ChanelExtractReturnFromAllBranchesCleaner . ChanelNilConditionalSimplifierCleaner . ChanelEmptyConditionalSimplifierCleaner }
]

{ #category : #cleaning }
ChanelCutConditionalBranchesCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`@receiver ifNil: [ nil ]' with: '`@receiver';
		replace: '`@receiver ifNil: [ nil ] ifNotNil: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver ifNotNil: `@arg ifNil: [ nil ]' with: '`@receiver ifNotNil: `@arg';

		replace: '`@receiver ifNil: nil' with: '`@receiver';
		replace: '`@receiver ifNil: nil ifNotNil: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver ifNotNil: `@arg ifNil: nil' with: '`@receiver ifNotNil: `@arg';
		
		replace: '`@receiver ifTrue: [ true ] ifFalse: [ false ]' with: '`@receiver';
		replace: '`@receiver ifTrue: [ false ] ifFalse: [ true ]' with: '`@receiver not';
		replace: '`@receiver ifFalse: [ false ] ifTrue: [ true ]' with: '`@receiver';
		replace: '`@receiver ifFalse: [ true ] ifTrue: [ false ]' with: '`@receiver not';
		
		replace: '`@receiver ifNotNil: [ `@receiver ]' with: '`@receiver';
		replace: '`@receiver ifNotNil: [ `@receiver ] ifNil: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver ifNil: `@arg ifNotNil: [ `@receiver ]' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver ifNotNil: [ :`temp | `temp ] ifNil: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver ifNil: `@arg ifNotNil: [ :`temp | `temp ]' with: '`@receiver ifNil: `@arg';
		
		replace: '`@receiver ifEmpty: `@arg ifNotEmpty: [ `@receiver ]' with: '`@receiver ifEmpty: `@arg';
		replace: '`@receiver ifNotEmpty: [ `@receiver ] ifEmpty: `@arg' with: '`@receiver ifEmpty: `@arg';
		replace: '`@receiver ifEmpty: `@arg ifNotEmpty: [ :`temp | `temp ]' with: '`@receiver ifEmpty: `@arg';
		replace: '`@receiver ifNotEmpty: [ :`temp | `temp ] ifEmpty: `@arg' with: '`@receiver ifEmpty: `@arg';
		
		replace: '`@receiver detect: `@arg1 ifFound: [ :`arg2 | `arg2 ] ifNone: `@arg3 ' with: '`@receiver detect: `@arg1 ifNone: `@arg3';
		replace: '`@receiver at: `@arg1 ifPresent: [ :`arg2 | `arg2 ] ifAbsent: `@arg3 ' with: '`@receiver at: `@arg1 ifAbsent: `@arg3';
		replace: '`@receiver at: `@arg1 ifPresent: [ `@receiver at: `@arg1 ] ifAbsent: `@arg3 ' with: '`@receiver at: `@arg1 ifAbsent: `@arg3';
		replace: '`@receiver at: `@arg1 ifPresent: [ :`arg2 | `@receiver at: `@arg1 ] ifAbsent: `@arg3 ' with: '`@receiver at: `@arg1 ifAbsent: `@arg3';
		yourself
]
