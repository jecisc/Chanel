"
Description
--------------------

I am a cleaner simplifying statements using the #not method when possible to make the code more readable.
"
Class {
	#name : #ChanelRemoveUnecesaryNotCleaner,
	#superclass : #ChanelMethodRewriterCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelRemoveUnecesaryNotCleaner class >> requirements [
	^ { ChanelMethodAliasesCleaner }
]

{ #category : #cleaning }
ChanelRemoveUnecesaryNotCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: 'true not' with: 'false';
		replace: 'false not' with: 'true';
		replace: '`@receiver not not' with: '`@receiver';

		replace: '`@receiver not ifTrue: `@arg' with: '`@receiver ifFalse: `@arg';
		replace: '`@receiver not ifFalse: `@arg' with: '`@receiver ifTrue: `@arg';
		replace: '`@receiver not ifTrue: `@arg1 ifFalse: `@arg2' with: '`@receiver ifTrue: `@arg2 ifFalse: `@arg1';
		replace: '`@receiver not ifFalse: `@arg1 ifTrue: `@arg2' with: '`@receiver ifTrue: `@arg1 ifFalse: `@arg2';

		replace: '`@receiver isEmpty not' with: '`@receiver isNotEmpty';
		replace: '`@receiver isNotEmpty not' with: '`@receiver isEmpty';

		replace: '`@receiver isNil not' with: '`@receiver isNotNil';
		replace: '`@receiver isNotNil not' with: '`@receiver isNil';

		replace: '`@receiver select: [:`each | | `@temps | ``@.Statements. ``@object not]' with: '`@receiver reject: [:`each | | `@temps | ``@.Statements. ``@object]';
		replace: '`@receiver reject: [:`each | | `@temps | ``@.Statements. ``@object not]' with: '`@receiver select: [:`each | | `@temps | ``@.Statements. ``@object]';

		replace: '(`@receiver <= `@arg) not' with: '`@receiver > `@arg';
		replace: '(`@receiver < `@arg) not' with: '`@receiver >= `@arg';
		replace: '(`@receiver = `@arg) not' with: '`@receiver ~= `@arg';
		replace: '(`@receiver == `@arg) not' with: '`@receiver ~~ `@arg';
		replace: '(`@receiver ~= `@arg) not' with: '`@receiver = `@arg';
		replace: '(`@receiver ~~ `@arg) not' with: '`@receiver == `@arg';
		replace: '(`@receiver >= `@arg) not' with: '`@receiver < `@arg';
		replace: '(`@receiver > `@arg) not' with: '`@receiver <= `@arg';

		replace: '[| `@temps | ``@.Statements. ``@object not] whileTrue: ``@block' with: '[| `@temps | ``@.Statements. ``@object] whileFalse: ``@block';
		replace: '[| `@temps | ``@.Statements. ``@object not] whileFalse: ``@block' with: '[| `@temps | ``@.Statements. ``@object] whileTrue: ``@block';
		replace: '[| `@temps | ``@.Statements. ``@object not] whileTrue' with: '[| `@temps | ``@.Statements. ``@object] whileFalse';
		replace: '[| `@temps | ``@.Statements. ``@object not] whileFalse' with: '[| `@temps | ``@.Statements. ``@object] whileTrue';

		replace: 'self assert: `@arg not' with: 'self deny: `@arg';
		replace: 'self deny: `@arg not' with: 'self assert: `@arg';
		replace: 'self assert: `@arg1 equals: `@arg2 not' with: 'self deny: `@arg1 equals: `@arg2' when: [ :n | self minimalPharoVersion >= 7 ];
		replace: 'self assert: `@arg1 not equals: `@arg2' with: 'self deny: `@arg1 equals: `@arg2' when: [ :n | self minimalPharoVersion >= 7 ];
		replace: 'self deny: `@arg1 equals: `@arg2 not' with: 'self assert: `@arg1 equals: `@arg2';
		replace: 'self deny: `@arg1 not equals: `@arg2' with: 'self assert: `@arg1 equals: `@arg2';

		yourself
]
