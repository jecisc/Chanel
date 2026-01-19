"
Description
--------------------

I am a cleaner removing unecessary assigments.
"
Class {
	#name : 'ChanelRemoveAssigmentWithoutEffectCleaner',
	#superclass : 'ChanelMethodRewriterCleaner',
	#category : 'Chanel',
	#package : 'Chanel'
}

{ #category : 'accessing' }
ChanelRemoveAssigmentWithoutEffectCleaner class >> requirements [
	^ { ChanelCutConditionalBranchesCleaner }
]

{ #category : 'cleaning' }
ChanelRemoveAssigmentWithoutEffectCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`var := `var' with: '';
		yourself
]
