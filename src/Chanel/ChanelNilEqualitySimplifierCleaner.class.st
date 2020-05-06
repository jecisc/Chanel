"
Description
--------------------

I am a cleaner replacing equality to nil by calls to #isNil or #isNotNil.
"
Class {
	#name : #ChanelNilEqualitySimplifierCleaner,
	#superclass : #ChanelMethodRewriterCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelNilEqualitySimplifierCleaner class >> priority [
	^ 2500
]

{ #category : #cleaning }
ChanelNilEqualitySimplifierCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`@object = nil' with: '`@object isNil';
		replace: '`@object == nil' with: '`@object isNil';
		replace: '`@object ~= nil' with: '`@object isNotNil';
		replace: '`@object ~~ nil' with: '`@object isNotNil';
		yourself
]
