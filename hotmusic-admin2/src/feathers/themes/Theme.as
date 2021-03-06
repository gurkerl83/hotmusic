/*
 Copyright (c) 2012 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package feathers.themes
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.component.ActionButton;
	import cz.hotmusic.component.ChangePasswordPanel;
	import cz.hotmusic.renderer.AddArtistRenderer;
	import cz.hotmusic.renderer.AlbumRenderer;
	import cz.hotmusic.renderer.ArtistRenderer;
	import cz.hotmusic.renderer.GenreRenderer;
	import cz.hotmusic.renderer.SongRenderer;
	import cz.hotmusic.renderer.UserRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.Screen;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TabBar;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.DropDownPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.PopUpManager;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.VerticalLayout;
	import feathers.skins.ImageStateValueSelector;
	import feathers.skins.Scale9ImageStateValueSelector;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Theme extends DisplayListWatcher
	{
		// typy tlacitek
		
		public static const LARGE_BOLD_GRAY			:String = "LARGE_BOLD_GRAY";
		public static const LARGE_BOLD_WHITE		:String = "LARGE_BOLD_WHITE";
		public static const LARGE_BOLD_GREEN		:String = "LARGE_BOLD_GREEN";
		public static const LARGE_BOLD_RED			:String = "LARGE_BOLD_RED";
		
		public static const SMALL_BOLD_WHITE		:String = "SMALL_BOLD_WHITE";
		public static const SMALL_BOLD_BLACK		:String = "SMALL_BOLD_BLACK";
		public static const SMALL_BOLD_RED			:String = "SMALL_BOLD_RED";
		public static const SMALL_BOLD_ORANGE		:String = "SMALL_BOLD_ORANGE";
		public static const SMALL_BOLD_GREEN		:String = "SMALL_BOLD_GREEN";
		public static const SMALL_BOLD_BLUE			:String = "SMALL_BOLD_BLUE";
		
		public static const SMALL_NORMAL_BLACK		:String = "SMALL_NORMAL_BLACK";
		public static const SMALL_NORMAL_GRAY		:String = "SMALL_NORMAL_GRAY";
		public static const SMALL_NORMAL_ORANGE		:String = "SMALL_NORMAL_ORANGE";

		public static const TINY_NORMAL_WHITE		:String = "TINY_NORMAL_WHITE";
		public static const TINY_NORMAL_GRAY		:String = "TINY_NORMAL_GRAY";
		public static const TINY_BOLD_WHITE			:String = "TINY_BOLD_WHITE";
		
		public static const PAGE_BUTTON_DARK		:String = "PAGE_BUTTON_DARK";
		public static const PAGE_BUTTON_LIGHT		:String = "PAGE_BUTTON_LIGHT";
		
		public static const HEADER_HIDE				:String = "HEADER_HIDE";
		
		// barvy
		
		public static const BLACK_TEXT_COLOR		:uint = 0x000004;
		public static const WHITE_TEXT_COLOR		:uint = 0xCCCCCC;
		public static const GRAY_TEXT_COLOR			:uint = 0x808080;
		public static const GREEN_TEXT_COLOR		:uint = 0x349E49;
		public static const RED_TEXT_COLOR			:uint = 0xC81D23;
		public static const BLUE_TEXT_COLOR			:uint = 0x005BAA;
		
		
		[Embed(source="/assets/theme/metalworks.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/assets/theme/metalworks.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

//		protected static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const LIGHT_TEXT_COLOR:uint = 0xC8C8C8;
		protected static const ORANGE_TEXT_COLOR:uint = 0xF19300;
		protected static const DARK_TEXT_COLOR:uint = 0x1a1a1a;
		protected static const SELECTED_TEXT_COLOR:uint = 0xff9900;
		protected static const DISABLED_TEXT_COLOR:uint = 0x333333;

		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

//		protected static const TEXTINPUT_SCALE9_GRID:Rectangle = new Rectangle(39, 0, 2, 49);
//		protected static const TEXTINPUTBLACK_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 7, 71);
		protected static const TEXTINPUTBLACK_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
		protected static const TEXTINPUTWHITE_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 10, 36);
		protected static const TEXTINPUT_SCALE9_GRID:Rectangle = new Rectangle(39, 0, 2, 49);
		protected static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 50, 50);
		protected static const BUTTON2_SCALE9_GRID:Rectangle = new Rectangle(15, 15, 4, 47);
		protected static const BUTTON_PAGE_SCALE9_GRID:Rectangle = new Rectangle(0, 0, 25, 25);
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 1, 82);
		protected static const ITEM_RENDERER_MAIN_SCALE9_GRID:Rectangle = new Rectangle(1, 5, 10, 40);
		protected static const ITEM_RENDERER_MENU_SCALE9_GRID:Rectangle = new Rectangle(1, 1, 26, 50);
		protected static const ITEM_RENDERER_PICKER_SCALE9_GRID:Rectangle = new Rectangle(1, 1, 13, 29);
		protected static const INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 1, 82);
		protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
		protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
		protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
		protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(19, 19, 50, 50);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;
		
		private var MyriadProRegularFont:Font = new FontAssets.MyriadProRegular();
		private var MyriadProBoldFont:Font = new FontAssets.MyriadProBold();

		public static const COMPONENT_NAME_PICKER_LIST_ITEM_RENDERER:String = "feathers-mobile-picker-list-item-renderer";

		protected static function textRendererFactory():TextFieldTextRenderer
		{
			return new TextFieldTextRenderer();
		}

		protected static function textEditorFactory():StageTextTextEditor
		{
			return new StageTextTextEditor();
		}

		protected static function popUpOverlayFactory():DisplayObject
		{
			const quad:Quad = new Quad(100, 100, 0x1a1a1a);
			quad.alpha = 0.85;
			return quad;
		}

		public function Theme(root:DisplayObjectContainer, scaleToDPI:Boolean = true)
		{
			super(root)
			this._scaleToDPI = scaleToDPI;
			this.initialize();
		}

		protected var _originalDPI:int;

		public function get originalDPI():int
		{
			return this._originalDPI;
		}

		protected var _scaleToDPI:Boolean;

		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}

		protected var scale:Number = 1;

		protected var primaryBackground:TiledImage;

		// moje text formaty
		protected var smallBoldBlackTextFormat:TextFormat;
		protected var smallBoldGrayTextFormat:TextFormat;
		protected var smallBoldWhiteTextFormat:TextFormat;
		protected var smallBoldGreenTextFormat:TextFormat;
		protected var smallBoldRedTextFormat:TextFormat;
		protected var smallBoldOrangeTextFormat:TextFormat;
		protected var smallBoldBlueTextFormat:TextFormat;

		protected var smallNormalBlackTextFormat:TextFormat;
		protected var smallNormalGrayTextFormat:TextFormat;
		protected var smallNormalOrangeTextFormat:TextFormat;
		protected var smallNormalWhiteTextFormat:TextFormat;

		protected var largeBoldGrayTextFormat:TextFormat;
		protected var largeBoldWhiteTextFormat:TextFormat;
		protected var largeBoldGreenTextFormat:TextFormat;
		protected var largeBoldRedTextFormat:TextFormat;

		protected var tinyNormalGrayTextFormat:TextFormat;
		protected var tinyNormalWhiteTextFormat:TextFormat;
		protected var tinyBoldWhiteTextFormat:TextFormat;
		// konec
		
		protected var headerTextFormat:TextFormat;

		protected var smallUIDarkTextFormat:TextFormat;
		protected var smallUILightTextFormat:TextFormat;
		protected var smallUISelectedTextFormat:TextFormat;
		protected var smallUIDisabledTextFormat:TextFormat;

		protected var largeUIDarkTextFormat:TextFormat;
		protected var largeUILightTextFormat:TextFormat;
		protected var largeUISelectedTextFormat:TextFormat;
		protected var largeUIDisabledTextFormat:TextFormat;

		protected var largeDarkTextFormat:TextFormat;
		protected var largeLightTextFormat:TextFormat;
		protected var largeOrangeTextFormat:TextFormat;
		protected var largeDisabledTextFormat:TextFormat;

		protected var smallDarkTextFormat:TextFormat;
		protected var smallLightTextFormat:TextFormat;
		protected var smallDisabledTextFormat:TextFormat;

		protected var tinyDarkTextFormat:TextFormat;
		protected var tinyLightTextFormat:TextFormat;
		protected var tinyDisabledTextFormat:TextFormat;

		public static var atlas:TextureAtlas;
		protected var atlasBitmapData:BitmapData;
		protected var primaryBackgroundTexture:Texture;
		protected var textinputblackSkinTextures:Scale9Textures;
		protected var textinputwhiteSkinTextures:Scale9Textures;
		protected var textinputSkinTextures:Scale9Textures;
		protected var backgroundSkinTextures:Scale9Textures;
		protected var backgroundDisabledSkinTextures:Scale9Textures;
		protected var backgroundFocusedSkinTextures:Scale9Textures;
		protected var textinputredSkinTextures:Scale9Textures;
		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;
		protected var buttonPageOrangeSkinTextures:Scale9Textures;
		protected var buttonPageLightSkinTextures:Scale9Textures;
		protected var buttonPageDarkSkinTextures:Scale9Textures;
		protected var pickerListUpButtonIconTexture:Texture;
		protected var pickerListDownButtonIconTexture:Texture;
		protected var tabDownSkinTextures:Scale9Textures;
		protected var tabSelectedSkinTextures:Scale9Textures;
		protected var pickerListItemSelectedIconTexture:Texture;
		protected var radioUpIconTexture:Texture;
		protected var radioDownIconTexture:Texture;
		protected var radioDisabledIconTexture:Texture;
		protected var radioSelectedUpIconTexture:Texture;
		protected var radioSelectedDownIconTexture:Texture;
		protected var radioSelectedDisabledIconTexture:Texture;
		protected var checkUpIconTexture:Texture;
		protected var checkDownIconTexture:Texture;
		protected var checkDisabledIconTexture:Texture;
		protected var checkSelectedUpIconTexture:Texture;
		protected var checkSelectedDownIconTexture:Texture;
		protected var checkSelectedDisabledIconTexture:Texture;
		protected var pageIndicatorNormalSkinTexture:Texture;
		protected var pageIndicatorSelectedSkinTexture:Texture;
		protected var itemRendererMainUpSkinTextures:Scale9Textures;
		protected var itemRendererMainSelectedSkinTextures:Scale9Textures;
		protected var itemRendererMainHoverSkinTextures:Scale9Textures;
		protected var itemRendererMenuUpSkinTextures:Scale9Textures;
		protected var itemRendererMenuSelectedSkinTextures:Scale9Textures;
		protected var itemRendererMenuHoverSkinTextures:Scale9Textures;
		protected var itemRendererAutocompleteUpSkinTextures:Scale9Textures;
		protected var itemRendererAutocompleteSelectedSkinTextures:Scale9Textures;
		protected var itemRendererAutocompleteHoverSkinTextures:Scale9Textures;
		protected var itemRendererPickerUpSkinTextures:Scale9Textures;
		protected var itemRendererPickerSelectedSkinTextures:Scale9Textures;
		
		protected var itemRendererUpSkinTextures:Scale9Textures;
		protected var itemRendererSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererMiddleUpSkinTextures:Scale9Textures;
		protected var insetItemRendererMiddleSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererFirstUpSkinTextures:Scale9Textures;
		protected var insetItemRendererFirstSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererLastUpSkinTextures:Scale9Textures;
		protected var insetItemRendererLastSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererSingleUpSkinTextures:Scale9Textures;
		protected var insetItemRendererSingleSelectedSkinTextures:Scale9Textures;
		protected var calloutTopArrowSkinTexture:Texture;
		protected var calloutRightArrowSkinTexture:Texture;
		protected var calloutBottomArrowSkinTexture:Texture;
		protected var calloutLeftArrowSkinTexture:Texture;
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;

		override public function dispose():void
		{
			if(this.root)
			{
				this.root.removeEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
				if(this.primaryBackground)
				{
					this.root.stage.removeEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
					this.root.removeEventListener(Event.REMOVED_FROM_STAGE, root_removedFromStageHandler);
					this.root.removeChild(this.primaryBackground, true);
					this.primaryBackground = null;
				}
			}
			if(atlas)
			{
				atlas.dispose();
				atlas = null;
			}
			if(this.atlasBitmapData)
			{
				this.atlasBitmapData.dispose();
				this.atlasBitmapData = null;
			}
			super.dispose();
		}

		protected function initializeRoot():void
		{
			this.primaryBackground = new TiledImage(this.primaryBackgroundTexture);
			this.primaryBackground.width = root.stage.stageWidth;
			this.primaryBackground.height = root.stage.stageHeight;
			this.root.addChildAt(this.primaryBackground, 0);
			this.root.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			this.root.addEventListener(Event.REMOVED_FROM_STAGE, root_removedFromStageHandler);
		}

		protected function initialize():void
		{
			const scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			this._originalDPI = scaledDPI;
			if(this._scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}

//			this.scale = scaledDPI / this._originalDPI;

			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;

//			const fontNames:String = "Helvetica Neue,Helvetica,Roboto,Arial,_sans";
//			const fontNormal:String = "MyriadProSemibold";
			const fontNormal:String = "MyriadProRegular";
			const fontBold:String = "MyriadProBold";
			const smallSize:int = 20;
			const largeSize:int = 33;
			const tinySize:int = 10;

			// definice mych text formatu
			this.smallBoldBlackTextFormat = new TextFormat(fontBold, smallSize * this.scale, BLACK_TEXT_COLOR, true);
			this.smallBoldGrayTextFormat = new TextFormat(fontBold, smallSize * this.scale, GRAY_TEXT_COLOR, true);
			this.smallBoldWhiteTextFormat = new TextFormat(fontBold, smallSize * this.scale, WHITE_TEXT_COLOR, true);
			this.smallBoldGreenTextFormat = new TextFormat(fontBold, smallSize * this.scale, GREEN_TEXT_COLOR, true);
			this.smallBoldRedTextFormat = new TextFormat(fontBold, smallSize * this.scale, RED_TEXT_COLOR, true);
			this.smallBoldOrangeTextFormat = new TextFormat(fontBold, smallSize * this.scale, ORANGE_TEXT_COLOR, true);
			this.smallBoldBlueTextFormat = new TextFormat(fontBold, smallSize * this.scale, BLUE_TEXT_COLOR, true);

			this.smallNormalGrayTextFormat = new TextFormat(fontNormal, smallSize * this.scale, GRAY_TEXT_COLOR, true);
			this.smallNormalBlackTextFormat = new TextFormat(fontNormal, smallSize * this.scale, BLACK_TEXT_COLOR, true);
			this.smallNormalOrangeTextFormat = new TextFormat(fontNormal, smallSize * this.scale, ORANGE_TEXT_COLOR, true);
			this.smallNormalWhiteTextFormat = new TextFormat(fontNormal, smallSize * this.scale, WHITE_TEXT_COLOR, true);
			
			this.largeBoldGrayTextFormat = new TextFormat(fontBold, largeSize * this.scale, GRAY_TEXT_COLOR, true);
			this.largeBoldWhiteTextFormat = new TextFormat(fontBold, largeSize * this.scale, WHITE_TEXT_COLOR, true);
			this.largeBoldGreenTextFormat = new TextFormat(fontBold, largeSize * this.scale, GREEN_TEXT_COLOR, true);
			this.largeBoldRedTextFormat = new TextFormat(fontBold, largeSize * this.scale, RED_TEXT_COLOR, true);
			
			this.tinyNormalGrayTextFormat = new TextFormat(fontNormal, tinySize * this.scale, GRAY_TEXT_COLOR, true);
			this.tinyNormalWhiteTextFormat = new TextFormat(fontNormal, tinySize * this.scale, WHITE_TEXT_COLOR, true);
			this.tinyBoldWhiteTextFormat = new TextFormat(fontBold, tinySize * this.scale, WHITE_TEXT_COLOR, true);
			// konec definice
			
			this.headerTextFormat = new TextFormat("MyriadProBold", Math.round(40 * this.scale), ORANGE_TEXT_COLOR, true);

			this.smallUIDarkTextFormat = new TextFormat(fontBold, smallSize * this.scale, DARK_TEXT_COLOR, true);
			this.smallUILightTextFormat = new TextFormat(fontBold, smallSize * this.scale, LIGHT_TEXT_COLOR, true);
			this.smallUISelectedTextFormat = new TextFormat(fontBold, smallSize * this.scale, SELECTED_TEXT_COLOR, true);
			this.smallUIDisabledTextFormat = new TextFormat(fontBold, smallSize * this.scale, DISABLED_TEXT_COLOR, true);

			this.largeUIDarkTextFormat = new TextFormat(fontNormal, largeSize * this.scale, DARK_TEXT_COLOR, true);
			this.largeUILightTextFormat = new TextFormat(fontNormal, largeSize * this.scale, LIGHT_TEXT_COLOR, true);
			this.largeUISelectedTextFormat = new TextFormat(fontNormal, largeSize * this.scale, SELECTED_TEXT_COLOR, true);
			this.largeUIDisabledTextFormat = new TextFormat(fontNormal, largeSize * this.scale, DISABLED_TEXT_COLOR, true);

			this.smallDarkTextFormat = new TextFormat("MyriadProRegular", smallSize * this.scale, DARK_TEXT_COLOR);
			this.smallLightTextFormat = new TextFormat("MyriadProRegular", smallSize * this.scale, LIGHT_TEXT_COLOR);
			this.smallDisabledTextFormat = new TextFormat("MyriadProRegular", smallSize * this.scale, DISABLED_TEXT_COLOR);

			this.tinyDarkTextFormat = new TextFormat("MyriadProRegular", tinySize * this.scale, DARK_TEXT_COLOR);
			this.tinyLightTextFormat = new TextFormat("MyriadProRegular", tinySize * this.scale, LIGHT_TEXT_COLOR);
			this.tinyDisabledTextFormat = new TextFormat("MyriadProRegular", tinySize * this.scale, DISABLED_TEXT_COLOR);

			this.largeDarkTextFormat = new TextFormat(fontNormal, largeSize * this.scale, DARK_TEXT_COLOR);
			this.largeLightTextFormat = new TextFormat(fontNormal, largeSize * this.scale, LIGHT_TEXT_COLOR);
			this.largeOrangeTextFormat = new TextFormat(fontNormal, largeSize * this.scale, ORANGE_TEXT_COLOR);
			this.largeDisabledTextFormat = new TextFormat(fontNormal, largeSize * this.scale, DISABLED_TEXT_COLOR);

			PopUpManager.overlayFactory = popUpOverlayFactory;
			Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
				Callout.stagePaddingLeft = 16 * this.scale;

			const atlasBitmapData:BitmapData = (new ATLAS_IMAGE()).bitmapData;
			atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(new ATLAS_XML()));
			if(Starling.handleLostContext)
			{
				this.atlasBitmapData = atlasBitmapData;
			}
			else
			{
				atlasBitmapData.dispose();
			}

			this.primaryBackgroundTexture = atlas.getTexture("primary-background");

			const textinputblackSkinTexture:Texture = atlas.getTexture("textinputblack-skin");
			const textinputwhiteSkinTexture:Texture = atlas.getTexture("textinputwhite-skin");
			const textinputSkinTexture:Texture = atlas.getTexture("textinput-skin");
			const textinputredSkinTexture:Texture = atlas.getTexture("textinputred-skin");
			const backgroundSkinTexture:Texture = atlas.getTexture("background-skin");
			const backgroundDownSkinTexture:Texture = atlas.getTexture("background-down-skin");
			const backgroundDisabledSkinTexture:Texture = atlas.getTexture("background-disabled-skin");
			const backgroundFocusedSkinTexture:Texture = atlas.getTexture("background-focused-skin");

			this.textinputblackSkinTextures = new Scale9Textures(textinputblackSkinTexture, TEXTINPUTBLACK_SCALE9_GRID);
			this.textinputwhiteSkinTextures = new Scale9Textures(textinputwhiteSkinTexture, TEXTINPUTWHITE_SCALE9_GRID);
			this.textinputSkinTextures = new Scale9Textures(textinputSkinTexture, TEXTINPUT_SCALE9_GRID);
			this.textinputredSkinTextures = new Scale9Textures(textinputredSkinTexture, TEXTINPUTWHITE_SCALE9_GRID);
			this.backgroundSkinTextures = new Scale9Textures(backgroundSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundDisabledSkinTextures = new Scale9Textures(backgroundDisabledSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundFocusedSkinTextures = new Scale9Textures(backgroundFocusedSkinTexture, DEFAULT_SCALE9_GRID);

			this.buttonUpSkinTextures = new Scale9Textures(atlas.getTexture("button2-up-skin"), BUTTON2_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(atlas.getTexture("button2-down-skin"), BUTTON2_SCALE9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(atlas.getTexture("button2-disabled-skin"), BUTTON2_SCALE9_GRID);
//			this.buttonUpSkinTextures = new Scale9Textures(atlas.getTexture("button-up-skin"), BUTTON_SCALE9_GRID);
//			this.buttonDownSkinTextures = new Scale9Textures(atlas.getTexture("button-down-skin"), BUTTON_SCALE9_GRID);
//			this.buttonDisabledSkinTextures = new Scale9Textures(atlas.getTexture("button-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(atlas.getTexture("button-selected-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(atlas.getTexture("button-selected-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonPageOrangeSkinTextures = new Scale9Textures(atlas.getTexture("buttonPage-orange-skin"), BUTTON_PAGE_SCALE9_GRID);
			this.buttonPageLightSkinTextures = new Scale9Textures(atlas.getTexture("buttonPage-light-skin"), BUTTON_PAGE_SCALE9_GRID);
			this.buttonPageDarkSkinTextures = new Scale9Textures(atlas.getTexture("buttonPage-dark-skin"), BUTTON_PAGE_SCALE9_GRID);

			this.tabDownSkinTextures = new Scale9Textures(atlas.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
			this.tabSelectedSkinTextures = new Scale9Textures(atlas.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);

			this.pickerListUpButtonIconTexture = atlas.getTexture("picker-list-up-icon");
			this.pickerListDownButtonIconTexture = atlas.getTexture("picker-list-down-icon");
			this.pickerListItemSelectedIconTexture = atlas.getTexture("picker-list-item-selected-icon");

			this.radioUpIconTexture = backgroundSkinTexture;
			this.radioDownIconTexture = backgroundDownSkinTexture;
			this.radioDisabledIconTexture = backgroundDisabledSkinTexture;
			this.radioSelectedUpIconTexture = atlas.getTexture("radio-selected-up-icon");
			this.radioSelectedDownIconTexture = atlas.getTexture("radio-selected-down-icon");
			this.radioSelectedDisabledIconTexture = atlas.getTexture("radio-selected-disabled-icon");

			this.checkUpIconTexture = backgroundSkinTexture;
			this.checkDownIconTexture = backgroundDownSkinTexture;
			this.checkDisabledIconTexture = backgroundDisabledSkinTexture;
			this.checkSelectedUpIconTexture = atlas.getTexture("check-selected-up-icon");
			this.checkSelectedDownIconTexture = atlas.getTexture("check-selected-down-icon");
			this.checkSelectedDisabledIconTexture = atlas.getTexture("check-selected-disabled-icon");

			this.pageIndicatorSelectedSkinTexture = atlas.getTexture("page-indicator-selected-skin");
			this.pageIndicatorNormalSkinTexture = atlas.getTexture("page-indicator-normal-skin");

			this.itemRendererMainUpSkinTextures = new Scale9Textures(atlas.getTexture("list-item-main-up-skin"), ITEM_RENDERER_MAIN_SCALE9_GRID);
			this.itemRendererMainSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-item-main-selected-skin"), ITEM_RENDERER_MAIN_SCALE9_GRID);
			this.itemRendererMainHoverSkinTextures = new Scale9Textures(atlas.getTexture("list-item-main-hover-skin"), ITEM_RENDERER_MAIN_SCALE9_GRID);
			this.itemRendererMenuUpSkinTextures = new Scale9Textures(atlas.getTexture("list-item-menu-up-skin"), ITEM_RENDERER_MENU_SCALE9_GRID);
			this.itemRendererMenuSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-item-menu-selected-skin"), ITEM_RENDERER_MENU_SCALE9_GRID);
			this.itemRendererMenuHoverSkinTextures = new Scale9Textures(atlas.getTexture("list-item-menu-hover-skin"), ITEM_RENDERER_MENU_SCALE9_GRID);
			this.itemRendererAutocompleteUpSkinTextures = itemRendererMainUpSkinTextures;
			this.itemRendererAutocompleteSelectedSkinTextures = itemRendererMainSelectedSkinTextures;
			this.itemRendererAutocompleteHoverSkinTextures = itemRendererMainSelectedSkinTextures;
			this.itemRendererPickerUpSkinTextures = new Scale9Textures(atlas.getTexture("picker-list-item-background"), ITEM_RENDERER_PICKER_SCALE9_GRID);
			this.itemRendererPickerSelectedSkinTextures = new Scale9Textures(atlas.getTexture("picker-list-item-selected-background"), ITEM_RENDERER_PICKER_SCALE9_GRID);
			
			
			this.itemRendererUpSkinTextures = new Scale9Textures(atlas.getTexture("list-item-up-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.itemRendererSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-item-selected-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.insetItemRendererMiddleUpSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-middle-up-skin"), INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID);
			this.insetItemRendererMiddleSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-middle-selected-skin"), INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID);
			this.insetItemRendererFirstUpSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-first-up-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererFirstSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-first-selected-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererLastUpSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-last-up-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererLastSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-last-selected-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererSingleUpSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-single-up-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			this.insetItemRendererSingleSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);

			this.calloutTopArrowSkinTexture = atlas.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = atlas.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = atlas.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = atlas.getTexture("callout-arrow-left-skin");

			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(atlas.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(atlas.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);

			StandardIcons.listDrillDownAccessoryTexture = atlas.getTexture("list-accessory-drill-down-icon");

			if(this.root.stage)
			{
				this.initializeRoot();
			}
			else
			{
				this.root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}

			this.setInitializerForClassAndSubclasses(Screen, screenInitializer);
			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(Label, labelBadgeInitializer, "badgeLabel");
			this.setInitializerForClass(Label, labelInitializer, "header");
			this.setInitializerForClass(TextFieldTextRenderer, itemRendererAccessoryLabelInitializer, BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ACCESSORY_LABEL);
			this.setInitializerForClass(ScrollText, scrollTextInitializer);
			this.setInitializerForClass(ActionButton, buttonInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Button, buttonGroupButtonInitializer, ButtonGroup.DEFAULT_CHILD_NAME_BUTTON);
			this.setInitializerForClass(Button, simpleButtonInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, simpleButtonInitializer, Slider.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, pickerListButtonInitializer, PickerList.DEFAULT_CHILD_NAME_BUTTON);
			this.setInitializerForClass(Button, tabInitializer, TabBar.DEFAULT_CHILD_NAME_TAB);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			this.setInitializerForClass(Button, toggleSwitchTrackInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, SimpleScrollBar.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(ButtonGroup, buttonGroupInitializer);
			this.setInitializerForClass(GenreRenderer, itemRendererMainInitializer);
			this.setInitializerForClass(ArtistRenderer, itemRendererMainInitializer);
			this.setInitializerForClass(AlbumRenderer, itemRendererMainInitializer);
			this.setInitializerForClass(SongRenderer, itemRendererMainInitializer);
			this.setInitializerForClass(UserRenderer, itemRendererMainInitializer);
			this.setInitializerForClass(AddArtistRenderer, itemRendererMainInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, pickerListItemRendererInitializer, COMPONENT_NAME_PICKER_LIST_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetMiddleItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetFirstItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_FIRST_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetLastItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_LAST_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetSingleItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_SINGLE_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, headerRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, footerRendererInitializer, GroupedList.DEFAULT_CHILD_NAME_FOOTER_RENDERER);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, insetHeaderRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_HEADER_RENDERER);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, insetFooterRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_FOOTER_RENDERER);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer, "textinputblack");
			this.setInitializerForClass(PageIndicator, pageIndicatorInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(Panel, panelInitializer);
			this.setInitializerForClass(ChangePasswordPanel, panelInitializer);
			this.setInitializerForClass(Header, headerInitializer);
			this.setInitializerForClass(Callout, calloutInitializer);
			this.setInitializerForClass(Scroller, scrollerInitializer);
			this.setInitializerForClass(List, nothingInitializer, PickerList.DEFAULT_CHILD_NAME_LIST);
			this.setInitializerForClass(GroupedList, insetGroupedListInitializer, GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
		}

		protected function pageIndicatorNormalSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorNormalSkinTexture;
			symbol.textureScale = this.scale;
			return symbol;
		}

		protected function pageIndicatorSelectedSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorSelectedSkinTexture;
			symbol.textureScale = this.scale;
			return symbol;
		}

		protected function imageLoaderFactory():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;
			return image;
		}

		protected function horizontalScrollBarFactory():SimpleScrollBar
		{
			const scrollBar:SimpleScrollBar = new SimpleScrollBar();
			scrollBar.direction = SimpleScrollBar.DIRECTION_HORIZONTAL;
			const defaultSkin:Scale3Image = new Scale3Image(this.horizontalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.width = 10 * this.scale;
			scrollBar.thumbProperties.defaultSkin = defaultSkin;
			scrollBar.paddingRight = scrollBar.paddingBottom = scrollBar.paddingLeft = 4 * this.scale;
			return scrollBar;
		}

		protected function verticalScrollBarFactory():SimpleScrollBar
		{
			const scrollBar:SimpleScrollBar = new SimpleScrollBar();
			scrollBar.direction = SimpleScrollBar.DIRECTION_VERTICAL;
			const defaultSkin:Scale3Image = new Scale3Image(this.verticalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.height = 10 * this.scale;
			scrollBar.thumbProperties.defaultSkin = defaultSkin;
			scrollBar.paddingTop = scrollBar.paddingRight = scrollBar.paddingBottom = 4 * this.scale;
			return scrollBar;
		}

		protected function nothingInitializer(target:DisplayObject):void {}

		protected function screenInitializer(screen:Screen):void
		{
			screen.originalDPI = this._originalDPI;
		}

		protected function simpleButtonInitializer(button:Button):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.imageProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.minWidth = button.minHeight = 60 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}

		protected function labelInitializer(label:Label):void
		{
//			label.textRendererProperties.textFormat = this.smallLightTextFormat;
			if (label.textRendererFactory == null && label.textRendererProperties.textFormat == null)
			{
				label.textRendererProperties.embedFonts = true;
				
				if (label.name == SMALL_NORMAL_GRAY) {
					label.textRendererProperties.textFormat = this.smallNormalGrayTextFormat;
				} else if (label.name == SMALL_NORMAL_ORANGE) {
					label.textRendererProperties.textFormat = this.smallNormalOrangeTextFormat;
				} else if (label.name == SMALL_BOLD_ORANGE) {
					label.textRendererProperties.textFormat = this.smallBoldOrangeTextFormat;
				} else if (label.name == SMALL_BOLD_BLACK) {
					label.textRendererProperties.textFormat = this.smallBoldBlackTextFormat;
				} else if (label.name == SMALL_BOLD_WHITE) {
					label.textRendererProperties.textFormat = this.smallBoldWhiteTextFormat;
				} else if (label.name == SMALL_NORMAL_BLACK) {
					label.textRendererProperties.textFormat = this.smallNormalBlackTextFormat;
					
				} else if (label.name == LARGE_BOLD_GRAY) {
					label.textRendererProperties.textFormat = this.largeBoldGrayTextFormat;
				} else if (label.name == LARGE_BOLD_GREEN) {
					label.textRendererProperties.textFormat = this.largeBoldGreenTextFormat;
				} else if (label.name == LARGE_BOLD_RED) {
					label.textRendererProperties.textFormat = this.largeBoldRedTextFormat;
				} else if (label.name == LARGE_BOLD_WHITE) {
					label.textRendererProperties.textFormat = this.largeBoldWhiteTextFormat;
					
				} else if (label.name == TINY_NORMAL_GRAY) {
					label.textRendererProperties.textFormat = this.tinyNormalGrayTextFormat;
				} else if (label.name == TINY_NORMAL_WHITE) {
					label.textRendererProperties.textFormat = this.tinyNormalWhiteTextFormat;
				} else if (label.name == TINY_BOLD_WHITE) {
					label.textRendererProperties.textFormat = this.tinyBoldWhiteTextFormat;
					
				} else {
					label.textRendererProperties.textFormat = this.smallNormalGrayTextFormat;
				}
			}
		}

		protected function labelBadgeInitializer(label:Label):void
		{
//			label.textRendererProperties.textFormat = this.smallLightTextFormat;
			if (label.textRendererFactory == null && label.textRendererProperties.textFormat == null)
			{
				var tf:TextFormat = new TextFormat("MyriadProBold", 27, 0x000004);
				tf.letterSpacing = -3;
				label.textRendererProperties.textFormat = tf; 
				label.textRendererProperties.embedFonts = true;
			}
		}

		protected function itemRendererAccessoryLabelInitializer(renderer:TextFieldTextRenderer):void
		{
			renderer.textFormat = this.tinyLightTextFormat;
			renderer.embedFonts = true;
		}

		protected function scrollTextInitializer(text:ScrollText):void
		{
			text.textFormat = this.smallLightTextFormat;
			text.paddingTop = text.paddingBottom = text.paddingLeft = 32 * this.scale;
			text.paddingRight = 36 * this.scale;
		}

		protected function buttonInitializer(button:Button):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			
			var myButtonUpSkinTextures:Scale9Textures;
			var myButtonSelectedUpSkinTextures:Scale9Textures;
			var myButtonDownSkinTextures:Scale9Textures;
			var myButtonDisabledSkinTextures:Scale9Textures;
			var myButtonSelectedDisabledSkinTextures:Scale9Textures;
			var myDefaultLabelTextFormat:TextFormat;
			var myDisabledLabelTextFormat:TextFormat;
			var mySelectedDisabledLabelTextFormat:TextFormat;
			var width:int = 60;
			var height:int = 40;
			var paddingVertical:int = 8;
			var paddingHorizontal:int = 16;

			if (button.name == SMALL_BOLD_RED)
			{
				myButtonUpSkinTextures = buttonDisabledSkinTextures;
				myButtonSelectedUpSkinTextures = buttonSelectedUpSkinTextures;
				myButtonDownSkinTextures = buttonDownSkinTextures;
				myButtonDisabledSkinTextures = buttonDisabledSkinTextures;
				myButtonSelectedDisabledSkinTextures = buttonSelectedDisabledSkinTextures;
				myDefaultLabelTextFormat = smallBoldRedTextFormat;
				myDisabledLabelTextFormat = smallUIDisabledTextFormat;
				mySelectedDisabledLabelTextFormat = smallUIDisabledTextFormat;
				
			} else if (button.name == SMALL_BOLD_BLUE) {
				myButtonUpSkinTextures = buttonDisabledSkinTextures;
				myButtonSelectedUpSkinTextures = buttonSelectedUpSkinTextures;
				myButtonDownSkinTextures = buttonDownSkinTextures;
				myButtonDisabledSkinTextures = buttonDisabledSkinTextures;
				myButtonSelectedDisabledSkinTextures = buttonSelectedDisabledSkinTextures;
				myDefaultLabelTextFormat = smallBoldBlueTextFormat;
				myDisabledLabelTextFormat = smallUIDisabledTextFormat;
				mySelectedDisabledLabelTextFormat = smallUIDisabledTextFormat;

			} else if (button.name == PAGE_BUTTON_DARK) {
				myButtonUpSkinTextures = buttonPageDarkSkinTextures;
				myButtonSelectedUpSkinTextures = buttonPageOrangeSkinTextures;
				myButtonDownSkinTextures = buttonPageOrangeSkinTextures;
				myButtonDisabledSkinTextures = buttonPageDarkSkinTextures;
				myButtonSelectedDisabledSkinTextures = buttonPageDarkSkinTextures;
				myDefaultLabelTextFormat = smallBoldBlackTextFormat;
				myDisabledLabelTextFormat = smallBoldBlackTextFormat;
				mySelectedDisabledLabelTextFormat = smallBoldBlackTextFormat;
				width = height = 25;
				paddingHorizontal = paddingVertical = 0;

			} else if (button.name == PAGE_BUTTON_LIGHT) {
				myButtonUpSkinTextures = buttonPageLightSkinTextures;
				myButtonSelectedUpSkinTextures = buttonPageOrangeSkinTextures;
				myButtonDownSkinTextures = buttonPageOrangeSkinTextures;
				myButtonDisabledSkinTextures = buttonPageOrangeSkinTextures;
				myButtonSelectedDisabledSkinTextures = buttonPageOrangeSkinTextures;
				myDefaultLabelTextFormat = smallBoldBlackTextFormat;
				myDisabledLabelTextFormat = smallBoldBlackTextFormat;
				mySelectedDisabledLabelTextFormat = smallBoldBlackTextFormat;
				width = height = 25;
				paddingHorizontal = paddingVertical = 0;
				
			} else {
				myButtonUpSkinTextures = buttonUpSkinTextures;
				myButtonSelectedUpSkinTextures = buttonSelectedUpSkinTextures;
				myButtonDownSkinTextures = buttonDownSkinTextures;
				myButtonDisabledSkinTextures = buttonDisabledSkinTextures;
				myButtonSelectedDisabledSkinTextures = buttonSelectedDisabledSkinTextures;
				myDefaultLabelTextFormat = smallUIDarkTextFormat;
				myDisabledLabelTextFormat = smallUIDisabledTextFormat;
				mySelectedDisabledLabelTextFormat = smallUIDisabledTextFormat;
			}
			
			skinSelector.defaultValue = myButtonUpSkinTextures;
			skinSelector.defaultSelectedValue = myButtonSelectedUpSkinTextures;
			skinSelector.setValueForState(myButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(myButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(myButtonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.imageProperties =
			{
				width: width * this.scale,
				height: height * this.scale,
				textureScale: this.scale
			};
			
//			if (button.name != "feathers-picker-list-button")
				button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.textFormat = myDefaultLabelTextFormat;
			button.defaultLabelProperties.embedFonts = true;
			button.disabledLabelProperties.textFormat = myDisabledLabelTextFormat;
			button.disabledLabelProperties.embedFonts = true;
			button.selectedDisabledLabelProperties.textFormat = mySelectedDisabledLabelTextFormat;
			button.selectedDisabledLabelProperties.embedFonts = true;

			button.paddingTop = button.paddingBottom = paddingVertical * this.scale;
			button.paddingLeft = button.paddingRight = paddingHorizontal * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = width * this.scale;
			button.minHeight = height * this.scale;
			button.minTouchWidth = width * this.scale;
			button.minTouchHeight = height * this.scale;
			button.useHandCursor = true;
		}

		protected function buttonGroupButtonInitializer(button:Button):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.imageProperties =
			{
				width: 76 * this.scale,
				height: 76 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.textFormat = this.largeUIDarkTextFormat;
			button.disabledLabelProperties.textFormat = this.largeUIDisabledTextFormat;
			button.selectedDisabledLabelProperties.textFormat = this.largeUIDisabledTextFormat;

			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 76 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}

		protected function pickerListButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.stateToSkinFunction = null;
			button.upSkin = new Scale9Image(textinputblackSkinTextures);
			button.hoverSkin = new Scale9Image(textinputblackSkinTextures);
			button.downSkin = new Scale9Image(textinputblackSkinTextures);
//			button.height = button.minHeight = 40;
//			button.width = 400;
			button.paddingRight = 6;
			button.paddingLeft = 18;

			const defaultIcon:Image = new Image(this.pickerListUpButtonIconTexture);
			defaultIcon.scaleX = defaultIcon.scaleY = this.scale;
			button.defaultIcon = defaultIcon;
			const downIcon:Image = new Image(this.pickerListDownButtonIconTexture);
			downIcon.scaleX = downIcon.scaleY = this.scale;
			button.downIcon = downIcon;

			button.gap = Number.POSITIVE_INFINITY;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
			
			button.defaultLabelProperties.textFormat = smallBoldWhiteTextFormat;
			button.defaultLabelProperties.embedFonts = true;
			button.disabledLabelProperties.textFormat = smallBoldWhiteTextFormat;
			button.disabledLabelProperties.embedFonts = true;
			button.selectedDisabledLabelProperties.textFormat = smallBoldWhiteTextFormat;
			button.selectedDisabledLabelProperties.embedFonts = true;
		}

		protected function toggleSwitchTrackInitializer(track:Button):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.imageProperties =
			{
				width: 150 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			track.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function tabInitializer(tab:Button):void
		{
			const defaultSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, 0x1a1a1a);
			tab.defaultSkin = defaultSkin;

			const downSkin:Scale9Image = new Scale9Image(this.tabDownSkinTextures, this.scale);
			tab.downSkin = downSkin;

			const defaultSelectedSkin:Scale9Image = new Scale9Image(this.tabSelectedSkinTextures, this.scale);
			tab.defaultSelectedSkin = defaultSelectedSkin;

			tab.defaultLabelProperties.textFormat = this.smallUILightTextFormat;
			tab.defaultSelectedLabelProperties.textFormat = this.smallUIDarkTextFormat;
			tab.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			tab.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;

			tab.paddingTop = tab.paddingBottom = 8 * this.scale;
			tab.paddingLeft = tab.paddingRight = 16 * this.scale;
			tab.gap = 12 * this.scale;
			tab.minWidth = tab.minHeight = 88 * this.scale;
			tab.minTouchWidth = tab.minTouchHeight = 88 * this.scale;
		}

		protected function buttonGroupInitializer(group:ButtonGroup):void
		{
			group.minWidth = 560 * this.scale;
			group.gap = 18 * this.scale;
		}

		protected function itemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			var skinDefault:Scale9Textures;
			var skinSelected:Scale9Textures;
			var skinHover:Scale9Textures;
			var height:int;
			var defaultTF:TextFormat;
			var selectedTF:TextFormat;
			var padding:int;
			var paddingLeft:int;
			if (renderer.name == "autocomplete") {
				skinDefault = itemRendererAutocompleteUpSkinTextures;
				skinSelected = itemRendererAutocompleteSelectedSkinTextures;
				skinHover = itemRendererAutocompleteHoverSkinTextures;
				defaultTF = selectedTF = smallBoldBlackTextFormat;
				height = 30;
				padding = 0;
				paddingLeft = 18;
			} else {
				skinDefault = itemRendererMenuUpSkinTextures;
				skinSelected = itemRendererMenuSelectedSkinTextures;
				skinHover = itemRendererMenuHoverSkinTextures;
				defaultTF = smallNormalBlackTextFormat;
				selectedTF = smallBoldBlackTextFormat;
				height = 50;
				padding = 8;
				paddingLeft = 32;
			}
			
			skinSelector.defaultValue = skinDefault;
			skinSelector.defaultSelectedValue = skinSelected;
			skinSelector.setValueForState(skinSelected, Button.STATE_DOWN, false);
			skinSelector.setValueForState(skinHover, Button.STATE_HOVER, false);
			skinSelector.imageProperties =
			{
				width: 50 * this.scale,
				height: height * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.textFormat = defaultTF;
			renderer.defaultLabelProperties.embedFonts = true;
			renderer.defaultSelectedLabelProperties.textFormat = selectedTF;
			renderer.defaultSelectedLabelProperties.embedFonts = true;
			renderer.downLabelProperties.textFormat = selectedTF;
			renderer.downLabelProperties.embedFonts = true;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = padding * this.scale;
			renderer.paddingLeft = paddingLeft * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = height * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = height * this.scale;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
			renderer.useHandCursor = true;
		}

		protected function itemRendererMainInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.itemRendererMainUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererMainSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererMainSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.itemRendererMainHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.imageProperties =
			{
				width: 50 * this.scale,
				height: 50 * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.textFormat = this.smallBoldBlackTextFormat;
			renderer.defaultLabelProperties.embedFonts = true;
			renderer.defaultSelectedLabelProperties.textFormat = this.smallBoldBlackTextFormat;
			renderer.defaultSelectedLabelProperties.embedFonts = true;
			renderer.downLabelProperties.textFormat = this.smallBoldBlackTextFormat;
			renderer.downLabelProperties.embedFonts = true;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 50 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 50 * this.scale;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
			renderer.useHandCursor = true;
		}

		protected function pickerListItemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.itemRendererPickerUpSkinTextures;
			skinSelector.setValueForState(this.itemRendererPickerSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.itemRendererPickerSelectedSkinTextures, Button.STATE_HOVER, false);
			skinSelector.imageProperties =
			{
				width: 88 * this.scale,
				height: 30 * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			const defaultSelectedIcon:Image = new Image(this.pickerListItemSelectedIconTexture);
			defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = this.scale;
			renderer.defaultSelectedIcon = null;

			const defaultIcon:Quad = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
			defaultIcon.alpha = 0;
			renderer.defaultIcon = null;;

			renderer.defaultLabelProperties.textFormat = this.smallBoldWhiteTextFormat;
			renderer.defaultLabelProperties.embedFonts = true;
			renderer.downLabelProperties.textFormat = this.smallBoldWhiteTextFormat;
			renderer.downLabelProperties.embedFonts = true;

			renderer.itemHasIcon = false;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 18 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 6 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_LEFT;
			renderer.minWidth = 88 * this.scale; 
			renderer.minHeight = 30 * this.scale;
			renderer.minTouchWidth = 88 * this.scale; 
			renderer.minTouchHeight = 30 * this.scale;
			
			renderer.useHandCursor = true;
		}

		protected function insetItemRendererInitializer(renderer:DefaultGroupedListItemRenderer, defaultSkinTextures:Scale9Textures, selectedAndDownSkinTextures:Scale9Textures):void
		{
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = defaultSkinTextures;
			skinSelector.defaultSelectedValue = selectedAndDownSkinTextures;
			skinSelector.setValueForState(selectedAndDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.imageProperties =
			{
				width: 88 * this.scale,
				height: 74 * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.textFormat = this.largeLightTextFormat;
			renderer.defaultLabelProperties.embedFonts = true;
			renderer.downLabelProperties.textFormat = this.largeOrangeTextFormat;
			renderer.downLabelProperties.embedFonts = true;
			renderer.defaultSelectedLabelProperties.textFormat = this.largeOrangeTextFormat;
			renderer.defaultSelectedLabelProperties.embedFonts = true;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 74 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 74 * this.scale;
		}

		protected function insetMiddleItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererMiddleUpSkinTextures, this.insetItemRendererMiddleSelectedSkinTextures);
		}

		protected function insetFirstItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererFirstUpSkinTextures, this.insetItemRendererFirstSelectedSkinTextures);
		}

		protected function insetLastItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererLastUpSkinTextures, this.insetItemRendererLastSelectedSkinTextures);
		}

		protected function insetSingleItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererSingleUpSkinTextures, this.insetItemRendererSingleSelectedSkinTextures);
		}

		protected function headerRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(44 * this.scale, 44 * this.scale, 0x242424);
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.textFormat = this.smallUILightTextFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this.scale;
			renderer.minWidth = renderer.minHeight = 44 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function footerRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(44 * this.scale, 44 * this.scale, 0x242424);
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.textFormat = this.smallLightTextFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this.scale;
			renderer.minWidth = renderer.minHeight = 44 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function insetHeaderRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(66 * this.scale, 66 * this.scale, 0xff00ff);
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.textFormat = this.smallLightTextFormat;
			renderer.contentLabelProperties.embedFonts = true;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 32 * this.scale;
			renderer.minWidth = renderer.minHeight = 66 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function insetFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(66 * this.scale, 66 * this.scale, 0xff00ff);
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.textFormat = this.smallLightTextFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 32 * this.scale;
			renderer.minWidth = renderer.minHeight = 66 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function radioInitializer(radio:Radio):void
		{
			const iconSelector:ImageStateValueSelector = new ImageStateValueSelector();
			iconSelector.defaultValue = this.radioUpIconTexture;
			iconSelector.defaultSelectedValue = this.radioSelectedUpIconTexture;
			iconSelector.setValueForState(this.radioDownIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.radioDisabledIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.radioSelectedDownIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.radioSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
			iconSelector.imageProperties =
			{
				scaleX: this.scale,
				scaleY: this.scale
			};
			radio.stateToIconFunction = iconSelector.updateValue;

			radio.defaultLabelProperties.textFormat = this.smallUILightTextFormat;
			radio.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			radio.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;

			radio.gap = 12 * this.scale;
			radio.minTouchWidth = radio.minTouchHeight = 88 * this.scale;
		}

		protected function checkInitializer(check:Check):void
		{
			const iconSelector:ImageStateValueSelector = new ImageStateValueSelector();
			iconSelector.defaultValue = this.checkUpIconTexture;
			iconSelector.defaultSelectedValue = this.checkSelectedUpIconTexture;
			iconSelector.setValueForState(this.checkUpIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.checkUpIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.checkSelectedUpIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.checkSelectedUpIconTexture, Button.STATE_DISABLED, true);
			iconSelector.imageProperties =
			{
				scaleX: this.scale,
				scaleY: this.scale
			};
			check.stateToIconFunction = iconSelector.updateValue;

			check.defaultLabelProperties.textFormat = this.smallNormalWhiteTextFormat;
			check.defaultLabelProperties.embedFonts = true;
			check.disabledLabelProperties.textFormat = this.smallNormalWhiteTextFormat;
			check.disabledLabelProperties.embedFonts = true;
			check.selectedDisabledLabelProperties.textFormat = this.smallNormalWhiteTextFormat;
			check.selectedDisabledLabelProperties.embedFonts = true;

			check.gap = 12 * this.scale;
			check.minTouchWidth = check.minTouchHeight = 40 * this.scale;
			check.useHandCursor = true;
		}

		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;

			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.imageProperties =
			{
				textureScale: this.scale
			};
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				skinSelector.imageProperties.width = 60 * this.scale;
				skinSelector.imageProperties.height = 210 * this.scale;
			}
			else
			{
				skinSelector.imageProperties.width = 210 * this.scale;
				skinSelector.imageProperties.height = 60 * this.scale;
			}
			slider.minimumTrackProperties.stateToSkinFunction = skinSelector.updateValue;
			slider.maximumTrackProperties.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function toggleSwitchInitializer(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			toggle.defaultLabelProperties.textFormat = this.smallUILightTextFormat;
			toggle.onLabelProperties.textFormat = this.smallUISelectedTextFormat;
		}

		protected function textInputInitializer(input:TextInput):void
		{
			var tist:Scale9Textures;
			var textcolor:uint;
			var promptcolor:uint;
			var paddingLeft:int;
			var height:int;
			var fontSize:int;
			if (input.name == "textinputblack")
			{
				tist = this.textinputblackSkinTextures;
				textcolor = 0xFEFEFE;
				promptcolor = 0xFEFEFE;
				paddingLeft = 18;
				height = 65;
				fontSize = 24;
			} else { //if (input.name == "textinputwhite") {
				tist = this.textinputwhiteSkinTextures;
				textcolor = 0x000004;
				promptcolor = 0x000004;
				paddingLeft = 18;
				height = 40;
				fontSize = 24;
			} 
			
			const backgroundSkin:Scale9Image = new Scale9Image(tist, this.scale);
			backgroundSkin.width = 264 * this.scale;
			backgroundSkin.height = height * this.scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			backgroundDisabledSkin.width = 264 * this.scale;
			backgroundDisabledSkin.height = height * this.scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;

			const backgroundFocusedSkin:Scale9Image = new Scale9Image(tist, this.scale);
			backgroundFocusedSkin.width = 264 * this.scale;
			backgroundFocusedSkin.height = height * this.scale;
			input.backgroundFocusedSkin = backgroundFocusedSkin;

//			const validatorTextInputSkin:Scale9Image = new Scale9Image(this.textinputredSkinTextures, this.scale);
//			validatorTextInputSkin.width = 264 * this.scale;
//			validatorTextInputSkin.height = height * this.scale;
//			input.focusIndicatorSkin = validatorTextInputSkin;

			input.minWidth = input.minHeight = height * this.scale;
			input.minTouchWidth = input.minTouchHeight = height * this.scale;
			input.paddingTop = input.paddingBottom = 4 * this.scale;
			input.paddingLeft = paddingLeft * this.scale;
			input.paddingRight = 12 * this.scale; 
			
			input.textEditorProperties.fontFamily = "Arial";
			input.textEditorProperties.embedFonts = true;
			input.textEditorProperties.fontSize = fontSize * this.scale;
			input.textEditorProperties.color = textcolor;
//			input.promptProperties.textFormat = new TextFormat( "MyriadProRegular", 30, 0x000004 );
//			input.promptProperties.embedFonts = true;
			
//			input.promptProperties.fontFamily = "Arial";
//			input.promptProperties.embedFonts = true;
//			input.promptProperties.fontSize = 30 * this.scale;
//			input.promptProperties.color = 0x7a7a7a;
			input.promptProperties.textFormat = new TextFormat( "MyriadProRegular", fontSize, promptcolor );
			input.promptProperties.embedFonts = true;
		}

		protected function pageIndicatorInitializer(pageIndicator:PageIndicator):void
		{
			pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = 10 * this.scale;
			pageIndicator.paddingTop = pageIndicator.paddingRight = pageIndicator.paddingBottom =
				pageIndicator.paddingLeft = 6 * this.scale;
			pageIndicator.minTouchWidth = pageIndicator.minTouchHeight = 44 * this.scale;
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
			backgroundSkin.width = 240 * this.scale;
			backgroundSkin.height = 22 * this.scale;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			backgroundDisabledSkin.width = 240 * this.scale;
			backgroundDisabledSkin.height = 22 * this.scale;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale9Image = new Scale9Image(this.buttonUpSkinTextures, this.scale);
			fillSkin.width = 8 * this.scale;
			fillSkin.height = 22 * this.scale;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale9Image = new Scale9Image(this.buttonDisabledSkinTextures, this.scale);
			fillDisabledSkin.width = 8 * this.scale;
			fillDisabledSkin.height = 22 * this.scale;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		protected function headerInitializer(header:Header):void
		{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;

			const backgroundSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, 0x000004);
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.textFormat = this.headerTextFormat;
			header.titleProperties.embedFonts = true;
			
			if (header.name == HEADER_HIDE) {
				header.minHeight = header.height = 0;
				header.backgroundSkin = null;
				header.paddingTop = header.paddingRight = header.paddingBottom =
					header.paddingLeft = 0;
			}
		}

		protected function pickerListInitializer(list:PickerList):void
		{
			list.popUpContentManager = new DropDownPopUpContentManager();
			list.listProperties.itemRendererName = COMPONENT_NAME_PICKER_LIST_ITEM_RENDERER;
			list.height = 40;
			
//			list.listProperties.backgroundSkin = new Scale9Image(this.backgroundDisabledSkinTextures); 
//			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
//			{
//				list.popUpContentManager = new CalloutPopUpContentManager();
//			}
//			else
//			{
//				const centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
//				centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom =
//					centerStage.marginLeft = 24 * this.scale;
//				list.popUpContentManager = centerStage;
//			}
//
//			const layout:VerticalLayout = new VerticalLayout();
//			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
//			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
//			layout.useVirtualLayout = true;
//			layout.gap = 0;
//			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
//				layout.paddingLeft = 0;
//			list.listProperties.layout = layout;
//			list.listProperties.@scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
//
//			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
//			{
//				list.listProperties.minWidth = 560 * this.scale;
//				list.listProperties.maxHeight = 528 * this.scale;
//			}
//			else
//			{
//				const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
//				backgroundSkin.width = 20 * this.scale;
//				backgroundSkin.height = 20 * this.scale;
//				list.listProperties.backgroundSkin = backgroundSkin;
//				list.listProperties.paddingTop = list.listProperties.paddingRight =
//					list.listProperties.paddingBottom = list.listProperties.paddingLeft = 8 * this.scale;
//			}
//
//			list.listProperties.itemRendererName = COMPONENT_NAME_PICKER_LIST_ITEM_RENDERER;
		}
		
		protected function panelInitializer(panel:Panel):void {
			panel.backgroundSkin = new Scale9Image(backgroundFocusedSkinTextures);
		}

		protected function calloutInitializer(callout:Callout):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			callout.backgroundSkin = backgroundSkin;

			const topArrowSkin:Image = new Image(this.calloutTopArrowSkinTexture);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this.scale;
			callout.topArrowSkin = topArrowSkin;

			const rightArrowSkin:Image = new Image(this.calloutRightArrowSkinTexture);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this.scale;
			callout.rightArrowSkin = rightArrowSkin;

			const bottomArrowSkin:Image = new Image(this.calloutBottomArrowSkinTexture);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this.scale;
			callout.bottomArrowSkin = bottomArrowSkin;

			const leftArrowSkin:Image = new Image(this.calloutLeftArrowSkinTexture);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this.scale;
			callout.leftArrowSkin = leftArrowSkin;

			callout.paddingTop = callout.paddingRight = callout.paddingBottom =
				callout.paddingLeft = 8 * this.scale;
		}

		protected function scrollerInitializer(scroller:Scroller):void
		{
			scroller.verticalScrollBarFactory = this.verticalScrollBarFactory;
			scroller.horizontalScrollBarFactory = this.horizontalScrollBarFactory;
		}

		protected function insetGroupedListInitializer(list:GroupedList):void
		{
			list.itemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_ITEM_RENDERER;
			list.firstItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_FIRST_ITEM_RENDERER;
			list.lastItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_LAST_ITEM_RENDERER;
			list.singleItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_SINGLE_ITEM_RENDERER;
			list.headerRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_HEADER_RENDERER;
			list.footerRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_FOOTER_RENDERER;

			const layout:VerticalLayout = new VerticalLayout();
			layout.useVirtualLayout = true;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = 18 * this.scale;
			layout.gap = 0;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			list.layout = layout;
		}

		protected function stage_resizeHandler(event:ResizeEvent):void
		{
			this.primaryBackground.width = event.width;
			this.primaryBackground.height = event.height;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			this.root.removeEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			this.initializeRoot();
		}

		protected function root_removedFromStageHandler(event:Event):void
		{
			this.root.removeEventListener(Event.REMOVED_FROM_STAGE, root_removedFromStageHandler);
			this.root.stage.removeEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			this.root.removeChild(this.primaryBackground, true);
			this.primaryBackground = null;
		}

	}
}
