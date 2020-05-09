"
Description
--------------------

I am a cleaner simplifying conditionals related to emptyness of collections.
"
Class {
	#name : #ChanelEmptyConditionalSimplifierCleaner,
	#superclass : #ChanelMethodRewriterCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelEmptyConditionalSimplifierCleaner class >> requirements [
	^ { ChanelMethodAliasesCleaner . ChanelRemoveUnecesaryNotCleaner }
]

{ #category : #cleaning }
ChanelEmptyConditionalSimplifierCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`@receiver ifEmpty: [ true ] ifNotEmpty: [ false ]' with: '`@receiver isEmpty';
		replace: '`@receiver ifEmpty: [ false ] ifNotEmpty: [ true ]' with: '`@receiver isNotEmpty';
		replace: '`@receiver ifNotEmpty: [ false ] ifEmpty: [ true ]' with: '`@receiver isEmpty';
		replace: '`@receiver ifNotEmpty: [ true ] ifEmpty: [ false ]' with: '`@receiver isNotEmpty';
		
		replace: '`@receiver isEmpty ifTrue: [ true ] ifFalse: [ false ]' with: '`@receiver isEmpty';
		replace: '`@receiver isEmpty ifTrue: [ false ] ifFalse: [ true ]' with: '`@receiver isNotEmpty';
		replace: '`@receiver isEmpty ifFalse: [ false ] ifTrue: [ true ]' with: '`@receiver isEmpty';
		replace: '`@receiver isEmpty ifFalse: [ true ] ifTrue: [ false ]' with: '`@receiver isNotEmpty';
		
		replace: '`@receiver isNotEmpty ifTrue: [ true ] ifFalse: [ false ]' with: '`@receiver isNotEmpty';
		replace: '`@receiver isNotEmpty ifTrue: [ false ] ifFalse: [ true ]' with: '`@receiver isEmpty';
		replace: '`@receiver isNotEmpty ifFalse: [ false ] ifTrue: [ true ]' with: '`@receiver isNotEmpty';
		replace: '`@receiver isNotEmpty ifFalse: [ true ] ifTrue: [ false ]' with: '`@receiver isEmpty';
	
		replace: '`@receiver isEmpty ifTrue: `@arg' with: '`@receiver ifEmpty: `@arg';
		replace: '`@receiver isEmpty ifFalse: `@arg' with: '`@receiver ifNotEmpty: `@arg';
		replace: '`@receiver isEmpty ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifEmpty: `@arg ifNotEmpty: `@arg2';
		replace: '`@receiver isEmpty ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifEmpty: `@arg2 ifNotEmpty: `@arg';
		
		replace: '`@receiver isNotEmpty ifTrue: `@arg' with: '`@receiver ifNotEmpty: `@arg';
		replace: '`@receiver isNotEmpty ifFalse: `@arg' with: '`@receiver ifEmpty: `@arg';
		replace: '`@receiver isNotEmpty ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifEmpty: `@arg2 ifNotEmpty: `@arg';
		replace: '`@receiver isNotEmpty ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifEmpty: `@arg ifNotEmpty: `@arg2';
		yourself
]
