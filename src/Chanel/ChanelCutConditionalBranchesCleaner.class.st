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
ChanelCutConditionalBranchesCleaner class >> priority [
	^ 4000
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
		yourself
]
