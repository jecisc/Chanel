<!--
git log --pretty="* %s ([%h](https://github.com/jecisc/Chanel/commit/%H))" v1.1.1...HEAD --grep="Merge pull" 
('Content' copyWithRegex: 'Merge pull request #[0-9]+ from [^/]+/[0-9]*' matchesReplacedWith: '') copyReplaceAll: '-' with: ' '
-->

# [v1.1.1](https://github.com/jecisc/TinyLogger/compare/v1.1.0...v1.1.1) (2020-08-13)

## Bug fixes

* Fix Pharo 9 compatibility ([23e5380](https://github.com/jecisc/Chanel/commit/23e53808e0f10083f660bee1a1a615c9f765d837))

# [v1.1.0](https://github.com/jecisc/TinyLogger/compare/v1.0.0...v1.1.0) (2020-06-01)

## General structure

* Extract each cleaning to its own class ([6d5e7c0](https://github.com/jecisc/Chanel/commit/6d5e7c07266e2d9281e10be88b6cfde3b2faee53))
* Review priority system to use topological sort ([971a92b](https://github.com/jecisc/Chanel/commit/971a92bf1e6b1f5d2ca310f33148c1679c2911fd))
* Add tests (loooots of tests) ([6d662de](https://github.com/jecisc/Chanel/commit/6d662dea6e0f472603c79cf3fbc459119a86f8ab))
* Add world menu entry ([d6ff456](https://github.com/jecisc/Chanel/commit/d6ff456dea5eb3645f81c97c093f55c0a15ca211))
* Add a way to select cleaners to call ([f2d3f67](https://github.com/jecisc/Chanel/commit/f2d3f673c2a1077bfb6a97abe79ff76e7c5e8b00))
* Add progress bar ([731a013](https://github.com/jecisc/Chanel/commit/731a0131f3e2375df816be958962c375f65a3321))
* Use Iterators ([1733c12](https://github.com/jecisc/Chanel/commit/1733c128fecca04052305ae19d2d34d4051f81d6))
* Add tests for each cleaner working on local methods that trait methods are not duplicated in class ([e15dda3](https://github.com/jecisc/Chanel/commit/e15dda3e8ea6ca8fbd423b6ba03eb1673ffea543))
* Add tests that extension methods dont have their protocol updated ([1cb1e3b](https://github.com/jecisc/Chanel/commit/1cb1e3b8011cfd3c97dd296b260b13de2b8c6b22))
* Add tests on cleaners about instanceclass sides cleanings ([70e8169](https://github.com/jecisc/Chanel/commit/70e816906bd479c78dbcc735138b12b81c6c1cfb))
* Use tiny logger to log everything that is changed in the code ([0bd83ce](https://github.com/jecisc/Chanel/commit/0bd83ce0825d5bf04c2e8157a52ff13aeb2aef80))
* Do not rewrite return with the call of the self method infinite loop ([676ca7b](https://github.com/jecisc/Chanel/commit/676ca7b38a9758900c03c0dc4f3e1bbb33087940))
* Add descriptions of all conditions in the documentation ([3fbc17e](https://github.com/jecisc/Chanel/commit/3fbc17e2b0b61edc4a0edcb8d7bd8c62575e1146))
* Add parameter to set the minimal version of Pharo in which the cleaned project should work ([8b16997](https://github.com/jecisc/Chanel/commit/8b16997b292d4c8e6b6995b4886b8ea4d457d703))
* Review priorities and add tests to ensure some are in the right order ([1067096](https://github.com/jecisc/Chanel/commit/10670966950041cd215ac0a558a170e3f2badb6f))
* Improve test to make it easier to write test about non rewritten methods ([5df6518](https://github.com/jecisc/Chanel/commit/5df6518079444f3b0d8832328456210806172d7d))

## New cleaners

* Add a cleaner to extract an assignation happening in both branches as last statement ([0d90455](https://github.com/jecisc/Chanel/commit/0d904552b1e9c919292d7f23c5accff444f317af))
* Add a cleaner extracting returns for conditionals with return as last statement in the two branches ([24eb895](https://github.com/jecisc/Chanel/commit/24eb895e98e205d251252cea8bd658fad0540908))
* Add rewrite for assert true and equivalents ([6cb60bc](https://github.com/jecisc/Chanel/commit/6cb60bc151bfcbe766b6dfcb002bdf6e43f6b40d))
* Cleaner to use only one version of some aliases (because some will be deprecated and others simplifies future cleaners) ([7022f3c](https://github.com/jecisc/Chanel/commit/7022f3ceceffd96d8801c061137dfc8431e78517))
* Cleaner to remove method with equivalent defined in super class  ([3671d2a](https://github.com/jecisc/Chanel/commit/3671d2afd148e51f76a1fc05296cfaa787e8f150))
* Add cleaner to classify unclassified methods with automatic categorizer  ([66e96b4](https://github.com/jecisc/Chanel/commit/66e96b433499782d475aa3ba48f23e4d7a9025b7))
* Add a cleaner rewriting `assert: x isEmpty` to use `assertEmpty:` & co ([a4443f2](https://github.com/jecisc/Chanel/commit/a4443f24fc76d4c51780129c5d864668283739fb))
* Check for methods in traits already present in a trait they use ([c34fc39](https://github.com/jecisc/Chanel/commit/c34fc39cfd79acda7a2607ec0996016be6367ef2))
* Remove some unecessary nodes from the AST ([18fce47](https://github.com/jecisc/Chanel/commit/18fce47b1b28a52c9e7b5f6f3aecfb46d76b05a1))
* Add simplification for ifEmpty:ifNotEmpty: ([aad07b1](https://github.com/jecisc/Chanel/commit/aad07b15e48c17c36ebb3b6f71de3b402d89867e))
* Introduce a cleaner removing useless conditional branches such as `ifNil: [ nil ]` ([96b851e](https://github.com/jecisc/Chanel/commit/96b851e86bb6db8748260cb3c2bb57ad50885e79))
* Remove assignment to itself ([feb98f3](https://github.com/jecisc/Chanel/commit/feb98f3e03a713f08a9e56d2b2e138e53b7ae31d))
* Clean equals nil  ([725f0a0](https://github.com/jecisc/Chanel/commit/725f0a04a0f1ce6fe415d196207943b04a1f6c76))
* Add cleaner to remove unecessary not ([f559984](https://github.com/jecisc/Chanel/commit/f559984ab968b47e081853edc58bd0bd5818f9eb))

## Enhancements

* Extract return should run before cut conditional branches ([399108c](https://github.com/jecisc/Chanel/commit/399108c83767f065d2be6e4b5984ada406dd1c5e))
* Reapply ChanelExtractReturnFromAllBranchesCleanerTest on methods who were cleaned in case we can extract more of them ([71f3eab](https://github.com/jecisc/Chanel/commit/71f3eaba8c919f32a4ab31eefe01e2ca37f0681d))
* Improve cut branch cleaner to also clean branches with blocks only returning their argument ([e38cc05](https://github.com/jecisc/Chanel/commit/e38cc054a63c22f0a283d9234d90431c0dcf58c2))
* Add extensions to Pharo AST to make the code more readable ([0f02a3a](https://github.com/jecisc/Chanel/commit/0f02a3a58ddd34145d6d9ea5f798f2f07733e8ea))
* Improve nil conditions cleaner to have better rewrites ([2073166](https://github.com/jecisc/Chanel/commit/2073166b525b8819eefa435db97823995da39695))

## Bug fixes

* Remove nil assignment can fail in case of assignment in an assignment ([1472ea8](https://github.com/jecisc/Chanel/commit/1472ea82ce4bc074481d5f4c61ec491e2fe2369e))
* TestCase renaming should check there is not another class with the same name in the system ([d513f1b](https://github.com/jecisc/Chanel/commit/d513f1bdead979331cb30bd68a2aa66563d06106))

