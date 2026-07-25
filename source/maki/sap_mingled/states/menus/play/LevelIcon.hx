package maki.sap_mingled.states.menus.play;

class LevelIcon extends SAPSprite
{
	public var replaceColorShader:ReplaceColorShader;

	public function new(icon = 'unknown', ID:Int)
	{
		super(x, y);

		loadGraphic(get_path_game_menus_play('levelIcons/${icon ?? 'unknown'}'));

		setGraphicSize(256);
		updateHitbox();

		this.ID = ID;

		shader = replaceColorShader = new ReplaceColorShader(false);
	}
}
