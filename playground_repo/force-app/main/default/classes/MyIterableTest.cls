@IsTest
public class MyIterableTest {
    
    @IsTest
    private static void testIterableForLoop(){
		List<String> strings = new List<String>{'Hello', 'World'};
        MyIterable myIter = new MyIterable(strings);
        for(String s : myIter){
            System.debug(s);
        }
    }

}