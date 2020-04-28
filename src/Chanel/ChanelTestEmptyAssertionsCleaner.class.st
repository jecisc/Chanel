"
Description
--------------------

I am a cleaner replacing the invocation of #assert: with #isEmpty or #isNotEmpty by #assertEmpty: or #denyEmpty: in Pharo >= 8. 

The reason is that it gives better logs in case of failure.
"
Class {
	#name : #ChanelTestEmptyAssertionsCleaner,
	#superclass : #ChanelMethodRewriterCleaner,
	#category : #Chanel
}

{ #category : #testing }
ChanelTestEmptyAssertionsCleaner class >> isAvailableForPharo: anInteger [
	^ anInteger >= 8
]

{ #category : #accessing }
ChanelTestEmptyAssertionsCleaner class >> priority [
	^ 1100
]

{ #category : #cleaning }
ChanelTestEmptyAssertionsCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`@receiver assert: `@arg isEmpty' with: '`@receiver assertEmpty: `@arg';
		replace: '`@receiver deny: `@arg isEmpty' with: '`@receiver denyEmpty: `@arg';
		replace: '`@receiver assert: `@arg isNotEmpty' with: '`@receiver denyEmpty: `@arg';
		replace: '`@receiver deny: `@arg isNotEmpty' with: '`@receiver assertEmpty: `@arg';
		yourself
]

{ #category : #cleaning }
ChanelTestEmptyAssertionsCleaner >> scope [
	^ self configuration definedTestCases
]
