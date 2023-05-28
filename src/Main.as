package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import graphics.*;
	import system.KeyCodes;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	/**
	 * ...
	 * @author falcon12
	 */
	[Frame(factoryClass = "system.Preloader")]
	public class Main extends Sprite 
	{		
		private var _graphicsPreloader:GraphicsPreloader;
		
		private static var _instance:Main;
		private var _screen:Screen; 
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			//stage.addEventListener(Event.MOUSE_LEAVE, leave);
			//createBG();
			_graphicsPreloader = GraphicsPreloader.getInstance(stage);
			_graphicsPreloader.textBar = "Caching...";

			_instance = this;
			//stage.focus = this;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var cache:CacheLibrary = CacheLibrary.getInstance();
			var	list:Array = [SimpleLevel_mc, LevelDead_mc, Level_1D_6T_mc, Level_1D_3T_1A_mc, Level_2D_5T_1C_mc, Level1_mc, Level2_mc, Level3_mc, Level4_mc, Level5_mc, Level6_mc, Level7_mc, Level8_mc, Level9_mc, Level10_mc, Level11_mc, Level12_mc, Level13_mc, Level14_mc, Level15_mc, Disparity_orange_mc, Disparity_blue_mc, Disparity_green_mc, Disparity_purple_mc, Torch_menu_mc, WTorch_deactive_mc, WTorch_orange_mc, WTorch_blue_mc, WTorch_green_mc, WTorch_purple_mc, LevelSelection_mc, Door_exit_mc, Door_complete_mc, Door_lock_mc,Knight_die_mc, Doors_mc,Knight_stayL,Knight_stayR,Knight_moveL,Knight_moveR,Knight_jumpL,Knight_jumpR,Knight_fallL,Knight_fallR, KnTorchL_none_mc, KnTorchR_none_mc, KnTorchL_orange_mc, KnTorchR_orange_mc, KnTorchL_green_mc, KnTorchR_green_mc, KnTorchL_blue_mc, KnTorchR_blue_mc, KnTorchL_purple_mc, KnTorchR_purple_mc, Cauldron_orange_mc, Cauldron_blue_mc, Cauldron_green_mc, Cauldron_purple_mc, Anim_grate_mc, Recess_none_mc, Recess_orange_mc, Recess_blue_mc, Recess_green_mc, Recess_purple_mc, Spike_mc, ScreenWon_mc, Screen_died_mc,  Screen_Pause_mc, GameTimeFon_mc, Won_flag_mc, ScreenMission_mc, Mission_torch_mc, GameWon_stars_mc, Won_stars_mc, Won_btn_mc, Bg_Screen_mc, GameButton_btn, Text_lose_mc, Menu_mc, Award_btn, Menu_btn, Play_btn, Close_btn, Guide_btn, Setting_btn, Delete_btn, Arrow_award_btn, OK_btn_mc, Kindle_torch_mc, Text_level_mc, Text_Enter_mc, Level_stars_mc, Flag_orange_mc, Flag_green_mc, HlmtOrng_attaksL_mc, HlmtOrng_attaksR_mc, HlmtOrng_bemusedL_mc, HlmtOrng_bemusedR_mc, HlmtOrng_runsR_mc, HlmtOrng_runsL_mc,HlmtOrng_sleepsR_mc, HlmtOrng_sleepsL_mc, HlmtBlue_runsL_mc, HlmtBlue_runsR_mc, HlmtBlue_bemusedR_mc, HlmtBlue_bemusedL_mc, HlmtBlue_attaksR_mc, HlmtBlue_attaksL_mc, HlmtBlue_sleepsL_mc, HlmtBlue_sleepsR_mc, HlmtGreen_attaksR_mc, HlmtGreen_attaksL_mc, HlmtGreen_sleepsR_mc, HlmtGreen_sleepsL_mc, HlmtGreen_runsR_mc, HlmtGreen_runsL_mc, HlmtGreen_bemusedR_mc, HlmtGreen_bemusedL_mc,HlmtPrpl_attaksR_mc, HlmtPrpl_attaksL_mc, HlmtPrpl_sleepsR_mc, HlmtPrpl_sleepsL_mc, HlmtPrpl_runsR_mc, HlmtPrpl_runsL_mc, HlmtPrpl_bemusedR_mc, HlmtPrpl_bemusedL_mc, Cannon_mc, CoreR_mc, CoreL_mc, Core_boom_mc, Award_bg_mc, SpriteAward_mc, SideBar_mc, Kindle_fire_orange_mc, Kindle_fire_blue_mc, Kindle_fire_green_mc, Kindle_fire_purple_mc, Orange_key_mc, Blue_key_mc, Green_key_mc, Purple_key_mc, Scene_mc, Ramka_close_mc, Toggle_mc, GameSetiing_btn];
				//cache.cacheList(list);
				cache.onProgressCallback = progressCallback;
				cache.onCompleteCallback = completeCallback;
				cache.cacheListStep(list);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function progressCallback(percent:Number):void
		{
			_graphicsPreloader.update(percent);
		}
		private function completeCallback():void
		{
			_graphicsPreloader.textBar = "Complete!";
			_graphicsPreloader.createButton();
			_graphicsPreloader.onCompleteCallback = startup;
		}
		
		private function startup():void
		{
			trace(Constants.PROJECT_DATE);
			_screen = Screen.getInstance(stage);
			this.addChild(_screen);
		}
		
		public static function getInstance():Main
		{
			return _instance;
		}
	}
	
}