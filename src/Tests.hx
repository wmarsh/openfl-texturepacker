// Copyright (c) 2014 Wayne Marsh

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import openfl.display.Tilesheet;

import com.marshgames.openfltexturepacker.TexturePackerImport;

class TexturePackerTests extends haxe.unit.TestCase 
{
	private var stage:flash.display.Stage;
	private var frames:Array<TexturePackerFrame>;
	private var tilesheet:Tilesheet;
	private var idMap:Map<String, Int>;

	override public function new(stage:flash.display.Stage)
	{
		this.stage = stage;
		super();
	}

	override public function setup() 
	{
		frames = TexturePackerImport.parseJson(
			openfl.Assets.getText("assets/sheet.json")
		);

		tilesheet = new Tilesheet(
			openfl.Assets.getBitmapData("assets/sheet.png")
		);

		idMap = TexturePackerImport.addToTilesheet(tilesheet, frames);
    }

    public function testDrawing()
    {
    	var sprite:flash.display.Sprite = new flash.display.Sprite();
    	stage.addChild(sprite);

    	tilesheet.drawTiles(sprite.graphics, [0, 0, idMap["Sprite3Bordered.png"]]);
    	tilesheet.drawTiles(sprite.graphics, [0, 0, idMap["Sprite3.png"]], false, Tilesheet.TILE_BLEND_ADD);

    	tilesheet.drawTiles(sprite.graphics, [256, 0, idMap["Sprite1.png"]]);
    	tilesheet.drawTiles(sprite.graphics, [0, 256, idMap["Sprite2.png"]]);

    	assertTrue(true);
    }

    public function testRotatedDrawing()
    {
    	var sprite:flash.display.Sprite = new flash.display.Sprite();
    	stage.addChild(sprite);

    	var angle:Float = Math.PI;

    	tilesheet.drawTiles(
    		sprite.graphics,
    		[
    			510, 510, idMap["Sprite3Bordered.png"], angle
    		],
    		true,
    		Tilesheet.TILE_ROTATION
    	);

    	tilesheet.drawTiles(
    		sprite.graphics,
    		[
    			510, 510, idMap["Sprite3.png"], angle
    		],
    		true,
    		Tilesheet.TILE_ROTATION | Tilesheet.TILE_BLEND_ADD
    	);

    	assertTrue(true);
    }

    public function testFrameCount()
    {
    	assertEquals(4, frames.length);
    }

    public function testFrame1()
    {
		// "frame": {"x":70,"y":350,"w":36,"h":86},
		// "rotated": false,
		// "trimmed": true,
		// "spriteSourceSize": {"x":108,"y":87,"w":36,"h":86},
		// "sourceSize": {"w":256,"h":256}
		var frame:TexturePackerFrame = null;
		for (candidate in frames)
		{
			if ("Sprite1.png" == candidate.name)
			{
				frame = candidate;
				break;
			}
		}

		assertTrue(frame != null);

		// Name
		assertEquals(frame.name, "Sprite1.png");
		
		// Frame dimensions
		assertEquals(frame.frame.x, 70);
		assertEquals(frame.frame.y, 350);
		assertEquals(frame.frame.w, 36);
		assertEquals(frame.frame.h, 86);

		// Rotation
		assertFalse(frame.rotated);

		// Trimmed
		assertTrue(frame.trimmed);

		// Sprite source size
		assertEquals(frame.spriteSourceSize.x, 108);
		assertEquals(frame.spriteSourceSize.y, 87);
		assertEquals(frame.spriteSourceSize.w, 36);
		assertEquals(frame.spriteSourceSize.h, 86);

		// Source size
		assertEquals(frame.sourceSize.w, 256);
		assertEquals(frame.sourceSize.h, 256);
    }
}

// Runner
class Tests extends flash.display.Sprite
{
    public function new()
    {
    	// addEventListener(flash.events.Event.ADDED_TO_STAGE, function(e):Void{
    		var r = new haxe.unit.TestRunner();
	        r.add(new TexturePackerTests(stage));
	        r.run();
    	// });

    	super();
    }
}