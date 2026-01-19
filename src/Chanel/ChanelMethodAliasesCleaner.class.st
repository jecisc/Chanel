"
Description
--------------------

I am a cleaner that will replace aliases with only one of the form. 

For example I'll replace `notEmpty` by `isNotEmpty` and `notNil` by `isNotNil`. The reason is that it is more coherent with `isNil` that cannot be written `nil`.

I'll also replace `ifNotNilDo:` because it is not an iteration and the name is missleading.
"
Class {
	#name : 'ChanelMethodAliasesCleaner',
	#superclass : 'ChanelMethodRewriterCleaner',
	#category : 'Chanel',
	#package : 'Chanel'
}

{ #category : 'cleaning' }
ChanelMethodAliasesCleaner >> rewriter [
	^ RBParseTreeRewriter new
		replace: '`@receiver notEmpty' with: '`@receiver isNotEmpty';
		replace: '`@receiver notNil' with: '`@receiver isNotNil';
		replace: '`@receiver includesAnyOf: `@arg' with: '`@receiver includesAny: `@arg';
		replace: '`@receiver includesAllOf: `@arg' with: '`@receiver includesAll: `@arg';
		replace: '`@receiver ifNotNilDo: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver ifNil: `@arg ifNotNilDo: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		replace: '`@receiver ifNotNilDo: `@arg ifNil: `@arg2' with: '`@receiver ifNotNil: `@arg ifNil: `@arg2';
		yourself
]
