openfl-texturepacker
====================

Provides easy TexturePacker importing for OpenFL, integrating with Tilesheet for batched blitting.

Example usage:

	var frames:Array<TexturePackerFrame> = TexturePackerImport.parseJson(
		openfl.Assets.getText("assets/sheet.json")
	);

	var tilesheet:Tilesheet = new Tilesheet(
		openfl.Assets.getBitmapData("assets/sheet.png")
	);

	var idMap:Map<String, Int> = TexturePackerImport.addToTilesheet(tilesheet, frames);

	tilesheet.drawTiles(target.graphics, [x, y, idMap["spriteName.png"]]);