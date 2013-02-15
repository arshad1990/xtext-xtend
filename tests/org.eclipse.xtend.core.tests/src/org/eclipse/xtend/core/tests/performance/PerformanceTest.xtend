package org.eclipse.xtend.core.tests.performance

import com.google.inject.Inject
import java.util.List
import org.eclipse.xtend.core.tests.AbstractXtendTestCase
import org.eclipse.xtext.junit4.internal.StopwatchRule
import org.junit.Ignore
import org.junit.Rule
import org.junit.Test

import static org.eclipse.xtext.util.internal.Stopwatches.*

class PerformanceTest extends AbstractXtendTestCase {
	
	@Inject XtendFileGenerator fileGenerator
	
	@Rule public static val rule = new StopwatchRule(true)

	/*
	Sven 2013-01-24 (old typesystem)
	-------------------------------------------------------------------------------------------------------------------------
	Task 'Validate all' took 20869ms (1 measurements).
	Task 'parsing' took 1181ms (57 measurements).
	Task 'primary JVM Model inference' took 1899ms (57 measurements).
	Task '[macros] findActiveAnnotations' took 802ms (57 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference' took 0ms (57 measurements).
	Task 'Crosslink resolution' took 23223ms (11902 measurements).
	Task 'validation' took 17002ms (57 measurements).
	----------------------------------------------------
	
	Sven 2013-01-24 (new typesystem)
	-------------------------------------------------------------------------------------------------------------------------
	Task 'Validate all' took 19591ms (1 measurements).
	Task 'parsing' took 1087ms (57 measurements).
	Task 'primary JVM Model inference' took 1703ms (57 measurements).
	Task '[macros] findActiveAnnotations' took 824ms (57 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference' took 0ms (57 measurements).
	Task 'Crosslink resolution' took 6639ms (4076 measurements).
	Task 'validation' took 15979ms (57 measurements).
	Task 'DefaultReentrantTypeResolver.resolve' took 12025ms (57 measurements).
	Task 'LightweightTypeReference.copyInto' took 84ms (379414 measurements).
	Task 'LightweightTypeReference#internalIsAssignableFrom' took 1745ms (283109 measurements).
	Task 'LightweightTypeReference#collectSuperTypes' took 13ms (267 measurements).
	Task 'DeclaratorTypeArgumentCollector.getTypeParameterMapping' took 159ms (31429 measurements).
	Task 'UnboundTypeReference.copyInto' took 23ms (24385 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	* 
	Sven 2013-01-24 (after cached ClassFinder - new typesystem)
	-------------------------------------------------------------------------------------------------------------------------
	Task 'Validate all' took 14995ms (1 measurements).
	Task 'parsing' took 1166ms (57 measurements).
	Task 'primary JVM Model inference' took 1229ms (57 measurements).
	Task '[macros] findActiveAnnotations' took 596ms (57 measurements).
	Task 'Load class ' took 329ms (204809 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference' took 1ms (57 measurements).
	Task 'Crosslink resolution' took 2366ms (4076 measurements).
	Task 'validation' took 11717ms (57 measurements).
	Task 'DefaultReentrantTypeResolver.resolve' took 9475ms (57 measurements).
	Task 'LightweightTypeReference.copyInto' took 114ms (379414 measurements).
	Task 'LightweightTypeReference#internalIsAssignableFrom' took 1730ms (283109 measurements).
	Task 'LightweightTypeReference#collectSuperTypes' took 14ms (267 measurements).
	Task 'DeclaratorTypeArgumentCollector.getTypeParameterMapping' took 157ms (31429 measurements).
	Task 'UnboundTypeReference.copyInto' took 28ms (24385 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	Sven 2013-01-24 (after cached ClassFinder - new typesystem)
	-------------------------------------------------------------------------------------------------------------------------
	Task 'Validate all' took 14135ms (1 measurements).
	Task 'parsing' took 1243ms (57 measurements).
	Task 'primary JVM Model inference' took 1416ms (57 measurements).
	Task '[macros] findActiveAnnotations' took 569ms (57 measurements).
	Task 'Load class ' took 301ms (60879 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference' took 0ms (57 measurements).
	Task 'Crosslink resolution' took 12790ms (11902 measurements).
	Task 'validation' took 10647ms (57 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	
	Test 'doCompile(org.eclipse.xtend.core.tests.performance.PerformanceTest)' :
	-------------------------------------------------------------------------------------------------------------------------
	Task 'Validate all' took 10521ms (1 measurements).
	Task 'parsing' took 720ms (57 measurements).
	Task 'primary JVM Model inference' took 1756ms (57 measurements).
	Task '[macros] findActiveAnnotations' took 1202ms (57 measurements).
	Task 'ClassFinder.forName' took 1189ms (60887 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference' took 0ms (57 measurements).
	Task 'Crosslink resolution' took 10582ms (11902 measurements).
	Task 'validation' took 7569ms (57 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	Test 'doCompile(org.eclipse.xtend.core.tests.performance.PerformanceTest)' :
	-------------------------------------------------------------------------------------------------------------------------
	Task 'PerformanceTest.doCompile' took 9253ms (1 measurements).
	Task 'AbstractParser.parse' took 696ms (57 measurements).
	Task 'primary JVM Model inference (JvmModelAssociator.installDerivedState)' took 1485ms (57 measurements).
	Task '[macros] findActiveAnnotations (ActiveAnnotationContextProvider.computeContext)' took 1113ms (57 measurements).
	Task 'ClassFinder.forName' took 237ms (172817 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference (JvmModelAssociator.installDerivedState)' took 0ms (57 measurements).
	Task 'Crosslink resolution (DefaultLinkingService.getLinkedObjects)' took 2225ms (4074 measurements).
	Task 'ResourceValidatorImpl.validation' took 6575ms (57 measurements).
	Task 'DefaultReentrantTypeResolver.resolve' took 5101ms (114 measurements).
	Task 'LightweightTypeReference.copyInto' took 70ms (274432 measurements).
	Task 'LightweightTypeReference#internalIsAssignableFrom' took 1295ms (265117 measurements).
	Task 'LightweightTypeReference#collectSuperTypes' took 5ms (62 measurements).
	Task 'DeclaratorTypeArgumentCollector.getTypeParameterMapping' took 57ms (12012 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	Test 'doCompile(org.eclipse.xtend.core.tests.performance.PerformanceTest)' :
	(without warmup)
	-------------------------------------------------------------------------------------------------------------------------
	Task 'PerformanceTest.doCompile' took 8441ms (1 measurements).
	Task 'AbstractParser.parse' took 723ms (57 measurements).
	Task 'primary JVM Model inference (JvmModelAssociator.installDerivedState)' took 1507ms (57 measurements).
	Task '[macros] findActiveAnnotations (ActiveAnnotationContextProvider.computeContext)' took 1105ms (57 measurements).
	Task 'ClassFinder.forName' took 199ms (72275 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference (JvmModelAssociator.installDerivedState)' took 0ms (57 measurements).
	Task 'Crosslink resolution (DefaultLinkingService.getLinkedObjects)' took 2312ms (4074 measurements).
	Task 'ResourceValidatorImpl.validation' took 5690ms (57 measurements).
	Task 'DefaultReentrantTypeResolver.resolve' took 3923ms (114 measurements).
	Task 'LightweightTypeReference.copyInto' took 44ms (94082 measurements).
	Task 'LightweightTypeReference#internalIsAssignableFrom' took 491ms (74909 measurements).
	Task 'LightweightTypeReference#collectSuperTypes' took 6ms (62 measurements).
	Task 'DeclaratorTypeArgumentCollector.getTypeParameterMapping' took 73ms (11369 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	(with warmup)
	Task 'PerformanceTest.doCompile' took 6106ms (1 measurements).
	Task 'AbstractParser.parse' took 408ms (57 measurements).
	Task 'primary JVM Model inference (JvmModelAssociator.installDerivedState)' took 349ms (57 measurements).
	Task '[macros] findActiveAnnotations (ActiveAnnotationContextProvider.computeContext)' took 159ms (57 measurements).
	Task 'ClassFinder.forName' took 311ms (72275 measurements).
	Task 'secondary (i.e. Macros) JVM Model inference (JvmModelAssociator.installDerivedState)' took 0ms (57 measurements).
	Task 'Crosslink resolution (DefaultLinkingService.getLinkedObjects)' took 1267ms (4074 measurements).
	Task 'ResourceValidatorImpl.validation' took 5108ms (57 measurements).
	Task 'DefaultReentrantTypeResolver.resolve' took 3730ms (114 measurements).
	Task 'LightweightTypeReference.copyInto' took 24ms (94082 measurements).
	Task 'LightweightTypeReference#internalIsAssignableFrom' took 442ms (74909 measurements).
	Task 'LightweightTypeReference#collectSuperTypes' took 0ms (62 measurements).
	Task 'DeclaratorTypeArgumentCollector.getTypeParameterMapping' took 54ms (11369 measurements).
	-------------------------------------------------------------------------------------------------------------------------
	 */
	@Test def void doCompile() {
		val num = 50;
		val map = fileGenerator.getDependencies();
		val List<String> files = newArrayList() 
		files.addAll(map.values.map[toString])
		val config = new GeneratorConfig();
		config.packageName = "generated";
		config.noTypeInference = false;
		for (i : 0..num) {
			config.className = "MyGeneratedType"+i;
			files.add(fileGenerator.getContents(config).toString());
		}
		val task = forTask("PerformanceTest.doCompile")
		task.start
		files(true, files as String[])
		task.stop
	}
	
	@Test
	@Ignore
	def void doCompileTwice() {
		doCompile
		doCompile
	}
	
	@Test
	@Ignore
	def void doCompileThreeTimes() {
		doCompile
		doCompile
		doCompile
	}
	
	@Test
	@Ignore
	def void doCompileFiveTimes() {
		doCompile
		doCompile
		doCompile
		doCompile
		doCompile
	}
}

