package mainGame.backend.data;

class Versions {

    public static var myFreakingEngine:String = '0.8.4 alpha';

    public static var psychEngineVersion:String = '0.7.1h';

    public static var vanilaVersion:String = '0.2.8';

    #if debug
    public static var dataBuild:String = "" + Date.now();
    #end
}