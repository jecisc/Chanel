"
Description
--------------------

I am a cleaner removing unecessary assigments.
"
Class {
	#name : #ChanelRemoveAssigmentWithoutEffectCleaner,
	#superclass : #ChanelMethodRewriterCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelRemoveAssigmentWithoutEffectCleaner class >> priority [
	^ 300
]

{ #category : #cleaning }
ChanelRemoveAssigmentWithoutEffectCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`var := `var' with: '';
		yourself
]
